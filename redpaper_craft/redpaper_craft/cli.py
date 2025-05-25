import os
import tempfile
import shutil
import subprocess
from pathlib import Path
from typing import List, Optional
import functools

import typer
from rich.console import Console

app = typer.Typer()
craft_app = typer.Typer(help="compile markdown documents using redpaper")
app.add_typer(craft_app, name="craft")
console = Console()

def run_command(cmd: List[str]) -> int:
    """run a command and return its exit code."""
    process = subprocess.run(cmd)
    return process.returncode

@craft_app.command()
def compile(
    input_file: Path = typer.Option(
        ..., "--input", "-i", help="input markdown file"
    ),
    output_file: Path = typer.Option(
        ..., "--output", "-o", help="output pdf file"
    ),
    redpaper_path: Path = typer.Option(
        ..., "--redpaper-path", "-r", help="path to redpaper repository"
    ),
    template: str = typer.Option(
        "style2/style2-single.tex", "--template", "-t", 
        help="template to use (relative to redpaper templates directory)"
    ),
    dpi: int = typer.Option(300, "--dpi", "-d", help="dpi setting for pandoc"),
    engine: str = typer.Option("lualatex", "--engine", "-e", help="pdf engine to use"),
    container_tool: str = typer.Option(
        "auto", "--container-tool", "-c", 
        help="container tool to use (docker, podman, or auto)"
    ),
    pandoc_args: Optional[List[str]] = typer.Option(
        None, "--pandoc-arg", "-p", 
        help="additional arguments to pass to pandoc (can be used multiple times)"
    ),
    extra: Optional[List[str]] = typer.Option(
        None, "--extra", "-x",
        help="extra raw pandoc arguments (everything after -- is passed directly to pandoc)"
    ),
):
    """compile a markdown file to pdf using redpaper."""
    # resolve all paths to absolute paths
    input_file = input_file.resolve()
    output_file = output_file.resolve()
    redpaper_path = redpaper_path.resolve()
    
    if not input_file.exists():
        console.print(f"[bold red]error:[/] input file {input_file} does not exist")
        raise typer.Exit(1)
    
    if not redpaper_path.exists():
        console.print(f"[bold red]error:[/] redpaper path {redpaper_path} does not exist")
        raise typer.Exit(1)
    
    # create parent directory for output file if it doesn't exist
    output_file.parent.mkdir(parents=True, exist_ok=True)
    
    # determine container tool to use
    if container_tool == "auto":
        # try to detect if docker or podman is available, preferring podman
        docker_available = run_command(["which", "docker"]) == 0
        podman_available = run_command(["which", "podman"]) == 0
        
        if podman_available:
            container_tool = "podman"
        elif docker_available:
            container_tool = "docker"
        else:
            console.print("[bold red]error:[/] neither docker nor podman found")
            raise typer.Exit(1)
    
    # create a temporary directory for output
    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_output = Path(tmp_dir) / output_file.name
        
        # get the directory containing the input file
        input_dir = input_file.parent
        
        # get the relative path of the input file from its directory
        rel_input = input_file.relative_to(input_dir)
        
        # calculate paths inside container
        container_input = f"/prj/{rel_input}"
        container_output = f"/tmp/{output_file.name}"
        container_template = f"/data/templates/{template}"
        
        # prepare the pandoc command
        pandoc_cmd = [
            "pandoc",
            f"--dpi={dpi}",
            f"--pdf-engine={engine}",
            f"--template={container_template}",
            "-i", container_input,
            "-o", container_output
        ]
        
        # add any additional pandoc arguments
        if pandoc_args:
            pandoc_cmd.extend(pandoc_args)
            
        # add any extra raw arguments
        if extra:
            pandoc_cmd.extend(extra)
        
        # prepare the container command
        container_cmd = [
            container_tool, "run", "--rm",
            "-v", f"{input_dir}:/prj",
            "-v", f"{redpaper_path}:/data",
            "-v", f"{tmp_dir}:/tmp",
            "redthing1/redpaper_host",
            *pandoc_cmd
        ]
        
        # show the command
        console.print("[bold blue]running:[/]", " ".join(container_cmd))
        
        # run the container
        result = run_command(container_cmd)
        
        if result != 0:
            console.print(f"[bold red]error:[/] container exited with status {result}")
            raise typer.Exit(result)
        
        # check if the output file was created
        if not tmp_output.exists():
            console.print(f"[bold red]error:[/] output file was not created")
            raise typer.Exit(1)
        
        # copy the output file to the final destination
        shutil.copy2(tmp_output, output_file)
        
        console.print(f"[bold green]success![/] pdf written to {output_file}")

# Add a direct shortcut at the top level for easier use
@app.command(name="make")
@functools.wraps(compile)  # This keeps the same function signature and docs
def make_shortcut(
    input_file: Path = typer.Option(
        ..., "--input", "-i", help="input markdown file"
    ),
    output_file: Path = typer.Option(
        ..., "--output", "-o", help="output pdf file"
    ),
    redpaper_path: Path = typer.Option(
        ..., "--redpaper-path", "-r", help="path to redpaper repository"
    ),
    template: str = typer.Option(
        "style2/style2-single.tex", "--template", "-t", 
        help="template to use (relative to redpaper templates directory)"
    ),
    dpi: int = typer.Option(300, "--dpi", "-d", help="dpi setting for pandoc"),
    engine: str = typer.Option("lualatex", "--engine", "-e", help="pdf engine to use"),
    container_tool: str = typer.Option(
        "auto", "--container-tool", "-c", 
        help="container tool to use (docker, podman, or auto)"
    ),
    pandoc_args: Optional[List[str]] = typer.Option(
        None, "--pandoc-arg", "-p", 
        help="additional arguments to pass to pandoc (can be used multiple times)"
    ),
    extra: Optional[List[str]] = typer.Option(
        None, "--extra", "-x",
        help="extra raw pandoc arguments (everything after -- is passed directly to pandoc)"
    ),
):
    """compile a markdown file to pdf using redpaper (shortcut)."""
    return compile(
        input_file=input_file,
        output_file=output_file,
        redpaper_path=redpaper_path,
        template=template,
        dpi=dpi,
        engine=engine,
        container_tool=container_tool,
        pandoc_args=pandoc_args,
        extra=extra
    )

if __name__ == "__main__":
    app()