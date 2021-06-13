/*
 * Copyright (c) 2014-2020 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

import deimos.cbor;
import core.stdc.stdio;
import core.stdc.stdlib;
import std.string;

void usage() {
    printf("Usage: readfile [input file]\n");
    exit(1);
}

/*
 * Reads data from a file. Example usage:
 * $ ./examples/readfile examples/data/nested_array.cbor
 */

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

    /* Assuming `buffer` contains `length` bytes of input data */
    cbor_load_result result;
    cbor_item_t* item = cbor_load(buffer, length, &result);

    if (result.error.code != cbor_error_code.CBOR_ERR_NONE) {
        printf(
               "There was an error while reading the input near byte %zu (read %zu
        bytes in total): ",
               result.error.position, result.read);
        final switch (result.error.code) {
        case cbor_error_code.CBOR_ERR_MALFORMATED:
            printf("Malformed data\n");
            break;

        case cbor_error_code.CBOR_ERR_MEMERROR:
            printf("Memory error -- perhaps the input is too large?\n");
            break;

        case cbor_error_code.CBOR_ERR_NODATA:
            printf("The input is empty\n");
            break;

        case cbor_error_code.CBOR_ERR_NOTENOUGHDATA:
            printf("Data seem to be missing -- is the input complete?\n");
            break;

        case cbor_error_code.CBOR_ERR_SYNTAXERROR:
            printf(
                   "Syntactically malformed data -- see
            http://tools.ietf.org/html/rfc7049\n");
            break;

        case cbor_error_code.CBOR_ERR_NONE:
            break;

        }
        exit(1);
    }

    /* Pretty-print the result */
    cbor_describe(item, stdout);
    fflush(stdout);
    /* Deallocate the result */
    cbor_decref(&item);

    fclose(f);
}
