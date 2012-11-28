--- RadixCodec.lua
-- @author (C)2006 Bill Johnson and The VFL Project
--
-- @description Tools for compressing and decompressing integers into strings.

local floor, len, sub, rep = math.floor, string.len, string.sub, string.rep;
local type = type;

--- Generate a pair of functions to encode/decode integers to/from strings.
-- @param radix The radix to use for the encoding.
-- @param power The digit padding of the encoder output.
-- @param base The base character code for the encoding (as string.char). The n'th character
--   in the output string will be char(base + d_n) where d_n is the n'th least significant
--   digit of the number in the given radix.
-- @param char A function for transforming integers in radix n to characters. Defaults to string.char
-- @param byte A function for transforming characters to integers in radix n. Defaults to string.byte
-- @return An encoder function
-- @return A decoder function
function VFL.GetRadixCodec(radix, power, base, char, byte)
	if type(char) ~= "function" then char = string.char; end
	if type(byte) ~= "function" then byte = string.byte; end
	if type(base) ~= "number" then base = 0; end

	local zero = 0;
	if type(power) == "number" then 
		power = floor(power); if(power < 0) then error("invalid power"); end
		zero = floor( (radix^power) / 2); 
	end

	local function Encoder(n)
		local ret, r;
		n = n + zero;
		if(n <= 0) then n = 0; ret = char(base); else ret = ""; end
		while(n > 0) do
			r = n % radix; n = floor(n/radix);
			ret = ret .. char(base + r);
		end
		if power and (len(ret) < power) then
			ret = ret .. rep(char(base), power - len(ret));
		end
		return ret;
	end;

	local function Decoder(str)
		local curpow, n, digit, l = 1, 0, 0, len(str);
		if(l == 0) then return 0; end
		for i=1,l do
			n = n + (byte(str, i) - base) * curpow;
			curpow = curpow * radix;
		end
		return n - zero;
	end;

	return Encoder, Decoder;
end


