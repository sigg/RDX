-- FC_Auras.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Filter Components dealing with buffs and debuffs.
RDXDAL.RegisterFilterComponentCategory(VFLI.i18n("Auras"));


-- Debuff Type: magic
RDXDAL.RegisterFilterComponent({
	name = "dmagic", title = VFLI.i18n("Magic"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "debuff", buff = "@magic" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

-- Debuff Type: curse
RDXDAL.RegisterFilterComponent({
	name = "dcurse", title = VFLI.i18n("Curse"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "debuff", buff = "@curse" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

-- Debuff Type: disease
RDXDAL.RegisterFilterComponent({
	name = "ddisease", title = VFLI.i18n("Disease"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "debuff", buff = "@disease" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

-- Debuff Type: poison
RDXDAL.RegisterFilterComponent({
	name = "dpoison", title = VFLI.i18n("Poison"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "debuff", buff = "@poison" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

-- Debuff Type: other
RDXDAL.RegisterFilterComponent({
	name = "dother", title = VFLI.i18n("Other"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "debuff", buff = "@other" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

-- Debuff by name
RDXDAL.RegisterFilterComponent({
	name = "debuff_n", title = VFLI.i18n("Debuff (by name)"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "debuff" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

-- Buff by name
RDXDAL.RegisterFilterComponent({
	name = "buff_n", title = VFLI.i18n("Buff (by name)"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "buff" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});
-- MyBuff by name by sigg
RDXDAL.RegisterFilterComponent({
	name = "mybuff_n", title = VFLI.i18n("MyBuff (by name)"), category = VFLI.i18n("Auras"),
	UIFromDescriptor = VFL.Nil,
	GetBlankDescriptor = function() return {"set", { class = "mybuff" } }; end,
	FilterFromDescriptor = VFL.Nil,
	EventsFromDescriptor = VFL.Nil,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});
