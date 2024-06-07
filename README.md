# Linux/Mac VHDL for GoBoard

This is a template for building VHDL for the excellent [NAND LAND Go Board] (https://nandland.com/the-go-board/)


References
  1. https://github.com/antonblanchard/ghdl-yosys-blink/
  2. https://github.com/YosysHQ/nextpnr
  3. https://blog.waynejohnson.net/doku.php/open_source_on_goboard

## Prerequisites

If your system has packages for GHDL, ghdlsynth-beta, yosys, nextpnr and nextprog, you can use them, but by default, this uses the Docker projects for these pacckages, so all you need is docker.

Note: Because Docker on Mac does not allow access to the /dev tree, you need to install nextprog natively.  You can use this [script](https://github.com/ddm/icetools/blob/master/icestorm.sh) to get it installed pretty 
easily. Run the following command for a one click install.  

```curl -fsSL https://github.com/ddm/icetools/blob/master/icestorm.sh | bash```

## Examples

There are examples in the examples directory straight from NAND LAND.  If you want to start with your own project, just run `./make_proj <proj_name>`.  This will create a directory and Makefile for your project.  It will even create boilerplate VHDL for you!  

## Building

```
make
make prog
```
