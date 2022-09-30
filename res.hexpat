
// Source: https://github.com/godotengine/godot/blob/master/core/io/resource_format_binary.cpp

bitfield GodotUnicodeStringSize {
	bit: 1; // I don't know what Godot uses this for
	size: 31; // Includes '\0'
};

struct GodotUnicodeString {
	GodotUnicodeStringSize size;
	char utf8[size.size];
} [[format("format_string")]];

fn format_string(GodotUnicodeString v) {
	return '"' + v.utf8 + '"';
};

bitfield GodotFormatFlags {
	padding: 29;
	real_t_is_double: 1;
	uids: 1;
	named_scene_ids: 1;
};

enum GodotResVariantType : u32 {
	NIL = 1,
	BOOL = 2,
	INT = 3,
	FLOAT = 4,
	STRING = 5,
	VECTOR2 = 10,
	RECT2 = 11,
	VECTOR3 = 12,
	PLANE = 13,
	QUATERNION = 14,
	AABB = 15,
	BASIS = 16,
	TRANSFORM3D = 17,
	TRANSFORM2D = 18,
	COLOR = 20,
	NODE_PATH = 22,
	RID = 23,
	OBJECT = 24,
	INPUT_EVENT = 25,
	DICTIONARY = 26,
	ARRAY = 30,
	PACKED_BYTE_ARRAY = 31,
	PACKED_INT32_ARRAY = 32,
	PACKED_FLOAT32_ARRAY = 33,
	PACKED_STRING_ARRAY = 34,
	PACKED_VECTOR3_ARRAY = 35,
	PACKED_COLOR_ARRAY = 36,
	PACKED_VECTOR2_ARRAY = 37,
	INT64 = 40,
	DOUBLE = 41,
	CALLABLE = 42,
	SIGNAL = 43,
	STRING_NAME = 44,
	VECTOR2I = 45,
	RECT2I = 46,
	VECTOR3I = 47,
	PACKED_INT64_ARRAY = 48,
	PACKED_FLOAT64_ARRAY = 49,
	VECTOR4 = 50,
	VECTOR4I = 51,
	PROJECTION = 52
};

struct GodotExternalResource {
	GodotUnicodeString class_name;
	GodotUnicodeString path;
	u64 ruid;
};

struct GodotInternalResourceInfo {
	GodotUnicodeString path;
	u64 offset;
};

struct GodotVector2f {
	float x;
	float y;
};

struct GodotVector2d {
	double x;
	double y;
};

struct GodotVector2i {
	s32 x;
	s32 y;
};

struct GodotVector3f {
	float x;
	float y;
	float z;
};

struct GodotVector3d {
	double x;
	double y;
	double z;
};

struct GodotVector3i {
	s32 x;
	s32 y;
	s32 z;
};

struct GodotVector4f {
	float x;
	float y;
	float z;
	float w;
};

struct GodotVector4d {
	double x;
	double y;
	double z;
	double w;
};

struct GodotVector4i {
	s32 x;
	s32 y;
	s32 z;
	s32 w;
};

struct GodotRect2f {
	GodotVector2f position;
	GodotVector2f size;
};

struct GodotRect2d {
	GodotVector2d position;
	GodotVector2d size;
};

struct GodotRect2i {
	GodotVector2i position;
	GodotVector2i size;
};

struct GodotPlaneD {
	GodotVector3d normal;
	double d;
};

struct GodotPlaneF {
	GodotVector3f normal;
	float d;
};

struct GodotQuaternionD {
	double x;
	double y;
	double z;
	double w;
};

struct GodotQuaternionF {
	float x;
	float y;
	float z;
	float w;
};

struct GodotAABBd {
	GodotVector3d position;
	GodotVector3d size;
};

struct GodotAABBf {
	GodotVector3f position;
	GodotVector3f size;
};

struct GodotBasisD {
	GodotVector3d rows[3];
};

struct GodotBasisF {
	GodotVector3f rows[3];
};

struct GodotTransform2Dd {
	GodotVector2d columns[3];
};

struct GodotTransform2Df {
	GodotVector2f columns[3];
};

struct GodotTransform3Dd {
	GodotBasisD basis;
	GodotVector3d origin;
};

struct GodotTransform3Df {
	GodotBasisF basis;
	GodotVector3f origin;
};

struct GodotProjectionD {
	GodotVector4d matrix[4];
};

struct GodotProjectionF {
	GodotVector4f matrix[4];
};

struct GodotColor {
	float r;
	float g;
	float b;
	float a;
};

struct GodotStringName {
	GodotUnicodeString unicode_string;
};

bool _godot_res_real_t_is_double;
u32 _godot_res_ver_format;
bool _godot_res_using_named_scene_ids;

enum GodotFormatVersion : u32 {
	VERSION = 4,
	VERSION_CAN_RENAME_DEPS = 1,
	VERSION_NO_NODEPATH_PROPERTY = 3
};

bitfield GodotNodePathSubNameCount {
	absolute: 1;
	count: 15;
};

struct GodotNodePath {
	u16 namecount;
	GodotNodePathSubNameCount subnamecount;

	if (_godot_res_ver_format < GodotFormatVersion::VERSION_NO_NODEPATH_PROPERTY) {
		// Obsolete format with property separate from subpath
		GodotUnicodeString names[namecount + subnamecount.count + 1];
	} else {
		GodotUnicodeString names[namecount + subnamecount.count];
	}
};

struct GodotRID {
	u32 data;
};

enum GodotObjectType : u32 {
	EMPTY = 0,
	EXTERNAL_RESOURCE = 1,
	INTERNAL_RESOURCE = 2,
	EXTERNAL_RESOURCE_INDEX = 3
};

struct GodotObject {
	u32 obj_type;

	if (obj_type == GodotObjectType::EMPTY) {
		// Nothing

	} else if (obj_type == GodotObjectType::INTERNAL_RESOURCE) {
		u32 index;

	} else if (obj_type == GodotObjectType::EXTERNAL_RESOURCE) {
		// old file format, still around for compatibility
		GodotUnicodeString ext_type;
		GodotUnicodeString path;

	} else if (obj_type == GodotObjectType::EXTERNAL_RESOURCE_INDEX) {
		//new file format, just refers to an index in the external list
		u32 erindex;
	}
};

using GodotResVariant;

struct GodotDictionaryItem {
	GodotResVariant key;
	GodotResVariant value;
};

bitfield GodotContainerHeader {
	shared: 1;
	len: 31;
};

struct GodotDictionary {
	GodotContainerHeader header;
	GodotDictionaryItem items[header.len];
};

struct GodotArray {
	GodotContainerHeader header;
	GodotResVariant items[header.len];
};

struct GodotPackedByteArray {
	u32 len;
	u8 data[len];
	if ((len % 4) != 0) {
		u8 pad[4 - (len % 4)];
	}
};

struct GodotPackedInt32Array {
	u32 len;
	s32 data[len];
};

struct GodotPackedInt64Array {
	u32 len;
	s64 data[len];
};

struct GodotPackedFloat32Array {
	u32 len;
	float data[len];
};

struct GodotPackedFloat64Array {
	u32 len;
	float data[len];
};

struct GodotPackedStringArray {
	u32 len;
	GodotUnicodeString data[len];
};

struct GodotPackedVector2dArray {
	u32 len;
	GodotVector2d data[len];
};

struct GodotPackedVector2fArray {
	u32 len;
	GodotVector2f data[len];
};

struct GodotPackedVector3dArray {
	u32 len;
	GodotVector3d data[len];
};

struct GodotPackedVector3fArray {
	u32 len;
	GodotVector3f data[len];
};

struct GodotPackedColorArray {
	u32 len;
	GodotColor data[len];
};

// Godot already has a Variant encoding format, but when saving resources,
// it uses another implementation of the same thing, with small differences...
// So we can't just import the variant format...
struct GodotResVariant {
	GodotResVariantType type;

	if (type == GodotResVariantType::NIL) {
		// Nothing
	
	} else if (type == GodotResVariantType::BOOL) {
		u32 bool_value;

	} else if (type == GodotResVariantType::INT) {
		s32 int32_value;

	} else if (type == GodotResVariantType::INT64) {
		s32 int64_value;

	} else if (type == GodotResVariantType::FLOAT) {
		float float_value;

	} else if (type == GodotResVariantType::DOUBLE) {
		double float_value;

	} else if (type == GodotResVariantType::STRING) {
		GodotUnicodeString str_value;

	} else if (type == GodotResVariantType::VECTOR2) {
		if (_godot_res_real_t_is_double) {
			GodotVector2d vec2d_value;
		} else {
			GodotVector2f vec2f_value;
		}

	} else if (type == GodotResVariantType::VECTOR2I) {
		GodotVector2i vec2i_value;

	} else if (type == GodotResVariantType::RECT2) {
		if (_godot_res_real_t_is_double) {
			GodotRect2d rect2d_value;
		} else {
			GodotRect2f rect2f_value;
		}

	} else if (type == GodotResVariantType::RECT2I) {
		GodotRect2i rect2i_value;

	} else if (type == GodotResVariantType::VECTOR3) {
		if (_godot_res_real_t_is_double) {
			GodotVector3d vector3f_value;
		} else {
			GodotVector3f vector3f_value;
		}
		
	} else if (type == GodotResVariantType::VECTOR3I) {
		GodotVector3i vec3i_value;

	} else if (type == GodotResVariantType::VECTOR4) {
		if (_godot_res_real_t_is_double) {
			GodotVector4d vector4f_value;
		} else {
			GodotVector4f vector4f_value;
		}
		
	} else if (type == GodotResVariantType::VECTOR4I) {
		GodotVector4i vec4i_value;

	} else if (type == GodotResVariantType::PLANE) {
		if (_godot_res_real_t_is_double) {
			GodotPlaneD planed_value;
		} else {
			GodotPlaneF planef_value;
		}

	} else if (type == GodotResVariantType::QUATERNION) {
		if (_godot_res_real_t_is_double) {
			GodotQuaternionD quatd_value;
		} else {
			GodotQuaternionF quatf_value;
		}

	} else if (type == GodotResVariantType::AABB) {
		if (_godot_res_real_t_is_double) {
			GodotAABBd aabbd_value;
		} else {
			GodotAABBf aabbf_value;
		}

	} else if (type == GodotResVariantType::TRANSFORM2D) {
		if (_godot_res_real_t_is_double) {
			GodotTransform2Dd transform2dd_value;
		} else {
			GodotTransform2Df transform2df_value;
		}

	} else if (type == GodotResVariantType::BASIS) {
		if (_godot_res_real_t_is_double) {
			GodotBasisD basisd_value;
		} else {
			GodotBasisD basisf_value;
		}

	} else if (type == GodotResVariantType::TRANSFORM3D) {
		if (_godot_res_real_t_is_double) {
			GodotTransform3Dd transform3dd_value;
		} else {
			GodotTransform3Df transform3df_value;
		}

	} else if (type == GodotResVariantType::PROJECTION) {
		if (_godot_res_real_t_is_double) {
			GodotProjectionD projd_value;
		} else {
			GodotProjectionF projf_value;
		}

	} else if (type == GodotResVariantType::COLOR) {
		GodotColor color_value;

	} else if (type == GodotResVariantType::STRING_NAME) {
		GodotStringName stringname_value;

	} else if (type == GodotResVariantType::NODE_PATH) {
		GodotNodePath nodepath_value;

	} else if (type == GodotResVariantType::RID) {
		GodotRID rid_value;

	} else if (type == GodotResVariantType::OBJECT) {
		GodotObject object_value;

	} else if (type == GodotResVariantType::CALLABLE) {
		// Nothing

	} else if (type == GodotResVariantType::SIGNAL) {
		// Nothing

	} else if (type == GodotResVariantType::DICTIONARY) {
		GodotDictionary dict_value;

	} else if (type == GodotResVariantType::ARRAY) {
		GodotArray array_value;

	} else if (type == GodotResVariantType::PACKED_BYTE_ARRAY) {
		GodotPackedByteArray byte_array_value;

	} else if (type == GodotResVariantType::PACKED_INT32_ARRAY) {
		GodotPackedInt32Array int32_array_value;

	} else if (type == GodotResVariantType::PACKED_INT64_ARRAY) {
		GodotPackedInt64Array int64_array_value;

	} else if (type == GodotResVariantType::PACKED_FLOAT32_ARRAY) {
		GodotPackedFloat32Array float_array_value;

	} else if (type == GodotResVariantType::PACKED_FLOAT64_ARRAY) {
		GodotPackedFloat64Array double_array_value;

	} else if (type == GodotResVariantType::PACKED_STRING_ARRAY) {
		GodotPackedStringArray string_array_value;

	} else if (type == GodotResVariantType::PACKED_VECTOR2_ARRAY) {
		if (_godot_res_real_t_is_double) {
			GodotPackedVector2dArray vec2d_array_value;
		} else {
			GodotPackedVector2fArray vec2f_array_value;
		}

	} else if (type == GodotResVariantType::PACKED_VECTOR3_ARRAY) {
		if (_godot_res_real_t_is_double) {
			GodotPackedVector3dArray vec3d_array_value;
		} else {
			GodotPackedVector3fArray vec3f_array_value;
		}

	} else if (type == GodotResVariantType::PACKED_COLOR_ARRAY) {
		GodotPackedColorArray color_array_value;
	}
} [[format("format_variant")]];

fn format_variant(GodotResVariant v) {
	if (v.type == GodotResVariantType::NIL) {
		return "null";
	
	} else if (v.type == GodotResVariantType::STRING) {
		return '"' + v.str_value.utf8 + '"';

	} else if(v.type == GodotResVariantType::BOOL) {
		return v.bool_value;

	} else if(v.type == GodotResVariantType::INT) {
		return v.int32_value;

	} else if(v.type == GodotResVariantType::INT64) {
		return v.int64_value;

	} else if(v.type == GodotResVariantType::FLOAT) {
		return v.float_value;

	} else if(v.type == GodotResVariantType::DOUBLE) {
		return v.double_value;
	}
	// TODO Format more types
	
	return "{ ... }";
};

struct GodotProperty {
	u32 name_idx;
	GodotResVariant value;
};

struct GodotInternalResource {
	GodotUnicodeString class_name;
	u32 properties_count;
	GodotProperty properties[properties_count];
} [[format("format_internal_resource")]];

fn format_internal_resource(GodotInternalResource v) {
	return v.class_name.utf8;
};

// Non-compressed variant
struct GodotResource {
	char header_magic[4]; // "RSRC"

	// `1` if big endian, `0` otherwise.
	// TODO ImHex doesnt seem to support changing default endianess in the middle of a pattern.
	// instead it has to be hardcoded with `le` and `be` prefixes.
	// This is impractical as it would lead to the duplication of the entire pattern,
	// so this pattern is only implemented for native endianess.
	u32 big_endian;

	u32 is_64_bit; // Always 0 for now

	u32 version_major;
	u32 version_minor;
	u32 format_version;
	_godot_res_ver_format = format_version;

	GodotUnicodeString class_name;

	u64 offset_for_metadata;

	GodotFormatFlags flags;
	_godot_res_real_t_is_double = flags.real_t_is_double;
	_godot_res_using_named_scene_ids = flags.named_scene_ids;

	u64 uid;

	u32 reserved_fields[11];

	u32 string_table_size;
	GodotUnicodeString string_table[string_table_size];

	u32 external_resources_count;
	GodotExternalResource external_resources[external_resources_count];

	u32 internal_resources_count;
	GodotInternalResourceInfo internal_resource_infos[internal_resources_count];

	// TODO It's unclear if the count is really `internal_resources_count`
	GodotInternalResource internal_resources[internal_resources_count];

	char footer_magic[4];
};

GodotResource res @ 0x0;
