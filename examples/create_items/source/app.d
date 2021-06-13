/*
 * Copyright (c) 2014-2020 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

import cbor;
import core.stdc.stdio;
import core.stdc.stdlib;

void main() {
    /* Preallocate the map structure */
    cbor_item_t* root = cbor_new_definite_map(2);
    scope(exit) cbor_decref(&root);

    /* Add the content */

    cbor_pair awesome = { key: cbor_move(cbor_build_string("Is CBOR awesome?")), value: cbor_move(cbor_build_bool(true)) };

    cbor_map_add(root, awesome);

    cbor_pair answer = { key: cbor_move(cbor_build_uint8(42)), value: cbor_move(cbor_build_string("Is the answer")) };

    cbor_map_add(root, answer);

    /* Output: `length` bytes of data in the `buffer` */
    ubyte* buffer;
    size_t buffer_size;

    size_t length = cbor_serialize_alloc(root, &buffer, &buffer_size);
    scope(exit) free(buffer);

    fwrite(buffer, 1, length, stdout);

    fflush(stdout);
}
