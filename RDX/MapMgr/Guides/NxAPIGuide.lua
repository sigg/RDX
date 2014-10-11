RDXMAP.APIGuide = {};

function RDXMAP.APIGuide.GetProfessionTrainer (profName)
	return " Trainer"
end
function RDXMAP.APIGuide.GetSecondaryTrainer (profName)
	return " Trainer"
end

-- CAPTURE
local PlayerNPCTarget, PlayerNPCTargetPos, VendorRepair, CanCap;

function RDXMAP.APIGuide.CaptureItems()
	if not NxData.NXVendorV then
		return
	end
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data
	local myunit = RDXDAL.GetMyUnit();
	if MerchantFrame:IsVisible() then
		local vcabr = RDXMAP.VendorCostAbr
		local npc = PlayerNPCTarget 
		local tag, name = strsplit ("~", npc)
		npc = format ("%s~%s", tag, name)
		local links = {}
		links["POS"] = format ("%d^%s^%s", myunit.mapId, myunit.PlyrRZX, myunit.PlyrRZY)
		links["T"] = time()
		links["R"] = VendorRepair
		for n = 1, GetMerchantNumItems() do
			local name, tx, price, quantity, numAvail, usable, exCost = GetMerchantItemInfo (n)
			local link = GetMerchantItemLink (n)
			if not name then
				return	
			end
			if not link then
				link = " :" .. name	
			end
			local priceStr = VFL.GetMoneyStr (price)
			if exCost then
				local iCnt = GetMerchantItemCostInfo (n)	
				if price <= 0 then
					priceStr = ""
				else
					priceStr = priceStr .. "|r "
				end
				if iCnt > 0 then
					for i = 1, MAX_ITEM_COST do
						local tx, value, costItemLink,costItemName = GetMerchantItemCostItem (n, i)  
						if value and value > 0 then
							
                            if costItemName then 
                                tx = costItemName
                            elseif costItemLink then
                                tx = costItemLink
                            elseif tx then
							
								tx = gsub (tx, "Interface\\Icons\\", "")
								if strfind (tx, "-Honor-") then	
									tx = " honor"
								end
								if strfind (tx, "-justice") then	
									tx = " justice"
								end
								if strfind (tx, "-valor") then	
									tx = " valor"
								end
							end
							
							priceStr = priceStr .. ( value>1 and value.." " or "") .. ( vcabr[tx] or tx )
							
						end
					end
				end
			end
			local _, id = strsplit (":", link)
			links[n] = id .. "^" .. strtrim (priceStr)
		end
		local vv = NxData.NXVendorV
		local nobefore = not vv[npc]
		vv[npc] = links
		local oName
		local maxCnt = min (max (1, opts["GuideVendorVMax"]), 1000)
		opts["GuideVendorVMax"] = maxCnt
		while true do
			local old = math.huge
			local cnt = 0
			for npcName, links in pairs (vv) do
				cnt = cnt + 1
				if links["T"] < old then	
					old = links["T"]
					oName = npcName
				end
			end
			if cnt <= maxCnt then		
				break
			end
			vv[oName] = nil	
		end
		if nobefore or RDXG.LootOn then
			VFL.vprint ("Captured %s (%d)", npc, #links)
		end
		return true
	end
end

function RDXMAP.APIGuide.SavePlayerNPCTarget()
    local visible = GameTooltip:IsVisible()
    GameTooltip:SetOwner(MerchantFrame) 
    GameTooltip:SetUnit("NPC")
	local tag = GameTooltipTextLeft2:GetText() or ""
	local lvl = GameTooltipTextLeft3:GetText() or ""
	local faction = GameTooltipTextLeft4:GetText() or ""
    if strfind(tag,"^" .. NXlLEVELSPC) or strfind(tag, "^|c%x%x%x%x%x%x%x%x" .. NXlLEVELSPC) then
        tag=""
        faction=lvl
    end
	local str=format("%s~%s~%s",tag,GameTooltipTextLeft1:GetText() or "",faction)
	PlayerNPCTarget = str
    if not visible then
        GameTooltip:Hide()
    end
		
	local myunit = RDXDAL.GetMyUnit();
	local s = RDXMAP.PackXY (myunit.PlyrRZX, myunit.PlyrRZY)
	PlayerNPCTargetPos = format ("%d^%s", RDXMAP.MapId2Zone[myunit.mapId] or 0, s)
end

function RDXMAP.APIGuide.CaptureNPC (data)
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data
	if not opts["CaptureEnable"] then
		return
	end
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:capNPC");
	local npcs = mbo.data;
	local len = 0
	for _, str in pairs (npcs) do
		len = len + 4 + #str + 1
	end
	if len > 5 * 1024 then		
		return
	end
	local name = PlayerNPCTarget
	local facI = UnitFactionGroup ("player") == "Horde" and 1 or 0
	npcs[name] = format ("%s^%d^%s", PlayerNPCTargetPos, facI, data)
end

function RDXMAP.APIGuide.CapTimer()
	if not Nx then return; end
	local g = Nx.Guideobj
	local ok = RDXMAP.APIGuide.CaptureItems()  
	if g then
		g:UpdateVisitedVendors()
		g:Update()
	end
	if not ok and MerchantFrame:IsVisible() then
		if RDXG.LootOn then
			VFL.vprint ("CapTimer retry")
		end
		return .5
	end
	CanCap = false		
end

function RDXMAP.APIGuide.OnMerchant_show()
	RDXMAP.APIGuide.SavePlayerNPCTarget()
	VendorRepair = CanMerchantRepair()
	RDXMAP.APIGuide.CaptureNPC (format ("M%s", VendorRepair and 1 or 0))
	CanCap = true
	RDXMAP.APIGuide.OnMerchant_update()
end
function RDXMAP.APIGuide.OnMerchant_update()
	if CanCap then
		VFLT.ZMSchedule(.3, RDXMAP.APIGuide.CapTimer);
	end
end


function RDXMAP.APIGuide.OnGossip_show()
	RDXMAP.APIGuide.SavePlayerNPCTarget()
	RDXMAP.APIGuide.CaptureNPC ("G")
end
function RDXMAP.APIGuide.OnTrainer_show()
	RDXMAP.APIGuide.SavePlayerNPCTarget()
	RDXMAP.APIGuide.CaptureNPC ("T")
end

--[[
function RDXMAP.APIGuide.OnTrade_skill_show()	-- Your own trade window


	VFL.vprint ("OnTRADE_SKILL_SHOW")

	Nax.prtStrHex ("Trade", GetTradeSkillListLink())
	local link = GetTradeSkillListLink()

--	RDXMAP.APIGuide.SavePlayerNPCTarget()
end
--]]