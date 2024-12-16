# oxy-neon-large
A larger sized version of the Oxygen Neon cursor theme

Forked from [Querta](https://www.pling.com/u/qwerta/)'s [Oxygen Neon project on gnome-look.org](https://www.gnome-look.org/p/999997/).

[Original Sources](https://www.gnome-look.org/p/999997/startdownload?file_id=1460735457&file_name=137109-oxy-neon-0.2.tar.gz&file_type=application/x-gzip&file_size=184907)

## Requirements
- [xcursorgen](https://www.x.org/releases/X11R7.7/doc/man/man1/xcursorgen.1.xhtml) -- To generate cursor files
- [Inkscape](https://inkscape.org/) -- To export multiple cursor sizes

## Installation

#### For basic installation

Creates cursors in 32, 48, 64, 72, and 96px sizes.

```bash
cd source
./exportPNG.sh
perl cursorconf.pl *.cursor
make
make install
```

The `exportPNG.sh` script exports the PNG files from the source SVG files and optimizes the output files.

The `cursorconf.pl` script updates the existing xcursorgen .cursor files to include larger PNGs

## TODO

- Add missing icons

## Authors

cactus@lophophora.ca

## License

GPL I guess..

## Acknowledgements
- Original author [Querta](https://www.pling.com/u/qwerta/)
