'# MWS Version: Version 2018.6 - Jun 15 2018 - ACIS 27.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 910 fmax = 920
'# created = '[VERSION]2018.6|27.0.2|20180615[/VERSION]


'@ use template: CloverLeaf.cfg

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
Solver.FrequencyRange "910", "920"

Dim sDefineAt As String
sDefineAt = "915"
Dim sDefineAtName As String
sDefineAtName = "915"
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
     .SetMeshType "Srf"
     .Set "Version", 1%
End With

With Mesh
     .MeshType "Surface"
End With

'set the solver type
ChangeSolverType("HF IntegralEq")



'@ define curve arc: curve1:arc1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Arc
     .Reset 
     .Name "arc1" 
     .Curve "curve1" 
     .Orientation "Clockwise" 
     .XCenter "-0.016" 
     .YCenter "0.03" 
     .X1 "0.006" 
     .Y1 "0.028" 
     .X2 "-0.038" 
     .Y2 "0.036" 
     .Angle "190" 
     .UseAngle "True" 
     .Segments "0" 
     .Create
End With


'@ new component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "component1" 


'@ define curve line: curve2:line1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve2" 
     .X1 "0.005" 
     .Y1 "0.033" 
     .X2 "0.048" 
     .Y2 "0.036" 
     .Create
End With


'@ delete curve item: curve2:line1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.DeleteCurveItem "curve2", "line1" 


'@ delete curve: curve2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.DeleteCurve "curve2" 


'@ delete curve: curve1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.DeleteCurve "curve1" 


'@ define curve polygon: curve1:polygon1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "0.059", "0.036" 
     .LineTo "0.029", "0.083" 
     .LineTo "0.1", "0.087" 
     .LineTo "0.146", "0.004" 
     .LineTo "0.073", "0.014" 
     .LineTo "0.063", "0" 
     .Create 
End With 


'@ define tracefromcurve: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Vacuum" 
     .Curve "curve1:polygon1" 
     .Thickness "0.1" 
     .Width "0.01" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .DeleteCurve "True" 
     .GapType "2" 
     .Create 
End With 


'@ define curve arc: curve1:arc1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Arc
     .Reset 
     .Name "arc1" 
     .Curve "curve1" 
     .Orientation "Clockwise" 
     .XCenter "0.395" 
     .YCenter "0.355" 
     .X1 "0.225" 
     .Y1 "0.355" 
     .X2 "0.38" 
     .Y2 "0.525" 
     .Angle "150" 
     .UseAngle "True" 
     .Segments "0" 
     .Create
End With


'@ define material: Alumina (96%) (lossy)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Material
     .Reset
     .Name "Alumina (96%) (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "MHz", "mm"
.Epsilon "9.4"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0004"
.TanDFreq "1.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "3800.0"
.ThermalType "Normal"
.ThermalConductivity "25"
.HeatCapacity "0.88"
.MechanicsType "Isotropic"
.YoungsModulus "300"
.PoissonsRatio "0.22"
.ThermalExpansionRate "7"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With 


'@ define tracefromcurve: component1:solid2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With TraceFromCurve 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Alumina (96%) (lossy)" 
     .Curve "curve1:arc1" 
     .Thickness "0.1" 
     .Width "0.1" 
     .RoundStart "False" 
     .RoundEnd "False" 
     .DeleteCurve "True" 
     .GapType "2" 
     .Create 
End With 


'@ activate local coordinates

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
WCS.ActivateWCS "local"


'@ define curve arc: curve1:arc1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Arc
     .Reset 
     .Name "arc1" 
     .Curve "curve1" 
     .Orientation "Clockwise" 
     .XCenter "-0.05" 
     .YCenter "0.2" 
     .X1 "0.03" 
     .Y1 "0.29" 
     .X2 "-0.17" 
     .Y2 "0.23" 
     .Angle "245" 
     .UseAngle "True" 
     .Segments "0" 
     .Create
End With


'@ define curve 3dpolygon: curve1:3dspline1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "3dspline1" 
     .Curve "curve1" 
     .SetInterpolation "Spline" 
     .Point "0", "0", "0" 
     .Point "1", "1", "1" 
     .Point "1", "2", "0" 
     .Create 
End With 


'@ set wcs properties

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With WCS
     .SetNormal "0", "0", "1"
     .SetOrigin "0", "0", "0"
     .SetUVector "1", "0", "0"
End With


'@ move wcs

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
WCS.MoveWCS "global", "0.0", "0.0", "0.0" 


'@ align wcs with global plane

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With WCS
     .SetNormal "0", "0", "1"
     .SetUVector "1", "0", "0"
     .ActivateWCS "local" 
End With


'@ align wcs with global coordinates

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
WCS.AlignWCSWithGlobalCoordinates 


'@ delete shape: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:solid1" 


'@ delete shape: component1:solid2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:solid2" 


'@ delete component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "component1" 


'@ define curvewire: curve1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire1" 
     .Folder "curve1" 
     .Radius "0.1" 
     .Type "CurveWire" 
     .Curve "curve1:3dspline1" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Natural" 
     .Mitering "NewMiter" 
     .AdvancedChainSelection "True" 
     .Add
End With


'@ delete curve: curve1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.DeleteCurve "curve1" 


'@ delete material: Alumina (96%) (lossy)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Material.Delete "Alumina (96%) (lossy)"


'@ delete wire folder: curve1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Wire.DeleteFolder "curve1" 


'@ activate global coordinates

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
WCS.ActivateWCS "global"


'@ define curve 3dpolygon: curve1:line1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "line1" 
     .Curve "curve1" 
     .Point "0", "0", "0" 
     .Point "r", "0", "0" 
     .Create 
End With 


'@ define curve 3dpolygon: curve1:line2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "line2" 
     .Curve "curve1" 
     .Point "0", "0", "0" 
     .Point "0", "offset", "offset" 
     .Create 
End With 


'@ define curve 3dpolygon: curve1:3dspline1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "3dspline1" 
     .Curve "curve1" 
     .SetInterpolation "Spline" 
     .Point "r", "0", "0" 
     .Point "0", "offset", "offset" 
     .Create 
End With 


'@ delete curve item: curve1:3dspline1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.DeleteCurveItem "curve1", "3dspline1" 


'@ define curve 3dpolygon: curve1:3dspline1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "3dspline1" 
     .Curve "curve1" 
     .SetInterpolation "Spline" 
     .Point "r", "0", "0" 
     .Point "offset", "r/2", "r/2" 
     .Point "0", "offset", "offset" 
     .Create 
End With 


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
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "0.001" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ define units

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Units 
     .Geometry "m" 
     .Frequency "GHz" 
     .Time "ns" 
     .TemperatureUnit "Kelvin" 
     .Voltage "V" 
     .Current "A" 
     .Resistance "Ohm" 
     .Conductance "Siemens" 
     .Capacitance "F" 
     .Inductance "H" 
End With 


'@ transform: rotate component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "45", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With 


'@ define curve 3dpolygon: curve1:3dspline2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "3dspline2" 
     .Curve "curve1" 
     .SetInterpolation "Spline" 
     .Point "r", "0", "0" 
     .Point "sqr(sqr(2)+2)/2*r", "1.1*r/4", "1.1*r/4" 
     .Point "offset", "r/2", "r/2" 
     .Point "sqr(2-sqr(2))/2*r", "5.2*r/8", "5.2*r/8" 
     .Point "0", "offset", "offset" 
     .Create 
End With 


'@ delete shape: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:solid1" 


'@ delete component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.Delete "component1" 


'@ rename curve item: curve1:3dspline1 to: curve1:curve1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.RenameCurveItem "curve1", "3dspline1", "curve1" 



'@ new curve: curve2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.NewCurve "curve2" 


'@ delete curve item: curve1:3dspline2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.DeleteCurveItem "curve1", "3dspline2" 


'@ define curvewire: curve1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire1" 
     .Folder "curve1" 
     .Radius "0.001" 
     .Type "CurveWire" 
     .Curve "curve1:curve1" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Natural" 
     .Mitering "NewMiter" 
     .AdvancedChainSelection "True" 
     .Add
End With


'@ new component: component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Component.New "component1" 


'@ Convert wire to solid: component1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset
     .SolidName "component1:wire1"
     .Name "wire1"
     .Folder "curve1"
     .KeepWire "False"
     .ConvertToSolidShape
End With


'@ transform: rotate component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "90" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With 


'@ transform: rotate component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "90" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With 


'@ transform: rotate component1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "90" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With 


'@ define sphere: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Sphere 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Vacuum" 
     .Axis "z" 
     .CenterRadius "r1" 
     .TopRadius "0" 
     .BottomRadius "0" 
     .Center "0", "0", "0" 
     .Segments "0" 
     .Create 
End With


'@ boolean insert shapes: component1:wire1, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1", "component1:solid1" 

'@ boolean insert shapes: component1:wire1_1, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1_1", "component1:solid1" 

'@ boolean insert shapes: component1:wire1_2, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1_2", "component1:solid1" 

'@ boolean insert shapes: component1:wire1_1_1, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1_1_1", "component1:solid1" 

'@ boolean insert shapes: component1:wire1_3, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1_3", "component1:solid1" 

'@ boolean insert shapes: component1:wire1_1_2, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1_1_2", "component1:solid1" 

'@ boolean insert shapes: component1:wire1_2_1, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1_2_1", "component1:solid1" 

'@ boolean insert shapes: component1:wire1_1_1_1, component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Insert "component1:wire1_1_1_1", "component1:solid1" 

'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1", "10", "9" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1", "11", "10" 


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
     .SetP1 "True", "-0.015819954165244", "0.001", "0.015819954165244" 
     .SetP2 "True", "-0.00070710678118655", "0.022372793736608", "0.00070710678118655" 
     .LocalCoordinates "False" 
     .InvertDirection "True" 
     .CenterEdge "True" 
     .Monitor "True" 
     .UseProjection "False" 
     .ReverseProjection "False" 
     .Create 
End With 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1", "10", "9" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1", "11", "10" 


'@ define discrete face port: 2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscreteFacePort 
     .Reset 
     .PortNumber "2" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .VoltageAmplitude "1.0" 
     .CurrentAmplitude "1.0" 
     .SetP1 "True", "0.001", "0.015819954165244", "0.015819954165244" 
     .SetP2 "True", "0.022372793736608", "0.00070710678118655", "0.00070710678118655" 
     .LocalCoordinates "False" 
     .InvertDirection "True" 
     .CenterEdge "True" 
     .Monitor "True" 
     .UseProjection "False" 
     .ReverseProjection "False" 
     .Create 
End With 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1_1_1", "10", "9" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1_1", "10", "9" 


'@ define discrete face port: 3

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscreteFacePort 
     .Reset 
     .PortNumber "3" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .VoltageAmplitude "1.0" 
     .CurrentAmplitude "1.0" 
     .SetP1 "True", "0.01541170587478", "-0.00081649658092773", "0.016228202455708" 
     .SetP2 "True", "0.00081649658092772", "-0.01541170587478", "0.016228202455708" 
     .LocalCoordinates "False" 
     .InvertDirection "False" 
     .CenterEdge "True" 
     .Monitor "True" 
     .UseProjection "False" 
     .ReverseProjection "False" 
     .Create 
End With 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromIdOn "port$port3", "3", "2" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1_1", "11", "10" 


'@ define discrete face port: 4

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscreteFacePort 
     .Reset 
     .PortNumber "4" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .VoltageAmplitude "1.0" 
     .CurrentAmplitude "1.0" 
     .SetP1 "True", "-0.001", "-0.015819954165244", "0.015819954165244" 
     .SetP2 "True", "-0.022372793736608", "-0.00070710678118655", "0.00070710678118655" 
     .LocalCoordinates "False" 
     .InvertDirection "True" 
     .CenterEdge "True" 
     .Monitor "True" 
     .UseProjection "False" 
     .ReverseProjection "False" 
     .Create 
End With 


'@ delete shape: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:solid1" 


'@ delete port: port3

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Port.Delete "3" 


'@ define sphere: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Sphere 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Vacuum" 
     .Axis "z" 
     .CenterRadius "r1" 
     .TopRadius "0" 
     .BottomRadius "0" 
     .Center "0", "0", "0" 
     .Segments "0" 
     .Create 
End With


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1_1_1", "11", "10" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1_1_1", "10", "9" 


'@ define discrete face port: 3

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With DiscreteFacePort 
     .Reset 
     .PortNumber "3" 
     .Type "SParameter" 
     .Label "" 
     .Folder "" 
     .Impedance "50.0" 
     .VoltagePortImpedance "0.0" 
     .VoltageAmplitude "1.0" 
     .CurrentAmplitude "1.0" 
     .SetP1 "True", "0.00070710678118654", "-0.022372793736608", "0.00070710678118655" 
     .SetP2 "True", "0.015819954165244", "-0.001", "0.015819954165244" 
     .LocalCoordinates "False" 
     .InvertDirection "False" 
     .CenterEdge "True" 
     .Monitor "True" 
     .UseProjection "False" 
     .ReverseProjection "False" 
     .Create 
End With 


'@ define frequency domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 

With FDSolver
     .Reset 
     .SetMethod "Surface", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "All", "1" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "False" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-4" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Auto" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "True" 
     .SetOpenBCTypeHex "Default" 
     .SetOpenBCTypeTet "Default" 
     .AddMonitorSamples "True" 
     .CalcStatBField "False" 
     .CalcPowerLoss "True" 
     .CalcPowerLossPerComponent "False" 
     .StoreSolutionCoefficients "True" 
     .UseDoublePrecision "False" 
     .UseDoublePrecision_ML "True" 
     .MixedOrderSrf "False" 
     .MixedOrderTet "False" 
     .PreconditionerAccuracyIntEq "0.15" 
     .MLFMMAccuracy "Default" 
     .MinMLFMMBoxSize "0.3" 
     .UseCFIEForCPECIntEq "True" 
     .UseFastRCSSweepIntEq "false" 
     .UseSensitivityAnalysis "False" 
     .RemoveAllStopCriteria "Hex"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
     .RemoveAllStopCriteria "Tet"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
     .RemoveAllStopCriteria "Srf"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
     .SweepMinimumSamples "3" 
     .SetNumberOfResultDataSamples "1001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddInactiveSampleInterval "920", "920", "1", "Single", "False" 
     .MPIParallelization "False"
     .UseDistributedComputing "False"
     .NetworkComputingStrategy "RunRemote"
     .NetworkComputingJobCount "3"
     .UseParallelization "True"
     .MaxCPUs "96"
     .MaximumNumberOfCPUDevices "2"
     .HardwareAcceleration "False"
     .MaximumNumberOfGPUs "1"
End With

With IESolver
     .Reset 
     .UseFastFrequencySweep "False" 
     .UseIEGroundPlane "False" 
     .SetRealGroundMaterialName "" 
     .CalcFarFieldInRealGround "False" 
     .RealGroundModelType "Auto" 
     .PreconditionerType "Auto" 
     .ExtendThinWireModelByWireNubs "False" 
End With

With IESolver
     .SetFMMFFCalcStopLevel "0" 
     .SetFMMFFCalcNumInterpPoints "6" 
     .UseFMMFarfieldCalc "True" 
     .SetCFIEAlpha "1.000000" 
     .LowFrequencyStabilization "False" 
     .LowFrequencyStabilizationML "True" 
     .Multilayer "False" 
     .SetiMoMACC_I "0.0001" 
     .SetiMoMACC_M "0.0001" 
     .DeembedExternalPorts "True" 
     .SetOpenBC_XY "True" 
     .OldRCSSweepDefintion "False" 
     .SetAccuracySetting "Medium" 
     .CalculateSParaforFieldsources "True" 
     .ModeTrackingCMA "True" 
     .NumberOfModesCMA "3" 
     .StartFrequencyCMA "-1.0" 
     .SetAccuracySettingCMA "Default" 
     .FrequencySamplesCMA "0" 
     .SetMemSettingCMA "Auto" 
End With


'@ delete monitor: h-field (f=915)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Monitor.Delete "h-field (f=915)" 


'@ delete monitor: e-field (f=915)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Monitor.Delete "e-field (f=915)" 


'@ change solver type

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
ChangeSolverType "HF Time Domain" 


'@ define time domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-20"
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


'@ define units

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Units 
     .Geometry "mm" 
     .Frequency "GHz" 
     .Time "ns" 
     .TemperatureUnit "Kelvin" 
     .Voltage "V" 
     .Current "A" 
     .Resistance "Ohm" 
     .Conductance "Siemens" 
     .Capacitance "F" 
     .Inductance "H" 
End With 


'@ change solver type

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
ChangeSolverType "HF Frequency Domain" 


'@ define frequency domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 

With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "All", "1" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "False" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-4" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Auto" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "True" 
     .SetOpenBCTypeHex "Default" 
     .SetOpenBCTypeTet "Default" 
     .AddMonitorSamples "True" 
     .CalcStatBField "False" 
     .CalcPowerLoss "True" 
     .CalcPowerLossPerComponent "False" 
     .StoreSolutionCoefficients "True" 
     .UseDoublePrecision "False" 
     .UseDoublePrecision_ML "True" 
     .MixedOrderSrf "False" 
     .MixedOrderTet "False" 
     .PreconditionerAccuracyIntEq "0.15" 
     .MLFMMAccuracy "Default" 
     .MinMLFMMBoxSize "0.3" 
     .UseCFIEForCPECIntEq "True" 
     .UseFastRCSSweepIntEq "false" 
     .UseSensitivityAnalysis "False" 
     .RemoveAllStopCriteria "Hex"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
     .RemoveAllStopCriteria "Tet"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
     .RemoveAllStopCriteria "Srf"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
     .SweepMinimumSamples "3" 
     .SetNumberOfResultDataSamples "1001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddInactiveSampleInterval "920", "920", "1", "Automatic", "True" 
     .MPIParallelization "False"
     .UseDistributedComputing "False"
     .NetworkComputingStrategy "RunRemote"
     .NetworkComputingJobCount "3"
     .UseParallelization "True"
     .MaxCPUs "96"
     .MaximumNumberOfCPUDevices "2"
End With

With IESolver
     .Reset 
     .UseFastFrequencySweep "True" 
     .UseIEGroundPlane "False" 
     .SetRealGroundMaterialName "" 
     .CalcFarFieldInRealGround "False" 
     .RealGroundModelType "Auto" 
     .PreconditionerType "Auto" 
     .ExtendThinWireModelByWireNubs "False" 
End With

With IESolver
     .SetFMMFFCalcStopLevel "0" 
     .SetFMMFFCalcNumInterpPoints "6" 
     .UseFMMFarfieldCalc "True" 
     .SetCFIEAlpha "1.000000" 
     .LowFrequencyStabilization "False" 
     .LowFrequencyStabilizationML "True" 
     .Multilayer "False" 
     .SetiMoMACC_I "0.0001" 
     .SetiMoMACC_M "0.0001" 
     .DeembedExternalPorts "True" 
     .SetOpenBC_XY "True" 
     .OldRCSSweepDefintion "False" 
     .SetAccuracySetting "Custom" 
     .CalculateSParaforFieldsources "True" 
     .ModeTrackingCMA "True" 
     .NumberOfModesCMA "3" 
     .StartFrequencyCMA "-1.0" 
     .SetAccuracySettingCMA "Default" 
     .FrequencySamplesCMA "0" 
     .SetMemSettingCMA "Auto" 
End With


