
bitfield GodotVariantType {
	padding: 15;
	// `ENCODE_FLAG_OBJECT_AS_ID` is the same flag,
	// it just depends on the type being Object or not...
	encode_flag_64: 1;
	padding: 8;
	id: 8;
};

enum GodotVariantTypeID : u8 {
	NIL,

	// atomic types
	BOOL,
	INT,
	FLOAT,
	STRING,

	// math types
	VECTOR2,
	VECTOR2I,
	RECT2,
	RECT2I,
	VECTOR3,
	VECTOR3I,
	TRANSFORM2D,
	VECTOR4,
	VECTOR4I,
	PLANE,
	QUATERNION,
	AABB,
	BASIS,
	TRANSFORM3D,
	PROJECTION,

	// misc types
	COLOR,
	STRING_NAME,
	NODE_PATH,
	RID,
	OBJECT,
	CALLABLE,
	SIGNAL,
	DICTIONARY,
	ARRAY,

	// typed arrays
	PACKED_BYTE_ARRAY,
	PACKED_INT32_ARRAY,
	PACKED_INT64_ARRAY,
	PACKED_FLOAT32_ARRAY,
	PACKED_FLOAT64_ARRAY,
	PACKED_STRING_ARRAY,
	PACKED_VECTOR2_ARRAY,
	PACKED_VECTOR3_ARRAY,
	PACKED_COLOR_ARRAY,

	VARIANT_MAX
};


struct GodotVector2i {
	s32 x;
	s32 y;
};

struct GodotVector2f {
	float x;
	float y;
};

struct GodotVector2d {
	double x;
	double y;
};

struct GodotVector3i {
	s32 x;
	s32 y;
	s32 z;
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

struct GodotVector4i {
	s32 x;
	s32 y;
	s32 z;
	s32 w;
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

struct GodotRect2i {
	GodotVector2i position;
	GodotVector2i size;
};

struct GodotRect2f {
	GodotVector2f position;
	GodotVector2f size;
};

struct GodotRect2d {
	GodotVector2d position;
	GodotVector2d size;
};

struct GodotTransform2Df {
	GodotVector2f columns[3];
};

struct GodotTransform2Dd {
	GodotVector2d columns[3];
};

struct GodotPlaneF {
	GodotVector2f normal;
	float distance;
};

struct GodotPlaneD {
	GodotVector2d normal;
	double distance;
};

struct GodotQuaternionF {
	float x;
	float y;
	float z;
	float w;
};

struct GodotQuaternionD {
	double x;
	double y;
	double z;
	double w;
};

struct GodotAABBf {
	GodotVector2f position;
	GodotVector2f size;
};

struct GodotAABBd {
	GodotVector2d position;
	GodotVector2d size;
};

struct GodotBasisF {
	GodotVector3f rows[3];
};

struct GodotBasisD {
	GodotVector3d rows[3];
};

struct GodotTransform3Df {
	GodotBasisF basis;
	GodotVector3f origin;
};

struct GodotTransform3Dd {
	GodotBasisD basis;
	GodotVector3d origin;
};

struct GodotProjectionF {
	GodotVector4f elements[4];
};

struct GodotProjectionD {
	GodotVector4d elements[4];
};

struct GodotColor {
	float r;
	float g;
	float b;
	float a;
};

struct GodotString {
	s32 length;
	char s[length];
	if ((length % 4) != 0) {
		u8 pad[4 - length % 4];
	}
};

bitfield GodotNodePathFlags {
	absolute : 1;
	property_separate_from_subpath : 1;
	padding : 30;
};

struct GodotNodePath {
	u16 namecount;
	u16 pad;
	u32 subnamecount;
	GodotNodePathFlags flags;

	if (flags.property_separate_from_subpath) {
		// Obsolete format with property separate from subpath
		GodotString names[namecount + subnamecount + 1];
	} else {
		GodotString names[namecount + subnamecount];
	}
};

struct GodotRID {
	u64 data;
};

struct GodotObjectAsID {
	u64 id;
};

using GodotVariant;

struct GodotObjectProperty {
	GodotString name;
	GodotVariant value;
};

struct GodotObject {
	GodotString class_name;

	if (class_name.length != 0) {
		u32 count;
		GodotObjectProperty properties[count];
	}
};

struct GodotSignal {
	GodotString name;
	u64 id;
};

struct GodotDictionaryPair {
	GodotVariant key;
	GodotVariant value;
};

struct GodotDictionary {
	u16 count;
	u16 shared; // Old
	GodotDictionaryPair items[count];
};

struct GodotArray {
	u16 count;
	u16 shared; // Old
	GodotVariant items[count];
};

struct GodotPackedByteArray {
	u32 count;
	u8 bytes[count];
};

struct GodotPackedInt32Array {
	u32 count;
	s32 values[count];
};

struct GodotPackedInt64Array {
	u32 count;
	s64 values[count];
};

struct GodotPackedFloat32Array {
	u32 count;
	float values[count];
};

struct GodotPackedFloat64Array {
	u32 count;
	double values[count];
};

struct GodotPackedStringArray {
	u32 count;
	GodotString values[count];
};

struct GodotPackedVector2fArray {
	u32 count;
	GodotVector2f values[count];
};

struct GodotPackedVector2dArray {
	u32 count;
	GodotVector2d values[count];
};

struct GodotPackedVector3fArray {
	u32 count;
	GodotVector3f values[count];
};

struct GodotPackedVector3dArray {
	u32 count;
	GodotVector3d values[count];
};

struct GodotPackedColorArray {
	u32 count;
	GodotColor values[count];
};

struct GodotVariant {
	GodotVariantType type;

	if (type.id == GodotVariantTypeID::NIL) {
		// Nothing

	} else if(type.id == GodotVariantTypeID::BOOL) {
		u32 bool_value;

	} else if(type.id == GodotVariantTypeID::INT) {
		if (type.encode_flag_64) {
			s64 int_value;
		} else {
			s32 int_value;
		}

	} else if(type.id == GodotVariantTypeID::FLOAT) {
		if (type.encode_flag_64) {
			double float_value;
		} else {
			float float_value;
		}		

	} else if(type.id == GodotVariantTypeID::STRING) {
		GodotString string_value;

	} else if(type.id == GodotVariantTypeID::VECTOR2) {
		if (type.encode_flag_64) {
			GodotVector2d vec2_value;
		} else {
			GodotVector2f vec2_value;
		}

	} else if(type.id == GodotVariantTypeID::RECT2) {
		if (type.encode_flag_64) {
			GodotRect2d rect2_value;
		} else {
			GodotRect2f rect2_value;
		}

	} else if(type.id == GodotVariantTypeID::RECT2I) {
		GodotRect2i rect2i_value;

	} else if(type.id == GodotVariantTypeID::VECTOR3) {
		if (type.encode_flag_64) {
			GodotVector3d vec3_value;
		} else {
			GodotVector3f vec3_value;
		}

	} else if(type.id == GodotVariantTypeID::VECTOR3I) {
		GodotVector3i vec3i_value;

	} else if(type.id == GodotVariantTypeID::VECTOR4) {
		if (type.encode_flag_64) {
			GodotVector4d vec4_value;
		} else {
			GodotVector4f vec4_value;
		}

	} else if(type.id == GodotVariantTypeID::VECTOR4I) {
		GodotVector4i vec4i_value;

	} else if(type.id == GodotVariantTypeID::TRANSFORM2D) {
		if (type.encode_flag_64) {
			GodotTransform2Dd transform2d_value;
		} else {
			GodotTransform2Df transform2d_value;
		}

	} else if(type.id == GodotVariantTypeID::PLANE) {
		if (type.encode_flag_64) {
			GodotPlaneD plane_value;
		} else {
			GodotPlaneF plane_value;
		}

	} else if(type.id == GodotVariantTypeID::QUATERNION) {
		if(type.encode_flag_64) {
			GodotQuaternionD quaternion_value;
		} else {
			GodotQuaternionF quaternion_value;
		}

	} else if(type.id == GodotVariantTypeID::AABB) {
		if(type.encode_flag_64) {
			GodotAABBd quaternion_value;
		} else {
			GodotAABBf quaternion_value;
		}

	} else if(type.id == GodotVariantTypeID::BASIS) {
		if(type.encode_flag_64) {
			GodotBasisD basis_value;
		} else {
			GodotBasisF basis_value;
		}

	} else if(type.id == GodotVariantTypeID::TRANSFORM3D) {
		if(type.encode_flag_64) {
			GodotTransform3Dd transform3d_value;
		} else {
			GodotTransform3Df transform3d_value;
		}

	} else if(type.id == GodotVariantTypeID::PROJECTION) {
		if(type.encode_flag_64) {
			GodotProjectionD projection_value;
		} else {
			GodotProjectionF projection_value;
		}

	} else if(type.id == GodotVariantTypeID::COLOR) {
		GodotColor color_value;

	} else if(type.id == GodotVariantTypeID::NODE_PATH) {
		GodotNodePath node_path_value;

	} else if(type.id == GodotVariantTypeID::RID) {
		GodotRID rid_value;

	} else if(type.id == GodotVariantTypeID::OBJECT) {
		// That flag is re-used as "ENCODE_FLAG_OBJECT_AS_ID"
		// since "64 bit" makes no sense for objects
		if(type.encode_flag_64) {
			GodotObjectAsID object_value;
		} else {
			GodotObject object_value;
		}

	} else if (type.id == GodotVariantTypeID::CALLABLE) {
		// Nothing

	} else if (type.id == GodotVariantTypeID::SIGNAL) {
		GodotSignal signal_value;

	} else if (type.id == GodotVariantTypeID::DICTIONARY) {
		GodotDictionary dictionary_value;

	} else if (type.id == GodotVariantTypeID::ARRAY) {
		GodotArray array_value;

	} else if(type.id == GodotVariantTypeID::PACKED_BYTE_ARRAY) {
		GodotPackedByteArray byte_array_value;

	} else if(type.id == GodotVariantTypeID::PACKED_INT32_ARRAY) {
		GodotPackedInt32Array int32_array_value;

	} else if(type.id == GodotVariantTypeID::PACKED_INT64_ARRAY) {
		GodotPackedInt64Array int64_array_value;

	} else if(type.id == GodotVariantTypeID::PACKED_FLOAT32_ARRAY) {
		GodotPackedFloat32Array float32_array_value;

	} else if(type.id == GodotVariantTypeID::PACKED_FLOAT64_ARRAY) {
		GodotPackedFloat64Array float64_array_value;

	} else if(type.id == GodotVariantTypeID::PACKED_STRING_ARRAY) {
		GodotPackedStringArray string_array_value;

	} else if(type.id == GodotVariantTypeID::PACKED_VECTOR2_ARRAY) {
		if (type.encode_flag_64) {
			GodotPackedVector2dArray vec2_array_value;
		} else {
			GodotPackedVector2fArray vec2_array_value;
		}

	} else if(type.id == GodotVariantTypeID::PACKED_VECTOR3_ARRAY) {
		if (type.encode_flag_64) {
			GodotPackedVector3dArray vec3_array_value;
		} else {
			GodotPackedVector3fArray vec3_array_value;
		}

	} else if (type.id == GodotVariantTypeID::PACKED_COLOR_ARRAY) {
		GodotPackedColorArray color_array_value;
	}
};

//GodotVariant data @ 0x0;
