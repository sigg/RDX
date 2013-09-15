

--- Get the mouse position in the local coordinates of the given frame.
function VFLUI.GetLocalMousePosition(frame)
	return VFLUI.GetLocalCoords(frame, GetCursorPosition());
end

--- Get the mouse position in the local coordinates of the given frame RELATIVE TO THE TOPLEFT OF THAT FRAME.
function VFLUI.GetRelativeLocalMousePosition(frame)
	l, t, mx, my = frame:GetLeft(), frame:GetTop(), VFLUI.GetLocalCoords(frame, GetCursorPosition());
	return (mx - l), (my - t);
end

function VFLUI.GetRelativeLocalMousePositionBL(frame)
	l, b, mx, my = frame:GetLeft(), frame:GetBottom(), VFLUI.GetLocalCoords(frame, GetCursorPosition());
	return (mx - l), (my - b);
end

--------
-- Check if mouse is over a frame
-- (frame)
-- ret XY offsets from bottom left corner or nil if not over

function VFLUI.IsMouseOver (frm)

	local x, y = GetCursorPosition()
	x = x / frm:GetEffectiveScale()

	local left = frm:GetLeft()
	local right = frm:GetRight()

	if x >= left and x <= right then

		y = y / frm:GetEffectiveScale()

		local top = frm:GetTop()
		local bottom = frm:GetBottom()

		if y >= bottom and y <= top then
			return x - left, y - bottom
		end
	end
end