module htmlcomp.gumbo;

import std.array;
import std.datetime;
import std.exception;
import std.string;

import gumbo.capi;
import gumbo.node;
import gumbo.parse;

import htmlcomp.entry;

public Entry run(string source) {

    auto doc = Output.fromString(source).document();
    Entry entry;

    auto h_entry = doc.getMf2Prop("h-entry");

    auto p_name = h_entry.getMf2Prop("p-name");
    entry.name = p_name.getInnerText();

    auto p_author = h_entry.getMf2Prop("p-author");
    entry.author = p_author.getInnerText();

    auto p_summary = h_entry.getMf2Prop("p-summary");
    entry.summary = p_summary.getInnerText();

    auto dt_published = h_entry.findChild!Element( 
            (e) => ( hasClass("dt-published")(e) && (e.getAttribute("datetime") !is null) ));
    enforce(dt_published !is null, "No dt-published found");
    entry.published = SysTime.fromISOExtString(dt_published.getAttribute("datetime").value);

    auto e_content = h_entry.getMf2Prop("e-content");
    entry.content = source[e_content.startPos().offset..e_content.endPos().offset];

    return entry;
}

private bool delegate(Element) hasClass(string className) {
    return (e) {
        auto cl = e.getAttribute("class");
        return cl !is null && cl.value.indexOf(className) >= 0;
    };
}

private Element getMf2Prop(Node parent, string propertyName) {
    auto prop = parent.findChild!Element( hasClass(propertyName) );
    enforce(prop !is null, "No %s found", propertyName);
    return prop;
}

private string getInnerText(Element el) {
    auto sb = appender!string();

    foreach( child; el.children ) {
        switch(child.type) {

            case GumboNodeType.GUMBO_NODE_TEXT:
            case GumboNodeType.GUMBO_NODE_CDATA:
                sb ~= (cast(Text)child).text;
                break;

            case GumboNodeType.GUMBO_NODE_ELEMENT:
                sb ~= (cast(Element)child).getInnerText();
                break;

            default:
                break;

        }
    }
    return sb.data;
}
