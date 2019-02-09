'# MWS Version: Version 2018.6 - Jun 15 2018 - ACIS 27.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 0.5 fmax = 1.5
'# created = '[VERSION]2018.6|27.0.2|20180615[/VERSION]


'@ use template: Project Dipole.cfg

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "H"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "F"
End With
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"
Mesh.FPBAAvoidNonRegUnite "True"
Mesh.ConsiderSpaceForLowerMeshLimit "False"
Mesh.MinimumStepNumber "5"
Mesh.RatioLimit "20"
Mesh.AutomeshRefineAtPecLines "True", "10"
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "10"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With
PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"
With MeshSettings
     .SetMeshType "Srf"
     .Set "Version", 1
End With
IESolver.SetCFIEAlpha "1.000000"
With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With
'----------------------------------------------------------------------------
'set the frequency range
Solver.FrequencyRange "0.5", "1.5"
Dim sDefineAt As String
sDefineAt = "1"
Dim sDefineAtName As String
sDefineAtName = "1"
Dim sDefineAtToken As String
sDefineAtToken = "f="
Dim aFreq() As String
aFreq = Split(sDefineAt, ";")
Dim aNames() As String
aNames = Split(sDefineAtName, ";")
Dim nIndex As Integer
For nIndex = LBound(aFreq) To UBound(aFreq)
Dim zz_val As String
zz_val = aFreq (nIndex)
Dim zz_name As String
zz_name = sDefineAtToken & aNames (nIndex)
' Define E-Field Monitors
With Monitor
    .Reset
    .Name "e-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Efield"
    .MonitorValue  zz_val
    .Create
End With
' Define H-Field Monitors
With Monitor
    .Reset
    .Name "h-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Hfield"
    .MonitorValue  zz_val
    .Create
End With
' Define Farfield Monitors
With Monitor
    .Reset
    .Name "farfield ("& zz_name &")"
    .Domain "Frequency"
    .FieldType "Farfield"
    .MonitorValue  zz_val
    .ExportFarfieldSource "False"
    .Create
End With
Next
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "PBA"
End With
'set the solver type
ChangeSolverType("HF Time Domain")

'@ new component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "component1"

'@ define cylinder: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "0.1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-10", "10" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ rename component: component1 to: Dipole

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Rename "component1", "Dipole"

'@ define cylinder: Dipole:Vacuum

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Vacuum" 
     .Component "Dipole" 
     .Material "Vacuum" 
     .OuterRadius "1" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-0.1", "0.1" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ boolean insert shapes: Dipole:solid1, Dipole:Vacuum

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "Dipole:solid1", "Dipole:Vacuum"

'@ clear picks

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.ClearAllPicks

'@ define discrete port: 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "1" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50" 
     .VoltagePortImpedance "0.0" 
     .Voltage "1.0" 
     .Current "1.0" 
     .SetP1 "False", "0.0", "0.0", "-0.1" 
     .SetP2 "False", "0.0", "0.0", "0.1" 
     .InvertDirection "False" 
     .LocalCoordinates "False" 
     .Monitor "True" 
     .Radius "0.0" 
     .Wire "" 
     .Position "end1" 
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-60"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ set parametersweep options

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
    .SetSimulationType "Transient" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ delete parsweep sequence: Sequence 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .DeleteSequence "Sequence 1" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:l

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .AddParameter_Stepwidth "Sequence 1", "l", "725", "775", "5" 
End With

'@ farfield plot options

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ edit parsweep parameter: Sequence 1:l

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "l" 
     .AddParameter_Linear "Sequence 1", "l", "140", "150", "2" 
End With

'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-60"
     .MeshAdaption "True"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set parsweep options

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With ParameterSweep
     .ResetOptions
     .SetOptionResetParameterValuesAfterRun "False" 
     .SetOptionSkipExistingCombinations "True" 
     .SaveOptions
End With

'@ define farfield monitor: farfield (f=1)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=1)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "1" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-75.9481145", "75.9481145", "-75.9481145", "75.9481145", "-149.9481145", "149.9481145" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ set 3d mesh adaptation results

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With MeshSettings
   .SetMeshType "Hex"
   .Set "StepsPerWaveNear", "20"
   .Set "StepsPerWaveFar", "20"
   .Set "StepsPerBoxNear", "25"
   .Set "StepsPerBoxFar", "6"
End With

'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-60"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ delete monitor: e-field (f=1)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Monitor.Delete "e-field (f=1)"

'@ delete monitor: h-field (f=1)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Monitor.Delete "h-field (f=1)"

'@ delete monitor: farfield (f=1)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Monitor.Delete "farfield (f=1)"

'@ define farfield monitor: farfield (f=1)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=1)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "1" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-75.9481145", "75.9481145", "-75.9481145", "75.9481145", "-144.9481145", "144.9481145" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ farfield plot options

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ delete shape: Dipole:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "Dipole:solid1"

'@ delete shape: Dipole:Vacuum

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "Dipole:Vacuum"

'@ delete port: port1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Port.Delete "1"

'@ delete component: Dipole

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "Dipole"

'@ new component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "component1"

'@ define cylinder: component1:Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Dipole1" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-300", "-150" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:Dipole2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Dipole2" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "150", "300" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ delete shape: component1:Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:Dipole1"

'@ delete shape: component1:Dipole2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:Dipole2"

'@ new component: Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "Dipole1"

'@ define cylinder: Dipole1:Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Dipole1" 
     .Component "Dipole1" 
     .Material "Vacuum" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-225", "-75" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ delete component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "component1"

'@ delete component: Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "Dipole1"

'@ new component: Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "Dipole1"

'@ define cylinder: Dipole1:Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Dipole1" 
     .Component "Dipole1" 
     .Material "PEC" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-225", "-75" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ new component: Dipole2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "Dipole2"

'@ define cylinder: Dipole2:Dipole2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Dipole2" 
     .Component "Dipole2" 
     .Material "PEC" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "225", "75" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: Dipole1:Vacuum1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Vacuum1" 
     .Component "Dipole1" 
     .Material "Vacuum" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-150.5", "-149.5" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ boolean insert shapes: Dipole1:Dipole1, Dipole1:Vacuum1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "Dipole1:Dipole1", "Dipole1:Vacuum1"

'@ define cylinder: Dipole2:Vacuum2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Vacuum2" 
     .Component "Dipole2" 
     .Material "Vacuum" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "149.5", "150.5" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ boolean insert shapes: Dipole2:Dipole2, Dipole2:Vacuum2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "Dipole2:Dipole2", "Dipole2:Vacuum2"

'@ define discrete port: 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "1" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .Voltage "1.0" 
     .Current "1.0" 
     .SetP1 "False", "0.0", "0.0", "-150.5" 
     .SetP2 "False", "0.0", "0.0", "-149.5" 
     .InvertDirection "False" 
     .LocalCoordinates "False" 
     .Monitor "True" 
     .Radius "0.0" 
     .Wire "" 
     .Position "end1" 
     .Create 
End With

'@ define discrete port: 2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "2" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .Voltage "1.0" 
     .Current "1.0" 
     .SetP1 "False", "0.0", "0.0", "149.5" 
     .SetP2 "False", "0.0", "0.0", "150.5" 
     .InvertDirection "False" 
     .LocalCoordinates "False" 
     .Monitor "True" 
     .Radius "0.0" 
     .Wire "" 
     .Position "end1" 
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "0.5" 
     .Step2 "0.5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ delete component: Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "Dipole1"

'@ delete component: Dipole2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "Dipole2"

'@ delete port: port2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Port.Delete "2"

'@ delete port: port1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Port.Delete "1"

'@ new component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "component1"

'@ define cylinder: component1:Antenna1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Antenna1" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "10", "-10" 
     .Xcenter "0" 
     .Ycenter "-300" 
     .Segments "0" 
     .Create 
End With

'@ delete component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "component1"

'@ new component: Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "Dipole1"

'@ define cylinder: Dipole1:Antenna1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Antenna1" 
     .Component "Dipole1" 
     .Material "PEC" 
     .OuterRadius "0.5" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-10", "10" 
     .Xcenter "0" 
     .Ycenter "-300" 
     .Segments "0" 
     .Create 
End With

'@ delete shape: Dipole1:Antenna1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "Dipole1:Antenna1"

'@ delete component: Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "Dipole1"

'@ new component: Dipole1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "Dipole1"

'@ define cylinder: Dipole1:Antenna1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Antenna1" 
     .Component "Dipole1" 
     .Material "PEC" 
     .OuterRadius "r" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-l/2", "l/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ define cylinder: Dipole1:Vacuum1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Vacuum1" 
     .Component "Dipole1" 
     .Material "Vacuum" 
     .OuterRadius "r" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-l/2/100", "l/2/100" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ boolean insert shapes: Dipole1:Antenna1, Dipole1:Vacuum1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "Dipole1:Antenna1", "Dipole1:Vacuum1"

'@ new component: Dipole2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "Dipole2"

'@ define cylinder: Dipole2:Antenna2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Antenna2" 
     .Component "Dipole2" 
     .Material "PEC" 
     .OuterRadius "r" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-l/2", "l/2" 
     .Xcenter "0" 
     .Ycenter "a" 
     .Segments "0" 
     .Create 
End With 


'@ define cylinder: Dipole2:Vacuum2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Vacuum2" 
     .Component "Dipole2" 
     .Material "Vacuum" 
     .OuterRadius "r" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-l/2/100", "l/2/100" 
     .Xcenter "0" 
     .Ycenter "a" 
     .Segments "0" 
     .Create 
End With 


'@ boolean insert shapes: Dipole2:Antenna2, Dipole2:Vacuum2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "Dipole2:Antenna2", "Dipole2:Vacuum2"

'@ define discrete port: 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "1" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .Voltage "1.0" 
     .Current "1.0" 
     .SetP1 "False", "0", "0", "l/2/100" 
     .SetP2 "False", "0", "0", "-l/2/100" 
     .InvertDirection "False" 
     .LocalCoordinates "False" 
     .Monitor "True" 
     .Radius "0.0" 
     .Wire "" 
     .Position "end1" 
     .Create 
End With


'@ define discrete port: 2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "2" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .Voltage "1.0" 
     .Current "1.0" 
     .SetP1 "False", "0.0", "a", "l/2/100" 
     .SetP2 "False", "0.0", "a", "-l/2/100" 
     .InvertDirection "False" 
     .LocalCoordinates "False" 
     .Monitor "True" 
     .Radius "0.0" 
     .Wire "" 
     .Position "end1" 
     .Create 
End With


'@ define solver excitation modes

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Solver 
     .ResetExcitationModes 
     .SParameterPortExcitation "False" 
     .SimultaneousExcitation "True" 
     .SetSimultaneousExcitAutoLabel "True" 
     .SetSimultaneousExcitationLabel "1[1.0,0.0]+2[1.0,0.0],[1]" 
     .SetSimultaneousExcitationOffset "Phaseshift" 
     .PhaseRefFrequency "1" 
     .ExcitationSelectionShowAdditionalSettings "False" 
     .ExcitationPortMode "1", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "2", "1", "1.0", "0.0", "default", "True" 
End With

'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "Selected"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ define solver excitation modes

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Solver 
     .ResetExcitationModes 
     .SParameterPortExcitation "False" 
     .SimultaneousExcitation "True" 
     .SetSimultaneousExcitAutoLabel "True" 
     .SetSimultaneousExcitationLabel "1[1.0,0.0]+2[1.0,0.0],[1]" 
     .SetSimultaneousExcitationOffset "Phaseshift" 
     .PhaseRefFrequency "1" 
     .ExcitationSelectionShowAdditionalSettings "False" 
     .ExcitationPortMode "1", "1", "1.0", "0.0", "default", "True" 
     .ExcitationPortMode "2", "1", "1.0", "0.0", "default", "True" 
End With 

'@ define boundaries

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Boundary
     .Xmin "open"
     .Xmax "open"
     .Ymin "open"
     .Ymax "open"
     .Zmin "open"
     .Zmax "open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "True"
End With


'@ new component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "component1" 


'@ define brick: component1:Test

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Brick
     .Reset 
     .Name "Test" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "-0.1", "0.1" 
     .Yrange "-0.1", "0.7" 
     .Zrange "-0.1", "0.1" 
     .Create
End With


'@ set mesh properties (Hexahedral TLM)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Mesh 
     .MeshType "HexahedralTLM" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "15" 
     .Set "StepsPerWaveFar", "15" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "20" 
     .Set "StepsPerBoxFar", "20" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "1" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "FaceRefinementOn", "1" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "5" 
     .Set "EllipseRefinementOn", "1" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "20" 
     .Set "FaceRefinementBufferLines", "2" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "2" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "2" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "1" 
     .Set "Equilibrate", "2" 
     .Set "IgnoreThinPanelMaterial", "1" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "0"
     .Set "SnapToEllipseCenters", "0"
     .Set "SnapCellCenters", "1"
     .Set "SnapProbeCellCenters", "0"
End With 
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "LimitCellSizeType", "Maxcellsizefarfrommodel"
     .Set "LimitCellSizeAbsolute", "0"
     .Set "UseCellSizeSmoothingRatio", "0"
     .Set "CellSizeSmoothingRatio", "4"
     .Set "LimitCellConnects", "0"
     .Set "PBAMetalAndThin", "1"
     .Set "PBADielectrics", "0"
     .Set "PBATimeStepReduction", "2"
End With
With Discretizer
     .PointAccEnhancement "0"
End With


'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral TLM"
     .SteadyStateLimit "-40"
     .StimulationPort "Selected"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .StoreTDResultsInCache  "False"
     .SuperimposePLWExcitation "False"
     .SParaSymmetry "False"
End With


'@ set mesh properties (Hexahedral TLM)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Mesh 
     .MeshType "HexahedralTLM" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "25" 
     .Set "StepsPerWaveFar", "25" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "20" 
     .Set "StepsPerBoxFar", "20" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "1" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "FaceRefinementOn", "1" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "5" 
     .Set "EllipseRefinementOn", "1" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "20" 
     .Set "FaceRefinementBufferLines", "2" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "2" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "2" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "1" 
     .Set "Equilibrate", "2" 
     .Set "IgnoreThinPanelMaterial", "1" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "0"
     .Set "SnapToEllipseCenters", "0"
     .Set "SnapCellCenters", "1"
     .Set "SnapProbeCellCenters", "0"
End With 
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "LimitCellSizeType", "Maxcellsizefarfrommodel"
     .Set "LimitCellSizeAbsolute", "0"
     .Set "UseCellSizeSmoothingRatio", "0"
     .Set "CellSizeSmoothingRatio", "4"
     .Set "LimitCellConnects", "0"
     .Set "PBAMetalAndThin", "1"
     .Set "PBADielectrics", "0"
     .Set "PBATimeStepReduction", "2"
End With
With Discretizer
     .PointAccEnhancement "0"
End With


'@ set mesh properties (Hexahedral)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "20" 
     .Set "StepsPerWaveFar", "20" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "25" 
     .Set "StepsPerBoxFar", "6" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "30" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "10" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "False"
     .UsePecEdgeModel "True" 
     .GapDetection "False" 
     .FPBAGapTolerance "1e-3" 
     .PointAccEnhancement "0" 
     .UseTST2 "False"
	  .PBAVersion "20180615" 
End With 


'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "Selected"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With


'@ set mesh properties (Hexahedral TLM)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Mesh 
     .MeshType "HexahedralTLM" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "60" 
     .Set "StepsPerWaveFar", "60" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "60" 
     .Set "StepsPerBoxFar", "60" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "1" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "40" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "FaceRefinementOn", "1" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "5" 
     .Set "EllipseRefinementOn", "1" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "20" 
     .Set "FaceRefinementBufferLines", "2" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "2" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "2" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "1" 
     .Set "Equilibrate", "2" 
     .Set "IgnoreThinPanelMaterial", "1" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "0"
     .Set "SnapToEllipseCenters", "0"
     .Set "SnapCellCenters", "1"
     .Set "SnapProbeCellCenters", "0"
End With 
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "LimitCellSizeType", "Maxcellsizefarfrommodel"
     .Set "LimitCellSizeAbsolute", "0"
     .Set "UseCellSizeSmoothingRatio", "0"
     .Set "CellSizeSmoothingRatio", "4"
     .Set "LimitCellConnects", "0"
     .Set "PBAMetalAndThin", "1"
     .Set "PBADielectrics", "0"
     .Set "PBATimeStepReduction", "2"
End With
With Discretizer
     .PointAccEnhancement "0"
End With


'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral TLM"
     .SteadyStateLimit "-40"
     .StimulationPort "Selected"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .StoreTDResultsInCache  "False"
     .SuperimposePLWExcitation "False"
     .SParaSymmetry "False"
End With


'@ set mesh properties (Hexahedral TLM)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Mesh 
     .MeshType "HexahedralTLM" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "40" 
     .Set "StepsPerWaveFar", "40" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "40" 
     .Set "StepsPerBoxFar", "40" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "1" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "40" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "FaceRefinementOn", "1" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "5" 
     .Set "EllipseRefinementOn", "1" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "20" 
     .Set "FaceRefinementBufferLines", "2" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "2" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "2" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "1" 
     .Set "Equilibrate", "2" 
     .Set "IgnoreThinPanelMaterial", "1" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "0"
     .Set "SnapToEllipseCenters", "0"
     .Set "SnapCellCenters", "1"
     .Set "SnapProbeCellCenters", "0"
End With 
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "LimitCellSizeType", "Maxcellsizefarfrommodel"
     .Set "LimitCellSizeAbsolute", "0"
     .Set "UseCellSizeSmoothingRatio", "0"
     .Set "CellSizeSmoothingRatio", "4"
     .Set "LimitCellConnects", "0"
     .Set "PBAMetalAndThin", "1"
     .Set "PBADielectrics", "0"
     .Set "PBATimeStepReduction", "2"
End With
With Discretizer
     .PointAccEnhancement "0"
End With


