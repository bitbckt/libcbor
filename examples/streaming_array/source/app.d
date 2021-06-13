/*
 * Copyright (c) 2014-2020 Pavel Kalvoda <me@pavelkalvoda.com>
 *
 * libcbor is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

import cbor;
import core.stdc.stdio;
import core.stdc.stdlib;
import std.string;

void usage() {
  printf("Usage: streaming_array <N>\n");
  printf("Prints out serialized array [0, ..., N-1]\n");
  exit(1);
}

enum size_t BUFFER_SIZE = 8;
ubyte[BUFFER_SIZE] buffer;
FILE* out_;

void flush(size_t bytes) {
  if (bytes == 0) exit(1);  // All items should be successfully encoded
  if (fwrite(&buffer, ubyte.sizeof, bytes, out_) != bytes) exit(1);
  if (fflush(out_)) exit(1);
}

/*
 * Example of using the streaming encoding API to create an array of integers
 * on the fly. Notice that a partial output is produced with every element.
 */
void main(string[] args) {
  if (args.length != 2) usage();
  long n = strtol(args[1].toStringz, null, 10);
  out_ = freopen(null, "wb", stdout);
  if (out_ is null) exit(1);

  // Start an indefinite-length array
  flush(cbor_encode_indef_array_start(buffer.ptr, BUFFER_SIZE));
  // Write the array items one by one
  for (uint i = 0; i < n; i++) {
    flush(cbor_encode_uint32(i, buffer.ptr, BUFFER_SIZE));
  }
  // Close the array
  flush(cbor_encode_break(buffer.ptr, BUFFER_SIZE));

  if (fclose(out_)) exit(1);
}
