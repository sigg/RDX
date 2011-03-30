-- AssistFeatures.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- This file contains copyrighted content. Use and distribution is subject to 
-- the terms of a separate license. Unlicensed copying is prohibited.
--
-- Features that allow target and targettarget info to be displayed for a unit.

local tempUnit = RDXDAL.tempUnit;

--------------------------------------
-- The assist frame.
--------------------------------------
RDX.RegisterFeature({
	name = "Assist Frames",
	title = "Assist Frame",
	category = VFLI.i18n("Subframes");
	IsPossible = function(state)
		--if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Frame") then return nil; end
		if state:Slot("StatusWindow") then return nil; end
		if state:Slot("DesignFrame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if (not desc) or (not desc.design) then
			VFL.AddError(errs, VFLI.i18n("Bad or missing unit frame design."));
			return nil;
		else
			if not RDX.LoadDesign(desc.design, RDXDB.ObjectState.Verify, state) then
				VFL.AddError(errs, VFLI.i18n("Could not load UnitFrameDesign at <") .. tostring(desc.design) .. ">.");
				return nil;
			end
		end
		state:AddSlot("UnitWindow", nil);
		state:AddSlot("DesignFrame");
		state:AddSlot("AssistFrame");
		state:AddSlot("SetupSubFrame");
		state:AddSlot("SubFrameDimensions");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local path = desc.design;
		local desPkg, desFile = RDXDB.ParsePath(desc.design);
		local showAssist, showTT = desc.showAssist, desc.showTT;
		-- Load the functions from the design object provided by the user.
		local ufstate = RDX.LoadDesign(desc.design, nil, state);
		local setupFrame = RDX.DesignGeneratingFunctor(ufstate);	
		if not setupFrame then return nil; end

		-- Attach a function allowing other processes to get the ambient dimensions of the unit frame
		local dx,dy = ufstate:RunSlot("FrameDimensions"); ufstate = nil;
		if (showAssist and showTT) then
			dx = dx * 3;
		elseif (showAssist or showTT) then
			dx = dx * 2;
		end
		state:Attach("SubFrameDimensions", nil, function() return dx,dy; end);
		
		state:_Attach(state:Slot("Create"), true, function(w)
			-- When the window's underlying unitframe is updated, rebuild it.
			RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(up, uf)
				if(up == desPkg) and (uf == desFile) then RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, w._path); end
			end, w._path .. path);
		end);

		local function assistSetData(frame, icv, uid)
			if not uid then return; end
			if frame.assist then
				tempUnit.uid = uid;	frame.assist:SetData(icv, uid, tempUnit);
			end
			uid = uid .. "target";
			if UnitExists(uid) then
				tempUnit.uid = uid; frame.target:SetData(icv, uid, tempUnit);
				frame.target:Show();
			else
				frame.target:Hide(); 
			end
			
			if frame.tt then
				uid = uid .. "target";
				tempUnit.uid = uid;	frame.tt:SetData(icv, uid, tempUnit);
			end
		end
		local function assistCleanup(frame)
			frame.target:Cleanup();
			if frame.assist then frame.assist:Cleanup(); end
			if frame.tt then frame.tt:Cleanup(); end
		end
		
		-- Create a new assist subframe.
		local function setupAssistFrame(frame)
			frame:SetWidth(dx); frame:SetHeight(dy);
			frame.GetHotspot = VFL.Nil;

			local subf = VFLUI.AcquireFrame("Frame");
			VFLUI.StdSetParent(subf, frame, 1); subf:Show();
			subf:SetPoint("TOPLEFT", frame, "TOPLEFT");
			setupFrame(subf); subf._paintmask = 1;
			frame.target = subf;

			if showAssist then
				subf = VFLUI.AcquireFrame("Frame");
				VFLUI.StdSetParent(subf, frame, 1); subf:Show();
				subf:SetPoint("TOPLEFT", frame, "TOPLEFT");	frame.target:SetPoint("TOPLEFT", subf, "TOPRIGHT");
				setupFrame(subf); subf._paintmask = 1;
				frame.assist = subf;
			end

			if showTT then
				subf = VFLUI.AcquireFrame("Frame");
				VFLUI.StdSetParent(subf, frame, 1); subf:Show();
				subf:SetPoint("TOPLEFT", frame.target, "TOPRIGHT");
				setupFrame(subf); subf._paintmask = 1;
				frame.tt = subf;
			end

			frame.SetData = assistSetData; frame.Cleanup = assistCleanup;

			frame.Destroy = VFL.hook(function(s)
				s.SetData = nil; s.Cleanup = nil; s.OnDeparent = nil; s.GetHotspot = nil;
				if s.assist then s.assist:Destroy(); s.assist = nil; end
				if s.target then s.target:Destroy(); s.target = nil; end
				if s.tt then s.tt:Destroy(); s.tt = nil; end
			end, frame.Destroy);

			return frame;
		end
		
		state:Attach("SetupSubFrame", nil, setupAssistFrame);
		
		-- Make a menu for editing the unitframe type.
		state:Attach("Menu", true, function(win, mnu)
			--if RDXU.devflag then
				table.insert(mnu, {
					text = VFLI.i18n("Edit UnitFrame");
					OnClick = function()
						VFL.poptree:Release();
						RDXDB.OpenObject(path, "Edit", VFLDIALOG);
					end;
				});
			--end
		end);

		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ofDesign = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty=="Design"); end);
		ofDesign:SetLabel(VFLI.i18n("Design type:"));
		if desc and desc.design then ofDesign:SetPath(desc.design); end
		ui:InsertFrame(ofDesign);

		local chk_asst = VFLUI.Checkbox:new(ui); chk_asst:Show();
		chk_asst:SetText(VFLI.i18n("Show assist"));
		if desc and desc.showAssist then chk_asst:SetChecked(true); else chk_asst:SetChecked(); end
		ui:InsertFrame(chk_asst);

		local chk_tt = VFLUI.Checkbox:new(ui); chk_tt:Show();
		chk_tt:SetText(VFLI.i18n("Show second-order target"));
		if desc and desc.showTT then chk_tt:SetChecked(true); else chk_tt:SetChecked(); end
		ui:InsertFrame(chk_tt);

		function ui:GetDescriptor()
			return { 
				feature = "Assist Frames",
				design = ofDesign:GetPath();
				showAssist = chk_asst:GetChecked();
				showTT = chk_tt:GetChecked();
			};
		end
		
		return ui;
	end,
	CreateDescriptor = function() 
		return { 
			feature = "Assist Frames", 
			showAssist = true, showTT = nil, 
 		}; 
	end,
});
