module deimos.cbor.arrays;

import deimos.cbor.data;

/*
 * Copyright (c) 2014-2019 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

extern (C):

/** Get the number of members
 *
 * @param item[borrow] An array
 * @return The number of members
 */
size_t cbor_array_size(const cbor_item_t* item);

/** Get the size of the allocated storage
 *
 * @param item[borrow] An array
 * @return The size of the allocated storage (number of items)
 */
size_t cbor_array_allocated(const cbor_item_t* item);

/** Get item by index
 *
 * @param item[borrow] An array
 * @param index The index
 * @return **incref** The item, or `NULL` in case of boundary violation
 */
cbor_item_t* cbor_array_get(const cbor_item_t* item, size_t index);

/** Set item by index
 *
 * Creating arrays with holes is not possible
 *
 * @param item[borrow] An array
 * @param value[incref] The item to assign
 * @param index The index, first item is 0.
 * @return true on success, false on allocation failure.
 */
bool cbor_array_set(cbor_item_t* item, size_t index, cbor_item_t* value);

/** Replace item at an index
 *
 * The item being replace will be #cbor_decref 'ed.
 *
 * @param item[borrow] An array
 * @param value[incref] The item to assign
 * @param index The index, first item is 0.
 * @return true on success, false on allocation failure.
 */
bool cbor_array_replace(cbor_item_t* item, size_t index, cbor_item_t* value);

/** Is the array definite?
 *
 * @param item[borrow] An array
 * @return Is the array definite?
 */
bool cbor_array_is_definite(const cbor_item_t* item);

/** Is the array indefinite?
 *
 * @param item[borrow] An array
 * @return Is the array indefinite?
 */
bool cbor_array_is_indefinite(const cbor_item_t* item);

/** Get the array contents
 *
 * The items may be reordered and modified as long as references remain
 * consistent.
 *
 * @param item[borrow] An array
 * @return #cbor_array_size items
 */
cbor_item_t** cbor_array_handle(const cbor_item_t* item);

/** Create new definite array
 *
 * @param size Number of slots to preallocate
 * @return **new** array or `NULL` upon malloc failure
 */
cbor_item_t* cbor_new_definite_array(size_t size);

/** Create new indefinite array
 *
 * @return **new** array or `NULL` upon malloc failure
 */
cbor_item_t* cbor_new_indefinite_array();

/** Append to the end
 *
 * For indefinite items, storage may be realloacted. For definite items, only
 * the preallocated capacity is available.
 *
 * @param array[borrow] An array
 * @param pushee[incref] The item to push
 * @return true on success, false on failure
 */
bool cbor_array_push(cbor_item_t* array, cbor_item_t* pushee);
