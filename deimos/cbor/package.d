module deimos.cbor;

public import deimos.cbor.arrays;
public import deimos.cbor.bytestrings;
public import deimos.cbor.callbacks;
public import deimos.cbor.common;
public import deimos.cbor.configuration;
public import deimos.cbor.data;
public import deimos.cbor.encoding;
public import deimos.cbor.floats_ctrls;
public import deimos.cbor.ints;
public import deimos.cbor.maps;
public import deimos.cbor.serialization;
public import deimos.cbor.streaming;
public import deimos.cbor.strings;
public import deimos.cbor.tags;

/*
 * Copyright (c) 2014-2019 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

import core.stdc.stdio;

extern (C):

/*
 * ============================================================================
 * High level decoding
 * ============================================================================
 */

/** Loads data item from a buffer
 *
 * @param source The buffer
 * @param source_size
 * @param result[out] Result indicator. #CBOR_ERR_NONE on success
 * @return **new** CBOR item or `NULL` on failure. In that case, \p result
 * contains location and description of the error.
 */
cbor_item_t* cbor_load(cbor_data source, size_t source_size, cbor_load_result* result);

/** Deep copy of an item
 *
 * All the reference counts in the new structure are set to one.
 *
 * @param item[borrow] item to copy
 * @return **new** CBOR deep copy
 */
cbor_item_t* cbor_copy(cbor_item_t* item);

void cbor_describe(cbor_item_t* item, FILE* out_);
