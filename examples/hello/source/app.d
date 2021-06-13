/*
 * Copyright (c) 2014-2020 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

import cbor;
import std.stdio;

void main() {
    writeln("Hello from libcbor ", CBOR_VERSION);
    writeln("Custom allocation support: ", CBOR_CUSTOM_ALLOC ? "yes" : "no");
    writeln("Pretty-printer support: ", CBOR_PRETTY_PRINTER ? "yes" : "no");
    writeln("Buffer growth factor: ", cast(float) CBOR_BUFFER_GROWTH);
}
