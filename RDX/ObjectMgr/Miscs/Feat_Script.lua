--------------------------------------------------
-- Scripted variable type
--------------------------------------------------
RDX.RegisterFeature({
	name = "Variable: Scripted";
	title = "Script";
	category = "Miscs";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		local md,_,_,ty = RDXDB.GetObjectData(desc.script);
		if (not md) or (ty ~= "Script") or (not md.data) or (not md.data.script) then
			VFL.AddError(errs, VFLI.i18n("Invalid script pointer.")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- Apply the custom code.
		local paintCode = [[

]];
		paintCode = paintCode .. (RDXDB.GetObjectData(desc.script)).data.script;
		paintCode = paintCode .. [[

]];

		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode(paintCode); end);
		
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local scriptsel = RDXDB.ObjectFinder:new(ui, function(d,p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Script")); end);
		scriptsel:SetLabel(VFLI.i18n("Script object")); scriptsel:Show();
		if desc and desc.script then scriptsel:SetPath(desc.script); end
		ui:InsertFrame(scriptsel);

		function ui:GetDescriptor()
			return { 
				feature = "Variable: Scripted";
				script = scriptsel:GetPath();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "Variable: Scripted", 
		};
	end;
});