/*-----------------------------------------------------------------------*/
/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2025        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

#include "../../include/manuos/kernel/ff.h"			/* Basic definitions of FatFs */
#include "../../include/manuos/kernel/diskio.h"		/* Declarations FatFs MAI */
#include "../../include/manuos/kernel/kernel.h"

/* Example: Declarations of the platform and disk functions in the project */
//#include "platform.h"
//#include "storage.h"

/* Example: Mapping of physical drive number for each drive */
#define DEV_FLASH	0	/* Map FTL to physical drive 0 */
#define DEV_MMC		1	/* Map MMC/SD card to physical drive 1 */
#define DEV_USB		2	/* Map USB MSD to physical drive 2 */

#define ATA_PRIMARY_IO  0x1F0
#define ATA_CONTROL_IO  0x3F6

void ide_wait(void) {
    while (inb(ATA_PRIMARY_IO + 7) & 0x80);
    while (!(inb(ATA_PRIMARY_IO + 7) & 0x08));
}

void ide_read_sector(uint32_t lba, uint8_t *buffer) {
    outb(ATA_PRIMARY_IO + 6, 0xE0 | ((lba >> 24) & 0x0F));

    // Send the sector count (1 sector), add more later
    outb(ATA_PRIMARY_IO + 2, 1);
    
    // Send the LBA
    outb(ATA_PRIMARY_IO + 3, (uint8_t)lba);
    outb(ATA_PRIMARY_IO + 4, (uint8_t)(lba >> 8));
    outb(ATA_PRIMARY_IO + 5, (uint8_t)(lba >> 16));
    
    // Send the command
    outb(ATA_PRIMARY_IO + 7, 0x20);

    ide_wait(); // Wait for the disk to be ready

    for (int i = 0; i < 256; i++) { // Copy the data
        ((uint16_t*)buffer)[i] = inw(ATA_PRIMARY_IO);
    }
}

void ide_write_sector(uint32_t lba, const uint8_t *buffer) {
    outb(ATA_PRIMARY_IO + 6, 0xE0 | ((lba >> 24) & 0x0F));

    // Send the sector count (1 sector), add more later
    outb(ATA_PRIMARY_IO + 2, 1);
    
    // Send the LBA
    outb(ATA_PRIMARY_IO + 3, (uint8_t)lba);
    outb(ATA_PRIMARY_IO + 4, (uint8_t)(lba >> 8));
    outb(ATA_PRIMARY_IO + 5, (uint8_t)(lba >> 16));

    // Send the command
    outb(ATA_PRIMARY_IO + 7, 0x30);

    ide_wait(); // Wait for the disk to be ready

    for (int i = 0; i < 256; i++) { // Copy the data
        outw(ATA_PRIMARY_IO, ((uint16_t*)buffer)[i]);
    }

    // Flush, enable on real hardware
    outb(ATA_PRIMARY_IO + 7, 0xE7);
    //ide_wait();
}

int write_multiple(const char *buffer, uint32_t lba, uint8_t count) {
    for (uint8_t i = 0; i < count; i++) {
      ide_write_sector(lba + i,buffer + i*512);
    }
    return 0;
}

int read_multiple(char *buffer, uint32_t lba, uint8_t count) {
    for (uint8_t i = 0; i < count; i++) {
      ide_read_sector(lba + i,buffer + i*512);
    }
    return 0;
}

/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
	BYTE pdrv		/* Physical drive nmuber to identify the drive */
)
{
	if (pdrv != 0) return STA_NOINIT;
	return 0;
}



/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
	BYTE pdrv				/* Physical drive nmuber to identify the drive */
)
{
	if (pdrv != 0) return STA_NOINIT; /* Just check for floppy */
	return 0;
}



/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/

DRESULT disk_read (
	BYTE pdrv,		/* Physical drive nmuber to identify the drive */
	BYTE *buff,		/* Data buffer to store read data */
	LBA_t sector,	/* Start sector in LBA */
	UINT count		/* Number of sectors to read */
)
{
	if (pdrv != 0) return RES_PARERR;
	if(read_multiple(buff, sector, count) != 0) return RES_ERROR;
	return RES_OK;
}



/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/

#if FF_FS_READONLY == 0

DRESULT disk_write (
	BYTE pdrv,			/* Physical drive nmuber to identify the drive */
	const BYTE *buff,	/* Data to be written */
	LBA_t sector,		/* Start sector in LBA */
	UINT count			/* Number of sectors to write */
)
{
	if (pdrv != 0) return RES_PARERR;
	if(write_multiple(buff, sector, count) != 0) return RES_ERROR;
	return RES_OK;
}

#endif


/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl (
	BYTE pdrv,		/* Physical drive nmuber (0..) */
	BYTE cmd,		/* Control code */
	void *buff		/* Buffer to send/receive control data */
)
{
	switch (cmd) {
		case CTRL_SYNC:
			return RES_OK;
		case GET_SECTOR_SIZE:
			*(WORD*)buff = 512;
			return RES_OK;
		case GET_BLOCK_SIZE:
			*(DWORD*)buff = 1;
			return RES_OK;
		case GET_SECTOR_COUNT:
		  *(DWORD*)buff = 129024;
			return RES_OK;
		default:
			return RES_PARERR;
	}
}

