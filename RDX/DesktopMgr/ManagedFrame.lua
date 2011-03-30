-- Frame.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- OpenRDX
-- Original code from WindowManager
-- frame functions
-- 

--------------------------------------------------------------------------------------------------
-- INDIVIDUAL FRAME FUNCTIONALITY
--------------------------------------------------------------------------------------------------
-- The default frame abstraction handlers.
local function Default_GetPositionalFrame(frame)
	return frame;
end
local function Default_GetDockPoint(frame, point)
	return point, 0, 0;
end
local function Default_GetDockBoundary(frame)
	local df = frame:WMGetPositionalFrame();
	return VFLUI.GetUniversalBoundary(df);
end

local function Default_Drag(frame)
	if (frame._dk_nolayout) or (frame._dk_drag) or frame._dk_name == "root" then return; end
	-- When we drag, we're actually dragging the dock group parent.
	local frameprops = RDXDK.GetCurrentDesktop():_GetFrameProps(frame._dk_name);
	local dragframeprops = RDXDK.FindDockGroupParent(frameprops) or frameprops;
	frame._dk_drag = RDXDK.GetCurrentDesktop():_GetFrame(dragframeprops.name)
	if frame._dk_drag._dk_name == "root" then return; end
	if frame.OnDrag then frame:OnDrag(true); end
	if frame._dk_drag then
		frame._dk_drag:WMGetPositionalFrame():StartMoving();
	end
end

local endingPosition_1, endingPosition_2;
local function Default_StopDrag(frame, quick)
	if (frame._dk_nolayout) or (not frame._dk_drag) then return; end
	-- Stop moving
	frame._dk_drag:WMGetPositionalFrame():StopMovingOrSizing();
	if frame.OnDrag then frame:OnDrag(nil); end
	
	--local frameprops = RDXDK.GetFrameProps(frame._dk_drag._dk_name);
	--RDXDK.SavePosition(frame._dk_drag, frameprops, true);

	-- get the position of the window when the mouse buton is released
	endingPosition_1, endingPosition_2 = GetCursorPosition();

	frame._dk_drag = nil;

 	-- if frame has not moved from stored position assume a single Click and Run the Click function
 	if((endingPosition_1 == frame._startingPosition_1) and (endingPosition_2 == frame._startingPosition_2)) then
 		if(frame._clickFunc) then frame._clickFunc(frame); end
 	else -- otherwise update postions and docks as normal
	 	-- save positions for all frames
		--RDXDK._SaveFramePropsList(true);
		
		-- Don't allow any docking to happen while in combat.
		if quick or InCombatLockdown() then return; end
		DesktopEvents:Dispatch("WINDOW_UPDATE_ALL", "POSITION");
		-- Figure out if this frame is dockable to any other frames nearby
		--local frameprops = RDXDK.GetFrameProps(frame._dk_name);
		
		--local iDocked = RDXDK.CheckDockInteraction(frameprops);
		-- Relayout the dock group.
		--if iDocked then
		--RDXDK.ResetDockGroupLayout(frame);
		--RDXDK.LayoutDockGroup(frame, true);
		--RDXDK._SaveFramePropsList(true);
		--else
			
		--end
	end
end

local function Rebuild(frame)
	RDXDK.ResetDockGroupLayout(frame);
	RDXDK.LayoutDockGroup(frame);
end

-- Undo what was done by ImbueManagedFrame.
local function UnimbueManagedFrame(frame)
	-- Clear vars
	frame._dk_layout = nil; frame._dk_nolayout = nil;
	frame._dk_drag = nil; frame._dk_name = nil;
	-- Quash functions
	frame.WMDrag = nil; frame.WMStopDrag = nil;
	--frame.WMGetIdentity = nil; 
	--frame.WMGetClass = nil;
	--frame.WMSetSecure = nil; 
	frame.WMRebuild = nil;

	frame.WMGetPositionalFrame = nil; frame.WMGetDockBoundary = nil;
	frame.WMGetDockTargetPoint = nil; frame.WMGetDockSourcePoint = nil;
	frame.WMCanOtherDockToMe = nil; frame.CanIDockToOther = nil;
end
RDXDK.UnimbueManagedFrame = UnimbueManagedFrame

-- Make a frame into a WM-managed frame.
local function ImbueManagedFrame(frame, name)
	
	-- Setup default internals
	frame._dk_name = name; 
	frame._dk_layout = nil;
	
	--- Non-overridable default methods
	frame.WMDrag = Default_Drag; 
	frame.WMStopDrag = Default_StopDrag;
	frame.WMRebuild = Rebuild;

	-- Overridable methods
	if not frame.WMGetPositionalFrame then frame.WMGetPositionalFrame = Default_GetPositionalFrame; end
	if not frame.WMGetDockBoundary then frame.WMGetDockBoundary = Default_GetDockBoundary; end
	if not frame.WMGetDockTargetPoint then frame.WMGetDockTargetPoint = Default_GetDockPoint; end
	if not frame.WMGetDockSourcePoint then frame.WMGetDockSourcePoint = Default_GetDockPoint; end
	if not frame.WMCanOtherDockToMe then frame.WMCanOtherDockToMe = Default_CanOtherDockToMe; end
	if not frame.WMCanIDockToOther then frame.WMCanIDockToOther = Default_CanIDockToOther; end

	-- Destructor
	--frame.Destroy = VFL.hook(function(s)
		-- Destroy mark if it exists
		--if s._wm_mark then
		--	VFLUI.ReleaseRegion(s._wm_mark);
		--	s._wm_mark = nil;
		--end
		-- Destroy layout
		--Unlayout(s);
		-- Remove this frame's record as an open frame
		--identMap[s:WMGetIdentity()] = nil;
		-- Destroy managed frame entries
		--UnimbueManagedFrame(s);
	--end, frame.Destroy);
end
RDXDK.ImbueManagedFrame = ImbueManagedFrame

--- Add a standard "move handle" to the given managed frame
function RDXDK.StdMove(frame, handle, clickFunc)
	if type(clickFunc) ~= "function" then clickFunc = VFL.Noop; end
	handle:SetScript("OnMouseDown", function(self, arg1)
		-- store the starting location to see if the frame was actually moved
		frame._startingPosition_1, frame._startingPosition_2 = GetCursorPosition();
		frame._clickFunc = clickFunc;
		if(arg1 == "LeftButton") then frame:WMDrag(); end
	end);
	handle:SetScript("OnMouseUp", function(self, arg1)
		if(arg1 == "LeftButton") then
			--if frame._dk_drag then
				frame:WMStopDrag();
			--else
			--	clickFunc(frame); -- todo doesn't work(Taelnia: fixed, see Default_StopDrag)
			--end
		elseif(arg1 == "RightButton") then
			RDXDK.FrameProperties(frame);
		end
		frame._clickFunc = nil;
		frame._startingPosition_1 = nil;
		frame._startingPosition_2 = nil;
	end);
end