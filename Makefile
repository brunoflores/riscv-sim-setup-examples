CC=riscv32-unknown-elf-gcc
CFLAGS=-I. -g -Og
LDFLAGS=-T spike.lds -nostartfiles
DEPS=
OBJ=rot13.o

SPIKE=spike
OPENOCD=openocd
GDB=riscv32-unknown-elf-gdb

rot13: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY:
clean:
	rm *.o rot13

.PHONY:
spike:
	$(SPIKE) --isa=RV32GC --rbb-port=9824 -m0x10000000:0x20000 rot13

.PHONY:
openocd:
	$(OPENOCD) -f spike.cfg

.PHONY:
gdb:
	$(GDB) -x gdb-command.gdb --batch rot13
