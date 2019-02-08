'# MWS Version: Version 2018.6 - Jun 15 2018 - ACIS 27.0.2 -

'# length = m
'# frequency = MHz
'# time = ns
'# frequency range: fmin = 0.9 fmax = 1.1
'# created = '[VERSION]2018.6|27.0.2|20180615[/VERSION]


'@ use template: Antenna - Wire_4.cfg

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
'set the units
With Units
    .Geometry "m"
    .Frequency "MHz"
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
Solver.FrequencyRange "0.9", "1.1"

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


'@ define cylinder: component1:Dipole

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Dipole" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "d" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-l/2", "l/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ delete component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "component1" 


'@ new component: Antenna

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "Antenna" 


'@ define cylinder: Antenna:Dipole

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Dipole" 
     .Component "Antenna" 
     .Material "PEC" 
     .OuterRadius "d" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-l/2", "l/2" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ define cylinder: Antenna:Vacuum

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "Vacuum" 
     .Component "Antenna" 
     .Material "Vacuum" 
     .OuterRadius "d" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "-l/2/100", "l/2/100" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ boolean insert shapes: Antenna:Dipole, Antenna:Vacuum

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "Antenna:Dipole", "Antenna:Vacuum" 

'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "Antenna:Vacuum", "1", "1" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "Antenna:Vacuum", "2", "2" 


'@ define discrete face port: 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscreteFacePort 
     .Reset 
     .PortNumber "1" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .VoltageAmplitude "1.0" 
     .CurrentAmplitude "1.0" 
     .SetP1 "True", "0.0093685", "0", "-0.0037474" 
     .SetP2 "True", "0.0093685", "0", "0.0037474" 
     .LocalCoordinates "False" 
     .InvertDirection "False" 
     .CenterEdge "True" 
     .Monitor "True" 
     .UseProjection "False" 
     .ReverseProjection "False" 
     .Create 
End With 


'@ delete port: port1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Port.Delete "1" 


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
     .SetP1 "False", "0.0", "0.0", "-l/2/100" 
     .SetP2 "False", "0.0", "0.0", "l/2/100" 
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
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "180" 
     .Phi "180" 
     .Step "5" 
     .Step2 "5" 
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
     .SetSubvolume "-0.0093685", "0.0093685", "-0.0093685", "0.0093685", "-0.37474", "0.37474" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With 


