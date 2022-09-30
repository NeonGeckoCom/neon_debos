#!/bin/bash

# Set to exit on error
set -Ee

export HEADER_DIR=/usr/src/linux-headers-5.4.51-v8-raspi2

cd $HEADER_DIR || exit 2
wget https://raw.githubusercontent.com/armbian/build/master/patch/misc/headers-debian-byteshift.patch -O - | patch -p1
#make scripts --warn-undefined-variables INIT_STACK_ALL=y
yes 1 | make scripts

find "$HEADER_DIR/scripts" -type f | while read i; do if file -b $i | egrep -q "^ELF.*x86-64"; then rm "$i"; fi; done
cd $HEADER_DIR/scripts || exit 2
#gcc mkkrnlimg.c -o "$HEADER_DIR/scripts/mkkrnlimg"
gcc kallsyms.c -o "$HEADER_DIR/scripts/kallsyms"
gcc pnmtologo.c -o "$HEADER_DIR/scripts/pnmtologo"
gcc conmakehash.c -o "$HEADER_DIR/scripts/conmakehash"
#gcc resource_tool.c -o "$HEADER_DIR/scripts/resource_tool"
#gcc ./basic/bin2c.c -o "$HEADER_DIR/scripts/basic/bin2c"
gcc recordmcount.c -o "$HEADER_DIR/scripts/recordmcount"
gcc -I../tools/include sortextable.c -o "$HEADER_DIR/scripts/sortextable"
gcc unifdef.c -o "$HEADER_DIR/scripts/unifdef"
gcc ./basic/fixdep.c -o "$HEADER_DIR/scripts/basic/fixdep"
gcc extract-cert.c -o "$HEADER_DIR/scripts/extract-cert" -lssl -lcrypto
gcc ./mod/modpost.c ./mod/file2alias.c ./mod/sumversion.c -o "$HEADER_DIR/scripts/mod/modpost"
gcc ./mod/mk_elfconfig.c -o "$HEADER_DIR/scripts/mod/mk_elfconfig"
gcc  -I../include asn1_compiler.c -o "$HEADER_DIR/scripts/asn1_compiler"
#ln -f ./genksyms/parse.tab.c_shipped ./genksyms/parse.tab.c;
#ln  -f ./genksyms/parse.tab.h_shipped ./genksyms/parse.tab.h;
#ln -f ./genksyms/lex.lex.c_shipped ./genksyms/lex.lex.c;
#ln -f ./genksyms/keywords.hash.c_shipped ./genksyms/keywords.hash.c;
gcc ./genksyms/genksyms.c ./genksyms/parse.tab.c ./genksyms/lex.lex.c -o "$HEADER_DIR/scripts/genksyms/genksyms"
