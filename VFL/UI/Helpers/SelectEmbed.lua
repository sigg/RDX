-- SelectEmbed.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Select/embed controls are a common RDX UI object wherein the user firsts
-- selects a "class" or "category" from a dropdown list, and then receives
-- additional options for that category. The additional options appear in the
-- form of an embeddable sub-interface.
--
-- The category must be represented by a table that has a GetUI function. 
--
-- The category is selected by a VFLUI.Dropdown. You provide the ddgen function
-- that generates this dropdown. The text can be whatever you like, however
-- the value must be the corresponding category's table.
--
-- The load function must accept a pointer to the control and a descriptor.
-- It should return a UI generated from the descriptor, properly parented
-- to the control. It should also return the (text,value) pair for the
-- dropdown.

VFLUI.SelectEmbed = {};
function VFLUI.SelectEmbed:new(parent, ddWidth, ddgen, load)
	local self = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(self, parent);

	-- Subcontrols
	local child = nil;
	local lbl = VFLUI.MakeLabel(nil, self, "");
	lbl:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -6);

	--------------------- INTERNAL API
	local function DestroyChild()
		if child then 
			child:Destroy(); child=nil; 
			VFLUI.UpdateDialogLayout(self);
		end
	end
	local function SetChild(ch)
		if ch then
			child = ch;
			child:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -25); child:Show();
			VFLUI.UpdateDialogLayout(self);
		end
	end
	local function SetClass(qq)
		DestroyChild(); SetChild(qq.GetUI(self));
	end
	-- Layout core.
	self.DialogOnLayout = function(s)
		local rw = VFL.clamp(s:GetWidth() - ddWidth, 0, 5000);
		lbl:SetWidth(rw);
		if child then
			child:SetWidth(s:GetWidth()); -- width constrained downward
			child:DialogOnLayout();
			self:SetHeight(25 + child:GetHeight()); -- height constrained upward
		else
			self:SetHeight(25);
		end
	end

	-- Dropdown control
	local dd = VFLUI.Dropdown:new(self, ddgen, function(val) SetClass(val) end);
	dd:SetPoint("TOPRIGHT", self, "TOPRIGHT"); dd:SetWidth(150); dd:Show();

	--------------------- EXTERNAL API
	-- Set the label text
	function self:SetText(t)
		lbl:SetText(t);
	end
	-- Get a descriptor object.
	self.GetDescriptor = function(s)
		if child then return child:GetDescriptor();	else return nil; end
	end
	-- Set the descriptor object
	self.SetDescriptor = function(s, desc)
		DestroyChild();
		local ui, ddText, ddVal = load(s, desc);
		dd:RawSetSelection(ddText, ddVal);
		if ui then SetChild(ui); end
	end

	self.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil; s.SetDescriptor = nil; s.SetText = nil;
		dd:Destroy(); dd = nil;
		if child then child:Destroy(); child = nil; end
	end, self.Destroy);

	return self;
end
