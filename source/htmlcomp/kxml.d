module htmlcomp.kxml;

import std.exception;
import std.string;

import kxml.xml;

import htmlcomp.entry;


public Entry run(string source) {
    //Turns out, HTML5 != XML

    auto doc = XmlDocument(source); //Throws exception

    auto nodes = doc.parseXPath(xpath.format("h-entry"));
    enforce(nodes.length > 0, "No h-entries found");

    auto h_entry = nodes[0];

    return Entry();
}

private immutable xpath = "//*[contains(@class, %s)]";
