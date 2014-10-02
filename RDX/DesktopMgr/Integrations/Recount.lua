
RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	if IsAddOnLoaded("Recount") then
		RDXDK.RegisterWindowLess({
			name = "Recount_MainWindow",
			Init = function(id)
				local a = Recount_MainWindow;
				Recount_MainWindow:SetScript("OnShow", nil);
				Recount_MainWindow:SetScript("OnHide", nil);
				Recount_MainWindow:SetScript("OnMouseDown", nil);
				Recount_MainWindow:SetScript("OnMouseUp", nil);
				Recount:LockWindows(true);
				if a then a:Hide(); end
				return true;
			end,
			Open = function(id)
				local a = Recount_MainWindow;
				if a then 
					a:Show(); 
					return a; 
				else
					return nil;
				end
			end,
			Close = function(id, frame)
				local a = Recount_MainWindow;
				if a then a:Hide(); end
				return true;
			end,
			Description = "Recount_MainWindow",
			Rebuild = function(id, frame)
				return true;
			end,
			Props = function(mnu, id, frame)
				table.insert(mnu, {
					text = VFLI.i18n("Rebuild"),
					func = function()
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