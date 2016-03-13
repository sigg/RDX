-- OpenRDX Sigg

RDX.RegisterFeature({
	name = "Open Close Window",
	category = VFLI.i18n("Windows");
	invisible = true;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		if not desc.ext or desc.ext == "" then VFL.AddError(errs, VFLI.i18n("Miss window name")); return false; end
		return true;
	end;
	ApplyFeature = function(desc, state)	
		state.Code:AppendCode([[
		BossmodEvents:Bind("ACTIVATE", nil, function()
			RDXDB.OpenObject("]].. desc.ext ..[[");
		end, encid);
		
		BossmodEvents:Bind("DEACTIVATE", nil, function()
			RDXDB.OpenObject("]].. desc.ext ..[[", "Close");
		end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local file_external = RDXDB.ObjectFinder:new(ui, function(d,p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Window$")); end);
		file_external:SetLabel(VFLI.i18n("Window File"));
		file_external:SetWidth(200); file_external:Show();
		ui:InsertFrame(file_external);
		if desc.ext then file_external:SetPath(desc.ext); end
		
		function ui:GetDescriptor()
			return {
				feature = "Open Close Window";
				ext = file_external:GetPath();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Open Close Window"}; end
});

RDX.RegisterFeature({
	name = "MultiTrack",
	category = VFLI.i18n("Windows");
	invisible = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state)
		if not desc then return nil; end
		if type(desc.trackList) ~= "table" then return nil; end
		state:AddSlot("MultiTrack");
		return true;
	end;
	ApplyFeature = function(desc, state)	
		state.Code:AppendCode([[
		BossmodEvents:Bind("ACTIVATE", nil, function()
			local trace;
		]]);
		for _,v in pairs(desc.trackList) do if type(v) == "string" then
			state.Code:AppendCode([[
			trace = HOT.TrackTarget("]]..v..[[");
			MultiTrack.Add(trace);
			]]);
		end end
		state.Code:AppendCode([[
			MultiTrack.Open();
		end, encid);
		
		BossmodEvents:Bind("DEACTIVATE", nil, function()
			MultiTrack.Close();
		end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local le_names = VFLUI.ListEditor:new(ui, desc.trackList or {}, function(cell,data)
			cell.text:SetText(data); end);
		le_names:SetHeight(200); le_names:Show();
		ui:InsertFrame(le_names);
		
		function ui:GetDescriptor()
			return {
				feature = "MultiTrack"; 
				trackList = le_names:GetList();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "MultiTrack"}; end
});
