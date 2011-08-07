--------------------------------------------------
-- Scripted variable type
--------------------------------------------------
RDX.RegisterFeature({
	name = "Debug";
	title = "Debug";
	category = "Miscs";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- Apply the custom code.
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode(desc.editor);
		end);
		
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local editor = VFLUI.TextEditor:new(ui, "LuaEditBox");
		editor:SetHeight(200); editor:Show();
		editor:SetText(desc.editor or "");
		editor:GetEditWidget():SetFocus();
		ui:InsertFrame(editor);

		function ui:GetDescriptor()
			return { 
				feature = "Debug";
				editor = editor:GetText();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "Debug", editor = "--enter your code here",
		};
	end;
});