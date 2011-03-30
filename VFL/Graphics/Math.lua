-- Math.lua
-- VFL
-- (C)2007 Bill Johnson and The VFL Project
--
-- Operations on matrices and vectors for use in vector graphics code.

local abs = math.abs;

VFLG = {};

---------------------------
-- Tools for manipulating and applying affine transformations.
-- Affine transformations are stored as a compact 6-member array
-- according to:
--          [A,B,C]
-- Matrix = [D,E,F]
--          [0,0,1]
--
-- stored as
--
-- Matrix = {A,B,C,D,E,F}
---------------------------

--------------------------
-- A metatable-driven API for affine transforms.
--------------------------
local AffineAPI = {};
local AffineMetatable = { __index = AffineAPI };
Affine2D = {};

--- Create a new 2D-affine transform
function Affine2D:new(x)
	x = x or {};
	setmetatable(x, AffineMetatable);
	x:LoadIdentity();
	return x;
end

--- Make this matrix equal to the identity matrix.
function AffineAPI:LoadIdentity()
	self[1] = 1; self[2] = 0; self[3] = 0; self[4] = 0; self[5] = 1; self[6] = 0;
	return self;
end

-- A temporary matrix used in computations below.
local tempMatrix = Affine2D:new();

--- Set the values piecewise
function AffineAPI:SetParts(a, b, c, d, e, f)
	self[1] = a; self[2] = b; self[3] = c; self[4] = d; self[5] = e; self[6] = f;
	return self;
end

--- Set equal to another affine transform
function AffineAPI:Set(other)
	self[1] = other[1]; self[2] = other[2]; self[3] = other[3]; 
	self[4] = other[4];	self[5] = other[5]; self[6] = other[6];
	return self;
end

--- Set equal to an affine translation
function AffineAPI:LoadTranslation(dx, dy)
	self[1] = 1; self[2] = 0; self[3] = dx;
	self[4] = 0; self[5] = 1; self[6] = dy;
end

--- Apply to a fully specified point
function AffineAPI:ApplyToPoint(x, y)
	return self[1] * x + self[2] * y + self[3], self[4] * x + self[5] * y + self[6];
end

--- Matrix multiplication: self = self * other
function AffineAPI:PostMultiply(m2)
	local m11,m12,m13,m21,m22,m23;
	local n11,n12,n13,n21,n22,n23;
	
	m11 = self[1]; m12 = self[2]; m13 = self[3];
	m21 = self[4]; m22 = self[5]; m23 = self[6];

	n11 = m2[1]; n12 = m2[2]; n13 = m2[3];
	n21 = m2[4]; n22 = m2[5]; n23 = m2[6];

	self[1] = m11*n11+m12*n21;
	self[2] = m11*n12+m12*n22;
	self[3] = m11*n13+m12*n23+m13;
	self[4] = m21*n11+m22*n21;
	self[5] = m21*n12+m22*n22;
	self[6] = m21*n13+m22*n23+m23;

	return self;
end

--- Matrix multiplication: self = other * self
function AffineAPI:PreMultiply(m2)
	local m11,m12,m13,m21,m22,m23;
	local n11,n12,n13,n21,n22,n23;
	
	m11 = m2[1]; m12 = m2[2]; m13 = m2[3];
	m21 = m2[4]; m22 = m2[5]; m23 = m2[6];

	n11 = self[1]; n12 = self[2]; n13 = self[3];
	n21 = self[4]; n22 = self[5]; n23 = self[6];

	self[1] = m11*n11+m12*n21;
	self[2] = m11*n12+m12*n22;
	self[3] = m11*n13+m12*n23+m13;
	self[4] = m21*n11+m22*n21;
	self[5] = m21*n12+m22*n22;
	self[6] = m21*n13+m22*n23+m23;

	return self;
end

--- Invert this matrix in place (if possible)
function AffineAPI:Invert()
	local m11,m12,m13,m21,m22,m23;
	m11 = self[1]; m12 = self[2]; m13 = self[3];
	m21 = self[4]; m22 = self[5]; m23 = self[6];

	-- Check invertibility
	local det = m11*m22 - m12*m21;
	if abs(det) < .000001 then return nil; end

	self[1] = m22/det; self[2] = -m12/det; self[3] = (m12*m23 - m13*m22)/det;
	self[4] = -m21/det; self[5] = m11/det; self[6] = (m13*m21 - m11*m23)/det;
	return self;
end

-- Load the affine transform from XY-space to UV-space such that:
-- (0,0) -> (ULx, ULy) and (0,1) -> (LLx, LLy) and (1, 0) -> (URx, URy)
function AffineAPI:LoadXYtoUV_Corners(ULx, ULy, LLx, LLy, URx, URy)
	self[1] = URx - ULx; self[2] = LLx - ULx; self[3] = ULx;
	self[4] = URy - ULy; self[5] = LLy - ULy; self[6] = ULy;
	return self;
end

-- Load the affine transform T from XY-space to UV-space such that
-- T(p0) = q0, T(p1) = q1, T(p2) = q2.
function AffineAPI:LoadXYtoUV_MatchPoints(p0x, p0y, q0x, q0y, p1x, p1y, q1x, q1y, p2x, p2y, q2x, q2y)
	-- First send <p0, p1, p2> -> <(0,0), (0,1), (1,0)>
	if tempMatrix:LoadXYtoUV_Corners(p0x, p0y, p1x, p1y, p2x, p2y):Invert() then
		-- Then send <(0,0), (0,1), (1,0)> to (q0, q1, q2)
		self:LoadXYtoUV_Corners(q0x, q0y, q1x, q1y, q2x, q2y):PostMultiply(tempMatrix);
		return self;
	else
		return nil;
	end
end

-- Debug dump a matrix
function AffineAPI:DebugDump()
	VFL.print("(" .. self[1] .. ", " .. self[2] .. ", " .. self[3] .. ")");
	VFL.print("(" .. self[4] .. ", " .. self[5] .. ", " .. self[6] .. ")");
end

