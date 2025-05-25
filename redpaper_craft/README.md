# redpaper craft

a cli tool for compiling markdown documents to pdf using redpaper in a container.

## installation

```bash
pip install redpaper-craft
```

or using poetry:

```bash
cd redpaper_craft
poetry install
```

## usage

```bash
# quick usage with shortcut command
redpaper make -i input.md -o output.pdf -r /path/to/redpaper

# standard usage
redpaper craft compile -i input.md -o output.pdf -r /path/to/redpaper

# use a specific template
redpaper craft compile -i input.md -o output.pdf -r /path/to/redpaper -t style2/style2-double.tex

# pass additional arguments to pandoc (multiple ways)
redpaper craft compile -i input.md -o output.pdf -r /path/to/redpaper -p "--toc" -p "--toc-depth=2"

# or use extra arguments flag for simpler syntax
redpaper craft compile -i input.md -o output.pdf -r /path/to/redpaper -x "--toc" -x "--toc-depth=2"

# use a specific container tool
redpaper craft compile -i input.md -o output.pdf -r /path/to/redpaper -c docker

# using long option names
redpaper craft compile --input input.md --output output.pdf --redpaper-path /path/to/redpaper --template style2/style2-double.tex --dpi 300 --engine lualatex
```

## requirements

- docker or podman
- access to redthing1/redpaper_host container image