--- Snippet.lua
-- @author (C)2006 Bill Johnson and The VFL Project
-- @class file
-- @name VFL.Snippet
-- @description The Snippet object allows the on-the-fly assembly of a snippet of code.

VFL.Snippet = {};
VFL.Snippet.__index = VFL.Snippet;

--- Construct a new, empty snippet
-- @return a new VFL.Snippet object
function VFL.Snippet:new()
	local self = {};
	self.code = "";
	setmetatable(self, VFL.Snippet);
	return self;
end

--- Append code to the snipet
-- @param x The code
function VFL.Snippet:AppendCode(x) self.code = self.code .. x; end

--- Prepend code to the snipet
-- @param x The code
function VFL.Snippet:PrependCode(x) self.code = x .. self.code; end

--- Append a snippet code to the snipet
-- @param s A Snippet
function VFL.Snippet:AppendSnippet(s) self.code = self.code .. s:GetCode(); end

--- Prepend a snippet code to the snipet
-- @param s A Snippet
function VFL.Snippet:PrependSnippet(s) self.code = s:GetCode() .. self.code; end

--- Get code of the snippet
-- @return code
function VFL.Snippet:GetCode() return self.code; end

--- Clean the code of the snippet
function VFL.Snippet:Clear() self.code = ""; end

