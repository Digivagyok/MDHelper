-- Capture all arguments passed to the function
local args = {...}
    
-- If no arguments are provided, default to "NewNote"
if #args == 0 then
    table.insert(args, "NewNote")
end

-- Join all arguments with underscores
local baseName = table.concat(args, "_")

function NewFileNameGenerator(...)
    return baseName .. "_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".md"
end

local fileName = "Notes\\" .. NewFileNameGenerator(...)

local createNewFile = "powershell -Command mdh " .. fileName .. " h 1 " .. string.gsub(baseName, "_", " ")
os.execute(createNewFile)

local defaultNoteFile = "README.md"

local linkNewFile = "powershell -Command mdh " .. defaultNoteFile .. " link " .. string.gsub(fileName, "\\", "/") .. " " .. baseName
os.execute(linkNewFile)

local openeditor = "nvim " .. fileName
os.execute(openeditor)