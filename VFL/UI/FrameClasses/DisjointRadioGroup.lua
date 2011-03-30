-- DisjointRadioGroup.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A DisjointRadioGroup is a radio group whose buttons can be scattered
-- in different locations.
--
-- The buttons of a DisjointRadioGroup must be destroyed individually.

VFLUI.DisjointRadioGroup = {};

-- Create a new DisjointRadioGroup.
function VFLUI.DisjointRadioGroup:new()
	local self = {};
	local buttons, value = {}, nil;

	function self:CreateRadioButton(parent)
		local b = VFLUI.RadioButton:new(parent);
		b:Show(); 
		table.insert(buttons, b);
		local n = table.getn(buttons);
		b.button:SetScript("OnClick", function() self:SetValue(n); end);
		return b;
	end

	function self:SetValue(v)
		value = v;
		for idx,button in ipairs(buttons) do
			if(idx == v) then button:SetChecked(true); else button:SetChecked(nil); end
		end
	end
	function self:GetValue() return value; end
	
	function self:Destroy() buttons = nil; value = nil; end
	
	return self;
end
