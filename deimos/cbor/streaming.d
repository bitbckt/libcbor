module deimos.cbor.streaming;

import deimos.cbor.callbacks;
import deimos.cbor.data;

/*
 * Copyright (c) 2014-2019 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

extern (C):

/** Stateless decoder
 *
 * Will try parsing the \p buffer and will invoke the appropriate callback on
 * success. Decodes one item at a time. No memory allocations occur.
 *
 * @param buffer Input buffer
 * @param buffer_size Length of the buffer
 * @param callbacks The callback bundle
 * @param context An arbitrary pointer to allow for maintaining context.
 */
cbor_decoder_result cbor_stream_decode(cbor_data buffer, size_t buffer_size,
        const cbor_callbacks* callbacks, void* context);
