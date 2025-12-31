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

build_image:
# Basically the same as in the OSDEV guide, run this as sudo
	dd if=/dev/zero of=disk.img bs=512 count=131072
	echo -e "n\np\n1\n\n\na\nw\n" | sudo fdisk disk.img
	sudo losetup /dev/loop0 disk.img
	sudo losetup /dev/loop1 disk.img -o 1048576
	sudo mkdosfs -F12 -f 2 /dev/loop1
	sudo mount /dev/loop1 /mnt
	sync
	sudo grub2-install --root-directory=/mnt --no-floppy --modules="normal part_msdos ext2 multiboot" /dev/loop0 -d /usr/share/grub2/i386-pc
	sudo cp $(BUILD_DIR)/manux.bin /mnt/boot/manux.bin
	sudo cp grub.cfg /mnt/boot/grub2/grub.cfg
	sudo cp testi.txt /mnt
	sync
	sudo umount /mnt
	sudo losetup -D


build_image-old:
# Not recommended
	mkdir -p image/boot/grub
	cp $(BUILD_DIR)/manux.bin image/boot/manux.bin
	cp grub.cfg image/boot/grub/grub.cfg
	grub2-mkrescue -o manuos.img image


build_manuos: build_kernel build_shell


qemu:
	qemu-system-i386 -m 32M -hda disk.img

qemu-debug:
	qemu-system-i386 -m 32M -hda disk.img -s -S

disasm-kernel:
	objdump -d $(BUILD_DIR)/manux.bin > disasm-kernel.asm


