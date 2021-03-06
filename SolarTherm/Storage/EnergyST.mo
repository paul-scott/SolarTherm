within SolarTherm.Storage;
model EnergyST "Energy storage tank"
	import SI = Modelica.SIunits;
	parameter SI.Energy E_max "Maximum energy";
	parameter SI.Energy E_0 = 0 "Starting energy";
	SI.Energy E(start=E_0, fixed=true, min=0, max=E_max) "Energy in tank";
	SolarTherm.Fluid.Interfaces.EnergyPort p;
equation
	der(E) = p.P;
end EnergyST;
