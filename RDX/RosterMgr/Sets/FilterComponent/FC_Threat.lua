----------------------------------------------------------
-- THREAT FILTER
----------------------------------------------------------
RDXDAL.RegisterFilterComponent({
   name = "threat", title = VFLI.i18n("Threat"), category = VFLI.i18n("Unit Status"),
   UIFromDescriptor = function(desc, parent)
      local ui = VFLUI.FilterDialogFrame:new(parent);
      ui:SetText(VFLI.i18n("Threat")); ui:Show();
      local container = VFLUI.CompoundFrame:new(ui);
      ui:SetChild(container); container:Show();

      local lb = VFLUI.LabeledEdit:new(container, 50);
      container:InsertFrame(lb);
      lb:SetText("Lower bound"); lb.editBox:SetText(desc[2]);
      lb:Show();
      local ub = VFLUI.LabeledEdit:new(container, 50);
      container:InsertFrame(ub);
      ub:SetText("Upper bound"); ub.editBox:SetText(desc[3]);
      ub:Show();

      ui.GetDescriptor = function(x)
         local lwr = lb.editBox:GetNumber(); if (not lwr) or (lwr < 0) then lwr = 0; end
         local upr = ub.editBox:GetNumber(); if (not upr) or (upr < 0) then upr = 1; end
         if(upr < lwr) then local temp = upr; upr = lwr; lwr = temp; end
         return {"threat", lwr, upr};
      end

      return ui;
   end,
   GetBlankDescriptor = function() return {"threat", 0, 1}; end,
   FilterFromDescriptor = function(desc, metadata)
      local lb, ub, vexpr = desc[2], desc[3];
      lb = VFL.clamp( lb, 0, 1);
      ub = VFL.clamp( ub, 0, 1);
      vexpr = "(unit:FracThreat())";
      -- Generate the closures/locals
      local vC = RDXDAL.GenerateFilterUpvalue();
      table.insert(metadata, { class = "LOCAL", name = vC, value = vexpr });
      -- Generate the filtration expression.
      return "((" .. vC .. " >= " .. lb ..") and (" .. vC .. " <= " .. ub .."))";
   end;
   ValidateDescriptor = VFL.True;
   SetsFromDescriptor = VFL.Noop;
   EventsFromDescriptor = function(desc, metadata)
      RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_THREAT");
   end;
});

RDXDAL.RegisterFilterComponent({
   name = "threatscaled", title = VFLI.i18n("Threat Scale"), category = VFLI.i18n("Unit Status"),
   UIFromDescriptor = function(desc, parent)
      local ui = VFLUI.FilterDialogFrame:new(parent);
      ui:SetText(VFLI.i18n("Threat Scale")); ui:Show();
      local container = VFLUI.CompoundFrame:new(ui);
      ui:SetChild(container); container:Show();

      local lb = VFLUI.LabeledEdit:new(container, 50);
      container:InsertFrame(lb);
      lb:SetText("Lower bound"); lb.editBox:SetText(desc[2]);
      lb:Show();
      local ub = VFLUI.LabeledEdit:new(container, 50);
      container:InsertFrame(ub);
      ub:SetText("Upper bound"); ub.editBox:SetText(desc[3]);
      ub:Show();

      ui.GetDescriptor = function(x)
         local lwr = lb.editBox:GetNumber(); if (not lwr) or (lwr < 0) then lwr = 0; end
         local upr = ub.editBox:GetNumber(); if (not upr) or (upr < 0) then upr = 1; end
         if(upr < lwr) then local temp = upr; upr = lwr; lwr = temp; end
         return {"threatscaled", lwr, upr};
      end

      return ui;
   end,
   GetBlankDescriptor = function() return {"threatscaled", 0, 1}; end,
   FilterFromDescriptor = function(desc, metadata)
      local lb, ub, vexpr = desc[2], desc[3];
      lb = VFL.clamp( lb, 0, 1);
      ub = VFL.clamp( ub, 0, 1);
      vexpr = "(unit:FracThreatScaled())";
      -- Generate the closures/locals
      local vC = RDXDAL.GenerateFilterUpvalue();
      table.insert(metadata, { class = "LOCAL", name = vC, value = vexpr });
      -- Generate the filtration expression.
      return "((" .. vC .. " >= " .. lb ..") and (" .. vC .. " <= " .. ub .."))";
   end;
   ValidateDescriptor = VFL.True;
   SetsFromDescriptor = VFL.Noop;
   EventsFromDescriptor = function(desc, metadata)
      RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_THREAT");
   end;
});