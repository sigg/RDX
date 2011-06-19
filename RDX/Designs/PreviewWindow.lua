-- PreviewWindow.lua
-- OpenRDX

------------------------------------------------------------------------
-- GUI Preview unitframe
--   By: Daniel LY (Sigg, Rashgarroth realm)
------------------------------------------------------------------------

local preview_window;

local function OpenPreviewWindow(parent)
	if preview_window then return preview_window; end
	
	preview_window = VFLUI.AcquireFrame("Frame");
	preview_window:SetParent(parent);
	preview_window:SetPoint("LEFT", parent or VFLParent, "RIGHT", 5, -2);
	preview_window:SetWidth(304); 
	preview_window:SetHeight(452);
	preview_window:SetBackdrop(VFLUI.DefaultDialogBorder);
	preview_window:Show();
	
	--local top = VFLUI.AcquireFrame("Frame");
	--top:SetParent(preview_window);
	--top:SetPoint("TOPLEFT", preview_window, "TOPLEFT", 2, -2);
	--top:SetWidth(300); 
	--top:SetHeight(80);
	--top:Show();
	--preview_window.top = top;
	
	local middle = VFLUI.AcquireFrame("Frame");
	middle:SetParent(preview_window);
	middle:SetAllPoints(preview_window);
	--middle:SetBackdrop(VFLUI.DarkDialogBackdrop);
	middle:SetBackdrop({
		bgFile="Interface\\Addons\\VFL\\Skin\\Checker", tile = true, tileSize = 16,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	});
	middle:Show();
	--middle.tex = VFLUI.CreateTexture(middle);
	--middle.tex:SetDrawLayer("BACKGROUND", 0);
	--middle.tex:SetAllPoints(middle);
	--middle.tex:SetTexCoord(0, 0.5, 0, 0.5);
	--middle.tex:SetTexture("Interface\\Addons\\VFL\\Skin\\Checker3");
	--middle.tex:SetHorizTile(true);
	--middle.tex:SetVertTile(true);
	--middle.tex:Show();
	preview_window.middle = middle;
	
	--local bottom = VFLUI.AcquireFrame("Frame");
	--bottom:SetParent(preview_window);
	--bottom:SetPoint("TOPLEFT", middle, "BOTTOMLEFT", 0, 0);
	--bottom:SetWidth(346); 
	--bottom:SetHeight(68);
	--bottom:Show();
	--preview_window.bottom = bottom;
	
	local bottom = VFLUI.List:new(dlg, 8, VFLUI.Selectable.AcquireCell_smallFont);
	local function elad(cell, data)
		cell.text:SetText(data);
		if(data ~= "Errors") then
			cell.selTexture:Hide();
		else
			cell.selTexture:SetVertexColor(0.75,0,0); cell.selTexture:Show();
		end
	end;
	bottom:SetPoint("TOPLEFT", middle, "BOTTOMLEFT", 0, -2);
	bottom:SetWidth(250); bottom:SetHeight(68); bottom:Rebuild(); bottom:Hide();
	preview_window.bottom = bottom;
	
	function HideErrors()
		bottom:Hide();
	end
	function ShowErrors(err)
		bottom:Show();
		local ec, et = err:Count(), err:ErrorTable();
		bottom:SetDataSource(elad, function() return ec + 1; end, function(x) if(x == 1) then return "Errors"; else return et[x-1]; end; end);
	end
	
	local curUF, unit = nil, nil;
	local function UpdateUnitFrameDesign(state, path)
		if not InCombatLockdown() then
			-- Destroy the old frame
			if curUF then curUF:Destroy(); curUF = nil; end
			-- Load the ufstate.
			local dstate = RDX.DesignState:new();
			local winstate = RDX._exportedWindowState;
			local _errs = VFL.Error:new();
			dstate:SetContainingWindowState(winstate);
			dstate:LoadDescriptor(state:GetDescriptor(), path);
			if not dstate:ApplyAll(_errs) then
				--_errs:ToErrorHandler("RDX", VFLI.i18n("Could not load DesignType at <preview>"));
				--return;
				ShowErrors(_errs);
			else
				HideErrors();
			end
			local createFrame = RDX.DesignGeneratingFunctor(dstate, "", true);
			if not createFrame then return; end
			-- Success, update the uf.
			curUF = VFLUI.AcquireFrame("Frame"); 
			VFLUI.StdSetParent(curUF, preview_window.middle);
			createFrame(curUF);
			curUF:SetPoint("CENTER", preview_window.middle, "CENTER", 0, 0); 
			curUF:Show();
			
			if curUF then
				unit = RDXDAL.ProjectUnitID("player");
				if unit then
					curUF._paintmask = 1;
					local succ,err = pcall(curUF.SetData, curUF, 1, unit.uid, unit);
					if not succ then RDXDK.PrintError(win, "PrevSetData", err); end
				end
				if curUF:GetWidth() > 300 then
					preview_window:SetWidth(curUF:GetWidth());
					preview_window:SetHeight(curUF:GetHeight());
					preview_window:ClearAllPoints();
					preview_window:SetPoint("TOP", parent, "BOTTOM", 5, 0);
				else
					preview_window:SetWidth(curUF:GetWidth());
					preview_window:SetHeight(curUF:GetHeight());
				end
			end
		end
	end
	
	RDXIEEvents:Bind("REBUILD", nil, UpdateUnitFrameDesign, "IEREBUILD");
	
	local unit;
	local function PaintUnitFrame()
		if curUF then 
			unit = RDXDAL.ProjectUnitID("player");
			if unit then
				curUF._paintmask = 1;
				curUF:SetData(1, unit.uid, unit);
			end
		end
	end
	VFLT.AdaptiveSchedule("__uf_preview", 1, PaintUnitFrame);
	
	--preview_window.UpdateFrame = UpdateUnitFrameDesign;
	
	preview_window.Destroy = VFL.hook(function(s)
		if curUF then curUF:Destroy(); end
		VFLT.AdaptiveUnschedule("__uf_preview");
		RDXIEEvents:Unbind("IEREBUILD");
		preview_window.bottom:Destroy(); preview_window.bottom = nil;
		--VFLUI.ReleaseRegion(preview_window.middle.tex); preview_window.middle.tex = nil;
		preview_window.middle:Destroy(); preview_window.middle = nil;
		--preview_window.top:Destroy(); preview_window.top = nil;
	end, preview_window.Destroy);
	
	return preview_window;
end

local function ClosePreviewWindow()
	if preview_window then preview_window:Destroy(); preview_window = nil; end
	return true;
end

local function TogglePreviewWindow(parent)
	if preview_window then
		return ClosePreviewWindow();
	else
		return OpenPreviewWindow(parent);
	end
end

local function PaintPreviewWindow(state)
	if preview_window then preview_window.UpdateFrame(state); end
	return true;
end

--RDX.PaintPreviewWindow = PaintPreviewWindow;
RDX.TogglePreviewWindow = TogglePreviewWindow;
RDX.ClosePreviewWindow = ClosePreviewWindow;
RDX.OpenPreviewWindow = OpenPreviewWindow;
