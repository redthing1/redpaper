# rt1_pandoc_templates

pandoc templates and toolkit

## redpaper host

build the container image:

```sh
podman build . -f redpaper_host.docker -t redthing1/redpaper_host
```

## example usage

within this repository, run a shell with the templates available:

```sh
podman run --rm -it -v $(pwd):/prj -v $(pwd):/data redthing1/redpaper_host
```

render some examples (within container shell):
```sh
cd /prj
pandoc --dpi=300 --template /data/templates/tufte/tufte-handout-template.tex -i ./examples/doc1.md -o ./examples/doc1_tufte.pdf
pandoc --dpi=300 --template /data/templates/classic/classic-template.tex -i ./examples/doc1.md -o ./examples/doc1_classic.pdf
pandoc --dpi=300 --template /data/templates/eisvogel/eisvogel-template.tex -i ./examples/doc1.md -o ./examples/doc1_eisvogel.pdf
```
