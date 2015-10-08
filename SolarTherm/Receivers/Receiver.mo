within SolarTherm.Receivers;
partial model Receiver "Solar receiver with fluid interface"
	extends Modelica.Fluid.Interfaces.PartialTwoPort(
		allowFlowReversal=false);
	import SI = Modelica.SIunits;

	parameter SI.Area A "Area of aperture";
	input SolarTherm.Interfaces.WeatherBus wbus;
	// Will typically use Tdry, Tdew, wdir, wspd.
	input SI.RadiantPower R "Radiant power on aperture";
equation
	port_a.m_flow + port_b.m_flow = 0;
end Receiver;