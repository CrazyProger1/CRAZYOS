BUILD_DIR?=build/
ASM?=nasm

.PHONY: all bootloader

all: bootloader

bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: bootloader.asm
	$(ASM) bootloader.asm -f bin -o $(BUILD_DIR)/bootloader.bin
