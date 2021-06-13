module deimos.cbor.callbacks;

import deimos.cbor.data;

/*
 * Copyright (c) 2014-2019 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

/** Callback prototype */
alias cbor_int8_callback = void function(void*, ubyte);

/** Callback prototype */
alias cbor_int16_callback = void function(void*, ushort);

/** Callback prototype */
alias cbor_int32_callback = void function(void*, uint);

/** Callback prototype */
alias cbor_int64_callback = void function(void*, ulong);

/** Callback prototype */
alias cbor_simple_callback = void function(void*);

/** Callback prototype */
alias cbor_string_callback = void function(void*, cbor_data, size_t);

/** Callback prototype */
alias cbor_collection_callback = void function(void*, size_t);

/** Callback prototype */
alias cbor_float_callback = void function(void*, float);

/** Callback prototype */
alias cbor_double_callback = void function(void*, double);

/** Callback prototype */
alias cbor_bool_callback = void function(void*, bool);

/** Callback bundle -- passed to the decoder */
struct cbor_callbacks
{
    /** Unsigned int */
    cbor_int8_callback uint8;
    /** Unsigned int */
    cbor_int16_callback uint16;
    /** Unsigned int */
    cbor_int32_callback uint32;
    /** Unsigned int */
    cbor_int64_callback uint64;

    /** Negative int */
    cbor_int64_callback negint64;
    /** Negative int */
    cbor_int32_callback negint32;
    /** Negative int */
    cbor_int16_callback negint16;
    /** Negative int */
    cbor_int8_callback negint8;

    /** Definite byte string */
    cbor_simple_callback byte_string_start;
    /** Indefinite byte string start */
    cbor_string_callback byte_string;

    /** Definite string */
    cbor_string_callback string;
    /** Indefinite string start */
    cbor_simple_callback string_start;

    /** Definite array */
    cbor_simple_callback indef_array_start;
    /** Indefinite array */
    cbor_collection_callback array_start;

    /** Definite map */
    cbor_simple_callback indef_map_start;
    /** Indefinite map */
    cbor_collection_callback map_start;

    /** Tags */
    cbor_int64_callback tag;

    /** Half float */
    cbor_float_callback float2;
    /** Single float */
    cbor_float_callback float4;
    /** Double float */
    cbor_double_callback float8;
    /** Undef */
    cbor_simple_callback undefined;
    /** Null */
    cbor_simple_callback null_;
    /** Bool */
    cbor_bool_callback boolean;

    /** Indefinite item break */
    cbor_simple_callback indef_break;
}

extern (C):

/** Dummy callback implementation - does nothing */
void cbor_null_uint8_callback(void*, ubyte);

/** Dummy callback implementation - does nothing */
void cbor_null_uint16_callback(void*, ushort);

/** Dummy callback implementation - does nothing */
void cbor_null_uint32_callback(void*, uint);

/** Dummy callback implementation - does nothing */
void cbor_null_uint64_callback(void*, ulong);

/** Dummy callback implementation - does nothing */
void cbor_null_negint8_callback(void*, ubyte);

/** Dummy callback implementation - does nothing */
void cbor_null_negint16_callback(void*, ushort);

/** Dummy callback implementation - does nothing */
void cbor_null_negint32_callback(void*, uint);

/** Dummy callback implementation - does nothing */
void cbor_null_negint64_callback(void*, ulong);

/** Dummy callback implementation - does nothing */
void cbor_null_string_callback(void*, cbor_data, size_t);

/** Dummy callback implementation - does nothing */
void cbor_null_string_start_callback(void*);

/** Dummy callback implementation - does nothing */
void cbor_null_byte_string_callback(void*, cbor_data, size_t);

/** Dummy callback implementation - does nothing */
void cbor_null_byte_string_start_callback(void*);

/** Dummy callback implementation - does nothing */
void cbor_null_array_start_callback(void*, size_t);

/** Dummy callback implementation - does nothing */
void cbor_null_indef_array_start_callback(void*);

/** Dummy callback implementation - does nothing */
void cbor_null_map_start_callback(void*, size_t);

/** Dummy callback implementation - does nothing */
void cbor_null_indef_map_start_callback(void*);

/** Dummy callback implementation - does nothing */
void cbor_null_tag_callback(void*, ulong);

/** Dummy callback implementation - does nothing */
void cbor_null_float2_callback(void*, float);

/** Dummy callback implementation - does nothing */
void cbor_null_float4_callback(void*, float);

/** Dummy callback implementation - does nothing */
void cbor_null_float8_callback(void*, double);

/** Dummy callback implementation - does nothing */
void cbor_null_null_callback(void*);

/** Dummy callback implementation - does nothing */
void cbor_null_undefined_callback(void*);

/** Dummy callback implementation - does nothing */
void cbor_null_boolean_callback(void*, bool);

/** Dummy callback implementation - does nothing */
void cbor_null_indef_break_callback(void*);

/** Dummy callback bundle - does nothing */
extern __gshared const cbor_callbacks cbor_empty_callbacks;
