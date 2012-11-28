-- CheckList.lua
-- VFL
-- (C)2006 Bill Johnson
--
-- A scrollable "checklist" with checkmarks on the left and textual items on 
-- the right.
--
-- A CheckList is an instance of List and so needs to have its Rebuild and
-- Update methods called when appropriate.

local function frameAlloc(p)
	local c = VFLUI.Checkbox:new(p);
	c.OnDeparent = c.Destroy;
	return c;
end

local function selectAll(self)
	for k,v in pairs(self.data) do v.sel = true; end
	self:Update();
end

local function selectNone(self)
	for k,v in pairs(self.data) do v.sel = nil; end
	self:Update();
end

VFLUI.CheckList = {};
function VFLUI.CheckList:new(parent, chex)
	chex = chex or {};

	local self = VFLUI.List:new(parent, 12, frameAlloc);
	self.OnClick = VFL.Noop;

	local function setData(cell, data, pos)
		cell:SetText(data.text);
		if data.isHeader then
			cell.check:Hide(); cell:SetBackdrop(VFLUI.WhiteBackdrop); cell:SetBackdropColor(0,0,1);
			return;
		end
		cell.check:Show(); cell:SetBackdrop(nil);
		if data.disabled then cell.check:Disable(); else cell.check:Enable(); end
		cell:SetChecked(data.sel);
		-- CATACLYSM
		--cell.check:SetScript("OnClick", function() 
		--	data.sel = this:GetChecked();
		--	self:OnClick(data, this:GetChecked());
		--end);
		cell.check:SetScript("OnClick", function(self2) 
			data.sel = self2:GetChecked();
			self:OnClick(data, self2:GetChecked());
		end);
	end

	self:SetDataSource(setData, VFL.ArrayLiterator(chex));

	self.data = chex;

	--- Select all/none operators
	self.SelectAll = selectAll; self.SelectNone = selectNone;

	self.Destroy = VFL.hook(function(s)
		s.SelectAll = nil; s.SelectNone = nil;
		s.data = nil; data = nil;
	end, self.Destroy);

	return self;
end
