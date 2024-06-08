#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo 'Specify the name of the project you want to create.  This will create the directory, create the makefile and set up constraints'
fi

mkdir $1
cp -r constraints $1
cat Makefile.tmpl | sed "s/\!package_name\!/$1/g" > $1/Makefile
cat >> $1/$1.vhdl << EOF
library ieee;
use ieee.std_logic_1164.all;

entity $1 is
   port (
   );
end entity $1;

architecture RTL of $1 is
begin
end architecture RTL;
EOF

   
