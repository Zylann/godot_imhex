
// Source: https://github.com/godotengine/godot/blob/master/editor/import/resource_importer_texture.cpp

enum DataFormat : u32 {
	DATA_FORMAT_IMAGE = 0,
	DATA_FORMAT_PNG = 1,
	DATA_FORMAT_WEBP = 2,
	DATA_FORMAT_BASIS_UNIVERSAL = 3
};

bitfield Flags {
	padding: 5;

	detect_roughness: 1;
	detect_normal: 1;
	_unused_detect_srgb: 1;
	detect_3d: 1;
	has_mipmaps: 1;
	bit_stream: 1;

	padding: 21;
};

struct CTEX {
	char magic[4]; // "GST2"
	u32 version; // 1
	//texture may be resized later, so original size must be saved first
	u32 width;
	u32 height;
	Flags flags;
	u32 limit_mipmap;
	//reserved for future use
	u32 reserved0;
	u32 reserved1;
	u32 reserved2;

	DataFormat data_format;
	u16 width2;
	u16 height2;
	u32 mipmap_count;
	u32 image_format;
	//GodotImageFormat image_format;

	if (data_format == DataFormat::DATA_FORMAT_IMAGE) {
		// TODO Embed GodotImage?
		//GodotImage image;
		u32 data_len;
		u8 image_data[data_len];

	} else if (data_format == DataFormat::DATA_FORMAT_WEBP) {
		// TODO Embed WEBP?
		u32 data_len;
		u8 webp_data[data_len];

	} else if(data_format == DataFormat::DATA_FORMAT_PNG) {
		// TODO Embed PNG?
		u32 data_len;
		u8 png_data[data_len];

	} else if(data_format == DataFormat::DATA_FORMAT_BASIS_UNIVERSAL) {
		// TODO Embed Basis Universal?
		u32 data_len;
		u8 basis_universal_data[data_len];
	}
};

CTEX texture @ 0x0;
