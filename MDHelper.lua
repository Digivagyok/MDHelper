local scriptDir = debug.getinfo(1, "S").source:match("@(.*[\\/])")
package.path = scriptDir .. "?.lua;" .. package.path

require("InsertionMethods")

local filename = arg[1] or "newMarkDown.md"
local insertArg = arg[2]


function ErrorScreen()
    print("Error: Invalid insertion method: " .. tostring(insertArg))
    print("Run 'lua markDownHelper.lua --help' for a list of valid methods.")
    return
end

function HelpScreen()
    print("\nMarkdown Helper Script")
    print("======================")
    print("This script helps you generate Markdown content with various formatting options.")
    print("\nUsage:")
    print("  lua markDownHelper.lua <output_file> <insertion_method> [arguments...]")
    print("\nArguments:")
    print("  <output_file>       The Markdown file to write to (e.g., 'output.md').")
    print("  <insertion_method>  The method to use for inserting content (see below).")
    print("  [arguments...]      Additional arguments required by the chosen method.")
    print("\nAvailable Insertion Methods:")
    print("  h <level> <title>               Insert a header (e.g., '# Header').")
    print("  ch <count> <checked>            Insert checkboxes (checked: true/false).")
    print("  ol <count> <depth>              Insert an ordered list with optional depth.")
    print("  ul <count> <depth>              Insert an unordered list with optional depth.")
    print("  bq <count> <depth>              Insert block quotes with optional depth.")
    print("  img <src> <alt_text>            Insert an image with source and alt text.")
    print("  link <src> <alt_text>           Insert a hyperlink with source and alt text.")
    print("  tb <rows> <cols> [headers...]   Insert a table with the specified rows, columns, and optional headers.")
    print("  mark <words...>                 Highlight text using <mark> tags.")
    print("  x <words...>                    Cross out text using ~~strikethrough~~.")
    print("  sup <words...>                  Insert superscript text.")
    print("  sub <words...>                  Insert subscript text.")
    print("  bold <words...>                 Insert bold text (**bold**).")
    print("  italic <words...>               Insert italic text (*italic*).")
    print("  bolditalic <words...>           Insert bold and italic text (***bolditalic***).")
    print("  c <words...>                    Insert inline code (`code`).")
    print("  mc <src_file> <start> <end> <language>")
    print("      Insert a multiline code block from a file with optional line range and language.")
    print("\nExamples:")
    print("  lua markDownHelper.lua output.md h 1 \"My Header\"")
    print("  lua markDownHelper.lua output.md ch 3 true")
    print("  lua markDownHelper.lua output.md mc source.lua 5 10 python")
    print("\nFor more information, refer to the documentation or source code.")
end


-- main
-- remove the ".\" prefix 
if filename:sub(1, 2) == ".\\" or filename:sub(1, 2) == "./" then
    filename = filename:sub(3)
end

if arg[1] == "--help" or arg[2] == "--help" then
    HelpScreen()
    return
end

if not insertArg or not insertionMethods[insertArg] then
    ErrorScreen()
end

if insertArg and insertionMethods[insertArg] then
    local file = OpenOrCreate(filename)
    file:write("\n")
    insertionMethods[insertArg](file, select(3, unpack(arg)))
    file:close()
else
    ErrorScreen()
end