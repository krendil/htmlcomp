module htmlcomp.arsd;

import std.datetime;
import std.exception;

import arsd.dom;

import htmlcomp.entry;

public Entry run(string html) {
    Document doc = new Document(html);
    Entry entry;

    Element h_entry = doc.querySelector(".h-entry");

    enforce(h_entry !is null, "No h-entry found");

    entry.name = findText(h_entry, ".p-name");
    entry.author = findText(h_entry, ".p-author");
    entry.summary = findText(h_entry, ".p-summary");

    auto dt_published = h_entry.querySelector(".dt-published[datetime]");
    enforce(dt_published !is null, "h-entry has no dt-published");
    entry.published = SysTime.fromISOExtString(dt_published.getAttribute("datetime"));

    auto e_content = h_entry.querySelector(".e-content");
    enforce(e_content !is null, "h-entry has no e-content");
    entry.content = e_content.innerHTML;

    return entry;
}

string findText(Element h_entry, string selector) {
    auto prop = h_entry.querySelector(selector);
    enforce(prop !is null, "h-entry has no %s", selector[1..$]);
    return prop.innerText;
}
