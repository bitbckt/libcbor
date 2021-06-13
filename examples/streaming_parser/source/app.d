/*
 * Copyright (c) 2014-2020 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

import cbor;
import core.stdc.stdlib;
import core.stdc.stdio;
import core.stdc.string;
import std.string;

void usage() {
    import std.stdio;
    writeln("Usage: streaming_parser [input file]");
    exit(1);
}

/*
 * Illustrates how one might skim through a map (which is assumed to have
 * string keys and values only), looking for the value of a specific key
 *
 * Use the examples/data/map.cbor input to test this.
 */

const char* key = "a secret key";
bool key_found = false;

extern (C) void find_string(void* _ctx, cbor_data buffer, size_t len) {
    if (key_found) {
        printf("Found the value: %.*s\n", len, buffer);
        key_found = false;
    } else if (len == strlen(key)) {
        key_found = (memcmp(cast(void*) key, cast(void*) buffer, len) == 0);
    }
}

void main(string[] args) {
    if (args.length != 2) usage();
    FILE* f = fopen(args[1].toStringz, "rb");
    if (f is null) usage();
    fseek(f, 0, SEEK_END);
    size_t length = cast(size_t) ftell(f);
    fseek(f, 0, SEEK_SET);
    ubyte* buffer = cast(ubyte*) malloc(length);
    scope(exit) free(buffer);
    fread(buffer, length, 1, f);

    cbor_callbacks callbacks = cbor_empty_callbacks;
    cbor_decoder_result decode_result;
    size_t bytes_read = 0;
    callbacks.string = &find_string;
    while (bytes_read < length) {
        decode_result = cbor_stream_decode(buffer + bytes_read, length - bytes_read,
                                           &callbacks, null);
        bytes_read += decode_result.read;
    }

    fclose(f);
}
