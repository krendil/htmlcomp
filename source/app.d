import std.stdio;

import std.array;
import std.datetime;
import std.range;

immutable source = import("getting-started-with-microformats2.htm");

immutable libs = ["Arsd", "Gumbo-d", "KXML", "Tango"];

void main()
{
    auto results = benchmark!(runArsd, runGumbo, runKXML, runTango)(10000);

    foreach( lib, time; libs[].zip(results[]) ) {
        writefln( "%s:\t%.3f s", lib, time.to!("seconds", double) );
    }
}

void runArsd() {
    import htmlcomp.arsd;
    auto e = run(source);
}

void runGumbo() {
    import htmlcomp.gumbo;
    auto e = run(source);
}

void runKXML() {
    import htmlcomp.kxml;
    auto e = run(source);
}

void runTango() {
    import htmlcomp.tango;
    auto e = run(source);
}
