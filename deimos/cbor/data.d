module deimos.cbor.data;

/*
 * Copyright (c) 2014-2019 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

alias cbor_data = const ubyte*;
alias cbor_mutable_data = ubyte*;

/** Specifies the Major type of ::cbor_item_t */
alias cbor_type = int;
enum : cbor_type
{
    CBOR_TYPE_UINT = 0, /** 0 - positive integers */

    CBOR_TYPE_NEGINT = 1, /** 1 - negative integers*/

    CBOR_TYPE_BYTESTRING = 2, /** 2 - byte strings */

    CBOR_TYPE_STRING = 3, /** 3 - strings */

    CBOR_TYPE_ARRAY = 4, /** 4 - arrays */

    CBOR_TYPE_MAP = 5, /** 5 - maps */

    CBOR_TYPE_TAG = 6, /** 6 - tags  */

    CBOR_TYPE_FLOAT_CTRL = 7 /** 7 - decimals and special values (true, false, nil,
       ...) */
}

/** Possible decoding errors */
alias cbor_error_code = int;
enum : cbor_error_code
{
    CBOR_ERR_NONE = 0,
    CBOR_ERR_NOTENOUGHDATA = 1,
    CBOR_ERR_NODATA = 2,
    CBOR_ERR_MALFORMATED = 3,
    CBOR_ERR_MEMERROR = 4, /** Memory error - item allocation failed. Is it too big for
       your allocator? */

    CBOR_ERR_SYNTAXERROR = 5 /** Stack parsing algorithm failed */
}

/** Possible widths of #CBOR_TYPE_UINT items */
alias cbor_int_width = int;
enum : cbor_int_width
{
    CBOR_INT_8 = 0,
    CBOR_INT_16 = 1,
    CBOR_INT_32 = 2,
    CBOR_INT_64 = 3
}

/** Possible widths of #CBOR_TYPE_FLOAT_CTRL items */
alias cbor_float_width = int;
enum : cbor_float_width
{
    CBOR_FLOAT_0 = 0, /** Internal use - ctrl and special values */

    CBOR_FLOAT_16 = 1, /** Half float */

    CBOR_FLOAT_32 = 2, /** Single float */

    CBOR_FLOAT_64 = 3 /** Double */
}

/** Metadata for dynamically sized types */
alias _cbor_dst_metadata = int;
enum : _cbor_dst_metadata
{
    _CBOR_METADATA_DEFINITE = 0,
    _CBOR_METADATA_INDEFINITE = 1
}

/** Semantic mapping for CTRL simple values */
alias _cbor_ctrl = int;
enum : _cbor_ctrl
{
    CBOR_CTRL_NONE = 0,
    CBOR_CTRL_FALSE = 20,
    CBOR_CTRL_TRUE = 21,
    CBOR_CTRL_NULL = 22,
    CBOR_CTRL_UNDEF = 23
}

/** Integers specific metadata */
struct _cbor_int_metadata
{
    cbor_int_width width;
}

/** Bytestrings specific metadata */
struct _cbor_bytestring_metadata
{
    size_t length;
    _cbor_dst_metadata type;
}

/** Strings specific metadata */
struct _cbor_string_metadata
{
    size_t length;
    size_t codepoint_count; /* Sum of chunks' codepoint_counts for indefinite
       strings */
    _cbor_dst_metadata type;
}

/** Arrays specific metadata */
struct _cbor_array_metadata
{
    size_t allocated;
    size_t end_ptr;
    _cbor_dst_metadata type;
}

/** Maps specific metadata */
struct _cbor_map_metadata
{
    size_t allocated;
    size_t end_ptr;
    _cbor_dst_metadata type;
}

/** Arrays specific metadata
 *
 * The pointer is included - cbor_item_metadata is
 * 2 * sizeof(size_t) + sizeof(_cbor_string_type_metadata),
 * lets use the space
 */
struct _cbor_tag_metadata
{
    cbor_item_t* tagged_item;
    ulong value;
}

/** Floats specific metadata - includes CTRL values */
struct _cbor_float_ctrl_metadata
{
    cbor_float_width width;
    ubyte ctrl;
}

/** Raw memory casts helper */
union _cbor_float_helper
{
    float as_float;
    uint as_uint;
}

/** Raw memory casts helper */
union _cbor_double_helper
{
    double as_double;
    ulong as_uint;
}

/** Union of metadata across all possible types - discriminated in #cbor_item_t
 */
union cbor_item_metadata
{
    _cbor_int_metadata int_metadata;
    _cbor_bytestring_metadata bytestring_metadata;
    _cbor_string_metadata string_metadata;
    _cbor_array_metadata array_metadata;
    _cbor_map_metadata map_metadata;
    _cbor_tag_metadata tag_metadata;
    _cbor_float_ctrl_metadata float_ctrl_metadata;
}

/** The item handle */
struct cbor_item_t
{
    /** Discriminated by type */
    cbor_item_metadata metadata;
    /** Reference count - initialize to 0 */
    size_t refcount;
    /** Major type discriminator */
    cbor_type type;
    /** Raw data block - interpretation depends on metadata */
    ubyte* data;
}

/** Defines cbor_item_t#data structure for indefinite strings and bytestrings
 *
 * Used to cast the raw representation for a sane manipulation
 */
struct cbor_indefinite_string_data
{
    size_t chunk_count;
    size_t chunk_capacity;
    cbor_item_t** chunks;
}

/** High-level decoding error */
struct cbor_error
{
    /** Aproximate position */
    size_t position;
    /** Description */
    cbor_error_code code;
}

/** Simple pair of items for use in maps */
struct cbor_pair
{
    cbor_item_t* key;
    cbor_item_t* value;
}

/** High-level decoding result */
struct cbor_load_result
{
    /** Error indicator */
    cbor_error error;
    /** Number of bytes read*/
    size_t read;
}

/** Streaming decoder result - status */
alias cbor_decoder_status = int;
enum : cbor_decoder_status
{
    CBOR_DECODER_FINISHED = 0, /** OK, finished */

    CBOR_DECODER_NEDATA = 1, /** Not enough data - mismatch with MTB */

    CBOR_DECODER_EBUFFER = 2, /** Buffer manipulation problem */

    CBOR_DECODER_ERROR = 3 /** Malformed or reserved MTB/value */
}

/** Streaming decoder result */
struct cbor_decoder_result
{
    /** Bytes read */
    size_t read;
    /** The result */
    cbor_decoder_status status;
    /** When status == CBOR_DECODER_NEDATA,
     *  the minimum number of bytes required to continue parsing */
    size_t required;
}
