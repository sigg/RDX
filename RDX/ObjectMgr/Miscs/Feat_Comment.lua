-- CommentFeature.lua
-- OpenRDX
--
-- Just for visual code

RDX.RegisterFeature({
	name = "commentline";
	category = "Miscs";
	version = 1;
	title = "----------";
	multiple = true;
	IsPossible = function(state)
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		return true;
	end;
	ApplyFeature = VFL.Noop;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_comment = VFLUI.LabeledEdit:new(ui, 400); ed_comment:Show();
		ed_comment:SetText("Comment");
		if desc.name then ed_comment.editBox:SetText(desc.name); end
		ui:InsertFrame(ed_comment);
		
		function ui:GetDescriptor()
			return { 
				feature = "commentline"; version = 1;
				name = ed_comment.editBox:GetText();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() return {feature = "commentline"}; end;
});