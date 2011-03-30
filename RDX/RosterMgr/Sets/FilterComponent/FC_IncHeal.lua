
-- Xenios

RDXDAL.RegisterFilterComponent({
    name = "incHeal", title = "incHeal", category = "Auras",
    UIFromDescriptor = function(desc, parent)
        local ui = VFLUI.FilterDialogFrame:new(parent);
        ui:SetText("incHeal"); ui:Show();
        ui.GetDescriptor = function() return {"incHeal"}; end;
        return ui;
    end,
    GetBlankDescriptor = function() return {"incHeal"}; end,
    FilterFromDescriptor = function(desc, metadata)
        table.insert(metadata, {class = "LOCAL", name = "heal", value = "(UnitGetIncomingHeals(unit.uid)) or 0"})
        return "(heal > 0)"
    end,
    EventsFromDescriptor = function(desc, metadata)
        RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_INCOMING_HEALS");
    end,
    SetsFromDescriptor = VFL.Noop,
    ValidateDescriptor = VFL.True,
});

