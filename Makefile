ASM=nasm
CC=gcc

SRC_DIR=src
TOOLS_DIR=tools
BUILD_DIR=build

.PHONY: all floppy kernel bootloader clean always

all: floppy

#
# Floppy image
#
floppy: $(BUILD_DIR)/crazyos.img

$(BUILD_DIR)/crazyos.img: bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/crazyos.img bs=512 count=2880
	mkfs.fat -F 12 -n "CRAZYOS" $(BUILD_DIR)/crazyos.img
	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/crazyos.img conv=notrunc
	mcopy -i $(BUILD_DIR)/crazyos.img $(BUILD_DIR)/kernel.bin "::kernel.bin"


#
# Bootloader
#
bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: always
	$(MAKE) -C $(SRC_DIR)/bootloader BUILD_DIR=$(abspath $(BUILD_DIR))


#
# Kernel
#
kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	$(MAKE) -C $(SRC_DIR)/kernel BUILD_DIR=$(abspath $(BUILD_DIR))


#
# Always
#
always:
	mkdir -p $(BUILD_DIR)

#
# Clean
#
clean:
	rm -rf $(BUILD_DIR)/*