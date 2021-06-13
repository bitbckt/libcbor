module deimos.cbor.encoding;

/*
 * Copyright (c) 2014-2019 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

extern (C):

/*
 * ============================================================================
 * Primitives encoding
 * ============================================================================
 */

size_t cbor_encode_uint8(ubyte, ubyte*, size_t);

size_t cbor_encode_uint16(ushort, ubyte*, size_t);

size_t cbor_encode_uint32(uint, ubyte*, size_t);

size_t cbor_encode_uint64(ulong, ubyte*, size_t);

size_t cbor_encode_uint(ulong, ubyte*, size_t);

size_t cbor_encode_negint8(ubyte, ubyte*, size_t);

size_t cbor_encode_negint16(ushort, ubyte*, size_t);

size_t cbor_encode_negint32(uint, ubyte*, size_t);

size_t cbor_encode_negint64(ulong, ubyte*, size_t);

size_t cbor_encode_negint(ulong, ubyte*, size_t);

size_t cbor_encode_bytestring_start(size_t, ubyte*, size_t);

size_t cbor_encode_indef_bytestring_start(ubyte*, size_t);

size_t cbor_encode_string_start(size_t, ubyte*, size_t);

size_t cbor_encode_indef_string_start(ubyte*, size_t);

size_t cbor_encode_array_start(size_t, ubyte*, size_t);

size_t cbor_encode_indef_array_start(ubyte*, size_t);

size_t cbor_encode_map_start(size_t, ubyte*, size_t);

size_t cbor_encode_indef_map_start(ubyte*, size_t);

size_t cbor_encode_tag(ulong, ubyte*, size_t);

size_t cbor_encode_bool(bool, ubyte*, size_t);

size_t cbor_encode_null(ubyte*, size_t);

size_t cbor_encode_undef(ubyte*, size_t);

/** Encodes a half-precision float
 *
 * Since there is no native representation or semantics for half floats
 * in the language, we use single-precision floats, as every value that
 * can be expressed as a half-float can also be expressed as a float.
 *
 * This however means that not all floats passed to this function can be
 * unambiguously encoded. The behavior is as follows:
 *  - Infinity, NaN are preserved
 *  - Zero is preserved
 *  - Denormalized numbers keep their sign bit and 10 most significant bit of
 * the significand
 *  - All other numbers
 *   - If the logical value of the exponent is < -24, the output is zero
 *   - If the logical value of the exponent is between -23 and -14, the output
 *     is cut off to represent the 'magnitude' of the input, by which we
 *     mean (-1)^{signbit} x 1.0e{exponent}. The value in the significand is
 * lost.
 *   - In all other cases, the sign bit, the exponent, and 10 most significant
 * bits of the significand are kept
 *
 * @param value
 * @param buffer Target buffer
 * @param buffer_size Available space in the buffer
 * @return number of bytes written
 */
size_t cbor_encode_half(float, ubyte*, size_t);

size_t cbor_encode_single(float, ubyte*, size_t);

size_t cbor_encode_double(double, ubyte*, size_t);

size_t cbor_encode_break(ubyte*, size_t);

size_t cbor_encode_ctrl(ubyte, ubyte*, size_t);
