#define programs
ASM := nasm
AS := as
CC := gcc
LD := ld

#flags
ASM_FLAGS := -f bin
AS_FLAGS := -nostdlib --32
#remove -O2 if not working
CC_FLAGS := -ffreestanding -fno-pic -nostdlib -Iinclude -fomit-frame-pointer -mno-sse -mno-mmx -m32 -c
LD_FLAGS := -m elf_i386 -T kernel_link.ld -nostdlib

#directories
BUILD_DIR := build
MANUOS_SOURCE_DIR := manuos
KERNEL_SOURCE_DIR := $(MANUOS_SOURCE_DIR)/kernel

#files
C_SOURCES := $(shell find $(KERNEL_SOURCE_DIR) -name '*.c')
ASM_SOURCES := $(shell find $(KERNEL_SOURCE_DIR) -name '*.s')
LIBC := libc/lansker-libc.c

C_OBJS := $(C_SOURCES:%.c=$(BUILD_DIR)/%.o)
ASM_OBJS := $(ASM_SOURCES:%.s=$(BUILD_DIR)/%.o)
LIBC_OBJ := $(BUILD_DIR)/libc.o

ALL_OBJS := $(C_OBJS) $(ASM_OBJS) $(LIBC_OBJ)

# c source
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $< -o $@

# asm source
$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	$(AS) $(AS_FLAGS) -o $@ $<

# libc
$(LIBC_OBJ): $(LIBC)
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $< -o $@

.PHONY: clean build_kernel

clean:
	rm -rf $(BUILD_DIR)
	rm manuos.img


build_kernel: $(ALL_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(AS) $(AS_FLAGS) -o $(BUILD_DIR)/boot.o $(MANUOS_SOURCE_DIR)/kernel/boot.asm
	$(LD) $(LD_FLAGS) $(BUILD_DIR)/boot.o $(ALL_OBJS) -o $(BUILD_DIR)/manux.bin

build_image-new:
	dd if=/dev/zero of=disk.img bs=512 count=131072

build_image-new-notworking:
	mkdir -p image/boot/grub
	cp $(BUILD_DIR)/manux.elf image/boot/manux.elf
	cp grub.cfg image/boot/grub/grub.cfg
	dd if=/dev/zero of=manuos.img bs=512 count=131072
	mkfs.fat -F 12 -n "MANUOS" manuos.img
	grub2-install --root-directory=image --no-floppy -d /usr/share/grub2/i386-pc manuos.img
	mcopy -i manuos.img -s image/boot/* ::/boot/

build_image:
	mkdir -p image/boot/grub
	cp $(BUILD_DIR)/manux.bin image/boot/manux.bin
	cp grub.cfg image/boot/grub/grub.cfg
	grub2-mkrescue -o manuos.img image


build_manuos: build_kernel build_shell


qemu:
	qemu-system-i386 -m 32M -hda manuos.img

qemu-debug:
	qemu-system-i386 -m 32M -hda manuos.img -s -S

disasm-kernel:
	objdump -d $(BUILD_DIR)/manux.bin > disasm-kernel.asm


