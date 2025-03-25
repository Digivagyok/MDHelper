-- if the language is not recognized by the file ending you can set a default language
local defaultLanguage = "plaintext"

local extensionToLanguage = {
    [".js"] = "javascript",
    [".jsx"] = "javascript",
    [".mjs"] = "javascript",
    [".ts"] = "typescript",
    [".tsx"] = "javascript",
    [".py"] = "python",
    [".java"] = "java",
    [".c"] = "c",
    [".cpp"] = "cpp",
    [".cs"] = "csharp",
    [".rb"] = "ruby",
    [".php"] = "php",
    [".go"] = "go",
    [".rs"] = "rust",
    [".kt"] = "kotlin",
    [".swift"] = "swift",
    [".pl"] = "perl",
    [".lua"] = "lua",
    [".html"] = "html",
    [".css"] = "css",
    [".scss"] = "scss",
    [".json"] = "json",
    [".xml"] = "xml",
    [".yaml"] = "yaml",
    [".md"] = "markdown",
    [".sh"] = "bash",
    [".ps1"] = "powershell",
    [".sql"] = "sql",
    [".r"] = "r",
    [".jl"] = "julia",
    [".m"] = "matlab",
    [".tf"] = "terraform",
    [".ini"] = "ini",
    [".toml"] = "toml",
    [".diff"] = "diff",
    [".dockerfile"] = "dockerfile",
    [".txt"] = "plaintext"
}

function GetLanguageFromExtension(extension)
    return extensionToLanguage[extension] or defaultLanguage
end

function GetFileExtension(filename)
    return filename:match("^.+(%..+)$") or "" -- Returns the extension or an empty string if none is found
end

function OpenOrCreate(filename)
    return io.open(filename, "a+")
end

function unpack(t, i)
    i = i or 1 -- Default index to 1 if not provided
    if i > #t then
        return nil -- Base case: return nil when index exceeds table size
    end
    return t[i], unpack(t, i + 1) -- Return the current element and recursively unpack the rest
end

function NormalStyling(file, method, methodend, ...)
    methodend = methodend or method
    local words = {...}

    file:write(method)
    for _, word in ipairs(words) do
        file:write(" " .. word .. " ")
    end
    file:write(methodend .. "\n")
end

function InsertHeader(file, num, ...)
    num = num or 1
    local hashmarks = string.rep("#", num)
    NormalStyling(file, hashmarks, " ", ...)
end

function InsertCheckBox(file, num, checked)
    num = num or 1
    local checkbox = "- [ ] "
    if checked then
        checkbox = "- [x] "
    end
    
    for i = 1, num do
        file:write(checkbox .. "\n")
    end
end

function InsertOrderedList(file, num, depth)
    num = num or 1
    depth = depth or 0
    local indentation = ""

    for i = 1, depth do
        indentation = indentation .. "\t"
    end

    for i = 1, num do
        file:write(indentation .. i .. ".  \n")
    end
end

function InsertUnorderedList(file, num, depth)
    num = num or 1
    depth = depth or 0
    local indentation = ""

    for i = 1, depth do
        indentation = indentation .. "\t"
    end

    for i = 1, num do
        file:write(indentation .. "- \n")
    end
end

function InsertBlockQuote(file, num, depth)
    num = num or 1
    depth = depth or 1
    local angelBrackets = ""

    for i = 1, depth do
        angelBrackets = angelBrackets .. ">"
    end

    for i = 1, num do
        file:write(angelBrackets .. " \n")
    end
end

function InsertImage(file, src, altText)
    src = string.gsub(src, "\\", "/") or "link"
    altText = altText or "Alt"

    file:write("![" .. altText .. "](" .. src .. ")\n")
end

function InsertLink(file, src, altText)
    src = string.gsub(src, "\\", "/") or "link"
    altText = altText or "Link"

    file:write("[" .. altText .. "](" .. src .. ")\n")
end

function InsertTable(file, rows, cols, ...)
    rows = rows or 2
    cols = cols or 2
    local headers = {...}

    for i = 1, rows + 1 do
        if i == 1 then
            for j = 1, cols do
                file:write("| " .. (headers[j] or ("Header " .. j)) .. " ")
            end
        elseif i == 2 then
            for j = 1, cols do
                file:write("| --- ")
            end
        else
            for j = 1, cols do
                file:write("| col " .. j .. " ")
            end
        end
        file:write("|\n")
    end
end



function InsertMarkedText(file, ...)
    NormalStyling(file, "<mark>", "</mark>", ...)
end

function InsertCrossedText(file, ...)
    NormalStyling(file, "~~", nil, ...)
end

function InsertSupText(file, ...)
    NormalStyling(file, "<sup>", "</sup>", ...)
end

function InsertSubText(file, ...)
    NormalStyling(file, "<sub>", "</sub>", ...)
end

function InsertBold(file, ...)
    NormalStyling(file, "**", nil, ...)
end

function InsertItalic(file, ...)
    NormalStyling(file, "*", nil, ...)
end

function InsertBoldItalic(file, ...)
    NormalStyling(file, "***", nil, ...)
end

function InsertSingleLineCode(file, ...)
    NormalStyling(file, "`", nil, ...)
end

function InsertMultiLineCodeFromFile(file, srcFile, startLine, endLine, language)
    startLine = tonumber(startLine) or 1
    endLine = tonumber(endLine)
    language = language or GetLanguageFromExtension(GetFileExtension(srcFile))

    if startLine and endLine then
        if startLine > endLine then
            startLine, endLine = endLine, startLine
        end
    end

    local src = io.open(srcFile, "r")
    if not src then
        file:write("``` html \n")
        file:write("<!-- Error: Could not open source file: " .. tostring(srcFile) .. " -->\n")
        file:write("```\n")
        print("Error: Could not open source file: " .. tostring(srcFile) .. "\n")
        return
    end

    if language then
        file:write("``` " .. language .. "\n")
    else
        file:write("```\n")
    end

    local currentLine = 0
    for line in src:lines() do
        currentLine = currentLine + 1
        if currentLine >= startLine and (not endLine or currentLine <= endLine) then
            file:write(line .. "\n")
        end
    end

    src:close()
    file:write("```\n")
end

function InsertNoteBlock(file, ...)
    file:write("> [!NOTE] \n")
    file:write(">")

    local words = {...}
    for _, value in pairs(words) do
        file:write(" " .. value)
    end
    file:write("\n")
end

-- Here are the insertionMethods
-- feel free to change their name
insertionMethods = {}

insertionMethods["h"] = InsertHeader
insertionMethods["ch"] = InsertCheckBox
insertionMethods["ol"] = InsertOrderedList
insertionMethods["ul"] = InsertUnorderedList
insertionMethods["bq"] = InsertBlockQuote
insertionMethods["img"] = InsertImage
insertionMethods["link"] = InsertLink
insertionMethods["tb"] = InsertTable
insertionMethods["table"] = InsertTable
insertionMethods["mark"] = InsertMarkedText
insertionMethods["x"] = InsertCrossedText
insertionMethods["sup"] = InsertSupText
insertionMethods["sub"] = InsertSubText
insertionMethods["bold"] = InsertBold
insertionMethods["b"] = InsertBold
insertionMethods["italic"] = InsertItalic
insertionMethods["i"] = InsertItalic
insertionMethods["bolditalic"] = InsertBoldItalic
insertionMethods["bi"] = InsertBoldItalic
insertionMethods["c"] = InsertSingleLineCode
insertionMethods["mc"] = InsertMultiLineCodeFromFile
insertionMethods["cc"] = InsertMultiLineCodeFromFile
insertionMethods["in"] = InsertNoteBlock
