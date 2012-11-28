
-----------------------------------------------------------
-- cache element
-----------------------------------------------------------

local function ElementCachePopup(db, callback, frame, point, dx, dy)
	local qq = {};
	for _,v in pairs(db) do
		local dbEntry = v;
		table.insert(qq, {
			text = v;
			OnClick = function()
				VFL.poptree:Release();
				callback(dbEntry);
			end
		});
	end
	table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
	table.insert(qq, { text = VFLI.i18n("Element not listed...") });
	VFL.poptree:Begin(200, 12, frame, point, dx, dy);
	VFL.poptree:Expand(nil, qq, 20);
end

function VFLUI.CreateElementEdit(parent, text, db)
	local ui = VFLUI.LabeledEdit:new(parent, 200);
	ui:SetText(text); ui:Show();
	
	local btn = VFLUI.Button:new(ui);
	btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
	btn:SetPoint("RIGHT", ui.editBox, "LEFT"); btn:Show();
	btn:SetScript("OnClick", function()
		ElementCachePopup(db, function(x) 
			if x then ui.editBox:SetText(x); end
		end, btn, "CENTER");
	end);
	
	ui.Destroy = VFL.hook(function(s)
			btn:Destroy(); btn = nil;
	end, ui.Destroy);
	
	return ui;
end