import std.stdio;

import std.datetime;

import htmlcomp.arsd;

immutable source = import("getting-started-with-microformats2.htm");

immutable libs = ["Arsd"];

void main()
{
    auto arsd = new ArsdTest(source);

    auto results = benchmark!(&arsd.test)(100);

    foreach( lib, time; results ) {
        writefln( "%s:\t%.3f", lib, time.to!("seconds", double) );
    }
}
