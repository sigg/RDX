-----------------------------------
-- The CooldownFilter object type.
-----------------------------------
local dlg = nil;

local function WriteFilter(dest, src)
	VFL.empty(dest);
	local auname, flag;
	for _,v in ipairs(src) do
		flag = nil;
		local test = string.sub(v, 1, 1);
		if test == "!" then
			flag = true;
			v = string.sub(v, 2);
		end
		local testnumber = tonumber(v);
		if testnumber then
			auname = GetSpellInfo(v);
			if flag then
				dest["!" .. auname] = true;
			else
				dest[auname] = true;
			end
		else
			if flag then
				dest["!" .. v] = true;
			else
				dest[v] = true;
			end
		end
	end
end

--RDXDB.WriteFilter = WriteFilter;

RDXDB.RegisterObjectType({
	name = "CooldownFilter";
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		if dlg then return; end
		if (not path) or (not md) or (not md.data) then return nil; end
		local inst = RDXDB.GetObjectInstance(path, true);

		dlg = VFLUI.Window:new(parent);
		VFLUI.Window.SetDefaultFraming(dlg, 22);
		dlg:SetTitleColor(0,0,.6);
		dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
		dlg:SetPoint("CENTER", RDXParent, "CENTER");
		dlg:SetWidth(310); dlg:SetHeight(270);
		dlg:SetText(VFLI.i18n("Edit CooldownFilter: ") .. path);
		dlg:SetClampedToScreen(true);
		
		VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
		if RDXPM.Ismanaged("CooldownFilter") then RDXPM.RestoreLayout(dlg, "CooldownFilter"); end

		local le_names = VFLUI.ListEditor:new(dlg, md.data, function(cell,data) 
			if type(data) == "number" then
				local name = GetSpellInfo(data);
				cell.text:SetText(name);
			else
				local test = string.sub(data, 1, 1);
				if test == "!" then
					local uname = string.sub(data, 2);
					local vname = GetSpellInfo(uname);
					if vname then
						cell.text:SetText("!" .. vname);
					else
						cell.text:SetText(data);
					end
				else
					cell.text:SetText(data);
				end
			end
		end, function()
			local db = RDXDAL._GetBuffCache();
			VFL.copyInto(db, RDXDAL._GetDebuffCache());
			return db;
		end);
		le_names:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
		le_names:SetWidth(300);	le_names:SetHeight(183); le_names:Show();
		
		--dlg:Show();
		dlg:_Show(RDX.smooth);

		local esch = function()
			dlg:_Hide(RDX.smooth, nil, function()
				RDXPM.StoreLayout(dlg, "CooldownFilter");
				dlg:Destroy(); dlg = nil;
			end);
		end
		VFL.AddEscapeHandler(esch);
		
		local function Save()
			local desc = le_names:GetList();
			if desc then
				local flag;
				local descid = {};
				for k,v in pairs(desc) do
					flag = nil;
					local test = string.sub(v, 1, 1);
					if test == "!" then
						flag = true;
						v = string.sub(v, 2);
					end
					local testnumber = tonumber(v);
					if testnumber then
						if flag then
							descid[k] = "!" .. testnumber;
						else
							descid[k] = testnumber;
						end
					else
						if flag then
							local spellid = RDXSS.GetSpellIdByLocalName(v);
							if spellid then
								descid[k] = "!" .. spellid;
							else
								descid[k] = "!" .. v;
							end
						else
							descid[k] = RDXSS.GetSpellIdByLocalName(v) or v;
						end
					end
				end
				md.data = descid;
				if inst then WriteFilter(inst, descid); end
			end
			VFL.EscapeTo(esch);
		end
	
		local savebtn = VFLUI.SaveButton:new()
		savebtn:SetScript("OnClick", Save);
		dlg:AddButton(savebtn);
		
		local closebtn = VFLUI.CloseButton:new(dlg);
		closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
		dlg:AddButton(closebtn);

		dlg.Destroy = VFL.hook(function(s)
			le_names:Destroy(); le_names = nil;
		end, dlg.Destroy);
	end;
	Instantiate = function(path, md)
		if type(md.data) ~= "table" then return nil; end
		local inst = {};
		WriteFilter(inst, md.data);
		return inst;
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});
