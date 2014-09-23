

--------
-- Init a map icon type and set drawing info

function RDXMAP.APIMap.InitIconType (map, iconType, drawMode, texture, w, h)

	local d = map.Data

	local t = wipe (d[iconType] or {})
	d[iconType] = t
	t.Num = 0
	t.Enabled = true
	t.DrawMode = drawMode or "ZP"	-- Zone point is default
	t.Tex = texture
	t.W = w
	t.H = h
	t.Scale = 1	-- USED???
	t.ClipFunc = RDXMAP.APIMap.ClipFrameW		-- For WP mode
end

--------
-- Clear a map icon type

function RDXMAP.APIMap.ClearIconType (map, iconType)

	local d = map.Data
	d[iconType] = nil
end

--------
-- Set alpha for an icon type

function RDXMAP.APIMap.SetIconTypeAlpha (map, iconType, alpha, alphaNear)

	local d = map.Data
	assert (d[iconType])

	d[iconType].Alpha = alpha
	d[iconType].AlphaNear = alphaNear
end

--------
-- Set at scale for an icon type

function RDXMAP.APIMap.SetIconTypeAtScale (map, iconType, scale)

	local d = map.Data
	assert (d[iconType])

	d[iconType].AtScale = scale
end

--------
-- Set level for an icon type

function RDXMAP.APIMap.SetIconTypeLevel (map, iconType, level)

	local d = map.Data
	assert (d[iconType])

	d[iconType].Lvl = level
end

--------
-- Set level for an icon type

function RDXMAP.APIMap.SetIconTypeChop (map, iconType, on)

	local d = map.Data
	assert (d[iconType])

	d[iconType].ClipFunc = on and RDXMAP.APIMap.ClipFrameWChop or RDXMAP.APIMap.ClipFrameW
end

--------
-- Add point icon to map data
-- ret: icon

function RDXMAP.APIMap.AddIconPt (map, iconType, x, y, color, texture)

	local d = map.Data

	assert (d[iconType])

	local tdata = d[iconType]
	tdata.Num = tdata.Num + 1		-- Use # instead??

	local icon = {}
	tdata[tdata.Num] = icon

	icon.X = x
	icon.Y = y
	icon.Color = color
	icon.Tex = texture

	assert (tdata.Tex or texture or color)

	return icon
end

--------
-- Get icon count

function RDXMAP.APIMap.GetIconCnt (map, iconType)

	return #map.Data[iconType]
end

--------
-- Get point icon XY at index (for routing code)

function RDXMAP.APIMap.GetIconPt (map, iconType, index)

	local icon = map.Data[iconType][index]
	return icon.X, icon.Y
end

--------
-- Add rectangle icon to map data (zone coords)
-- ret: icon

function RDXMAP.APIMap.AddIconRect (map, iconType, mapId, x, y, x2, y2, color)

	local d = map.Data

	assert (d[iconType])

	local tdata = d[iconType]
	tdata.Num = tdata.Num + 1

	local icon = {}
	tdata[tdata.Num] = icon

	icon.MapId = mapId
	icon.X = x
	icon.Y = y
	icon.X2 = x2
	icon.Y2 = y2
	icon.Color = color

	return icon
end

--------
-- Add icon tool tip

function RDXMAP.APIMap.SetIconTip (icon, tip)
	icon.Tip = tip
end

--------
-- Set user data

function RDXMAP.APIMap.SetIconUserData (icon, data)
	icon.UData = data
end

--------
-- Set favorite data

function RDXMAP.APIMap.SetIconFavData (icon, data1, data2)
	icon.FavData1 = data1
	icon.FavData2 = data2
end

--------
-- Set favorite data

function RDXMAP.APIMap.GetIconFavData (icon)
	return icon.FavData1, icon.FavData2
end

------
-- Reset icons

function RDXMAP.APIMap.ResetIcons(map)

	local frms = map.IconFrms
	frms.Used = frms.Next - 1		-- Save last frame used
	frms.Next = 1

	local frms = map.IconNIFrms
	frms.Used = frms.Next - 1		-- Save last frame used
	frms.Next = 1

	local frms = map.IconStaticFrms
	frms.Used = frms.Next - 1		-- Save last frame used
	frms.Next = 1

	local data = map.TextFStrs
	data.Used = data.Next - 1		-- Save last used
	data.Next = 1
end

------
-- Hide extra icons (a hide and then show will reset mouse state, breaking OnMouseUp)

function RDXMAP.APIMap.HideExtraIcons(map)

	local frms = map.IconFrms

	for n = frms.Next, frms.Used do		-- Hide up to last frames used amount
		frms[n]:Hide()
	end

	local frms = map.IconNIFrms

	for n = frms.Next, frms.Used do		-- Hide up to last frames used amount
		frms[n]:Hide()
	end

	local frms = map.IconStaticFrms

	for n = frms.Next, frms.Used do		-- Hide up to last frames used amount
		frms[n]:Hide()
	end

	local data = map.TextFStrs

	for n = data.Next, data.Used do		-- Hide up to last used amount
		data[n]:Hide()
	end
end

-- RDX new ICON type with dragging system

VFLUI.POIIcon = {};
function VFLUI.POIIcon:new(map, levelAdd)
	local btn = VFLUI.AcquireFrame("Frame");
	--if map.Frm then
		btn:SetParent(map.Frm);
		btn:SetFrameStrata(map.Frm:GetFrameStrata());
		btn:SetFrameLevel(map.Level + (levelAdd or 0));
	--end
	btn.NxMap = map
	-- Background
	--btn:SetBackdrop(VFLUI.DefaultDialogBorder);

	-- Textures
	local tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.1);
	tex:SetDrawLayer("ARTWORK", 1);
	--tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	--tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:SetAllPoints(btn);
	tex:Show();
	btn.texture = tex;
	
	-- handler
	btn:SetScript ("OnMouseDown", RDXMAP.APIMap.IconOnMouseDown)
	btn:SetScript ("OnMouseUp", RDXMAP.APIMap.IconOnMouseUp)
	btn:SetScript ("OnEnter", RDXMAP.APIMap.IconOnEnter)
	btn:SetScript ("OnLeave", RDXMAP.APIMap.IconOnLeave)
	btn:SetScript ("OnHide", RDXMAP.APIMap.IconOnLeave)

	btn:EnableMouse (true)

	-- dragging system
	--map.DragContext:RegisterDragTarget(btn);

	btn.Destroy = VFL.hook(function(s)
		--map.DragContext:UnregisterDragTarget(s);
		VFLUI.ReleaseRegion(s.texture); s.texture = nil;
	end, btn.Destroy);

	return btn;
end

------
-- Get next available map icon or create one
-- ret: icon frame

function RDXMAP.APIMap.GetIcon (map, levelAdd)

	local frms = map.IconFrms
	local pos = frms.Next

	if pos > 1500 then
		pos = 1500	-- Too many used. Reuse
	end

	local f = frms[pos]
	if not f then

		f = CreateFrame ("Frame", "NxIcon"..pos, map.Frm)
		frms[pos] = f
		f.NxMap = map

		f:SetScript ("OnMouseDown", RDXMAP.APIMap.IconOnMouseDown)
		f:SetScript ("OnMouseUp", RDXMAP.APIMap.IconOnMouseUp)
		f:SetScript ("OnEnter", RDXMAP.APIMap.IconOnEnter)
		f:SetScript ("OnLeave", RDXMAP.APIMap.IconOnLeave)
		f:SetScript ("OnHide", RDXMAP.APIMap.IconOnLeave)

		f:EnableMouse (true)

		local t = f:CreateTexture()
		f.texture = t
		t:SetAllPoints (f)
	end

	f:SetFrameLevel (map.Level + (levelAdd or 0))

	f.texture:SetVertexColor (1, 1, 1, 1)
--	f.texture:SetBlendMode ("BLEND")

	f.NxTip = nil
	f.NXType = nil			-- 1000 plyr, 2000 BG, 3000 POI, 8000 debug, 9000+ quest
	f.NXData = nil
	f.NXData2 = nil

	frms.Next = pos + 1

	return f
end

------
-- Get next available map non interactive icon or create one
-- ret: icon frame

function RDXMAP.APIMap.GetIconNI (map, levelAdd)

	local frms = map.IconNIFrms
	local pos = frms.Next

	if pos > 1500 then
		pos = 1500	-- Too many used. Reuse
		VFL.print("reach 1500")
	end

	local f = frms[pos]
	if not f then

		f = CreateFrame ("Frame", "NxIconNI"..pos, map.Frm)
		frms[pos] = f
		f.NxMap = map

		local t = f:CreateTexture()
		f.texture = t
		t:SetAllPoints (f)
	end

	local add = levelAdd or 0
	f:SetFrameLevel (map.Level + add)

	f.texture:SetVertexColor (1, 1, 1, 1)
	f.texture:SetBlendMode ("BLEND")

	frms.Next = pos + 1

	return f
end

------
-- Get next available map static (for non moving stuff) icon or create one
-- ret: icon frame

function RDXMAP.APIMap.GetIconStatic (map, levelAdd)

	local frms = map.IconStaticFrms
	local pos = frms.Next

	if pos > 1500 then
		pos = 1500	-- Too many used. Reuse
	end

	local f = frms[pos]
	if not f then

		f = CreateFrame ("Frame", "NxIconS"..pos, map.Frm)
		frms[pos] = f
		f.NxMap = map

		f:SetScript ("OnMouseDown", RDXMAP.APIMap.IconOnMouseDown)
		f:SetScript ("OnMouseUp", RDXMAP.APIMap.IconOnMouseUp)
		f:SetScript ("OnEnter", RDXMAP.APIMap.IconOnEnter)
		f:SetScript ("OnLeave", RDXMAP.APIMap.IconOnLeave)
		f:SetScript ("OnHide", RDXMAP.APIMap.IconOnLeave)

		f:EnableMouse (true)

		local t = f:CreateTexture()
		f.texture = t
		t:SetAllPoints (f)
	end

	local add = levelAdd or 0
	f:SetFrameLevel (map.Level + add)

	f.texture:SetVertexColor (1, 1, 1, 1)
--	f.texture:SetBlendMode ("BLEND")

	f.NxTip = nil
	f.NXType = nil			-- 1000 plyr, 2000 BG, 3000 POI, 8000 debug, 9000+ quest
	f.NXData = nil
	f.NXData2 = nil

	frms.Next = pos + 1

	return f
end

--------
-- Get next available map text or create one
-- ret: text font string

function RDXMAP.APIMap.GetText (map, text, levelAdd)

	local data = map.TextFStrs
	local pos = data.Next

	if pos > 100 then
		pos = 1	-- Reset. Too many used
	end

	local fstr = data[pos]
	if not fstr then

		fstr = map.TextFrm:CreateFontString()
		data[pos] = fstr

		fstr:SetFontObject ("NxFontMap")
		fstr:SetJustifyH ("LEFT")
		fstr:SetJustifyV ("TOP")
--		fstr:SetWidth (400)
		fstr:SetHeight (100)
		fstr:SetTextColor (1, 1, 1, 1)
	end

	fstr:SetText (text)

--	local add = levelAdd or 0
--	f:SetFrameLevel (map.Level + add)

	data.Next = pos + 1

	return fstr
end

--------
-- Move text

function RDXMAP.APIMap.MoveTextToIcon (fstr, icon, ox, oy)

	local f = icon
	local atPt, relTo, relPt, x, y = f:GetPoint()

--	VFL.vprint ("Text %s %s %s", relPt, x, y)

	fstr:SetPoint ("TOPLEFT", x + ox, y - oy)
	fstr:Show()
end


--------
-- Handle mouse click on icon

function RDXMAP.APIMap.IconOnMouseDown (self, button)

--	VFL.vprint ("MapIconMouseDown "..button.." "..(self:GetName() or "?"))

	local map = self.NxMap
	map:CalcClick()
	map.ClickFrm = self
	map.ClickType = self.NXType
	map.ClickIcon = self.NXData

	local shift = IsShiftKeyDown()

	if button == "LeftButton" then

		local cat = floor ((self.NXType or 0) / 1000)

		if cat == 2 and shift then		-- BG location

			if map.BGIncNum > 0 then

				local _, _, _, str = strsplit ("~", map.BGMsg)
				local _, _, _, str2 = strsplit ("~", self.NXData)

				if str ~= str2 then				-- Different node?
					VFLT.ZMUnscheduleId("BGInc")
				end
			end

			map.BGMsg = self.NXData
			map.BGIncNum = map.BGIncNum + 1

			UIErrorsFrame:AddMessage ("Inc " .. map.BGIncNum, 1, 1, 1, 1)

			VFLT.ZMSchedule(1.5, map.BGIncSendTimer, "BGInc");

--		elseif cat == 8 then
--			map:HotspotDebugClick (button)

		else
			if map:IsDoubleClick() then
				if cat == 3 then
--					VFL.vprint ("Icon dbl click")
					map:GMenu_OnGoto()
				end

			else
				RDXMAP.APIMap.OnMouseDown (map.Frm, button)
			end
		end

	else		--if button == "MiddleButton" or button == "Button4" or IsShiftKeyDown() then

		if button == "RightButton" then

			local typ = self.NXType

--			VFL.vprint ("Icon type %s", typ or 0)

			if typ then

				local i = floor (typ / 1000)

				if i == 1 then
					RDXMAP.APIMap.BuildPlyrLists(map)
					map.PIconMenu:Open()

				elseif i == 2 then				-- BG location

					VFLT.ZMUnscheduleId("BGInc")

					map.BGMsg = self.NXData
					map.BGIconMenu:Open()

				elseif i == 3 then
					map:GMenuOpen (self.NXData, typ)

				elseif i == 9 then				-- Quest
					if Nx.Quest then
						Nx.Quest:IconOnMouseDown (self)
					end
				end
			end

		else
			RDXMAP.APIMap.OnMouseDown (map.Frm, button)
		end
	end
end

function RDXMAP.APIMap.IconOnMouseUp (self, button)

--	VFL.vprint ("MapIconMouseUp "..button)
	RDXMAP.APIMap.OnMouseUp (self.NxMap.Frm, button)
end

--------
-- Handle mouse on icon

function RDXMAP.APIMap.IconOnEnter (self, motion)

--	VFL.vprint ("MapIconEnter %s", self:GetName() or "nil")

	local map = self.NxMap

--	map.BackgndAlphaTarget = map.LOpts.BackgndAlphaFull

	RDXMAP.APIMap.BuildPlyrLists(map)

	if self.NxTip then
--		VFL.vprint ("MapIconEnter %s %s", self:GetName() or "nil", self.NxTip)

		local tt = GameTooltip

		local str = strsplit ("~", self.NxTip)

		local owner = self
		local tippos = "ANCHOR_CURSOR"

		local opts = Nx:GetGlobalOpts()
		if opts["MapTopTooltip"] then
			owner = map.Win.Frm
			tippos = "ANCHOR_TOPLEFT"
		end

		owner.NXIconFrm = self

--		Nx.TooltipOwner = owner ---
--		map.TooltipType = 2

		tt:SetOwner (owner, tippos, 0, 0)

		Nx:SetTooltipText (str .. RDXMAP.PlyrNamesTipStr)

		owner["UpdateTooltip"] = RDXMAP.APIMap.IconOnUpdateTooltip
	end

	local t = self.NXType or -1

	if t >= 9000 then	-- Quest
		if Nx.Quest then
			Nx.Quest:IconOnEnter (self)
		end
	end
end

--------
-- Handle mouse leaving icon (or icon hiding)

function RDXMAP.APIMap.IconOnLeave (self, motion)

	local t = self.NXType or -1

	if t >= 9000 then -- Quest
		if Nx.Quest then
			Nx.Quest:IconOnLeave (self)
		end
	end

--	self.TooltipType = 0

--	if not self:IsVisible() then
--		VFL.vprint ("IconOnLeave not vis")
--		return
--	end

--	local map = self.NxMap
--	local owner = map.Win.Frm

	--if GameTooltip:IsOwned (self) or GameTooltip:IsOwned (self.NxMap.Win.Frm) then
	if GameTooltip:IsOwned (self) then
		GameTooltip:Hide()
--		VFL.vprint ("MapIconLeave hide tip")
	end
end

--------
-- Called by tooltip
-- self = frame

function RDXMAP.APIMap.IconOnUpdateTooltip(self)

	local f = self.NXIconFrm

	if f and f.NxTip then

		local map = f.NxMap
		RDXMAP.APIMap.BuildPlyrLists(map)

		local str = strsplit ("~", f.NxTip)
		Nx:SetTooltipText (str .. RDXMAP.PlyrNamesTipStr)

		if Nx.Quest and Nx.Quest.Enabled then
			Nx.Quest:TooltipProcess()
		end

--		VFL.vprint ("IconOnUpdateTooltip")
	end
end



--------
-- Update all icons

function RDXMAP.APIMap.UpdateIcons (map, drawNonGuide)

	local c2rgb = VFL.explodeHexStringColor
	local c2rgba = VFL.explodeHexStringRGBA
	local d = map.Data

	local wpScale = 1
	local wpMin = map.GOpts["MapIconScaleMin"]
	if wpMin >= 0 then
		wpScale = map.ScaleDraw * .08
	end

	for type, v in pairs (d) do
		v.Enabled = drawNonGuide or strbyte (type) == 33	-- "!" is guide types

		if v.AtScale then
			if map.ScaleDraw < v.AtScale then
				v.Enabled = false
			end
		end
	end

	for k, v in pairs (d) do

--		VFL.vprint ("UpdateIcons %s %s", k, v.DrawMode)

		if v.Enabled then

			if v.DrawMode == "ZP" then		-- Zone point

				local scale = map.LOpts.NXIconScale
				local w = v.W * scale
				local h = v.H * scale

				for n = 1, v.Num do

					local icon = v[n]
					local f = RDXMAP.APIMap.GetIconStatic (map, v.Lvl)

					if RDXMAP.APIMap.ClipFrameZ (map, f, icon.X, icon.Y, w, h, 0) then

						f.NxTip = icon.Tip

--						assert (icon.Tex or v.Tex or icon.Color)

						if icon.Tex then
							f.texture:SetTexture (icon.Tex)

						elseif v.Tex then
							f.texture:SetTexture (v.Tex)

						else
							f.texture:SetTexture (c2rgb (icon.Color))
						end
					end
				end

			elseif v.DrawMode == "WP" then		-- World point

				local scale = map.LOpts.NXIconScale * v.Scale * wpScale
				local w = max (v.W * scale, wpMin)
				local h = max (v.H * scale, wpMin)
				
				local myunit = RDXDAL.GetMyUnit();

				if v.AlphaNear then

					local aNear = v.AlphaNear * (abs (GetTime() % .7 - .35) / .7 + .5)	-- 50% to 100% pulse

					for n = 1, v.Num do

						local icon = v[n]
						local f = RDXMAP.APIMap.GetIconStatic (map, v.Lvl)

						if v.ClipFunc (map, f, icon.X, icon.Y, w, h, 0) then

							f.NxTip = icon.Tip
							f.NXType = 3000
							f.NXData = icon

							if icon.Tex then
								f.texture:SetTexture (icon.Tex)

							elseif v.Tex then
								f.texture:SetTexture (v.Tex)

							else
								f.texture:SetTexture (c2rgb (icon.Color))
							end

							local a = v.Alpha

							local dist = (icon.X - myunit.PlyrX) ^ 2 + (icon.Y - myunit.PlyrY) ^ 2
							if dist < 306 then	-- 80 yards * 4.575 ^ 2
								a = aNear
--								VFL.vprint ("fade %s %s", dist ^ .5, a)
							end

							f.texture:SetVertexColor (1, 1, 1, a)
						end
					end

				else
					for n = 1, v.Num do

						local icon = v[n]
						local f = RDXMAP.APIMap.GetIconStatic (map, v.Lvl)

						if v.ClipFunc (map, f, icon.X, icon.Y, w, h, 0) then

							f.NxTip = icon.Tip
							f.NXType = 3000
							f.NXData = icon

							if icon.Tex then
								f.texture:SetTexture (icon.Tex)

							elseif v.Tex then
								f.texture:SetTexture (v.Tex)

							else
								f.texture:SetTexture (c2rgb (icon.Color))
							end

							if v.Alpha then
								f.texture:SetVertexColor (1, 1, 1, v.Alpha)
								--f.texture:SetVertexColor (1, 1, 1, 1)
							end
						end
					end
				end

			elseif v.DrawMode == "ZR" then	-- Zone rectangle

				local x, y, x2, y2
--				local x0, y0, x2, y2 = RDXMAP.APIMap.GetWorldRect (map.MapId, 0, 0, 100, 100)

				for n = 1, v.Num do

					local icon = v[n]
					local f = RDXMAP.APIMap.GetIconStatic (map, v.Lvl)

--					VFL.vprint ("ZR #%d %f %f %f %f", n, icon.X, icon.Y, icon.X2, icon.Y2)

					f.NxTip = icon.Tip

					x, y = RDXMAP.APIMap.GetWorldPos (icon.MapId, icon.X, icon.Y)
					x2, y2 = RDXMAP.APIMap.GetWorldPos (icon.MapId, icon.X2, icon.Y2)

--					VFL.vprint ("%f %f %f %f", x, y, x2, y2)

					if RDXMAP.APIMap.ClipFrameTL (map, f, x, y, x2-x, y2-y) then
						if v.Texture then
							f.texture:SetTexture (v.Tex)
						else
							f.texture:SetTexture (c2rgba (icon.Color))
						end
					end
				end
			end
		end
	end
end

function RDXMAP.APIMap.UpdateIconsBattlefieldVehicle(map)
	local vtex = _G["VEHICLE_TEXTURES"]

	for n = 1, GetNumBattlefieldVehicles() do

		local x, y, unitName, possessed, typ, orientation, player = GetBattlefieldVehicleInfo (n)
		if x and x > 0 and not player then

--			VFL.vprintCtrl ("#%s %s %.2f %.2f %.3f %s %s %s", n, unitName or "nil", x or -1, y or -1, orientation or -1, typ or "no type", possessed and "poss" or "-poss", player and "plyr" or "-plyr")

			if vtex[typ] then
				local f2 = RDXMAP.APIMap.GetIconNI (map, 1)
				local sc = map.ScaleDraw * 0.8
				if map.myunit.InstanceId then				
					sc = .5		-- Airships
				end
				if typ == "Drive" or typ == "Fly" then
					sc = 1
					if map.myunit.InstanceId then
					  sc = .7
					end
				end							
				if RDXMAP.APIMap.ClipFrameZ (map, f2, x * 100, y * 100, vtex[typ]["width"] * sc, vtex[typ]["height"] * sc, orientation / PI * -180) then
					f2.texture:SetTexture (WorldMap_GetVehicleTexture (typ, possessed))
				end

--				VFL.vprintCtrl ("%s %s %s %s", unitName, x, y, orientation)
			end
		end
	end
end

-- deprecated not finish (bg part)
function RDXMAP.APIMap.UpdateIconsPOI(map)
	local name, description, txIndex, pX, pY
	local txX1, txX2, txY1, txY2
	local poiNum = GetNumMapLandmarks()

--	VFL.vprint ("poiNum %d", poiNum)

	for i = 1, poiNum do
		name, desc, txIndex, pX, pY = GetMapLandmarkInfo (i)

		if txIndex ~= 0 then		-- WotLK has 0 index POIs for named locations

			local tip = name
			if desc then
				tip = format ("%s\n%s", name, desc)
			end

			pX = pX * 100
			pY = pY * 100

--			VFL.vprintCtrl ("poi %d %s %s %d", i, name, desc, txIndex)

			local f = RDXMAP.APIMap.GetIcon (map, 3)

			if map.CurMapBG then

				f.NXType = 2000

				local iconType = RDXMAP.MapPOITypes[txIndex]

				local sideStr = ""
				if iconType == 1 then	-- Ally?
					sideStr = " (Ally)"
				elseif iconType == 2 then	-- Horde?
					sideStr = " (Horde)"
				end

				if desc == NXlINCONFLICT then

					local state = RDXMAP.BGTimers[name]
					if state ~= txIndex then
						RDXMAP.BGTimers[name] = txIndex
						RDXMAP.BGTimers[name.."#"] = GetTime()
					end

					local dur = GetTime() - RDXMAP.BGTimers[name.."#"]
					local doneDur = (rid == 9001 or rid == 9009 or rid == 9010) and 64 or 241
					local leftDur = max (doneDur - dur, 0)
					local tmStr

					if leftDur < 60 then
						tmStr = format (":%02d", leftDur)
					else
						tmStr = format ("%d:%02d", floor (leftDur / 60), floor (leftDur % 60))
					end

					f.NXData = format ("1~%f~%f~%s%s %s", pX, pY, name, sideStr, tmStr)

					tip = format ("%s\n%s", tip, tmStr)

					-- Horizontal bar

					local sz = 30 / map.ScaleDraw

					local f2 = RDXMAP.APIMap.GetIcon (map, 0)
					RDXMAP.APIMap.ClipFrameZTLO (map, f2, pX, pY, sz, sz, -15, -15)
					f2.texture:SetTexture (0, 0, 0, .35)

					f2.NXType = 2000
					f2.NxTip = tip
					f2.NXData = f.NXData

					local f2 = RDXMAP.APIMap.GetIconNI (map, 1)

					if leftDur < 10 then

						if map.BGGrowBars then

							local al = abs (GetTime() % .4 - .2) / .2 * .2 + .8

							local f3 = RDXMAP.APIMap.GetIconNI (map, 2)
							RDXMAP.APIMap.ClipFrameZTLO (map, f3, pX, pY, sz * (10 - leftDur) * .1, 3 / map.ScaleDraw, -15, -15)
							f3.texture:SetTexture (.5, 1, .5, al)

							local f3 = RDXMAP.APIMap.GetIconNI (map, 2)
							RDXMAP.APIMap.ClipFrameZTLO (map, f3, pX, pY, sz * (10 - leftDur) * .1, 3 / map.ScaleDraw, -15, 12)
							f3.texture:SetTexture (.5, 1, .5, al)
						end

--						f2.texture:SetTexture (.5, 1, .5, abs (GetTime() % .6 - .3) / .3 * .7 + .3)
					end

					local red = .3
					local blue = 1
					if iconType == 2 then	-- Horde?
						red = 1
						blue = .3
					end

					f2.texture:SetTexture (red, .3, blue, abs (GetTime() % 2 - 1) * .5 + .5)

					local per = leftDur / doneDur
					local vper = per > .1 and 1 or per * 10

					if map.BGGrowBars then
						per = 1 - per
						vper = 1
					else
						per = max (per, .1)
					end

					RDXMAP.APIMap.ClipFrameZTLO (map, f2, pX, pY, sz * per, sz * vper, -15, -15)

				else	-- No conflict

					f.NXData = format ("0~%f~%f~%s%s", pX, pY, name, sideStr)

					RDXMAP.BGTimers[name] = nil

					-- Rect

					local sz = 30 / map.ScaleDraw

					local f2 = RDXMAP.APIMap.GetIcon (map, 0)
					RDXMAP.APIMap.ClipFrameZTLO (map, f2, pX, pY, sz, sz, -15, -15)

--					VFL.vprintCtrl ("I %s %s %s", name, txIndex, iconType or "nil")

					if iconType == 1 then	-- Ally?
						f2.texture:SetTexture (0, 0, 1, .3)
--						VFL.vprintCtrl ("Blue")
					elseif iconType == 2 then	-- Horde?
						f2.texture:SetTexture (1, 0, 0, .3)
--						VFL.vprintCtrl ("Red")
					else
						f2.texture:SetTexture (0, 0, 0, .3)
					end

					f2.NXType = 2000
					f2.NxTip = tip
					f2.NXData = f.NXData

				end
			end

			f.NxTip = tip

			RDXMAP.APIMap.ClipFrameZ (map, f, pX, pY, 16, 16, 0)

			f.texture:SetTexture ("Interface\\Minimap\\POIIcons")
			txX1, txX2, txY1, txY2 = GetPOITextureCoords (txIndex)
			f.texture:SetTexCoord (txX1 + .003, txX2 - .003, txY1 + .003, txY2 - .003)
			f.texture:SetVertexColor (1, 1, 1, 1)
		end
	end
end

function RDXMAP.APIMap.BuildPlyrLists(map)

	RDXMAP.PlyrNames = {}
	RDXMAP.AFKers = {}
	local tipStr = ""

	local frms = map.IconFrms
	local f

	local cnt = 0

	for n = 1, frms.Next-1 do

		f = frms[n]
		local plyr = f.NXType == 1000 and f.NXData2
		if plyr then

			local x, y = VFLUI.IsMouseOver (f)
			if x then

--				VFL.vprint ("Plyr %s", plyr)

				tinsert (RDXMAP.PlyrNames, plyr)

				if f.NXData then
					tinsert (RDXMAP.AFKers, f.NXData)
--					VFL.vprint ("AFKer %d %s %s", #RDXMAP.AFKers, plyr, f.NXData)
				end
			end
		end
	end

	if #RDXMAP.PlyrNames >= 2 then

		tipStr = format ("\n\n|cff00cf00%s players:", #RDXMAP.PlyrNames)

		sort (RDXMAP.PlyrNames)

		for _, name in ipairs (RDXMAP.PlyrNames) do
			tipStr = tipStr .. "\n" .. name
		end
	end

	RDXMAP.PlyrNamesTipStr = tipStr

end
