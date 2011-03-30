-- LearnWizard.lua
-- OpenRDX
--

-- English text.
local title_text = {};
title_text[1] = "Welcome";
title_text[2] = "Main Menu";
title_text[3] = "Blizzard UI";
title_text[4] = "Windows";
title_text[5] = "KeyBindings";
title_text[6] = "MouseBindings";
title_text[7] = "RDX Theme UI";
title_text[8] = "Done";

local content_text = {};

content_text[1] = [[
This is the first time you are using RDX, this quick tutorial will help you to learn how to use RDX.
You can close this tutorial at any time.
Go to the menu Settings to reopen this tutorial.

The tutorial will explain the following topics:
- Main Menu
- Blizzard UI
- Windows Desktop
- KeyBindings
- MouseBindings
- RDX Theme UI
]];

content_text[2] = [[
The main menu is located on the top of your screen.
Solo, Multi, UI, Repo, Settings
Move your mouse on the main menu.

You should also see a small RDX icon in the center of the screen. This is the quick menu.
You can move it with the key shift. Using the quick menu, you can hide the main menu.
]];

content_text[3] = [[
You can customize the main menu.
Click on the menu Settings and select RDX Settings.
You can disable the animation of the main menu, check the box Always show main panel.
You can change the icon texture here. Click on the disk to save when finish.
]];

content_text[4] = [[
Before begining, you need to hide the default Blizzard UI.
Click on the menu UI and select Blizzard Frame Manager.
Check all elements and click on the button save.
Your UI will be reload and should be empty except the chatframe blizzard.
]];

content_text[5] = [[
Your UI is working like your Windows 7 desktop. You can open or you can close some windows on your UI.
A player frame is a window, a minimap is a window, a window could be complexe, with a chatframe, some actionsbar etc ...

Let's open some windows on your desktop. Click on the menu UI, select windows and windows list.

The windows list contains all the available windows from your repository.
Open the window WoWRDX:Player_Main
Open more windows if you wish.

By default, windows are located in the center of your UI.
You can close windows by clicking again in the windows list.
]];

content_text[6] = [[
To move a window, you need to switch in UI edit mode. Right click on the main menu UI.

All windows show a blue panel. You can drag them everywhere on your UI.

Right click again on the main menu UI to leave the edit mode.
]];

content_text[7] = [[
You can define the scale, the alpha and the stratum for each window.

Switch in UI edit mode.
Right click the blue panel of a window and select Layout.

A panel option appears and let you modify the window.
]];

content_text[8] = [[
You can dock two windows together. So when you move one windows, it will move all.

Switch in UI edit mode.
Drag and drop a anchor point from one window to a anchor point of a second windows.
Both points will be colored in red.
Drag them again.

Tip: By default, one of the window become the parent window and it appears as purple.
Tip: You can dock a window to a anchor points of your UI.
]];

content_text[9] = [[
By default, key bindings are link to Blizzard Action bar. It is important that you configure your key bindings with RDX Action bar.

Use the windows list to open the windows WoWRDX:Actionbar_1, WoWRDX:Actionbar_3, WoWRDX:Actionbar_4,  WoWRDX:Actionbar_5 and WoWRDX:Actionbar_6.
Click on the menu UI, Locking, Lock/Unlock KeyBindings.
In your action bars, you should see some numbers. Click on the button number to set the key bindings.
When you have finish, Lock your KeyBindings
]];

content_text[10] = [[
You can define your mouse bindings for each window.
For example, left click will heal the unit, right click set the focus.
Switch in UI edit mode.
Right click on a window and select Edit Bindings.
Some windows have many clickable field, so you will have many Edit Bindings.
]];

content_text[11] = [[
By default, you are customizing the theme AUI link to your character.
You can load some predefined theme.
Click on the menu UI, Theme AUI and select the theme you wish to load.

More AUIs are available on WoWInterface at this link:
http://www.wowinterface.com/downloads/cat117.html
]];

content_text[12] = [[
Each theme come with 10 predefined desktop.
SOLO, PARTY, RAID, ARENA, PVP and smae with the second spec.

Click on the menu UI, States, and select the state you want.
You can also enable the automatic state switch.
]];

content_text[13] = [[
The tutorial is done.
You have finished to learn basic usage of RDX.

Now for more informations, tutorials, communities, visit us at:
http://www.wowrdx.com

Sigg email:
sigg@wowrdx.com

Enjoy your new user interface.

Cheers
The RDX Team.
]];

if GetLocale() == "frFR" and VFL.titlefrFR and VFL.contentfrFR then
	title_text = VFL.titlefrFR;
	content_text = VFL.contentfrFR;
elseif GetLocale() == "deDE" and VFL.titledeDE and VFL.contentdeDE then
	title_text = VFL.titledeDE;
	content_text = VFL.contentdeDE;
end

local ww = RDXUI.Wizard:new();

---------------------------------------------
-- Pg 1: Welcome
---------------------------------------------
ww:RegisterPage(1, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[1]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[1], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(120);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local chk_hideLW = VFLUI.Checkbox:new(page); chk_hideLW:Show();
		chk_hideLW:SetHeight(20); chk_hideLW:SetWidth(200);
		chk_hideLW:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, -20);
		chk_hideLW:SetText("Not show this guide at startup.");
		if RDXG and RDXG.hideLW then chk_hideLW:SetChecked(true); else chk_hideLW:SetChecked(); end
		
		local lb2 = VFLUI.MakeLabel(nil, page, "1/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);

		function page:GetDescriptor()
			if RDXG then RDXG.hideLW = chk_hideLW:GetChecked(); end
			return {};
		end
		
		RDXG.learnNum = 1;

		page.Destroy = VFL.hook(function(s)
			chk_hideLW:Destroy();
		end, page.Destroy);
		
		wizard:OnNext(function(wiz) wiz:SetPage(2); end);
		wizard:Final();
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		return true;
	end;
});

ww:RegisterPage(2, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[2]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[2], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "2/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		function page:GetDescriptor()
			return {};
		end
		
		RDXG.learnNum = 2;
		
		wizard:OnNext(function(wiz) wiz:SetPage(3); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		return true;
	end;
});

ww:RegisterPage(3, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[2]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[3], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "3/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		function page:GetDescriptor()
			return {};
		end
		
		RDXG.learnNum = 3;
		
		wizard:OnNext(function(wiz) wiz:SetPage(4); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if not RDXPM.IsRDXManageOpen() then errs:AddError("Panel RDX Settings is not open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(4, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[3]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[4], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "4/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		function page:GetDescriptor()
			return {};
		end
		
		RDXG.learnNum = 4;
		
		wizard:OnNext(function(wiz) wiz:SetPage(5); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXPM.IsRDXManageOpen() then errs:AddError("Panel RDX Settings is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(5, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[4]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[5], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(190);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "5/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		function page:GetDescriptor()
			return {};
		end
		
		RDXG.learnNum = 5;
		
		wizard:OnNext(function(wiz) wiz:SetPage(6); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if not RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is not open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(6, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[4]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[6], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "6/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 6;
		
		function page:GetDescriptor()
			return {};
		end
		
		wizard:OnNext(function(wiz) wiz:SetPage(7); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(7, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[4]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[7], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "7/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 7;
		
		function page:GetDescriptor()
			return {};
		end
		
		wizard:OnNext(function(wiz) wiz:SetPage(8); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(8, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[4]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[8], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "8/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 8;
		
		function page:GetDescriptor()
			return {};
		end
		
		wizard:OnNext(function(wiz) wiz:SetPage(9); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(9, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[5]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[9], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "9/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 9;
		
		function page:GetDescriptor()
			return {};
		end
		
		wizard:OnNext(function(wiz) wiz:SetPage(10); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(10, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[6]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[10], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "10/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 10;
		
		function page:GetDescriptor()
			return {};
		end
		
		wizard:OnNext(function(wiz) wiz:SetPage(11); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(11, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[7]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[11], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "11/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 11;
		
		function page:GetDescriptor()
			return {};
		end
		
		wizard:OnNext(function(wiz) wiz:SetPage(12); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(12, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[7]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[12], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "12/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 12;
		
		function page:GetDescriptor()
			return {};
		end
		
		wizard:OnNext(function(wiz) wiz:SetPage(13); end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

ww:RegisterPage(13, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, title_text[8]);
		
		local lbl = VFLUI.MakeLabel(nil, page, content_text[13], "LEFT", "TOP");
		lbl:SetWidth(250); lbl:SetHeight(160);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local lb2 = VFLUI.MakeLabel(nil, page, "13/13", "CENTER", "CENTER");
		lb2:SetWidth(250); lb2:SetHeight(10);
		lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
		
		RDXG.learnNum = 1;
		
		function page:GetDescriptor()
			return {};
		end
		
		--wizard:OnNext(function(wiz) wiz:SetPage(13); end);
		wizard:Final();
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		--if RDXDK.IsBlizzardManageOpen() then errs:AddError("Panel Blizzard UI Element is still open."); end
		return not errs:HasError();
	end;
});

function ww:OnOK()
	--VFL.print("OnOK");
end

ww.title = "Learn RDX Wizard";
RDX.learnWizard = ww;

function RDX.NewLearnWizard(num)
	RDX.learnWizard:SetDescriptor({});
	RDX.learnWizard:Open(VFLDIALOG, num);
end

