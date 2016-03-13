-- Skein.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE LICENSE.
-- UNLICENSED COPYING IS PROHIBITED.
--
-- A Skein is a bundle of lines that visually associates two windows.
--
-- Skeins can only be added to windows with Sorts as their underlying data sources.
--
-- The Skein is implemented as a pair of features, one on each window. The source window has the
-- Skein Out feature, and the receiving window has the Skein In feature.
--
-- The properties of the Skein and all of the repainting are associated with the Skein Out feature.

----------------------------------------------------
-- The Layer on which all skeins are painted.
----------------------------------------------------
local skeinLayer = VFLUI.AcquireFrame("Frame");
skeinLayer:SetParent(RDXParent); skeinLayer:SetAllPoints(RDXParent);
skeinLayer:SetFrameStrata("LOW"); skeinLayer:SetFrameLevel(1);
skeinLayer:Show();
VFL.MakeLayer(skeinLayer);


---------------------------------------------------------------------------------------------
-- A SkeinInstance is a single instance of a skein with a defined source and target window.
---------------------------------------------------------------------------------------------
RDX.SkeinInstance = {};
RDX.SkeinInstance.__index = RDX.SkeinInstance;

--- Create a new skein instance between the given pair of open windows.
function RDX.SkeinInstance:new(srcw, dstw)
	if (not srcw) or (not dstw) then return nil; end
	-- Check the source window for an out-skein; if it already has one, we're done.
	if srcw._outSkein then return nil; end
	-- Check the destination window for an in-skein system, and determine if this skein
	-- is already there. If it is, we're out.
	if (not dstw._inSkeins) then return nil; end
	if dstw._inSkeins[srcw] then return nil; end
	if (not dstw:IsShown()) then return nil; end
	-- Make sure the destination window is addressible
	if (not dstw.LookupUnit) then return nil; end

--	RDX.printI("Creating skein from " .. tostring(srcw._path) .. " to " .. tostring(dstw._path));
	if srcw.RepaintAll then srcw:RepaintAll(); end
	
	-- Generate us.
	local self = VFLG.TextureBundle:new(skeinLayer);
	self.LookupUnit = dstw.LookupUnit;
	self.destroyed = nil;
	self.enabled = true; self.order = 10;
	self.c1 = _red; self.c2 = _red;
--	self.c1.a = 1; self.c2.a = 0.5;
	self.w1 = 1; self.w2 = 1;
	setmetatable(self, RDX.SkeinInstance);

	-- Associate us to our windows.
	self.srcw = srcw; self.dstw = dstw;
	srcw._outSkein = self;
	dstw._inSkeins[self] = true;

	return self;
end

--- Disable this skein instance from being painted (e.g. on window move)
function RDX.SkeinInstance:Disable()
	self.enabled = nil;
	self:HideAll();
end

--- Enable this skein instance.
function RDX.SkeinInstance:Enable() self.enabled = true; end

--- Destroy this skein instance, removing it from its underlying windows as well.
function RDX.SkeinInstance:Unravel()
	-- Prevent multiple destroys.
	if self.destroyed then return; end
	self.destroyed = true;
	self:Destroy(); -- Destroy the underlying TextureBundle
	-- Remove references to this instance from the underlying windows.
	self.srcw._outSkein = nil;
	self.dstw._inSkeins[self] = nil;
end

--- Connect a pair of frames on this skein instance.
function RDX.SkeinInstance:Weave(index, f1, f2)
	-- Ignore out of bounds weaves.
	if (not self.enabled) or (not index) or (index < 1) or (index > self.order) then return nil; end
	-- Now, figure out which points we should connect.
	-- If the "left" of F1 is right of the "right" of F2, then connect the left of F1
	-- to the right of F2. Otherwise connect the right of F1 to the left of F2.
	local f1_l, f1_t, f1_r, f1_b = VFLUI.GetUniversalBoundary(f1);
	local f2_l, f2_t, f2_r, f2_b = VFLUI.GetUniversalBoundary(f2);
	if (not f1_l) or (not f2_l) then return; end
	VFLG.SetClipFlag(false);
	-- Case 1 (left F1 -> right F2)
	if(f1_l > f2_r) then
		self:UniversalLine(index, f1_l, (f1_t+f1_b)/2, f2_r, (f2_t+f2_b)/2, VFL.lerp5( (index-1)/self.order, self.w1, self.w2, self.c1.r, self.c2.r, self.c1.g, self.c2.g, self.c1.b, self.c2.b, self.c1.a, self.c2.a ) );
	else -- Case 2 (right F1 -> left F2)
		self:UniversalLine(index, f1_r, (f1_t+f1_b)/2, f2_l, (f2_t+f2_b)/2, VFL.lerp5( (index-1)/self.order, self.w1, self.w2, self.c1.r, self.c2.r, self.c1.g, self.c2.g, self.c1.b, self.c2.b, self.c1.a, self.c2.a ) );
	end
end

-----------------------------------------------------------------
-- The Skein Out feature
-----------------------------------------------------------------
RDX.RegisterFeature({
	name = "Skein Out";
	category = VFLI.i18n("Visualization");
	IsPossible = function(state)
		if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("Layout") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if (not desc) then return nil; end
		if not desc.tw then
			VFL.AddError(errs, VFLI.i18n("Missing target window."));
			return nil;
		end
		if not desc.order then
			VFL.AddError(errs, VFLI.i18n("Missing skein order."));
			return nil;
		end
		if (not desc.thick1) or (not desc.thick2) or (not desc.color) or (not desc.fadeColor) then
			VFL.AddError(errs, VFLI.i18n("Missing visual parameters."));
			return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local targetWindowPath = desc.tw;
		local order, w1, w2, c1, c2 = desc.order, desc.thick1, desc.thick2, desc.color, desc.fadeColor;
		-- On create, get our window object.
		local win = nil;
		state:Attach(state:Slot("Create"), true, function(w)
			win = w;
			win._outSkein = nil;
		end);

		-- On hide, destroy a skein instance if there's one associated to us.
		state:Attach(state:Slot("Hide"), true, function(w)
			local sk = w._outSkein;
			if sk then sk:Unravel(); end
		end);

		-- On update, if we don't have a valid skein instance, try to find our target window and
		-- create a skein instance with it.
		local t = 0;
		state:Attach(state:Slot("Update"), true, function(w)
			-- Prevent spam
			if( (GetTime() - t) < 2 ) then return; end
			t = GetTime();
			-- Early-out if we have a skein instance
			if (not w) or w._outSkein then return; end
			-- Try to get an instance of our target window
			local tw = RDXDB.GetObjectInstance(targetWindowPath, true);
			if not tw then return; end
			-- Try to make a skein instance between these two windows.
			local si = RDX.SkeinInstance:new(w, tw);
			-- Apply parameters
			if si then
				si.order = order; si.w1 = w1; si.w2 = w2; si.c1 = c1; si.c2 = c2;
			end
		end);

		-- On prepaint, hide the entire skein
		state:Attach(state:Slot("TotalPrePaintAdvice"), true, function(w)
			if w._outSkein then w._outSkein:HideAll(); end
		end);

		-- On cell paint, if we have a valid skein instance, find the same unit in the opposite side's
		-- sort and draw a line linking them.
		state:Attach(state:Slot("CellPostPaintAdvice"), true, function(w, cell, index, icv, uid, rdxUnit)
			if not rdxUnit then return; end
			local sk = w._outSkein; if not sk then return; end
			if(not sk.enabled) or (index > sk.order) then return; end
			local tuf = sk.LookupUnit(rdxUnit);
			if not tuf then return; end
			sk:Weave(index, cell, tuf);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local tw = RDXDB.ObjectFinder:new(ui, function(d,p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Window$")); end);
		tw:SetLabel(VFLI.i18n("Target window")); tw:Show();
		if desc and desc.tw then tw:SetPath(desc.tw); end
		ui:InsertFrame(tw);

		local order = VFLUI.LabeledEdit:new(ui, 50); order:Show();
		order:SetText(VFLI.i18n("Skein size"));
		if desc and desc.order then order.editBox:SetText(desc.order); end
		ui:InsertFrame(order);

		local thick1 = VFLUI.LabeledEdit:new(ui, 50); thick1:Show();
		thick1:SetText(VFLI.i18n("Starting thickness"));
		if desc and desc.thick1 then thick1.editBox:SetText(desc.thick1); end
		ui:InsertFrame(thick1);

		local thick2 = VFLUI.LabeledEdit:new(ui, 50); thick2:Show();
		thick2:SetText(VFLI.i18n("Ending thickness"));
		if desc and desc.thick2 then thick2.editBox:SetText(desc.thick2); end
		ui:InsertFrame(thick2);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Starting color:"));
		local swatch_c = VFLUI.ColorSwatch:new(er);
		swatch_c:Show();
		if desc and desc.color then swatch_c:SetColor(VFL.explodeRGBA(desc.color)); end
		er:EmbedChild(swatch_c); er:Show();
		ui:InsertFrame(er);

		er = VFLUI.EmbedRight(ui, VFLI.i18n("Ending color:"));
		local swatch_fc = VFLUI.ColorSwatch:new(er);
		swatch_fc:Show();
		if desc and desc.fadeColor then swatch_fc:SetColor(VFL.explodeRGBA(desc.fadeColor)); end
		er:EmbedChild(swatch_fc); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return {feature = "Skein Out", tw = tw:GetPath(), order = VFL.clamp(order.editBox:GetNumber(), 1, 40),
				thick1 = VFL.clamp(thick1.editBox:GetNumber(), 1, 18), thick2 = VFL.clamp(thick2.editBox:GetNumber(), 1, 18),
				color = swatch_c:GetColor(), fadeColor = swatch_fc:GetColor(),
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {feature = "Skein Out", order = 10, thick1 = 1, thick2 = 1, color = {r=1,g=0,b=0,a=1}, fadeColor = {r=0,g=1,b=0,a=1}};
	end;
});

--------------------------------------------------------------
-- The Skein In feature
--------------------------------------------------------------
RDX.RegisterFeature({
	name = "Skein In";
	category = VFLI.i18n("Visualization");
	IsPossible = function(state)
		if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("Layout") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- On create, allow skein array
		state:Attach(state:Slot("Create"), true, function(w)
			w._inSkeins = {};
		end);
		-- On hide, unravel all skeins
		state:Attach(state:Slot("Hide"), true, function(w)
			if w and w._inSkeins then
				for skein,_ in pairs(w._inSkeins) do
					skein:Unravel();
				end
			end
		end);
		-- On destroy, destroy skein array
		state:Attach(state:Slot("Destroy"), true, function(w)
			w._inSkeins = nil;
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function()
		return {feature = "Skein In"};
	end;
});

-----------------------------------------------------------------
-- The Sort Bar feature
-----------------------------------------------------------------
RDX.RegisterFeature({
	name = "Sort Bars";
	category = VFLI.i18n("Visualization");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("Frame") then return nil; end
		if not state:Slot("RepaintData") then return nil; end
		if not state:Slot("TotalPrePaintAdvice") then return nil; end
		if not state:Slot("CellPostPaintAdvice") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if (not desc) then return nil; end
		if desc.sort then
			local si = RDXDB.GetObjectInstance(desc.sort);
			if not si then
				VFL.AddError(errs, VFLI.i18n("Invalid sort pointer."));
				return nil;
			end
		else
			VFL.AddError(errs, VFLI.i18n("Missing sort pointer."));
			return nil;
		end
		if not desc.order then
			VFL.AddError(errs, VFLI.i18n("Missing order."));
			return nil;
		end
		if (not desc.orientation) or (not desc.thick1) or (not desc.thick2) or (not desc.len1) or (not desc.len2) or (not desc.color) or (not desc.fadeColor) then
			VFL.AddError(errs, VFLI.i18n("Missing visual parameters."));
			return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local si = RDXDB.GetObjectInstance(desc.sort);
		local orientation, order, t1, t2, w1, w2, c1, c2 = desc.orientation, desc.order, desc.thick1, desc.thick2, desc.len1, desc.len2, desc.color, desc.fadeColor;
		-- On create, get our window object.
		local win = nil;
		state:Attach(state:Slot("Create"), true, function(w) win = w; end);

		-- Event hint: sort delta -> Repaintdata
		local mux = state:GetSlotValue("Multiplexer");
		mux:Event_SigUpdateMaskAll(si, 2); -- 2 = generic paintall mask

		-- A little framepool..
		local frames = {};
		local function MakeFrame()
			local tex = VFLUI.CreateTexture(win);
			tex:SetTexture(1,1,1,1); tex:Hide();
			return tex;
		end
		local function GetFrame(n)
			if not win then return nil; end
			if not frames[n] then frames[n] = MakeFrame(); end
			return frames[n];
		end
		local function HideAll()
			for n,fr in pairs(frames) do fr:Hide(); end
		end

		-- On destroy, destroy our framepool
		state:Attach(state:Slot("Destroy"), true, function(w)
			win = nil;
			for n,fr in pairs(frames) do fr:Destroy(); frames[n] = nil; end
		end);

		-- On prepaint, hide everything
		state:Attach("TotalPrePaintAdvice", true, HideAll);

		-- On cell paint, attach a frame to the cell; fade based on index/order.
		state:Attach("CellPostPaintAdvice", true, function(w, cell, index, icv, uid, rdxUnit)
			-- Get a frame from our framepool
			local fr = GetFrame(index); if not fr then return; end
			-- Look us up in the sort.
			local ix = si:IndexOfUnit(rdxUnit); if not ix then return; end
			if(ix > order) then return; end
			if orientation == 1 then
				fr:SetPoint("RIGHT", cell, "LEFT", -2, 0);
			else
				fr:SetPoint("LEFT", cell, "RIGHT", 2, 0);
			end
			local th,w,r,g,b,a = VFL.lerp6((ix-1)/order, t1, t2, w1, w2, c1.r, c2.r, c1.g, c2.g, c1.b, c2.b, c1.a, c2.a);
			fr:SetHeight(th); fr:SetWidth(w); fr:SetVertexColor(r,g,b,a); fr:Show();
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local sort = RDXDB.ObjectFinder:new(ui, function(d,p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Sort$")); end);
		sort:SetLabel(VFLI.i18n("Sort")); sort:Show();
		if desc and desc.sort then sort:SetPath(desc.sort); end
		ui:InsertFrame(sort);

		local order = VFLUI.LabeledEdit:new(ui, 50); order:Show();
		order:SetText(VFLI.i18n("Size"));
		if desc and desc.order then order.editBox:SetText(desc.order); end
		ui:InsertFrame(order);

	  local orientation = VFLUI.RadioGroup:new(ui);
  	orientation:SetLayout(2,2);
	  orientation.buttons[1]:SetText(VFLI.i18n("Orient Left"));
		orientation.buttons[2]:SetText(VFLI.i18n("Orient Right"));
		orientation:SetValue(desc.orientation or 1);
		ui:InsertFrame(orientation);

		local thick1 = VFLUI.LabeledEdit:new(ui, 50); thick1:Show();
		thick1:SetText(VFLI.i18n("Starting thickness"));
		if desc and desc.thick1 then thick1.editBox:SetText(desc.thick1); end
		ui:InsertFrame(thick1);

		local thick2 = VFLUI.LabeledEdit:new(ui, 50); thick2:Show();
		thick2:SetText(VFLI.i18n("End thickness"));
		if desc and desc.thick2 then thick2.editBox:SetText(desc.thick2); end
		ui:InsertFrame(thick2);

		local len1 = VFLUI.LabeledEdit:new(ui, 50); len1:Show();
		len1:SetText(VFLI.i18n("Starting length"));
		if desc and desc.len1 then len1.editBox:SetText(desc.len1); end
		ui:InsertFrame(len1);

		local len2 = VFLUI.LabeledEdit:new(ui, 50); len2:Show();
		len2:SetText(VFLI.i18n("End length"));
		if desc and desc.len2 then len2.editBox:SetText(desc.len2); end
		ui:InsertFrame(len2);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Starting color"));
		local swatch_c = VFLUI.ColorSwatch:new(er);
		swatch_c:Show();
		if desc and desc.color then swatch_c:SetColor(VFL.explodeRGBA(desc.color)); end
		er:EmbedChild(swatch_c); er:Show();
		ui:InsertFrame(er);

		er = VFLUI.EmbedRight(ui, VFLI.i18n("End color"));
		local swatch_fc = VFLUI.ColorSwatch:new(er);
		swatch_fc:Show();
		if desc and desc.fadeColor then swatch_fc:SetColor(VFL.explodeRGBA(desc.fadeColor)); end
		er:EmbedChild(swatch_fc); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return {
				feature = "Sort Bars", sort = sort:GetPath(), order = VFL.clamp(order.editBox:GetNumber(), 1, 40),
				orientation = orientation:GetValue(),
				thick1 = VFL.clamp(thick1.editBox:GetNumber(), 1, 18), thick2 = VFL.clamp(thick2.editBox:GetNumber(), 1, 18),
				len1 = VFL.clamp(len1.editBox:GetNumber(), 1, 500), len2 = VFL.clamp(len2.editBox:GetNumber(), 1, 500),
				color = swatch_c:GetColor(), fadeColor = swatch_fc:GetColor(),
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {feature = "Sort Bars", order = 10, orientation = 1, len1 = 30, len2 = 1, thick1 = 10, thick2 = 1, color = {r=1,g=0,b=0,a=1}, fadeColor = {r=0,g=1,b=0,a=0.5}};
	end;
});
