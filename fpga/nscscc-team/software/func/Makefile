func_src_path = ../../../../software/func/func_src
inst_path = ${func_src_path}/inst
include_path = ${func_src_path}/include
obj_path = ./obj
inst_srcs = $(wildcard ${inst_path}/*.S)
EXP = 16
CACHEFLAGS = -Dvivado -Dhas_cache=0 -Dcache_index_depth=0x100 -Dcache_offset_width=0x4 -Dcache_way=2

default: 
	make all
	make tidy
	@echo "=====\nSuccessfully Generated\n====="

all:
	mkdir -p ${func_src_path}/obj
	mkdir -p ${obj_path}
	make ${obj_path}/inst_ram.coe ${obj_path}/test.s

tidy: 
	rm -f ${obj_path}/convert ${obj_path}/main.data  ${obj_path}/data_ram.coe ${obj_path}/data_ram.mif
	rm -f ${obj_path}/start.s ${obj_path}/start.o ${obj_path}/init.s ${obj_path}/init.o
	rm -rf ${func_src_path}/obj
	make -C ${inst_path}/ clean 

${obj_path}/test.s: ${obj_path}/main.elf
	loongarch32r-linux-gnusf-objdump -alD ${obj_path}/main.elf > ${obj_path}/test.s

${func_src_path}/obj/libinst.a: ${inst_srcs}
	make -C ${inst_path}/ EXP=$(EXP) libinst.a

${obj_path}/start.o: ${obj_path}/start.s
	loongarch32r-linux-gnusf-as -mabi=ilp32 ${obj_path}/start.s -o ${obj_path}/start.o
${obj_path}/init.o: ${obj_path}/init.s
	loongarch32r-linux-gnusf-as -mabi=ilp32 ${obj_path}/init.s -o ${obj_path}/init.o

${obj_path}/inst_ram.coe ${obj_path}/inst_ram.mif: ${obj_path}/main.bin ${obj_path}/main.data ${obj_path}/convert
	cd ${obj_path} && ./convert 

${obj_path}/convert: ${func_src_path}/convert.c
	gcc ${func_src_path}/convert.c -o ${obj_path}/convert 

${obj_path}/main.bin: ${obj_path}/main.elf
	loongarch32r-linux-gnusf-objcopy -O binary -j .text ${obj_path}/main.elf ${obj_path}/main.bin
${obj_path}/main.data: ${obj_path}/main.elf
	loongarch32r-linux-gnusf-objcopy -O binary -j .data ${obj_path}/main.elf ${obj_path}/main.data

${obj_path}/main.elf: ${func_src_path}/bin.lds ${func_src_path}/obj/libinst.a ${obj_path}/start.o ${obj_path}/init.o
	loongarch32r-linux-gnusf-ld ${obj_path}/start.o ${obj_path}/init.o ${func_src_path}/obj/libinst.a -T ${func_src_path}/bin.lds -o ${obj_path}/main.elf

${obj_path}/start.s: ${func_src_path}/start.S
	@mkdir -p ${obj_path}
	loongarch32r-linux-gnusf-gcc \
		-I${include_path} -nostdinc -nostdlib -D_KERNEL -fno-builtin -D__loongarch32 $(CACHEFLAGS)\
		-DMEMSTART=0x10000000 -DMEMSIZE=0x04000 -DCPU_COUNT_PER_US=1000 -DEXP=$(EXP) -Dnscscc \
		-S ${func_src_path}/start.S > ${obj_path}/start.s 
${obj_path}/init.s: ${func_src_path}/init.S
	@mkdir -p ${obj_path}
	loongarch32r-linux-gnusf-gcc \
		-I${include_path} -nostdinc -nostdlib -D_KERNEL -fno-builtin -D__loongarch32\
		-DMEMSTART=0x10000000 -DMEMSIZE=0x04000 -DCPU_COUNT_PER_US=1000 -DEXP=$(EXP) -Dnscscc \
		-S ${func_src_path}/init.S > ${obj_path}/init.s 

clean:
	rm -rf obj

help:
	@echo "################################################################"
	@echo "### help for compiling func"
	@echo "################################################################"
	@echo "### options:"
	@echo "###     make      : get compiled result, which is saved in ./obj"
	@echo "###     make clean: remove *.o, *.a, and ./obj"
	@echo "###     make help : show help information"
	@echo "###############################################################"

