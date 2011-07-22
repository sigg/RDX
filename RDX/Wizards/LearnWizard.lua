-- LearnWizard.lua
-- OpenRDX
--

local page_default = {};

local page_id = 0;
local function GetNextPageId()
	page_id = page_id + 1;
	return page_id;
end

page_default[GetNextPageId()] = {
	title = "Welcome";
	txt = [[
Welcome to RDX.

For more informations, tutorials, communities, visit us at:
http://www.wowrdx.com

Sigg / Rashgarroth FR
Siggounet / Galakrond US

Email:
sigg@wowrdx.com

Click on the button Next to start the tutorial.
]];
};

page_default[GetNextPageId()] = {
	title = "Classic Menu";
	txt = [[
The small RDX icon in the center of your screen is the classic menu.
Move it with the key shift and the mouse.

The classic menu contains some quick links to handle your UI.
You can also show/hide the main menu which contains more options.

Right click on the classic menu to edit your current Theme.
]];
};

page_default[GetNextPageId()] = {
	title = "Main Menu";
	txt = [[
Click on the classic menu, visibility and show Main Menu.
The Main Menu is located on the top of your screen. 
Solo, Multi, UI, Repo, Settings

You can customize the main menu:
Click on the menu Settings and select RDX Settings.
You can disable the animation of the main menu, check the box Always show main panel.
You can change the icon texture here. Click on the disk to save when finish.
]];
};

page_default[GetNextPageId()] = {
	title = "Blizzard UI";
	txt = [[
All the Blizzard UI elements are hidden by default
If you wish to display some elements, Click on the Main Menu UI and select Blizzard Frame Manager.
Uncheck the components you wish to display.
Your UI will be reload.
]];
};

page_default[GetNextPageId()] = {
	title = "Theme";
	txt = [[
RDX 8.1.1 contains 10 themes AUI.
To select a theme, click on the Classic Menu, theme the submenu Themes.
Your current theme will be closed (all your modifications are saved), the new theme will be open.
]];
};

page_default[GetNextPageId()] = {
	title = "Theme states";
	txt = [[
Each theme come with 5 predefined desktop.
SOLO, PARTY, RAID, ARENA, PVP.

Your desktop will automatically switch depend of your current situation.

Click on the Classic Menu, Theme States and select the state you want.

Select Auto, if you want your theme to automatic switch.
]];
};

page_default[GetNextPageId()] = {
	name = "desktop_manager";
	title = "Desktop Manager";
	txt = [[
Right click on the Classic Menu to open the desktop manager and to activate the UI edit mode.

Using the Desktop Manager, you can:
Modify the viewport
Open/Close some windows
Manage the properties of a window
Manage your keys bindings
Manage your Gametooltip

Right click again on the Classic Menu to leave the UI edit mode.
]];
};

page_default[GetNextPageId()] = {
	title = "Windows List";
	txt = [[
You can open/close some windows on your UI.
A player frame is a window, a minimap is a window, each UI element is a window.

The windows list contains all the available windows of your current theme.

You can move them everywhere on your UI.
]];
};

page_default[GetNextPageId()] = {
	title = "Window properties";
	txt = [[
You can define the scale, the alpha and the stratum of each window.
Select a window, the desktop manager will show the options to modify it.

]];
};

page_default[GetNextPageId()] = {
	name = "docking_windows";
	title = "Docking windows";
	txt = [[
To undock two windows: Right click on a red/yellow anchor point.
To dock two windows: Drag a anchor point of the first window and drop it on the anchor point of the second window.
You can also dock a window to the parent UI, but you will not be able to move this window anymore.
Tip: By default, one of the window become the parent window and it appears as purple color.

Click on a existing dock to define the offset between two windows.
]];
};

page_default[GetNextPageId()] = {
	title = "Key bindings";
	txt = [[
Click on the button Setup your KeyBindings of the desktop manager.
In your action bars, you should see some numbers. Click on the button number to set the key bindings.
When you have finish, Click back on the desktop manager.
]];
};

page_default[GetNextPageId()] = {
	title = "Mouse bindings";
	txt = [[
You can define your mouse bindings for each window.
For example, left click will heal the unit, right click set the focus.
Switch in UI edit mode.
Right click on a window and select Edit Bindings.
]];
};

page_default[GetNextPageId()] = {
	title = "Chatframes";
	txt = [[
It is possible that you have some strange behaviours with chatframes, after installing RDX.
Go to the menu Settings (Main Menu), Debugging and click on Reset Chatframes.
Your UI will be reloaded.
]];
};

page_default[GetNextPageId()] = {
	title = "Tutorial End";
	txt = [[
Thanks you

We hope you will enjoy RDX.

Cheers
The RDX Team.
]];
};

if GetLocale() == "frFR" and VFL.pagefrFR then
	page_default = VFL.pagefrFR;
elseif GetLocale() == "deDE" and VFL.pagedeDE and VFL.contentdeDE then
	page_default = VFL.pagedeDE;
end

local maxpage = #page_default;

local ww = RDXUI.Wizard:new();

for i,v in ipairs(page_default) do
	ww:RegisterPage(i, {
		OpenPage = function(parent, wizard, desc)
			local page = RDXUI.GenerateStdWizardPage(parent, v.title);
			
			local lbl = VFLUI.MakeLabel(nil, page, v.txt, "LEFT", "TOP");
			lbl:SetWidth(250); lbl:SetHeight(150);
			lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
			
			local lb2 = VFLUI.MakeLabel(nil, page, i .."/"..maxpage, "CENTER", "CENTER");
			lb2:SetWidth(250); lb2:SetHeight(10);
			lb2:SetPoint("BOTTOM", page, "BOTTOM", 0, 5);
			
			function page:GetDescriptor()
				return {};
			end
			
			RDXG.learnNum = i;
			
			wizard:OnNext(function(wiz) wiz:SetPage(i + 1); end);
			wizard:Final();
			
			return page;
		end;
		Verify = function(desc, wizard, errs)
			return true;
		end;
	});
end

function ww:OnOK()
	--VFL.print("OnOK");
end

ww.title = "Learn RDX Wizard";
RDX.learnWizard = ww;

function RDX.NewLearnWizard(num)
	RDX.learnWizard:SetDescriptor({});
	RDX.learnWizard:Open(VFLDIALOG, num);
end

function RDX.NewLearnWizardName(name)
	local num = 1;
	for i,v in ipairs(page_default) do
		if v.name == name then num = i; end
	end
	RDX.learnWizard:SetDescriptor({});
	RDX.learnWizard:Open(VFLDIALOG, num);
end

