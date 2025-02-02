# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
frac_permeability = 1e-12
endTime = 40e6  # 462 days
dt_max = 10000 # NOTE, Lynn had 50000, but i want to check convergence for more agressive cases
dt_max2 = 50000 # this is the timestep size after 90 days
injection_temp = 323.15
injection_rate = 10 #kg/s

# NOTES FROM LYNN

# Step 2:  Run readWriteProps.i to read in upscaled permeabilities onto a
#          uniform mesh and output it an exodus file of it.
#
# seacas explore output
# p3_aniso_post_stim_out.e
# Mesh Limits:
# Min X =  1.911310000E+03, Max X =  2.511310000E+03, Range =  6.000000000E+02
# Min Y =  1.662310000E+03, Max Y =  2.262310000E+03, Range =  6.000000000E+02
# Min Z = -1.150000000E+03, Max Z = -5.500000000E+02, Range =  6.000000000E+02

[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 60
    ny = 60
    nz = 60
    xmin = 0
    xmax =600
    ymin = 0
    ymax =600
    zmin = 0
    zmax =600
  []
  [dummy]
    type = SubdomainBoundingBoxGenerator
    input = 'gmg'
    block_id = 1
    bottom_left = '0 0 0'
    top_right = '100 100 100'
    location = outside
  []
[]

##############################################################
[AuxVariables]
  [cut]
    order = CONSTANT
    family = MONOMIAL
  []
  [indicator]
    order = CONSTANT
    family = MONOMIAL
  []
  [marker]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[AuxKernels]
  [cut]
    type = MarkCutElems
    mesh_file = MS_DFN_Local_Coords.exo
    variable = cut
  []
[]

[UserObjects]
  [DFN]
    type = CoupledVarThresholdElementSubdomainModifier
    coupled_var = 'cut'
    criterion_type = ABOVE
    threshold = 0.5
    subdomain_id = 1
    complement_subdomain_id = 0
    execute_on = 'TIMESTEP_END'
  []
[]

[Adaptivity]
  marker = marker
  max_h_level = 2
  stop_time = 7
  [Indicators]
    [indicator]
      type = ValueJumpIndicator
      variable = cut
    []
  []
  [Markers]
    [marker]
      type = ErrorFractionMarker
      indicator = indicator
      coarsen = 0.1
      refine = 0.9
    []
  []
[]

##############################################################
[Problem]
  solve = true
[]

##############################################################
[GlobalParams]
  PorousFlowDictator = dictator
[]

[PorousFlowFullySaturated]
  coupling_type = ThermoHydro
  porepressure = porepressure
  temperature = temperature
  dictator_name = dictator
  fp = true_water
  stabilization = full
[]
[FluidProperties]
  [true_water]
    type = Water97FluidProperties
  []
  # [tabulated_water]
  #   type = TabulatedFluidProperties
  #   fp = true_water
  #   fluid_property_file = tabulated_fluid_properties_v2.csv
  # []
[]

##############################################################
[Variables]
[porepressure]
[]
  [temperature]
  []
[]

[ICs]
  [P]
    type = FunctionIC
    function = insitu_pp
    variable = porepressure
  []
  [T]
    type = FunctionIC
    function = insitu_T
    variable = temperature
  []
[]
##############################################################
[BCs]
# NOTE: these BCs prevent water and heat from exiting or entering the model
# from its sides, while providing water and heat from the model top and bottom
# boundaries to ensure those boundaries remain at insitu pressure
# and temperature
  [porepressure_top]
    type = FunctionDirichletBC
    variable = porepressure
    boundary = 'front'
    function = insitu_pp
  []
#  [porepressure_bottom]
#    type = FunctionDirichletBC
#    variable = porepressure
#    boundary = 'back'
#    function = insitu_pp
#  []
  [poreptemperature_top]
    type = FunctionDirichletBC
    variable = temperature
    boundary = 'front'
    function = insitu_T
  []
  [poreptemperature_bottom]
    type = FunctionDirichletBC
    variable = temperature
    boundary = 'back'
    function = insitu_T
  []
[]

##############################################################
[Materials]
  [biot_modulus]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = 0.47
    solid_bulk_compliance = 2e-7
    fluid_bulk_modulus = 1e7
  []
  [porosity_matrix]
    type = PorousFlowPorosity
    porosity_zero = 0.001
    block = 0
  []
  [./permeability_matrix]
    type = PorousFlowPermeabilityConst
    permeability = '1e-18 0 0 0 1e-18 0 0 0 1e-18'
    block = 0
  [../]
  [rock_internal_energy_matrix]
    type = PorousFlowMatrixInternalEnergy
    density = 2750.0
    specific_heat_capacity = 790.0
    block = 0
  []
  [thermal_conductivity_matrix]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '3.05 0 0 0 3.05 0 0 0 3.05'
    block = 0
  []

  [porosity_fracture]
    type = PorousFlowPorosityConst
    porosity = 0.01
    block = 1
  []
  [permeability_fracture]
    type = PorousFlowPermeabilityConst
    block = 1
    permeability = '${frac_permeability} 0 0 0 ${frac_permeability} 0 0 0 ${frac_permeability}'
  []
  [rock_internal_energy_fracture]
    type = PorousFlowMatrixInternalEnergy
    density = 2500.0
    specific_heat_capacity = 100.0 # NOTE: Lynn value of 10.0 seemed quite low, so i increased it.  This may not impact the simulation much
    block = 1
  []
  [thermal_conductivity_fracture]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '3 0 0 0 3 0 0 0 3'
    block = 1
  []
[]

##########################################################
[Functions]
  [dts]
    type = PiecewiseLinear
    x = '0   5.0  6.0  50000      2592000    5184000'
    y = '1.0 1.0  1000 ${dt_max}  ${dt_max} ${dt_max2}'
  []
  [mass_flux_in]
    type = PiecewiseLinear
    xy_data = '
    0    0.0
    50000 ${injection_rate}'
  []
# NOTE: because this is used in BCs, it should be reasonably physically correct,
# otherwise the BCs will be withdrawing or injecting heat-energy inappropriately
  [insitu_T]
    type = ParsedFunction
    value = '426.67-0.0733333*(z-1150)'
  []
  [insitu_pp]
    type = ParsedFunction
    value = '1.6025e7-8500*(z-1150)' # NOTE: because this is used in BCs, it should be reasonably physically correct, otherwise the BCs will be withdrawing or injecting water inappropriately.  Note also that the 8500 should be the unit_weight in the PeacemanBoreholes
  []
  [insitu_pp_borehole]
    type = ParsedFunction
    value = '1.6025e7-8500*(z-1150) + 1e6' # NOTE, Lynn used + 1e6, but i want to be more agressive
  []

[]

###########################################################

[UserObjects]
  [borehole_fluid_outflow_mass]
    type = PorousFlowSumQuantity
  []
  [borehole_prod_temperature]
    type = PorousFlowSumQuantity
  []
[]

[DiracKernels]
  [source]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src
    point = '404.616 258.1823 221.3399'
  []
  [source_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src
    point = '404.616 258.1823 221.3399'
    T_in = inject_T
    pressure = porepressure
    fp = true_water
  []
  [withdraw_fluid]
    type = PorousFlowPeacemanBorehole
    variable = porepressure
    bottom_p_or_t = insitu_pp_borehole
    SumQuantityUO = borehole_fluid_outflow_mass
    point_file = production_z100.csv
    function_of = pressure
    fluid_phase = 0
    unit_weight = '0 0 -0.85e4' # NOTE: Lynn had -1e4, but 0.85e4 is equal to the insitu_pp
    use_mobility = true
    character = 1
  []
  [bh_energy_flow]
    type = PorousFlowPeacemanBorehole
    variable = temperature
    bottom_p_or_t = insitu_pp_borehole
    SumQuantityUO = borehole_prod_temperature
    point_file = production_z100.csv
    function_of = pressure
    fluid_phase = 0
    unit_weight = '0 0 -0.85e4' # NOTE: Lynn had -1e4, but 0.85e4 is equal to the insitu_pp
    use_mobility = true
    use_enthalpy = true
    character = 1
  []
[]

[Postprocessors]
  [p_in]
    type = PointValue
    point = '404.616 258.1823 221.3399'
    variable =porepressure 
  []
  [p_out1]
    type = PointValue
    point = '3.879982e+02 2.567783e+02 3.034653e+02'
    variable =porepressure 
  []
  [p_out2]
    type = PointValue
    point = '3.775368e+02 2.558945e+02 3.079509e+02'
    variable =porepressure
  []
  [p_out3]
    type = PointValue
    point = '3.250460e+02 2.514597e+02 3.304578e+02'
    variable =porepressure
  []
  [p_out4]
    type = PointValue
    point = '2.023419e+02 2.410930e+02 3.830706e+02'
    variable = porepressure
  []
  [t_out1]
    type = PointValue
    point = '3.879982e+02 2.567783e+02 3.034653e+02'
    variable = temperature
  []
  [t_out2]
    type = PointValue
    point = '3.775368e+02 2.558945e+02 3.079509e+02'
    variable = temperature
  []
  [t_out3]
    type = PointValue
    point = '3.250460e+02 2.514597e+02 3.304578e+02'
    variable = temperature
  []
  [t_out4]
    type = PointValue
    point = '2.023419e+02 2.410930e+02 3.830706e+02'
    variable = temperature
  []
  [pmin_ts]
    type = NodalExtremeValue
    variable = porepressure
    value_type = min
  []
  [pmax_ts]
    type = NodalExtremeValue
    variable = porepressure
    value_type = max
  []
  [tmin_ts]
    type = NodalExtremeValue
    variable = temperature
    value_type = min
  []
  [tmax_ts]
    type = NodalExtremeValue
    variable = temperature
    value_type = max
  []
  [mass_flux_src]
      type = FunctionValuePostprocessor
      function = mass_flux_in
      execute_on = 'initial timestep_end'
  []
  [inject_T]
    type = Receiver
    default = ${injection_temp}
  []
  [fluid_report]
    type = PorousFlowPlotQuantity
    uo = borehole_fluid_outflow_mass
  []
  [energy_prod]
    type = PorousFlowPlotQuantity
    uo = borehole_prod_temperature
  []
  [a1_nl_its]
    type = NumNonlinearIterations
  []
  [a1_l_its]
    type = NumLinearIterations
  []
  [a1_dt]
    type = TimestepSize
  []
  [a0_wall_time]
    type = PerfGraphData
    section_name = "Root"
    data_type = total
  []
  [a2_total_mem]
    type = MemoryUsage
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [a2_per_proc_mem]
    type = MemoryUsage
    value_type = "average"
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [a2_max_proc_mem]
    type = MemoryUsage
    value_type = "max_process"
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [a3_n_elements]
    type = NumElems
    execute_on = timestep_end
  []
  [a3_n_nodes]
    type = NumNodes
    execute_on = timestep_end
  []
  [a3_DOFs]
    type = NumDOFs
  []
[]
###########################################################
[Preconditioning]
  active = hypre # NOTE - perhaps ilu is going to be necessary in the full problem?
  # NOTE: the following is how i would use hypre - probably worth an experiment on the full problem
    [./hypre]
      type = SMP
      full = true
      petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
      petsc_options_iname = '-pc_type -pc_hypre_type'
      petsc_options_value = ' hypre    boomeramg'
    [../]
    [./asm_ilu]  #uses less memory
      type = SMP
      full = true
      petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
      petsc_options_iname = '-ksp_type -ksp_grmres_restart -pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
      petsc_options_value = 'gmres 30 asm ilu NONZERO 2'
    [../]
    [./asm_lu]  #uses less memory
      type = SMP
      full = true
      petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
      petsc_options_iname = '-ksp_type -ksp_grmres_restart -pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
      petsc_options_value = 'gmres 30 asm lu NONZERO 2'
    [../]
    [./superlu]
      type = SMP
      full = true
      petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
      petsc_options_iname = '-ksp_type -pc_type -pc_factor_mat_solver_package'
      petsc_options_value = 'gmres lu superlu_dist'
    [../]
    [./preferred]
      type = SMP
      full = true
      petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
      petsc_options_value = ' lu       mumps'
    [../]
[]
[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = ${endTime}
  dtmin = 1
  dtmax = ${dt_max}
  l_tol      = 1e-4 #1e-12 #NOTE, Lynn had 1e-4, which is possibly OK, but i want to work the linear solver harder to potentially reduce nonlinear iterations.  ALSO NOTE: if the linear solver gives a crappy inversion then it is quite likely that MOOSE will be forced to evaluate water props at crazy (P, T), and hence fail.
  l_max_its  = 200 #1000 # NOTE, Lynn had 200, but i am trying to work the linear solver harder - also, ilu will probably need more iterations than lu
  nl_max_its = 50 #200
  #nl_abs_tol = 1e-4# #1e-6 # NOTE Lynn had nl_abs_tol = 1e-4 , but i want to make sure i get quality convergence while i'm checking over the input file
  nl_rel_tol = 1e-5 #1E-8 # NOTE, Lynn had 1e-5 , but i want to make sure i get quality convergence while i'm checking over the input file
  automatic_scaling =true # false
  # NOTE line_search = none
  # NOTE reuse_preconditioner=true
  # [Predictor]
  #   type = SimplePredictor
  #   scale = 0.5
  # []
  [TimeStepper]
    type = FunctionDT
    function = dts
    min_dt = 10
    interpolate = true
    growth_factor = 3
  []
[]

##############################################################
[Outputs]
  csv = true
  [exo]
    type = Exodus
    sync_times = '1 2 3 4 5
    5.00E+04	1.00E+05	1.50E+05	2.00E+05	2.50E+05	3.00E+05
    3.50E+05	4.00E+05	4.50E+05	5.00E+05	5.50E+05	6.00E+05	6.50E+05
    7.00E+05	7.50E+05	8.00E+05	8.50E+05	9.00E+05	9.50E+05	1.00E+06
    1.05E+06	1.10E+06	1.15E+06	1.20E+06	1.25E+06	1.30E+06	1.35E+06
    1.40E+06	1.45E+06	1.50E+06	1.55E+06	1.60E+06	1.65E+06	1.70E+06
    1.75E+06	1.80E+06	1.85E+06	1.90E+06	1.95E+06	2.00E+06	2.05E+06
    2.10E+06	2.15E+06	2.20E+06	2.25E+06	2.30E+06	2.35E+06	2.40E+06
    2.45E+06	2.50E+06	2.55E+06	2.60E+06	2.65E+06	2.70E+06	2.75E+06
    2.80E+06	2.85E+06	2.90E+06	2.95E+06	3.00E+06	3.05E+06	3.10E+06
    3.15E+06	3.20E+06	3.25E+06	3.30E+06	3.35E+06	3.40E+06	3.45E+06
    3.50E+06	3.55E+06	3.60E+06	3.65E+06	3.70E+06	3.75E+06	3.80E+06
    3.85E+06	3.90E+06	3.95E+06	4.00E+06	4.05E+06	4.10E+06	4.15E+06
    4.20E+06	4.25E+06	4.30E+06	4.35E+06	4.40E+06	4.45E+06	4.50E+06
    4.55E+06	4.60E+06	4.65E+06	4.70E+06	4.75E+06	4.80E+06	4.85E+06
    4.90E+06	4.95E+06	5.00E+06	5.05E+06	5.10E+06	5.15E+06	5.20E+06
    5.25E+06	5.30E+06	5.35E+06	5.40E+06	5.45E+06	5.50E+06	5.55E+06
    5.60E+06	5.65E+06	5.70E+06	5.75E+06	5.80E+06	5.85E+06	5.90E+06
    5.95E+06	6.00E+06	6.05E+06	6.10E+06	6.15E+06	6.20E+06	6.25E+06
    6.30E+06	6.35E+06	6.40E+06	6.45E+06	6.50E+06	6.55E+06	6.60E+06
    6.65E+06	6.70E+06	6.75E+06	6.80E+06	6.85E+06	6.90E+06	6.95E+06
    7.00E+06	7.05E+06	7.10E+06	7.15E+06	7.20E+06	7.25E+06	7.30E+06
    7.35E+06	7.40E+06	7.45E+06	7.50E+06	7.55E+06	7.60E+06	7.65E+06
    7.70E+06	7.75E+06 8e6 9e6
    10e6 11e6 12e6 13e6 14e6 15e6 16e6 17e6 18e6 19e6
    20e6 21e6 22e6 23e6 24e6 25e6 26e6 27e6 28e6 29e6
    30e6 31e6 32e6 33e6 34e6 35e6 36e6 37e6 38e6 39e6
    40e6'
    sync_only = true
  []
[]

# NOTE - following is useful for checking scaling
# NOTE [Debug]
# NOTE   show_var_residual_norms = true
# NOTE []
