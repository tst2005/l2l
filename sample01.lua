
--- Example 11 ---

-- I am running this line in the compilation step!
-- This too!
-- 1 + 1 = 2!
-- Okay that's enough.

--- Example 12 ---

local sample01= (function() 
require('core').import('core')
local _var1
_var1=print("\n--- Example 1 ---\n")
function _bang(n)
local _var0
local _var1
do
if (n==0) then
_var1=1
goto _var1
end
if (n==1) then
_var1=1
goto _var1
end
_var1=(n * _bang((n - 1)))
::_var1::
end
return _var1
end
_var1=print(_bang(100))
_var1=print("\n--- Example 2 ---\n")
function _206_163()
local _var0
return print("ΣΣΣ")
end
_var1=_206_163()
_var1=print("\n--- Example 3 ---\n")
hello_world="hello gibberish world"
_var1=print(table.concat(pack(string.gsub(hello_world, "gibberish ", "")), " "))
_var1=print("\n--- Example 4 ---\n")
_var1=map(print, list({1,2,3,map((function (x)
local _var0
return (x * 5)
end), list({1,2,3}))}))
_var1=print("\n--- Example 5 ---\n")
local _var18
do
local a=(1 + 2)
local b=(3 + 4)
_var18=print(a)
_var18=print(b)
end
_var1=print("\n--- Example 6 ---\n")
dict("write", (function (self, x)
local _var0
return print(x)
end))["write"]=dict("write", (function (self, x)
local _var0
return print(x)
end))
_var1=dict("write", (function (self, x)
local _var0
return print(x)
end))["write"]
_var1=print("\n--- Example 7 ---\n")
_var1=print((function (x, y)
local _var0
return (x + y)
end)(10, 20))
_var1=print("\n--- Example 8 ---\n")
local _var31
do
local a=(7 * 8)
_var31=map(print, vector(1, 2, a, 4))
end
_var1=print("\n--- Example 9 ---\n")
local _var37
do
local dict=dict("a", "b", 1, 2, "3", 4)
_var37=print(dict["a"], "b")
_var37=print(dict.a, "b")
_var37=print(dict[1], 2)
end
_var1=print("\n--- Example 10 ---\n")
_C[hash("--")]=function (block, stream, str)
local _var0
local _var1
_var1 =( (
"\n--" ) .. (
tostring(str) ) .. "" )
return table.insert(block, _var1)
end
_var1=_C[hash("--")]

--This is a comment
_C[hash("_do")]=function (block, stream, ...)
local _var0
local _var1
_var1=block
local var = declare(_var1)
_var1[#_var1]=_var1[#_var1].." "..tostring("\ndo")
local _64action=map((function (obj)
local _var0
local _var1
_var1=block
local _64=compile(block, stream, obj)
table.insert(_var1, var)
_var1[#_var1]=_var1[#_var1].." "..tostring("=")
table.insert(_var1, _64)
end), pack(...))
_var1[#_var1]=_var1[#_var1].." "..tostring("\nend")
return var
end
_var1=_C[hash("_do")]
_var1=print("\n--- Example 11 ---\n")
_var1=print("\n--- Did you see what was printed while compiling? ---\n")
local _var52 
do
_var52 =
print(1)
_var52 =
print(2) 
end
_var1=print("\n--- Example 12 ---\n")
_C[hash("_if")]=function (block, stream, condition, action, otherwise)
local _var0
local _var1
do
local fn=eval(list({symbol("lambda"),list({symbol("condition"),symbol("action"),symbol("otherwise")}),list({symbol("quasiquote"),list({symbol("cond"),condition,action,otherwise})})}))
_var1=compile(block, stream, fn(condition, action, otherwise))
end
return _var1
end
_var1=_C[hash("_if")]
local _var60
do
local a=2
local _var63
do
if (a=="1") then
_var63=print("a == 1")
goto _var63
end
local _var69
do
if (a==2) then
_var69=print("a == 2")
goto _var69
end
_var69=print("a != 2")
::_var69::
end
_var63=_var69
::_var63::
end
_var60=_var63
end
_C[hash("GAMMA")]=function (block, stream)
local _var0
local _var1
do
local fn=eval(list({symbol("lambda"),nil,list({symbol("quote"),list({symbol("_43"),1,2})})}))
_var1=compile(block, stream, fn())
end
return _var1
end
_var1=_C[hash("GAMMA")]
_C[hash("BETA")]=function (block, stream)
local _var0
local _var1
do
local fn=eval(list({symbol("lambda"),nil,list({symbol("quote"),list({symbol("_46_46"),list({symbol("tostring"),list({symbol("GAMMA")})}),"4"})})}))
_var1=compile(block, stream, fn())
end
return _var1
end
_var1=_C[hash("BETA")]
_C[hash("ALPHA")]=function (block, stream)
local _var0
local _var1
do
local fn=eval(list({symbol("lambda"),nil,list({symbol("quote"),list({symbol("BETA")})})}))
_var1=compile(block, stream, fn())
end
return _var1
end
_var1=_C[hash("ALPHA")]
local _var89
_var89 =( (
tostring((1 + 2)) ) .. (
"4" ) .. "" )
_var1=print(_var89)
return _var1
end)()
