-- SecureMouseBindings.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Implementation of WoW 2.0 secure bindings.

-- Create the Clique array if it doesn't exist
if not ClickCastFrames then ClickCastFrames = {}; end

----------------------------------
-- Implementation details
----------------------------------
local function SecureDecodeClickSymbol(cs)
	local ret = "";
	if string.find(cs, "A", 1, true) then ret = ret .. "alt-"; end
	if string.find(cs, "C", 1, true) then ret = ret .. "ctrl-"; end
	if string.find(cs, "S", 1, true) then ret = ret .. "shift-"; end
	local _,_,qq = string.find(cs, "(%d)$");
	if qq then
		return ret, qq;
	else
		return nil;
	end
end

--- Given mouse binding data, apply attributes to the SecureUnitFrame given.
function RDX.ApplySecureAttributes(mbData, uf, btnPrefix)
	if (not mbData) or (not type(mbData) == "table") then return; end
	local qq, pfx, btn = nil, nil, nil;
	for k,v in pairs(mbData) do
		qq = RDX.GetClickActionByName(v.action);
		pfx,btn = SecureDecodeClickSymbol(k);
		if qq and qq.ApplySecureAttributes and pfx then
			uf:RegisterForClicks("AnyDown");
			qq.ApplySecureAttributes(v, uf, pfx, btnPrefix .. btn);
		end
	end
end

local function ClearModifiedAttributes(uf, p, s)
	uf:SetAttribute(p .. "type" .. s, nil);
	uf:SetAttribute(p .. "spell" .. s, nil);
	uf:SetAttribute(p .. "macro" .. s, nil);
	uf:SetAttribute(p .. "macrotext" .. s, nil);
	uf:SetAttribute(p .. "unitsuffix" .. s, nil);
end

local function ClearModifierKeys(uf, s)
	ClearModifiedAttributes(uf, "", s);
	ClearModifiedAttributes(uf, "shift-", s);
	ClearModifiedAttributes(uf, "ctrl-", s);
	ClearModifiedAttributes(uf, "alt-", s);
	ClearModifiedAttributes(uf, "ctrl-shift-", s);
	ClearModifiedAttributes(uf, "alt-shift-", s);
	ClearModifiedAttributes(uf, "alt-ctrl-", s);
	ClearModifiedAttributes(uf, "alt-ctrl-shift-", s);
end

--- Clear secure bindings that might have been "left over" from previous RDX usage.
function RDX.ClearSecureClickAttributes(uf)
	uf:SetAttribute("unitsuffix", nil);
	for i=1,5 do ClearModifierKeys(uf, i); end
end

------------------
-- The secure mouse bindings feature
------------------
RDX.RegisterFeature({
	name = "mousebindings"; version = 1;
	title = VFLI.i18n("Mouse Bindings"); category = VFLI.i18n("Mouse Bindings");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Layout") then return nil; end
		if not state:Slot("SecureDataSource") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if (not desc) or (not desc.mbFriendly) then
			VFL.AddError(errs, VFLI.i18n("Bad or missing Mouse bindings."));
			return nil;
		end
		if not RDXDB.CheckObject(desc.mbFriendly, "MouseBindings") then VFL.AddError(errs, VFLI.i18n("Invalid MouseBinding")); return nil; end
		state:AddSlot("MouseBindings");	state:AddSlot("SecureSubframes");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local path, friendly, hostile = desc.mbFriendly, nil, nil;
		local pkg,file = RDXDB.ParsePath(path);
		if (not pkg) or (not file) then return; end

		friendly = RDXDB.GetObjectData(path);
		if friendly and friendly.data then friendly=friendly.data; else friendly=nil; end
		if not friendly then return; end

		local hsid = desc.hotspot;	
		if (type(hsid) ~= "string") or (strtrim(hsid) == "") then hsid = nil; else hsid = strtrim(hsid); end
		
		local txttmp = "";
		if hsid == nil then 
			txttmp = VFLI.i18n("Edit Bindings");
		else
			txttmp = VFLI.i18n("Edit Bindings : ") .. hsid;
		end

		-- Add a menu to the window to edit the mouse bindings
		state:Attach("Menu", true, function(win, mnu)
			table.insert(mnu, {
				text = txttmp;
				OnClick = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Edit", VFLDIALOG);
				end;
			});
		end);

		-- When our parent object changes we want to rebuild the window.
		state:Attach("Create", true, function(w)
			RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(up, uf)
				if(up == pkg) and (uf == file) then RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, w._path); end
			end, w._path .. path);
		end);
		state:Attach("Destroy", true, function(w)
			RDXDBEvents:Unbind(w._path .. path);
		end);

		-- Apply attributes
		if state:Slot("AcclimatizeAdvice") then
			state:Attach(state:Slot("AcclimatizeAdvice"), true, function(headerGrid, header, frame)
				local hs = frame:GetHotspot(hsid);
				if hs then
					RDX.ClearSecureClickAttributes(hs);
					RDX.ApplySecureAttributes(friendly, hs, "");
				end
			end);
		end
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ofMB = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty=="MouseBindings"); end);
		ofMB:SetLabel(VFLI.i18n("Mouse bindings"));
		if desc and desc.mbFriendly then ofMB:SetPath(desc.mbFriendly); end
		ui:InsertFrame(ofMB);
	
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Hotspot"));
		ed_name.editBox:SetText(desc.hotspot or "");
		ui:InsertFrame(ed_name);

		function ui:GetDescriptor()
			return { 
				feature = "mousebindings"; version = 1;
				hotspot = ed_name.editBox:GetText();
				mbFriendly = ofMB:GetPath();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "mousebindings"; version = 1;
			hotspot = "";
			mbFriendly = "default:bindings"; 
		};
	end;
});

-- Update old mousebindings
RDX.RegisterFeature({
	name = "Mouse Bindings (Secure)"; version = 31337; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "mousebindings"; desc.version = 1; 
		desc.hotspot = "";
		return true;
	end;
});

------------------------------------------
-- "Exported" mouse bindings - export to external click cast mods
------------------------------------------
RDX.RegisterFeature({
	name = "Mouse Bindings (Exported)";
	invisible = true;
	category = VFLI.i18n("Mouse Bindings");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Layout") then return nil; end
		if (not state:Slot("AcclimatizeAdvice")) or (not state:Slot("DeacclimatizeAdvice")) then return nil; end
		if state:Slot("MouseBindings") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("MouseBindings");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("AcclimatizeAdvice"), true, function(headerGrid, header, frame)
			local hs = frame:GetHotspot();
			if hs then ClickCastFrames[hs] = true; end
		end);
		state:Attach(state:Slot("DeacclimatizeAdvice"), true, function(headerGrid, header, frame)
			local hs = frame:GetHotspot();
			if hs then ClickCastFrames[hs] = nil; end
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function()
		return { feature = "Mouse Bindings (Exported)" };
	end;
});

