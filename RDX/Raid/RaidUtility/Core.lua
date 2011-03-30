-- Core.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Root definitions for the logistics module.

Logistics = RegisterVFLModule({
	name = "Logistics";
	title = "Omnipresence";
	description = "Omnipresence - a logistics facility for RDX6";
	parent = RDX;
	version = {1,0,0};
});

LogisticsEvents = DispatchTable:new();

-- Create the logistics menu
--Logistics.menu = RDXPM.Menu:new();
--RDX.RegisterMainMenuEntry("Omnipresence", true, function(tree,frame) Logistics.menu:Open(tree, frame); end);

