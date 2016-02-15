within SolarTherm.Optics;
block OptEffFile "Read in optical efficiency from file"
	extends SolarTherm.Optics.OptEff;
	// Expects data in file to be oriented north (i.e. as for system in Southern
	// hemisphere).  When running simulations in the Northern hemisphere, the
	// the field can be turned around be setting orient_north = false.
	import SI = Modelica.SIunits;
	parameter String fileName "Optical efficiency table (relative to aperture area)";
	parameter Boolean orient_north = true "Orient system toward north else south";

	parameter String tableNames[nelem] = {"eff" + String(i) for i in 1:nelem};
	Modelica.Blocks.Tables.CombiTable2D table[nelem](
		each verboseRead=false,
		each tableOnFile=true,
		each fileName=fileName,
		each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
		//each extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
		// Could also try Periodic table extrapolation
		// Painful: CombiTimeTable has extrapolation but not CombiTable1D or CombiTable2D
		tableName=tableNames
		);
equation
	for i in 1:nelem loop
		table[i].u1 = max(alt, 0); // Needed because of interpolation below horizon

		if orient_north then
			table[i].u2 = azi;
		else
			table[i].u2 = mod(azi + 180.0, 360);
		end if;
		eff[i] = table[i].y;
	end for;
end OptEffFile;