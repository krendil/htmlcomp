module htmlcomp.tango;

import tango.text.xml.Document;

import htmlcomp.entry;

Entry run(string source) {

    Entry entry;
    auto doc = new Document!char();

    doc.parse(source);  //Throws exception

    return entry;
}
