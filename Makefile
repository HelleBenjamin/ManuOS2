#define programs
ASM := nasm
AS := as
CC := gcc
LD := ld

# I know that this Makefile is such a mess
.PHONY: clean libc kernel userland image

#directories
BUILD_DIR := build
MANUOS_SOURCE_DIR := manuos
KERNEL_SOURCE_DIR := $(MANUOS_SOURCE_DIR)/kernel
USERLAND_SOURCE_DIR := $(MANUOS_SOURCE_DIR)/userland
LIBC_DIR := libc

#flags
ASM_FLAGS := -f bin
AS_FLAGS := -nostdlib --32
#remove -O2 if not working
# Kernel C stuff
CC_FLAGS := -ffreestanding -fno-pic -nostdlib -Iinclude -fomit-frame-pointer -mno-sse -mno-mmx -m32 -Ilibc/include -c
LD_FLAGS := -m elf_i386 -T kernel_link.ld -nostdlib

# Userland C stuff
USERLAND_CC_FLAGS := -ffreestanding -fPIC -nostdlib -fomit-frame-pointer -mno-sse -mno-mmx -m32 -Ilibc/include -c
USERLAND_LD_FLAGS := -m elf_i386 -T user_link.ld -nostdlib




# ---Libc stuff---
LIBC_SRC := $(shell find libc -name '*.c' -print)
LIBC_OBJ := $(patsubst libc/%.c,$(BUILD_DIR)/libc/%.o,$(LIBC_SRC))
LIBC_A := $(BUILD_DIR)/libc/libc.a
CRT0_SRC := $(LIBC_DIR)/crt0.s
CRT0_OBJ := $(BUILD_DIR)/libc/crt0.o

$(BUILD_DIR)/libc/%.o: libc/%.c
	@mkdir -p $(dir $@)
# Disable optimizations if the code don't work
	$(CC) -ffreestanding -fPIC -nostdlib -m32 -mno-sse -mno-mmx -Ilibc/include -O2 -c $< -o $@

$(CRT0_OBJ): $(CRT0_SRC)
	@mkdir -p $(dir $@)
	$(CC) -ffreestanding -fPIC -nostdlib -m32 -c $< -o $@

$(LIBC_A): $(CRT0_OBJ) $(LIBC_OBJ)
	@mkdir -p $(dir $@)
	$(AR) rcs $@ $(CRT0_OBJ) $(LIBC_OBJ)




# ---Kernel stuff---
KERNEL_C_SOURCES := $(shell find $(KERNEL_SOURCE_DIR) -name '*.c')
KERNEL_ASM_SOURCES := $(shell find $(KERNEL_SOURCE_DIR) -name '*.s')

KERNEL_C_OBJS := $(KERNEL_C_SOURCES:%.c=$(BUILD_DIR)/%.o)
KERNEL_ASM_OBJS := $(KERNEL_ASM_SOURCES:%.s=$(BUILD_DIR)/%.o)

KERNEL_OBJS := $(KERNEL_C_OBJS) $(KERNEL_ASM_OBJS)

# kernel c source
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $< -o $@


# kernel asm source
$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	$(AS) $(AS_FLAGS) -o $@ $<




# ---Userland stuff---
USERLAND_C_SOURCES := $(shell find $(USERLAND_SOURCE_DIR) -name '*.c')
USERLAND_C_OBJS := $(USERLAND_C_SOURCES:$(USERLAND_SOURCE_DIR)/%.c=$(BUILD_DIR)/%.o)
USERLAND_ELFS := $(USERLAND_C_OBJS:$(BUILD_DIR)/%.o=$(BUILD_DIR)/%.elf)
USERLAND_BINS := $(USERLAND_ELFS:$(BUILD_DIR)/%.elf=$(BUILD_DIR)/userland/%.bin)

# compile and convert to .bin
$(BUILD_DIR)/%.o: $(USERLAND_SOURCE_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(USERLAND_CC_FLAGS) $< -o $@

$(BUILD_DIR)/%.elf: $(BUILD_DIR)/%.o
	@mkdir -p $(dir $@)
	$(LD) $(USERLAND_LD_FLAGS) $< $(BUILD_DIR)/libc/libc.a -o $@

$(BUILD_DIR)/userland/%.bin: $(BUILD_DIR)/%.elf
	@mkdir -p $(dir $@)
	objcopy -O binary $< $@




# ---Targets---

libc: $(LIBC_A)
	@mkdir -p $(BUILD_DIR)

kernel: $(KERNEL_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(AS) $(AS_FLAGS) -o $(BUILD_DIR)/boot.o $(MANUOS_SOURCE_DIR)/kernel/boot.asm
	$(LD) $(LD_FLAGS) $(BUILD_DIR)/boot.o $(KERNEL_OBJS) $(LIBC_A) -o $(BUILD_DIR)/manux.bin

userland: $(USERLAND_BINS)
	@mkdir -p $(BUILD_DIR)/userland

clean:
	rm -rf $(BUILD_DIR)
	rm disk.img

image:
# Basically the same as in the OSDEV guide, run this as sudo
	dd if=/dev/zero of=disk.img bs=512 count=131072
	echo -e "n\np\n1\n\n\na\nw\n" | sudo fdisk disk.img
	sudo losetup /dev/loop0 disk.img
	sudo losetup /dev/loop1 disk.img -o 1048576
	sudo mkdosfs -F12 -f 2 /dev/loop1
	sudo mount /dev/loop1 /mnt
	sudo grub2-install --root-directory=/mnt --no-floppy --modules="normal part_msdos ext2 multiboot" /dev/loop0 -d /usr/share/grub2/i386-pc
# Here you can add your own files
	sudo mkdir -p /mnt/bin
	sudo cp $(BUILD_DIR)/manux.bin /mnt/boot/manux.bin
	sudo cp grub.cfg /mnt/boot/grub2/grub.cfg
	sudo cp testi.txt /mnt
	sudo cp build/userland/shell.bin /mnt/bin/shell.bin
	sync
	sudo umount /mnt
	sudo losetup -D

# Only update the files
image-update:
	sudo losetup /dev/loop1 disk.img -o 1048576
	sudo mount /dev/loop1 /mnt
	sudo rm /mnt/boot/grub2/grub.cfg /mnt/testi.txt /mnt/bin/shell.bin /mnt/boot/manux.bin
	sudo cp $(BUILD_DIR)/manux.bin /mnt/boot/manux.bin
	sudo cp grub.cfg /mnt/boot/grub2/grub.cfg
	sudo cp testi.txt /mnt
	sudo cp build/userland/shell.bin /mnt/bin/shell.bin
	sync
	sudo umount /mnt
	sudo losetup -D

build_image-old:
# Not recommended
	mkdir -p image/boot/grub
	cp $(BUILD_DIR)/manux.bin image/boot/manux.bin
	cp grub.cfg image/boot/grub/grub.cfg
	grub2-mkrescue -o manuos.img image


build_manuos: libc kernel userland image


qemu:
	qemu-system-i386 -m 32M -hda disk.img

qemu-debug:
	qemu-system-i386 -m 32M -hda disk.img -s -S

disasm-kernel:
	objdump -d $(BUILD_DIR)/manux.bin > disasm-kernel.asm


