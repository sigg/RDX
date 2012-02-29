
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	
	if IsAddOnLoaded("QuestKing") then
		RDXDK.RegisterWindowLess({
			name = "desktop_questking",
			Init = function(id)
				local a = QuestKing_Tracker;
				if a then a:Hide(); end
				return true;
			end,
			Open = function(id)
				local a = QuestKing_Tracker;
				if a then 
					a:Show(); 
					return a; 
				else
					return nil;
				end
			end,
			Close = function(id, frame)
				local a = QuestKing_Tracker;
				if a then a:Hide(); end
				return true;
			end,
			Description = "QuestKing",
			Rebuild = function(id, frame)
				return true;
			end,
			Props = function(mnu, id, frame)
				table.insert(mnu, {
					text = VFLI.i18n("Rebuild"),
					OnClick = function()
						VFL.poptree:Release();
						local cls = RDXDK.GetWindowLess(frame._dk_name);
						if cls then
							cls.Rebuild(id, frame);
						end
					end
				});
			end
		});
	end
end);