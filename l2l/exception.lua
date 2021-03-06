--- Return a the line, and its start and end indices in a string at a position.
-- @param src The string.
-- @param index The character index.
-- @return the line, start index, end index
local function lineat(src, index)
  if index > #src or index < 0 then
    print(debug.traceback())
    error('index out of bounds: '.. index)
  end
  local cursor = index
  local start
  local char = src:sub(cursor, cursor)
  local line = ""
  while cursor > 0 and char ~= "\n" do
    line = char..line
    cursor = cursor - 1
    char = src:sub(cursor, cursor)
  end
  cursor = math.max(cursor, 0)
  start = cursor
  cursor = index + 1
  char = src:sub(cursor, cursor)
  while cursor <= #src and char ~= "\n" do
    line = line..char
    cursor = cursor + 1
    char = src:sub(cursor, cursor)
  end
  cursor = math.min(cursor, #src + 1)
  local check = src:sub(start + 1, cursor - 1)
  if check ~= line then
    error('lineat error: \n"'..line ..'"\n does not match \n"'..check..'"')
  end
  return line, start + 1, cursor-1
end

--- Return a string representing an arrow, that can be aligned with a line.
-- Given a multi-line string, this function returns a arrow made of "~" with a
-- "^" arrow head that can be used to point to the `index` position of string 
-- `src`. The string returned will be of one line. Align this string below the 
-- targeted line in `src` to point at the target character.
-- @param src The string.
-- @param index The character index.
-- @return string representing the arrow.
-- @see formatsource
local function pointat(src, index)
  local _, start, finish = lineat(src, index)
  local display = ""
  for i=start, finish, 1 do
    if i == index then
      display = display.."^"
    else
      display = display.."~"
    end
  end
  return display
end

--- Return a line number, given a string and a character index.
-- This function is 1-based. The first line is line 1.
-- @param src The string to look at.
-- @param index The character index.
-- @return number of lines until `index` in the string `src`.
local function numberat(src, index)
  local count = 1
  for i=1, #src:sub(0, index) do
    if src:sub(i, i) == "\n" then
      count = count + 1
    end
  end
  return count
end

--- Format a multi-line string with line numbers, an arrow, and a message.
-- This function can be used for generating exception messages. Given a string
-- a message, and a target character index, it can generate a string that
-- shows the message at which position in which line, along with an arrow
-- generated by `pointat(src, index)` to point at the particular line. It also
-- shows the lines around the targeted line as context, and line numbers on
-- the left side. The string is stored in a table, split by line breaks.
-- For example,
-- `formatsource("for i, k in z do\nprint(1)\nend", "A statement", 20)`
-- {"A statement at line 2, column 3:",
-- "1 |for i, k in z do",
-- "2 |print(1)",
-- "  |~~^~~~~~",
-- "3 |end"}
-- @param src The string.
-- @param message The message to show, appended with line number and index.
-- @param index The character index.
-- @return array of strings.
local function formatsource(src, message, index)
  local messages = {}
  local linenumber = numberat(src, index)
  local line, start, finish = lineat(src, index)
  local columnnumber = index - start + 1

  table.insert(messages, tostring(message).." at line "..linenumber..
    ", column "..columnnumber..":")
  local stack, content, _ = {}
  for _=1, 3 do
    if start >= 2 then
      content, start = lineat(src, start-2)
      table.insert(stack, content)
    end
  end
  for i=0, #stack-1 do
    table.insert(messages, linenumber-(#stack-i).."\t|"..stack[(#stack-i)])
  end
  table.insert(messages, linenumber.."\t|".. line)
  table.insert(messages, "\t|".. pointat(src, index))
  for i=1, 3 do
    if finish + 1 <= #src then
      content, _, finish = lineat(src, finish+1)
      table.insert(messages, (linenumber + i).."\t|"..content)
    end
  end
  return messages
end

local function raise(except, stream, position)
  if type(except) == "string" then
    error("expected non-string exception." .. except)
    local index = stream:seek("cur")
    stream:seek("set", 0)
    local src = stream:read("*all")
    stream:seek("set", index)
    error(table.concat(formatsource(src, except, index), "\n"))
  else
    if stream then
      if position then
        stream:seek("set", position)
      end
      except = except(stream)
    end
    error(except)
  end
end

local Exception;
Exception = {
  __tostring = function(self)
    return self.message or ""
  end,
  __call = function(self, stream, ...)
    if not stream then
      print(debug.traceback())
      error("stream argument expected")
    end
    local index = stream:seek("cur")
    local message
    stream:seek("set", 0)
    local src = stream:read("*all")
    stream:seek("set", index)
    if type(self.message) == "function" then
      if not ... and self.parameters then
        message = self:message(stream, unpack(Exception.parameters))
      elseif ... then
        message = self:message(stream, ...)
      else
        message = self:message(stream)
      end
    else
      message = self.message
    end
    local messages = formatsource(src, message, index)
    local instance = setmetatable({
      stream=stream, 
      parameters={...},
      message=table.concat(messages, "\n")}, self)
    return instance
  end
}


local function exception(message)
  local class = setmetatable({message=message,
    __tostring = function(self) 
      return tostring(self.message) or ""
    end}, Exception)
  class.__index = class
  return class
end

return setmetatable({
    exception = exception,
    Exception = Exception,
    raise = raise,
    formatsource = formatsource,
    lineat = lineat,
    pointat = pointat,
    numberat = numberat
}, {__call = function(_, ...) return exception(...) end})
