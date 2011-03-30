frame_n = 100;
frame_type = "EditBox";
frame_prefix = "VFLEd";
frame_inherit = "VFLEditT";

io.output("xmlgen.xml");
for i=1,frame_n do
	if frame_inherit then
		io.write('<' .. frame_type .. ' name="'..frame_prefix..i..'" inherits="'..frame_inherit..'" id="'..i..'"/>\n');
	else
		io.write('<' .. frame_type .. ' name="'..frame_prefix..i..'" id="'..i..'"/>\n');
	end
end
