module htmlcomp.entry;

import std.datetime;

struct Entry {
    string name;
    string author;
    SysTime published;
    string summary;
    string content;
}

