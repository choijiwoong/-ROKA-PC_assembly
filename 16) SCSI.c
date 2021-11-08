#define MS_OR_BORLAND (defined(__BORLANDC__)\||defined(_MSC_VER))

#if MS_OR)BORLAND
#pragma pack(push)
#pragme pack(1)
#endif

struct SCSI_read_cmd{
	unsigned opcode:8;//unsigned char
	unsigned lba_msb:5;//...
	unsigned logical_unit:3
	unsigned lba_mid:8;
	unsigned lbs_lsb:8;//Endian
	unsigned transfer_length:8;
	unsigned control:8;
}

#if defined(__GNUC__)
	__attribute__((packed))
#endif
;

#if MS_OR_BORLAND
#pragma pack(pop
#endif