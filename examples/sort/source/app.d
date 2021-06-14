/*
 * Copyright (c) 2014-2020 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

import cbor;
import core.stdc.stdio;
import core.stdc.stdlib;

/*
 * Illustrates how to use the contiguous storage of nested items with
 * standard library functions.
 */

extern (C) int compareUint(const void *a, const void *b) {
    ubyte av = cbor_get_uint8(*(cast(cbor_item_t**) a));
    ubyte bv = cbor_get_uint8(*(cast(cbor_item_t**) b));

  if (av < bv)
    return -1;
  else if (av == bv)
    return 0;
  else
    return 1;
}

void main() {
  cbor_item_t *array = cbor_new_definite_array(4);
  cbor_array_push(array, cbor_move(cbor_build_uint8(4)));
  cbor_array_push(array, cbor_move(cbor_build_uint8(3)));
  cbor_array_push(array, cbor_move(cbor_build_uint8(1)));
  cbor_array_push(array, cbor_move(cbor_build_uint8(2)));

  qsort(cbor_array_handle(array), cbor_array_size(array), (cbor_item_t *).sizeof,
        &compareUint);

  cbor_describe(array, stdout);
  fflush(stdout);
}
