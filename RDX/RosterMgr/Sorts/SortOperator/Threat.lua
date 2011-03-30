
----------------------------------------------------------
-- THREAT SORT
----------------------------------------------------------
RDXDAL.RegisterSortOperator({
   name = "threat";
   title = VFLI.i18n("Raw Threat");
   category = VFLI.i18n("Status");
   EmitLocals = function(desc, code, vars)
      if not vars["threat"] then
         vars["threat"] = true;
         code:AppendCode([[
local threat1,threat2 = u1:FracThreat(), u2:FracThreat();
]]);
      end
   end;
   EmitCode = function(desc, code, context)
      code:AppendCode([[
if(threat1 == threat2) then
]]);
      RDXDAL._SortContinuation(context);
      code:AppendCode([[else
]]);
      if desc.reversed then
         code:AppendCode([[return threat1 < threat2;]]);
      else
         code:AppendCode([[return threat1 > threat2;]]);
      end
code:AppendCode([[
end
]]);
   end;
   GetUI = RDXDAL.TrivialSortUI("threat", "Raw Threat");
   GetBlankDescriptor = function() return {op = "threat"}; end;
   Events = function(desc, ev)
      ev["UNIT_THREAT"] = true;
   end;
});

RDXDAL.RegisterSortOperator({
   name = "threatscaled";
   title = VFLI.i18n("Scaled Threat");
   category = VFLI.i18n("Status");
   EmitLocals = function(desc, code, vars)
      if not vars["threatscaled"] then
         vars["threatscaled"] = true;
         code:AppendCode([[
local threatscaled1,threatscaled2 = u1:FracThreatScaled(), u2:FracThreatScaled();
]]);
      end
   end;
   EmitCode = function(desc, code, context)
      code:AppendCode([[
if(threatscaled1 == threatscaled2) then
]]);
      RDXDAL._SortContinuation(context);
      code:AppendCode([[else
]]);
      if desc.reversed then
         code:AppendCode([[return threatscaled1 < threatscaled2;]]);
      else
         code:AppendCode([[return threatscaled1 > threatscaled2;]]);
      end
code:AppendCode([[
end
]]);
   end;
   GetUI = RDXDAL.TrivialSortUI("threatscaled", "Scaled Threat");
   GetBlankDescriptor = function() return {op = "threatscaled"}; end;
   Events = function(desc, ev)
      ev["UNIT_THREAT"] = true;
   end;
});