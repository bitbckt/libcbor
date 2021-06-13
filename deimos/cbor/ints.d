module deimos.cbor.ints;

import deimos.cbor.data;

/*
 * Copyright (c) 2014-2019 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

extern (C):

/*
 * ============================================================================
 * Integer (uints and negints) manipulation
 * ============================================================================
 */

/** Extracts the integer value
 *
 * @param item[borrow] positive or negative integer
 * @return the value
 */
ubyte cbor_get_uint8(const cbor_item_t* item);

/** Extracts the integer value
 *
 * @param item[borrow] positive or negative integer
 * @return the value
 */
ushort cbor_get_uint16(const cbor_item_t* item);

/** Extracts the integer value
 *
 * @param item[borrow] positive or negative integer
 * @return the value
 */
uint cbor_get_uint32(const cbor_item_t* item);

/** Extracts the integer value
 *
 * @param item[borrow] positive or negative integer
 * @return the value
 */
ulong cbor_get_uint64(const cbor_item_t* item);

/** Extracts the integer value
 *
 * @param item[borrow] positive or negative integer
 * @return the value, extended to `uint64_t`
 */
ulong cbor_get_int(const cbor_item_t* item);

/** Assigns the integer value
 *
 * @param item[borrow] positive or negative integer item
 * @param value the value to assign. For negative integer, the logical value is
 * `-value - 1`
 */
void cbor_set_uint8(cbor_item_t* item, ubyte value);

/** Assigns the integer value
 *
 * @param item[borrow] positive or negative integer item
 * @param value the value to assign. For negative integer, the logical value is
 * `-value - 1`
 */
void cbor_set_uint16(cbor_item_t* item, ushort value);

/** Assigns the integer value
 *
 * @param item[borrow] positive or negative integer item
 * @param value the value to assign. For negative integer, the logical value is
 * `-value - 1`
 */
void cbor_set_uint32(cbor_item_t* item, uint value);

/** Assigns the integer value
 *
 * @param item[borrow] positive or negative integer item
 * @param value the value to assign. For negative integer, the logical value is
 * `-value - 1`
 */
void cbor_set_uint64(cbor_item_t* item, ulong value);

/** Queries the integer width
 *
 *  @param item[borrow] positive or negative integer item
 *  @return the width
 */
cbor_int_width cbor_int_get_width(const cbor_item_t* item);

/** Marks the integer item as a positive integer
 *
 * The data value is not changed
 *
 * @param item[borrow] positive or negative integer item
 */
void cbor_mark_uint(cbor_item_t* item);

/** Marks the integer item as a negative integer
 *
 * The data value is not changed
 *
 * @param item[borrow] positive or negative integer item
 */
void cbor_mark_negint(cbor_item_t* item);

/** Allocates new integer with 1B width
 *
 * The width cannot be changed once allocated
 *
 * @return **new** positive integer or `NULL` on memory allocation failure. The
 * value is not initialized
 */
cbor_item_t* cbor_new_int8();

/** Allocates new integer with 2B width
 *
 * The width cannot be changed once allocated
 *
 * @return **new** positive integer or `NULL` on memory allocation failure. The
 * value is not initialized
 */
cbor_item_t* cbor_new_int16();

/** Allocates new integer with 4B width
 *
 * The width cannot be changed once allocated
 *
 * @return **new** positive integer or `NULL` on memory allocation failure. The
 * value is not initialized
 */
cbor_item_t* cbor_new_int32();

/** Allocates new integer with 8B width
 *
 * The width cannot be changed once allocated
 *
 * @return **new** positive integer or `NULL` on memory allocation failure. The
 * value is not initialized
 */
cbor_item_t* cbor_new_int64();

/** Constructs a new positive integer
 *
 * @param value the value to use
 * @return **new** positive integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_uint8(ubyte value);

/** Constructs a new positive integer
 *
 * @param value the value to use
 * @return **new** positive integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_uint16(ushort value);

/** Constructs a new positive integer
 *
 * @param value the value to use
 * @return **new** positive integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_uint32(uint value);

/** Constructs a new positive integer
 *
 * @param value the value to use
 * @return **new** positive integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_uint64(ulong value);

/** Constructs a new negative integer
 *
 * @param value the value to use
 * @return **new** negative integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_negint8(ubyte value);

/** Constructs a new negative integer
 *
 * @param value the value to use
 * @return **new** negative integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_negint16(ushort value);

/** Constructs a new negative integer
 *
 * @param value the value to use
 * @return **new** negative integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_negint32(uint value);

/** Constructs a new negative integer
 *
 * @param value the value to use
 * @return **new** negative integer or `NULL` on memory allocation failure
 */
cbor_item_t* cbor_build_negint64(ulong value);
