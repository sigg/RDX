


local i, j, k
--local frms, frm
local scale
local size
local clipW
local clipH
local texX1, texX2
local texY1, texY2
local vx0, vx1, vx2
local vy0, vy1, vy2
local x, y, w, h
local bx, by, bw, bh
local wx, wy, ww, wh
local zname
local zx, zy, zw, zh

local t1x, t1y, t2x, t2y, t3x, t3y, t4x, t4y
local co
local si

--------
-- Zone clip a frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function RDXMAP.APIMap.ClipFrameZ (map, frm, x, y, w, h, dir)
	x, y = RDXMAP.APIMap.GetWorldPos (map.MapId, x, y)
	return RDXMAP.APIMap.ClipFrameW (map, frm, x, y, w, h, dir)
end

--------
-- Clip a frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function RDXMAP.APIMap.ClipFrameW (map, frm, bx, by, w, h, dir)

	scale = map.ScaleDraw

	-- Calc x

	bw = w
	clipW = map.MapW
	x = (bx - map.MapPosXDraw) * scale + clipW * .5

	texX1 = 0
	texX2 = 1

	vx0 = x - bw * .5		-- Center frame at bx
	vx1 = vx0
	vx2 = vx0 + bw

	if vx1 < 0 then
		vx1 = 0
		texX1 = (vx1 - vx0) / bw
	end

	if vx2 > clipW then
		vx2 = clipW
		texX2 = (vx2 - vx0) / bw
	end

	w = vx2 - vx1

	if w < .3 then

		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Calc y

	bh = h
	clipH = map.MapH
	y = (by - map.MapPosYDraw) * scale + clipH * .5

	texY1 = 0
	texY2 = 1

	vy0 = y - bh * .5		-- Center frame at by
	vy1 = vy0
	vy2 = vy0 + bh

	if vy1 < 0 then
		vy1 = 0
		texY1 = (vy1 - vy0) / bh
	end

	if vy2 > clipH then
		vy2 = clipH
		texY2 = (vy2 - vy0) / bh
	end

	h = vy2 - vy1

	if h < .3 then

		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Set frame

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - map.TitleH)
	frm:SetWidth (w)
	frm:SetHeight (h)

	if dir == -1 then
	
	elseif dir == 0 then

		frm.texture:SetTexCoord (texX1, texX2, texY1, texY2)

	else
		-- 13 UV order
		-- 24

		-- Make UV range -.5 to .5
		texX1 = texX1 - .5
		texX2 = texX2 - .5
		texY1 = texY1 - .5
		texY2 = texY2 - .5

		co = cos (dir)
		si = sin (dir)
		t1x = texX1 * co + texY1 * si + .5
		t1y = texX1 * -si + texY1 * co + .5
		t2x = texX1 * co + texY2 * si + .5
		t2y = texX1 * -si + texY2 * co + .5
		t3x = texX2 * co + texY1 * si + .5
		t3y = texX2 * -si + texY1 * co + .5
		t4x = texX2 * co + texY2 * si + .5
		t4y = texX2 * -si + texY2 * co + .5
		frm.texture:SetTexCoord (t1x, t1y, t2x, t2y, t3x, t3y, t4x, t4y)

--		VFL.vprint (" T1 "..t1x.." "..t1y)
--		VFL.vprint (" T2 "..t2x.." "..t2y)
	end

	frm:Show()

	return true
end

--------
-- Zone clip a frame to the map and set position (top left), size and texture coords
-- Width and height are scaled

function RDXMAP.APIMap.ClipFrameZTL (map, frm, x, y, w, h)

	x, y = RDXMAP.APIMap.GetWorldPos (map.MapId, x, y)
	return RDXMAP.APIMap.ClipFrameTL (map, frm, x, y, w, h)
end

--------
-- Zone clip a frame (top left with offset)
-- Width and height are scaled

function RDXMAP.APIMap.ClipFrameZTLO (map, frm, x, y, w, h, xo, yo)

	x, y = RDXMAP.APIMap.GetWorldPos (map.MapId, x, y)
	return RDXMAP.APIMap.ClipFrameTL (map, frm, x + xo / map.ScaleDraw, y + yo / map.ScaleDraw, w, h)
end

--------
-- Clip a frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function RDXMAP.APIMap.ClipFrameWChop (map, frm, bx, by, w, h)

	bw = w
	bh = h
	clipW = map.MapW
	clipH = map.MapH

	scale = map.ScaleDraw
	x = (bx - map.MapPosXDraw) * scale + clipW / 2
	y = (by - map.MapPosYDraw) * scale + clipH / 2

	texX1 = 0
	texX2 = 1

	-- Center frame at bx, by

	vx0 = x - bw * .5
	vx1 = vx0
	vx2 = vx0 + bw

	if vx1 < 0 then
		vx1 = 0
		texX1 = (vx1 - vx0) / bw
	end

	if vx2 > clipW then
		vx2 = clipW
		texX2 = (vx2 - vx0) / bw
	end

	w = vx2 - vx1

	if w < .3 then
		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	texY1 = 0
	texY2 = 1

	vy0 = y - bh * .5
	vy1 = vy0
	vy2 = vy0 + bh

	if vy1 < 0 then
		vy1 = 0
		texY1 = (vy1 - vy0) / bh
	end

	if vy2 > clipH then
		vy2 = clipH
		texY2 = (vy2 - vy0) / bh
	end

	h = vy2 - vy1

	if h < .3 then
		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - map.TitleH)
	frm:SetWidth (w)
	frm:SetHeight (h)

	frm.texture:SetTexCoord (texX1 * .9 + .05, texX2 * .9 + .05, texY1 * .9 + .05, texY2 * .9 + .05)

	frm:Show()

	return true
end

--------
-- Clip minimap frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function RDXMAP.APIMap.ClipMMW (map, frm, bx, by, w, h)

	scale = map.ScaleDraw

	-- Each world unit maps to a pixel, so w * scale == size in pixels

	bw = w * scale
	bh = h * scale
	clipW = map.MapW
	clipH = map.MapH
	x = (bx - map.MapPosXDraw) * scale + clipW * .5
	y = (by - map.MapPosYDraw) * scale + clipH * .5

	vx0 = x - bw * .5
	vx1 = vx0
	vx2 = vx0 + bw

	if vx1 < 0 or vx2 > clipW then
		return false
	end

	w = vx2 - vx1

	if w <= 0 then
		return false
	end

	vy0 = y - bh * .5
	vy1 = vy0
	vy2 = vy0 + bh

	if vy1 < 0 or vy2 > clipH then
		return false
	end

	h = vy2 - vy1

	if h <= 0 then
		return false
	end

--	frm:SetPoint ("TOPLEFT", vx1, -vy1 - map.TitleH)
--	frm:SetWidth (w)
--	frm:SetHeight (h)

	i = w / 140
	map.MMFScale = i

	j = map.GOpts["MapMMIScale"]
	map:MinimapSetScale (i, j)

--	frm:SetScale (i)
	frm:SetPoint ("TOPLEFT", map.Frm, "TOPLEFT", vx1 / j, (-vy1 - map.TitleH) / j)

	frm:Show()

	return true
end

--------
-- Clip a frame to the map and set position (top left), size and texture coords
-- Width and height are scaled by base (zone) scale

function RDXMAP.APIMap.ClipFrameTL (map, frm, bx, by, w, h)

	-- Each world unit maps to a pixel, so w * scale == size in pixels

	scale = map.ScaleDraw

	-- Calc x

	bw = w * scale
	clipW = map.MapW
	x = (bx - map.MapPosXDraw) * scale + clipW * .5

	texX1 = 0
	texX2 = 1

	vx1 = x
	vx2 = x + bw

	if vx1 < 0 then
		vx1 = 0
		texX1 = (vx1 - x) / bw
	end

	if vx2 > clipW then
		vx2 = clipW
		texX2 = (vx2 - x) / bw
	end

	w = vx2 - vx1

	if w < .3 then
		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Calc y

	bh = h * scale
	clipH = map.MapH
	y = (by - map.MapPosYDraw) * scale + clipH * .5

	texY1 = 0
	texY2 = 1

	vy1 = y
	vy2 = y + bh

	if vy1 < 0 then
		vy1 = 0
		texY1 = (vy1 - y) / bh
	end

	if vy2 > clipH then
		vy2 = clipH
		texY2 = (vy2 - y) / bh
	end

	h = vy2 - vy1

	if h < .3 then
		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - map.TitleH)

	if w <= 1.2 then		-- Adjust so we get a clean line
		w = map.Size1
		if w <= 0 then
			frm:SetWidth (.001)
			return
		end
	end

	if h <= 1.2 then
		h = map.Size1
		if h <= 0 then
			frm:SetWidth (.001)
			return
		end
	end

	frm:SetWidth (w)
	frm:SetHeight (h)

	frm.texture:SetTexCoord (texX1, texX2, texY1, texY2)

	frm:Show()

	return true
end

--------
-- Clip a frame to the map and set position (top left), size and texture coords
-- Width and height are scaled by base (zone) scale
-- Solid color texture version

function RDXMAP.APIMap.ClipFrameTLSolid (map, frm, bx, by, w, h)

	-- Each world unit maps to a pixel, so w * scale == size in pixels

	scale = map.ScaleDraw

	-- Calc x

	clipW = map.MapW
	vx1 = (bx - map.MapPosXDraw) * scale + clipW * .5
	vx2 = vx1 + w * scale

	if vx1 < 0 then
		vx1 = 0
	end

	if vx2 > clipW then
		vx2 = clipW
	end

	w = vx2 - vx1

	if w < .3 then
		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Calc y

	clipH = map.MapH
	vy1 = (by - map.MapPosYDraw) * scale + clipH * .5
	vy2 = vy1 + h * scale

	if vy1 < 0 then
		vy1 = 0
	end

	if vy2 > clipH then
		vy2 = clipH
	end

	h = vy2 - vy1

	if h < .3 then
		if map.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - map.TitleH)

	frm:SetWidth (w)
	frm:SetHeight (h)

	frm:Show()

	return true
end

--------
-- Clip full zone frame to map

function RDXMAP.APIMap.ClipZoneFrm (map, mapId, frm, alpha)

	zname, zx, zy, zw, zh = RDXMAP.APIMap.GetWorldZoneInfo (mapId)
	if not zx then
		return
	end

	scale = map.ScaleDraw

	clipW = map.MapW
	clipH = map.MapH
	x = (zx - map.MapPosXDraw) * scale + clipW / 2
	y = (zy - map.MapPosYDraw) * scale + clipH / 2
	bx = 0
	by = 0
	bw = zw * scale
	bh = zh * scale

	i = map.Level

	if frm then

		vx0 = bx * bw + x
		vx1 = vx0
		vx2 = vx0 + bw

		vy0 = by * bh + y
		vy1 = vy0
		vy2 = vy0 + bh

		w = vx2 - vx1
		h = vy2 - vy1

		if w <= 0 or h <= 0 then
			frm:Hide()
		else
			j = w / 1002
			vx1 = vx1 / j
			vy1 = vy1 / j
			frm:SetPoint ("TOPLEFT", vx1, -vy1 - map.TitleH)
			frm:SetScale (j)
--			frm:SetFrameLevel (i)

			frm:Show()

--			VFL.vprint ("ClipZF %f, %f (%s)", vx1, vy1, j)
		end
	end
end

--------
--
--[[
function RDXMAP.Map:DrawZoneRect (mapId, x, y, w, h, tip)

	mapId = mapId or self.MapId

	local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
	local scale = RDXMAP.APIMap.GetWorldZoneScale (mapId) / 10.02

	local f = RDXMAP.APIMap.GetIcon(map)

	if RDXMAP.APIMap.ClipFrameTL (self, f, wx, wy, w * scale, h * scale) then
		f.NxTip = tip
		f.texture:SetColorTexture (r, g, b, .5)
	end
end
--]]


--------
-- Draw a tracking cursor and lines

function RDXMAP.APIMap.DrawTracking (map, srcX, srcY, dstX, dstY, tex, name)

	local x = dstX - srcX
	local y = dstY - srcY

	local dist = (x * x + y * y) ^ .5
	map.TrackDistYd = dist * 4.575

	if RDXMAP.icontex[tex] then

		local f = RDXMAP.APIMap.GetIcon (map, 1)

		local size = 16 * map.LOpts.NXIconNavScale
		RDXMAP.APIMap.ClipFrameW (map, f, dstX, dstY, size, size, 0)

		local s = name or map.TrackName

		f.NxTip = format ("%s\n%d yds", s, dist * 4.575)

		f.texture:SetTexture (RDXMAP.icontex[tex] or "Interface\\AddOns\\RDX\\Skin\\Map\\IconWayTarget")
		if RDXMAP.icontexCoord[tex] then
			local tbl = RDXMAP.icontexCoord[tex];
			f.texture:SetTexCoord (tbl[1], tbl[2], tbl[3], tbl[4])
		end
	end

	map.TrackDir = false

	if 1 then

		local dir = math.deg (math.atan2 (y, x)) + 90

		map.TrackDir = dir
		map.TrackX = dstX
		map.TrackY = dstY

		local sx = map.ScaleDraw
		local sy = map.ScaleDraw / 1.5

		x = x * sx
		y = y * sy

		-- Offset toward target
--		local off = 1 / sqrt (x * x + y * y)
--		local xo = x * off
--		local yo = y * off

		local cnt = (x * x + y * y) ^ .5 / 15 / map.LOpts.NXIconNavScale
		if cnt < 5 then
			cnt = cnt + .5
		end
		cnt = min (floor (cnt), 40)

		if cnt >= 1 then

			local dx = x / cnt
			local dy = y / cnt

			local offset = map.ArrowScroll
			x = dx * offset
			y = dy * offset

			local size = 16 * map.LOpts.NXIconNavScale
--			local pulse = floor (map.ArrowPulse)
			local usedIcon = true
			local f

			for n = 1, cnt do

				local wx = srcX + x / sx
				local wy = srcY + y / sy

--[[			-- Needed if we use an offset
				if n >= cnt then
					if sqrt ((wx - srcX) ^ 2 + (wy - plY) ^ 2) > dist then
						VFL.vprint ("Target arrow")
						break
					end
				end
--]]
				if usedIcon then
					usedIcon = false
					f = RDXMAP.APIMap.GetIconNI(map)
				end

				if RDXMAP.APIMap.ClipFrameW (map, f, wx, wy, size, size, dir) then

					f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconArrowGrad")

--					local a = n == pulse and .8 or .2
--					f.texture:SetVertexColor (1, 1, 1, a)

					if tex == "B" then -- BG manual tracking
						f.texture:SetVertexColor (.7, .7, 1, .5)
					elseif tex == "FLM" then -- Flight
						f.texture:SetVertexColor (1, 1, 0, .9)
					elseif tex == "D" then  -- Corpse dead manuel
						f.texture:SetVertexColor (1, 0, 0, 1)
					end

					usedIcon = true
				end

				x = x + dx
				y = y + dy
			end
		end
	end
end



