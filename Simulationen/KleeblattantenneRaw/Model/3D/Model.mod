'# MWS Version: Version 2018.6 - Jun 15 2018 - ACIS 27.0.2 -

'# length = mm
'# frequency = MHz
'# time = ns
'# frequency range: fmin = 500 fmax = 1000
'# created = '[VERSION]2018.6|27.0.2|20180615[/VERSION]


'@ use template: Planar Filter_1.cfg

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
'set the units
With Units
    .Geometry "um"
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
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "electric"
     .Ymax "electric"
     .Zmin "electric"
     .Zmax "electric"
End With
' mesh - Tetrahedral
With Mesh
     .MeshType "Tetrahedral"
     .SetCreator "High Frequency"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 1%
     .Set "StepsPerWaveNear", "6"
     .Set "StepsPerBoxNear", "10"
     .Set "CellsPerWavelengthPolicy", "automatic"
     .Set "CurvatureOrder", "2"
     .Set "CurvatureOrderPolicy", "automatic"
     .Set "CurvRefinementControl", "NormalTolerance"
     .Set "NormalTolerance", "60"
     .Set "SrfMeshGradation", "1.5"
     .Set "UseAnisoCurveRefinement", "1"
     .Set "UseSameSrfAndVolMeshGradation", "1"
     .Set "VolMeshGradation", "1.5"
End With
With MeshSettings
     .SetMeshType "Unstr"
     .Set "MoveMesh", "1"
     .Set "OptimizeForPlanarStructures", "1"
End With
With Mesh
     .MeshType "PBA"
     .SetCreator "High Frequency"
     .AutomeshRefineAtPecLines "True", "4"
     .UseRatioLimit "True"
     .RatioLimit "50"
     .LinesPerWavelength "20"
     .MinimumStepNumber "10"
     .Automesh "True"
End With
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "50"
     .Set "StepsPerWaveNear", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "4"
End With
' mesh - Multilayer (Preview)
' default
' solver - FD settings
With FDSolver
     .Reset
     .Method "Tetrahedral Mesh" ' i.e. general purpose
     .AccuracyHex "1e-6"
     .AccuracyTet "1e-5"
     .AccuracySrf "1e-3"
     .SetUseFastResonantForSweepTet "False"
     .Type "Direct"
     .MeshAdaptionHex "False"
     .MeshAdaptionTet "True"
     .InterpolationSamples "5001"
End With
With MeshAdaption3D
    .SetType "HighFrequencyTet"
    .SetAdaptionStrategy "Energy"
    .MinPasses "3"
    .MaxPasses "10"
End With
FDSolver.SetShieldAllPorts "True"
With FDSolver
     .Method "Tetrahedral Mesh (MOR)"
     .HexMORSettings "", "5001"
End With
FDSolver.Method "Tetrahedral Mesh" ' i.e. general purpose
' solver - TD settings
With MeshAdaption3D
    .SetType "Time"
    .SetAdaptionStrategy "Energy"
    .CellIncreaseFactor "0.5"
    .AddSParameterStopCriterion "True", "0.0", "10", "0.01", "1", "True"
End With
With Solver
     .Method "Hexahedral"
     .SteadyStateLimit "-40"
     .MeshAdaption "True"
     .NumberOfPulseWidths "50"
     .FrequencySamples "5001"
     .UseArfilter "True"
End With
' solver - M settings
'----------------------------------------------------------------------------
'set the frequency range
Solver.FrequencyRange "0.5", "10"
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "Tetrahedral"
End With
'set the solver type
ChangeSolverType("HF Frequency Domain")

'@ define curve arc: curve1:arc1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Arc
     .Reset 
     .Name "arc1" 
     .Curve "curve1" 
     .Orientation "Clockwise" 
     .XCenter "-0" 
     .YCenter "-0" 
     .X1 "-5" 
     .Y1 "-0" 
     .X2 "0.0" 
     .Y2 "0.0" 
     .Angle "90" 
     .UseAngle "True" 
     .Segments "0" 
     .Create
End With

'@ define curve line: curve1:line1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "-0" 
     .Y1 "5" 
     .X2 "0" 
     .Y2 "1" 
     .Create
End With

'@ define curve line: curve1:line2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Line
     .Reset 
     .Name "line2" 
     .Curve "curve1" 
     .X1 "-5" 
     .Y1 "-0" 
     .X2 "-1" 
     .Y2 "-0" 
     .Create
End With

'@ delete curve: curve1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Curve.DeleteCurve "curve1"

'@ define units

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Units 
     .Geometry "mm" 
     .Frequency "MHz" 
     .Time "ns" 
     .TemperatureUnit "Kelvin" 
     .Voltage "V" 
     .Current "A" 
     .Resistance "Ohm" 
     .Conductance "Siemens" 
     .Capacitance "F" 
     .Inductance "H" 
End With

'@ define curve arc: curve1:arc1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Arc
     .Reset 
     .Name "arc1" 
     .Curve "curve1" 
     .Orientation "Clockwise" 
     .XCenter "0" 
     .YCenter "-0" 
     .X1 "-r1" 
     .Y1 "-0" 
     .X2 "0.0" 
     .Y2 "0.0" 
     .Angle "90" 
     .UseAngle "True" 
     .Segments "0" 
     .Create
End With

'@ define curve line: curve1:line1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "0" 
     .Y1 "r1" 
     .X2 "0.0" 
     .Y2 "ss" 
     .Create
End With

'@ define curve line: curve1:line2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Line
     .Reset 
     .Name "line2" 
     .Curve "curve1" 
     .X1 "-r1" 
     .Y1 "0" 
     .X2 "-ss" 
     .Y2 "0" 
     .Create
End With

'@ define curvewire: curve1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire1" 
     .Folder "curve1" 
     .Radius "rr" 
     .Type "CurveWire" 
     .Curve "curve1:arc1" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Natural" 
     .Mitering "NewMiter" 
     .AdvancedChainSelection "True" 
     .Add
End With

'@ define material: Aluminum

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Material
     .Reset
     .Name "Aluminum"
     .Folder ""
     .FrqType "static"
     .Type "Normal"
     .SetMaterialUnit "Hz", "mm"
     .Epsilon "1"
     .Mu "1.0"
     .Kappa "3.56e+007"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .KappaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "General 1st"
     .DispersiveFittingSchemeMu "General 1st"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .FrqType "all"
     .Type "Lossy metal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "Kelvin"
     .Mu "1.0"
     .Sigma "3.56e+007"
     .Rho "2700.0"
     .ThermalType "Normal"
     .ThermalConductivity "237.0"
     .HeatCapacity "0.9"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Isotropic"
     .YoungsModulus "69"
     .PoissonsRatio "0.33"
     .ThermalExpansionRate "23"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "1", "1", "0"
     .Wireframe "False"
     .Reflection "False"
     .Allowoutline "True"
     .Transparentoutline "False"
     .Transparency "0"
     .Create
End With

'@ change wire material: curve1:wire1 to: Aluminum

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Wire.ChangeMaterial "curve1:wire1", "Aluminum"

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
     .Angle "0", "0", "-90" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "90", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "90" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "90", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "-45" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "-45", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "45", "0", "0" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: mirror component1:wire1_2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_2" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "-1", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Mirror" 
End With

'@ switch working plane

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Plot.DrawWorkplane "true"

'@ define cylinder: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Aluminum" 
     .OuterRadius "ra" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-10", "-zz" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:solid2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Aluminum" 
     .OuterRadius "raa+ws" 
     .InnerRadius "raa" 
     .Axis "z" 
     .Zrange "-10", "-zz" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ pick face

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickFaceFromId "component1:solid1", "1"

'@ pick face

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickFaceFromId "component1:solid2", "1"

'@ offset selected faces

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With LocalModification
     .Reset 
     .Name "component1:solid1" 
     .AddName "component1:solid2" 
     .EnableInvertedFaceRemoval "True" 
     .SetConsiderBlends "False" 
     .OffsetSelectedFaces "10" 
End With

'@ pick face

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickFaceFromId "component1:solid2", "1"

'@ define port: 1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-3", "3" 
     .Yrange "-3", "3" 
     .Zrange "-20", "-20" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .WaveguideMonitor "False" 
     .Create 
End With

'@ define frequency range

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solver.FrequencyRange "0.5", "1"

'@ define frequency domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "All", "All" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "True" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-5" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Direct" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
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
     .SetNumberOfResultDataSamples "5001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddSampleInterval "", "", "", "Automatic", "False" 
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
     .SetCFIEAlpha "0.500000" 
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

'@ pick center point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickCenterpointFromId "component1:wire1_2", "5"

'@ pick center point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickCenterpointFromId "component1:solid1", "3"

'@ define bondwire: curve1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire1" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "2.5" 
     .Radius "0.0" 
     .Point1 "4", "2.7564237370048e-17", "-2.7564237370048e-17", "True"
     .Point2 "-3.8981718325194e-17", "0", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "False" 
     .Termination "Extended" 
     .Add
End With

'@ pick center point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickCenterpointFromId "component1:wire1_2", "2"

'@ pick circle point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickCirclepointFromId "component1:solid2", "3"

'@ define bondwire: curve1:wire2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire2" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "3.5696835555998" 
     .Radius "0.0" 
     .Point1 "0", "2.8284271247462", "2.8284271247462", "True"
     .Point2 "3", "0", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "False" 
     .Termination "Extended" 
     .Add
End With

'@ create group: meshgroup1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.Add "meshgroup1", "mesh"

'@ add items to group: "meshgroup1"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1", "meshgroup1"

'@ add items to group: "Excluded from Simulation"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1", "Excluded from Simulation"

'@ add items to group: "Excluded from Bounding Box"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1", "Excluded from Bounding Box"

'@ create group: meshgroup2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.Add "meshgroup2", "mesh"

'@ add items to group: "meshgroup2"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1_1", "meshgroup2"

'@ add items to group: "Excluded from Simulation"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1_1", "Excluded from Simulation"

'@ add items to group: "Excluded from Bounding Box"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1_1", "Excluded from Bounding Box"

'@ transform: rotate component1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "45", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "45", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "45", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "290", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "350", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "300" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "90", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "5", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:wire1_1_1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Transform 
     .Reset 
     .Name "component1:wire1_1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "5", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ delete wire: curve1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Wire.Delete "curve1:wire1"

'@ delete wire: curve1:wire2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Wire.Delete "curve1:wire2"

'@ clear picks

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.ClearAllPicks

'@ pick point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickPointFromCoordinates "0", "0", "0"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid1", "2", "3", "0"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEndpointFromId "component1:solid2", "4"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:wire1_1", "7", "5", "0"

'@ define bondwire: curve1:wire1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire1" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "2.8081530059282" 
     .Radius "0.2" 
     .Point1 "2.5", "0", "-3", "True"
     .Point2 "-0.70710678118655", "-4", "-0.70710678118655", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:wire1", "1", "1", "0"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid2", "3", "3", "1"

'@ define bondwire: curve1:wire2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire2" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "2.9580398915498" 
     .Radius "0.2" 
     .Point1 "0.70710678118655", "4", "-0.70710678118655", "True"
     .Point2 "-3", "3.6739403974421e-16", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:wire1_1_1", "7", "5", "0"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid2", "3", "3", "0"

'@ define bondwire: curve1:wire3

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire3" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "2.5708595104411" 
     .Radius "0.2" 
     .Point1 "-3.9976570688428", "0.7277185326509", "-0.69940238573203", "True"
     .Point2 "1.836970198721e-16", "3", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid2", "3", "3", "2"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:wire1_2", "7", "5", "1"

'@ define bondwire: curve1:wire4

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire4" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "2.9580398915498" 
     .Radius "0.2" 
     .Point1 "-5.5109105961631e-16", "-3", "-3", "True"
     .Point2 "4", "0.70710678118655", "-0.70710678118655", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:wire1_2", "1", "1", "2"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid1", "2", "3", "1"

'@ define bondwire: curve1:wire5

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire5" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "3.3900797464247" 
     .Radius "0.2" 
     .Point1 "1", "2.8284271247462", "2.8284271247462", "True"
     .Point2 "-1", "1.2246467991474e-16", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:wire1_1", "1", "1", "0"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid1", "2", "3", "2"

'@ define bondwire: curve1:wire6

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire6" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "3.3900797464247" 
     .Radius "0.2" 
     .Point1 "2.8284271247462", "1", "2.8284271247462", "True"
     .Point2 "-1.836970198721e-16", "-1", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEndpointFromId "component1:wire1", "6"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid1", "2", "3", "0"

'@ define bondwire: curve1:wire7

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire7" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "3.471786407442" 
     .Radius "0.2" 
     .Point1 "-2.1213203435596", "0", "3.5355339059327", "True"
     .Point2 "6.1232339957368e-17", "1", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:wire1_1_1", "1", "1", "1"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEndpointFromId "component1:solid1", "2"

'@ define bondwire: curve1:wire8

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Wire
     .Reset 
     .Name "wire8" 
     .Folder "curve1" 
     .Type "BondWire" 
     .Height "3.4690264115578" 
     .Radius "0.2" 
     .Point1 "-0.0059837147087182", "-2.1457294959711", "3.5207682578207", "True"
     .Point2 "1", "0", "-3", "True" 
     .BondWireType "Spline" 
     .Alpha "75" 
     .Beta "35" 
     .RelativeCenterPosition "0.5" 
     .Material "PEC" 
     .SolidWireModel "True" 
     .Termination "Extended" 
     .Add
End With

'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:solid2", "1", "1"

'@ pick face

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickFaceFromId "component1:solid2", "4"

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
     .SetP1 "True", "-3", "3.6739403974421e-16", "-20" 
     .SetP2 "True", "-2.5", "-3.0616169978684e-16", "-20" 
     .LocalCoordinates "False" 
     .InvertDirection "False" 
     .CenterEdge "True" 
     .Monitor "True" 
     .UseProjection "False" 
     .ReverseProjection "False" 
     .Create 
End With

'@ define frequency range

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solver.FrequencyRange "0.5", "1"

'@ pick end point

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickExtraCirclepointFromId "component1:solid1", "1", "1", "1"

'@ define discrete port: 3

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "All", "All" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "True" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-5" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Direct" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
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
     .SetNumberOfResultDataSamples "5001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddInactiveSampleInterval "", "", "", "Automatic", "False" 
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
     .SetCFIEAlpha "0.500000" 
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

'@ define frequency domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "All", "All" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "True" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-5" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Direct" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
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
     .SetNumberOfResultDataSamples "5001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddInactiveSampleInterval "", "", "", "Automatic", "False" 
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
     .SetCFIEAlpha "0.500000" 
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

'@ define monitor: e-field (f=0.75)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=0.75)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "0.75" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-100.99946853705", "101", "-72.200761934379", "71.710678118655", "-20", "71.710678118655" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With

'@ define plane wave properties

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With PlaneWave
     .Reset 
     .Normal "0", "0", "1" 
     .EVector "1", "0", "0" 
     .Polarization "Linear" 
     .ReferenceFrequency "0.75" 
     .PhaseDifference "-90.0" 
     .CircularDirection "Left" 
     .AxialRatio "0.0" 
     .SetUserDecouplingPlane "False" 
     .Store
End With

'@ delete port: port2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Port.Delete "2"

'@ define monitor: e-field (f=0.75)

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=0.75)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "0.75" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-100.99946853704529", "101", "-72.20076193437859", "71.710678118654741", "-20", "71.710678118654741" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
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
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic_linear" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "ludwig2ae" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Slant" 
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
     .StoreSettings
End With

'@ define frequency range

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solver.FrequencyRange "500", "1000"

'@ define frequency domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "1", "All" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "True" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-5" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Direct" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
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
     .SetNumberOfResultDataSamples "5001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddInactiveSampleInterval "", "", "", "Automatic", "False" 
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
     .SetCFIEAlpha "0.500000" 
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

'@ remove items from group: "Excluded from Simulation"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.RemoveItem "solid$component1:wire1", "Excluded from Simulation"

'@ remove items from group: "Excluded from Bounding Box"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.RemoveItem "solid$component1:wire1", "Excluded from Bounding Box"

'@ remove items from group: "Excluded from Simulation"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.RemoveItem "solid$component1:wire1_1", "Excluded from Simulation"

'@ remove items from group: "Excluded from Bounding Box"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.RemoveItem "solid$component1:wire1_1", "Excluded from Bounding Box"

'@ add items to group: "meshgroup1"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1_1", "meshgroup1"

'@ add items to group: "Excluded from Bounding Box"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1_1", "Excluded from Bounding Box"

'@ create group: meshgroup3

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.Add "meshgroup3", "mesh"

'@ add items to group: "meshgroup3"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1_2", "meshgroup3"

'@ create group: meshgroup4

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.Add "meshgroup4", "mesh"

'@ add items to group: "meshgroup4"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.AddItem "solid$component1:wire1_1_1", "meshgroup4"

'@ remove items from group: "Excluded from Bounding Box"

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Group.RemoveItem "solid$component1:wire1_1", "Excluded from Bounding Box"

'@ define frequency range

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solver.FrequencyRange "500", "1000"

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
     .Set "StepsPerBoxNear", "20" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "50" 
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
     .Set "EdgeRefinementRatio", "4" 
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

'@ define frequency domain solver parameters

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Mesh.SetCreator "High Frequency" 
With FDSolver
     .Reset 
     .SetMethod "Hexahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "1", "All" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "True" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-5" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Direct" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
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
     .SetNumberOfResultDataSamples "5001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddInactiveSampleInterval "", "", "", "Automatic", "False" 
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
     .SetCFIEAlpha "0.500000" 
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

'@ delete shape: component1:solid1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:solid1"

'@ delete shape: component1:solid2

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Solid.Delete "component1:solid2"

'@ delete wire folder: curve1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Wire.DeleteFolder "curve1"

'@ delete port: port1

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Port.Delete "1"

'@ delete plane wave

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
PlaneWave.Delete 

'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1", "1", "1" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1_1", "7", "6" 


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
     .SetP1 "True", "-0.99999975605979", "4", "0.00069848433693811" 
     .SetP2 "True", "-3.9960333388606", "1.0157311475479", "0.0027911673779546" 
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


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_2", "7", "6" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_2", "1", "1" 


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
     .SetP1 "True", "4", "0.70710678118655", "0.70710678118655" 
     .SetP2 "True", "1", "2.8284271247462", "2.8284271247462" 
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
Pick.PickEdgeFromId "component1:wire1", "1", "1" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1", "7", "6" 


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
     .SetP1 "True", "-0.70710678118655", "4", "0.70710678118655" 
     .SetP2 "True", "-2.8284271247462", "1", "2.8284271247462" 
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
Pick.PickEdgeFromId "component1:wire1_1_1", "7", "6" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1_1", "1", "1" 


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
     .SetP1 "True", "-4.0022790512573", "-0.69624075545686", "0.70499021717152" 
     .SetP2 "True", "-1.0092359798416", "-2.8439838540662", "2.809483684737" 
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
Pick.PickEdgeFromId "component1:wire1_1", "7", "6" 


'@ pick edge

'[VERSION]2018.6|27.0.2|20180615[/VERSION]
Pick.PickEdgeFromId "component1:wire1_1", "1", "1" 


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
     .SetP1 "True", "0.70710678118655", "-4", "0.70710678118655" 
     .SetP2 "True", "2.8284271247462", "-1", "2.8284271247462" 
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
     .SetMethod "Hexahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "1", "1" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "True" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-5" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Direct" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
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
     .SetNumberOfResultDataSamples "5001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddInactiveSampleInterval "", "", "", "Automatic", "False" 
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
     .SetCFIEAlpha "0.500000" 
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


