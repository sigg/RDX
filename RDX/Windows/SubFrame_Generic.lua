-- UnitFrameGlue.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--

----------------------------------------------------------
-- A generic frame feature usable in mod construction.
----------------------------------------------------------
RDX.RegisterFeature({
	name = "Generic Subframe";
	title = "Generic Frame",
	category = "Subframes";
	invisible = true;
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Frame") then return nil; end
		if state:Slot("DesignFrame") then return nil; end
		if state:Slot("CreateSubFrame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if (not desc) or (not desc.w) or (not desc.h) then
			VFL.AddError(errs, VFLI.i18n("Bad or missing width and height parameters."));
			return nil;
		end
		state:AddSlot("UnitWindow");
		state:AddSlot("DesignFrame");
		state:AddSlot("SetupSubFrame");
		state:AddSlot("SubFrameDimensions");
		return true;
	end;
	ApplyFeature = function(desc, state)
		------------ Metadata
		local applyData = state:GetSlotFunction("_ApplyData");
		local dx,dy = desc.w,desc.h;
		local t1dx, t2dx = desc.tdx, dx - desc.tdx;
		-- Attach a function allowing other processes to get the ambient dimensions of the unit frame
		state:_Attach(state:Slot("SubFrameDimensions"), nil, function() return dx,dy; end);

		local function cleanup(frame)
			frame._data = nil;
			frame.button:SetScript("OnClick", nil);
			frame.bar:SetValue(0);
			frame.text1:SetTextColor(1,1,1,1); frame.text1:SetText("");
			frame.text2:SetTextColor(1,1,1,1); frame.text2:SetText("");
		end

		------------ Frame handling
		local function createFrame(frame)
			frame:SetWidth(dx); frame:SetHeight(dy);
			local bar = VFLUI.AcquireFrame("StatusBar");
			bar:SetParent(frame); bar:SetFrameLevel(frame:GetFrameLevel() - 1);
			bar:SetWidth(dx); bar:SetHeight(dy);
			bar:SetPoint("TOPLEFT", frame, "TOPLEFT");
			bar:SetStatusBarTexture("Interface\\Addons\\RDX\\Skin\\bar1");
			bar:SetMinMaxValues(0,1); bar:Show();
			frame.bar = bar;

			local btn = VFLUI.AcquireFrame("Button");
			VFLUI.StdSetParent(btn, frame, 1);
			btn:SetAllPoints(frame); btn:Show();
			frame.button = btn;
			
			local txt = VFLUI.CreateFontString(frame);
			txt:SetWidth(t1dx); txt:SetHeight(dy);
			txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));
			txt:SetJustifyH("LEFT"); txt:SetJustifyV("CENTER");
			txt:SetPoint("LEFT", frame, "LEFT"); txt:Show();
			frame.text1 = txt;

			txt = VFLUI.CreateFontString(frame);
			txt:SetWidth(t2dx); txt:SetHeight(dy);
			txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));
			txt:SetJustifyH("RIGHT"); txt:SetJustifyV("CENTER");
			txt:SetPoint("RIGHT", frame, "RIGHT"); txt:Show();
			frame.text2 = txt;

			frame.Cleanup = cleanup; frame.SetData = applyData;

			function frame:GetHotspot() return self.button; end
			
			frame.Destroy = VFL.hook(function(s)
				s.Cleanup = nil; s.SetData = nil; s.GetHotspot = nil;
				s._data = nil;
				s.bar:Destroy(); s.bar = nil;
				s.button:Destroy(); s.button = nil;
				VFLUI.ReleaseRegion(s.text1); s.text1 = nil;
				VFLUI.ReleaseRegion(s.text2); s.text2 = nil;
			end, frame.Destroy);

			return frame;
		end
	
		-- The UnitFrame function should return something out of the pool.
		-- When the UnitFrame is released, its OnDeparent will be called,
		-- returning it to the pool afterwards.
		state:_Attach(state:Slot("SetupSubFrame"), nil, createFrame);

		return true;
	end,
	UIFromDescriptor = VFL.Nil,
	CreateDescriptor = function() return { feature = "Generic Subframe" }; end,
});

