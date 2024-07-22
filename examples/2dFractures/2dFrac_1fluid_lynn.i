# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
frac_permeability = 1e-12
injection_rate_a = 5 # kg/s
injection_rate_b = 5 # kg/s
injection_temp = 323
endTime = 40e6  # 462 days
dt_max = 20000

#injection points
p1inx = 4.046160e+02
p1iny = 2.581823e+02
p1inz = 2.213399e+02

p2inx = 3.165507e+02
p2iny = 2.507420e+02
p2inz = 2.591004e+02

#production points for 75m Only using pt 1 & 3 from production_z75.csv
#these are being used in the postprocessors for T and P
#Peaceman is using 4 production points from newProduction_z75.csv
p1x =3.879982e+02
p1y =2.567783e+02
p1z =3.034653e+02

p3x =3.250460e+02
p3y =2.514597e+02
p3z =3.304578e+02



[Mesh]
  [fmg]
    type = FileMeshGenerator
    file='forge_10m.e'
  []
[]

[GlobalParams]
  PorousFlowDictator = dictator
  gravity = '0 0 -9.81'
[]

[Variables]
  [frac_P]
  []
  [frac_T]
  []
[]

[AuxVariables]
  [Pdiff]
  []
  [Tdiff]
  []
  [./density]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./viscosity]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [Pdiff]
    type = ParsedAux
    use_xyzt=true
    variable = Pdiff
    coupled_variables = 'frac_P'
    expression = 'frac_P-(1.6025e7-8500*(z-1150))'
    execute_on = TIMESTEP_END
  []
  [Tdiff]
    type = ParsedAux
    use_xyzt=true
    variable = Tdiff
    coupled_variables = 'frac_T'
    expression = 'frac_T-(1.6025e7-8500*(z-1150))'
    execute_on = TIMESTEP_END
  []
  [./density]
    type = MaterialRealAux
    variable = density
    property = PorousFlow_fluid_phase_density_qp0
    execute_on = TIMESTEP_END
  [../]
  [./viscosity]
    type = MaterialRealAux
    variable = viscosity
    property = PorousFlow_viscosity_qp0
    execute_on = TIMESTEP_END
  [../]
[]

[ICs]
  [frac_P]
    type = FunctionIC
    variable = frac_P
    function = insitu_pp
  []
  [frac_T]
    type = FunctionIC
    variable = frac_T
    function = insitu_T
  []
[]

[PorousFlowFullySaturated]
  coupling_type = ThermoHydro
  porepressure = frac_P
  temperature = frac_T
  fp = true_water #the_simple_fluid
  pressure_unit = Pa
  stabilization = full
  #gravity = '0 0 -9.81'
[]

[FluidProperties]
    [the_simple_fluid]
        type = SimpleFluidProperties
        bulk_modulus = 2E9
        viscosity = 1.0E-3
        density0 = 1000.0
    []

    [./true_water]
      type = Water97FluidProperties
    [../]

    [./tabulated_water]
      type = TabulatedBicubicFluidProperties
      fp = true_water
      fluid_property_file = tabulated_fluid_properties_v2.csv
    [../]
[]

[Reporters]
  [inject_pt1]
    type = ConstantReporter
    real_vector_names = 'pt_x pt_y pt_z'
    real_vector_values = '${p1inx}; ${p1iny}; ${p1inz}'
    outputs = none
  []
  [inject_node1]
    type = ClosestNode
    point_x = inject_pt1/pt_x
    point_y = inject_pt1/pt_y
    point_z = inject_pt1/pt_z
    projection_tolerance = 5
    execute_on = TIMESTEP_BEGIN
    outputs = none
  []
  [inject_pt2]
    type = ConstantReporter
    real_vector_names = 'pt_x pt_y pt_z'
    real_vector_values = '${p2inx}; ${p2iny}; ${p2inz}'
    outputs = none
  []
  [inject_node2]
    type = ClosestNode
    point_x = inject_pt2/pt_x
    point_y = inject_pt2/pt_y
    point_z = inject_pt2/pt_z
    projection_tolerance = 5
    execute_on = TIMESTEP_BEGIN
    outputs = none
  []

  # [prod_line]
  #   type = ConstantReporter
  #   real_vector_names = 'pt1_x pt1_y pt1_z pt2_x pt2_y pt2_z'
  #   real_vector_values = '${fparse p1x+(p3x-p1x)*10}; ${fparse p1y+(p3y-p1y)*10}; ${fparse p1z+(p3z-p1z)*10};
  #                         ${fparse p3x-(p3x-p1x)*10}; ${fparse p3y-(p3y-p1y)*10}; ${fparse p3z-(p3z-p1z)*10}'
  #   outputs = none
  # []
  # [prod_pt]
  #   type = ClosestElemsToLineWithValues
  #   projection_tolerance = 5
  #   point_x1 = prod_line/pt1_x
  #   point_y1 = prod_line/pt1_y
  #   point_z1 = prod_line/pt1_z
  #   point_x2 = prod_line/pt2_x
  #   point_y2 = prod_line/pt2_y
  #   point_z2 = prod_line/pt2_z
  #   value = 0.1
  #   # variable = frac_filter
  #   block = fracture
  #   # outputs = none
  # []
[]

[DiracKernels]
  [inject_fluid_mass]
    type = PorousFlowReporterPointSourcePP
    mass_flux = mass_flux_src_a
    variable = frac_P
    x_coord_reporter = 'inject_node1/node_x'
    y_coord_reporter = 'inject_node1/node_y'
    z_coord_reporter = 'inject_node1/node_z'
  []
  [inject_fluid_h]
    type = PorousFlowReporterPointEnthalpySourcePP
    variable = frac_T
    mass_flux = mass_flux_src_a
    T_in = 'inject_T'
    pressure = frac_P
    fp = true_water
    x_coord_reporter = 'inject_node1/node_x'
    y_coord_reporter = 'inject_node1/node_y'
    z_coord_reporter = 'inject_node1/node_z'
  []
  [inject_fluid_mass2]
    type = PorousFlowReporterPointSourcePP
    mass_flux = mass_flux_src_b
    variable = frac_P
    x_coord_reporter = 'inject_node2/node_x'
    y_coord_reporter = 'inject_node2/node_y'
    z_coord_reporter = 'inject_node2/node_z'
  []
  [inject_fluid_h2]
    type = PorousFlowReporterPointEnthalpySourcePP
    variable = frac_T
    mass_flux = mass_flux_src_b
    T_in = 'inject_T'
    pressure = frac_P
    fp = true_water
    x_coord_reporter = 'inject_node2/node_x'
    y_coord_reporter = 'inject_node2/node_y'
    z_coord_reporter = 'inject_node2/node_z'
  []

  [withdraw_fluid]
    type = PorousFlowPeacemanBorehole
    SumQuantityUO = kg_out_uo
    bottom_p_or_t = insitu_pp_borehole
    point_file = newProduction_z75.csv
    unit_weight = '0 0 -1e4'
    fluid_phase = 0
    use_mobility = true
    variable = frac_P
    character = 1
    block = fracture
  []

  [withdraw_heat]
    type = PorousFlowPeacemanBorehole
    SumQuantityUO = J_out_uo
    bottom_p_or_t = insitu_pp_borehole
    point_file = newProduction_z75.csv
    unit_weight = '0 0 -1e4'
    fluid_phase = 0
    use_mobility = true
    use_enthalpy = true
    variable = frac_T
    character = 1
    block = fracture
  []

  # [withdraw_fluid_pt3]
  #   type = PorousFlowPeacemanBorehole
  #   SumQuantityUO = kg_out_uo
  #   bottom_p_or_t = insitu_pp_borehole
  #   line_length = 1
  #   x_coord_reporter = 'prod_pt3/point_x'
  #   y_coord_reporter = 'prod_pt3/point_y'
  #   z_coord_reporter = 'prod_pt3/point_z'
  #   weight_reporter = 'prod_pt3/value'
  #   unit_weight = '0 0 -1e4'
  #   # fluid_phase = 0
  #   use_mobility = true
  #   variable = frac_P
  #   character = 1
  #   block = fracture
  # []
  # [withdraw_heat_pt3]
  #   type = PorousFlowPeacemanBorehole
  #   SumQuantityUO = J_out_uo
  #   bottom_p_or_t = insitu_pp_borehole
  #   line_length = 1
  #   x_coord_reporter = 'prod_pt3/point_x'
  #   y_coord_reporter = 'prod_pt3/point_y'
  #   z_coord_reporter = 'prod_pt3/point_z'
  #   weight_reporter = 'prod_pt3/value'
  #   unit_weight = '0 0 -1e4'
  #   # fluid_phase = 0
  #   use_mobility = true
  #   use_enthalpy = true
  #   variable = frac_T
  #   character = 1
  #   block = fracture
  # []
[]

[UserObjects]
  [kg_out_uo]
    type = PorousFlowSumQuantity
  []
  [J_out_uo]
    type = PorousFlowSumQuantity
  []
[]

[Materials]
  [porosity_frac]
    type = PorousFlowPorosity
    porosity_zero = 0.9
    block = fracture
  []
  [permeability_frac]
    type = PorousFlowPermeabilityConst
    permeability = '${frac_permeability} 0 0   0 ${frac_permeability} 0   0 0 ${frac_permeability}'
    block = fracture
  []
  [internal_energy_frac]
    type = PorousFlowMatrixInternalEnergy
    density = 2700
    specific_heat_capacity = 0
    block = fracture
  []
  [aq_thermal_conductivity_frac]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '0.6E-4 0 0  0 0.6E-4 0  0 0 0.6E-4'
    block = fracture
  []

  [porosity_matrix]
    type = PorousFlowPorosity
    porosity_zero = 0.001
    block = matrix
  []
  [permeability_matrix]
    type = PorousFlowPermeabilityConst
    permeability = '1e-18 0 0   0 1e-18 0   0 0 1e-18'
    block = matrix
  []
  [internal_energy_matrix]
    type = PorousFlowMatrixInternalEnergy
    density = 2750
    specific_heat_capacity = 790
    block = matrix
  []
  [aq_thermal_conductivity_matrix]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '3.05 0 0  0 3.05 0  0 0 3.05'
    block = matrix
  []

[]

[Functions]
  # NOTE: because this is used in BCs, it should be reasonably physically correct,
  # otherwise the BCs will be withdrawing or injecting heat-energy inappropriately
    [insitu_T]
      type = ParsedFunction
      expression = '426.67-0.0733333*(z-1150)'
    []
    [insitu_pp]
      type = ParsedFunction
      expression = '1.6025e7-8500*(z-1150)' # NOTE: because this is used in BCs, it should be reasonably physically correct, otherwise the BCs will be withdrawing or injecting water inappropriately.  Note also that the 8500 should be the unit_weight in the PeacemanBoreholes
    []
    [insitu_pp_borehole]
      type = ParsedFunction
      expression = '1.6025e7-8500*(z-1150) + 1e6' # NOTE, Lynn used + 1e6, but i want to be more agressive
    []
  [mass_flux_in_a]
    type = PiecewiseLinear
    xy_data = '
    0    0.0
    50000 ${injection_rate_a}'
  []
  [mass_flux_in_b]
    type = PiecewiseLinear
    xy_data = '
    0    0.0
    50000 ${injection_rate_b}'
  []
  # [kg_rate]
  #   type = ParsedFunction
  #   symbol_names = 'a1_dt kg_out'
  #   symbol_values = 'a1_dt kg_out'
  #   expression = 'kg_out/a1_dt'
  # []
[]

[Postprocessors]
  [mass_flux_src_a]
    type = FunctionValuePostprocessor
    function = mass_flux_in_a
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_b]
    type = FunctionValuePostprocessor
    function = mass_flux_in_b
    execute_on = 'initial timestep_end'
  []

  [kg_out]
    type = PorousFlowPlotQuantity
    uo = kg_out_uo
  []
  [j_out]
    type = PorousFlowPlotQuantity
    uo = J_out_uo
  []
  # [kg_per_s]
  #   type = FunctionValuePostprocessor
  #   function = kg_rate
  #   execute_on = TIMESTEP_END
  # []


[p1_in]
  type = PointValue
  point = '${p1inx} ${p1iny} ${p1inz}'
  variable =frac_P
[]
[p2_in]
  type = PointValue
  point = '${p2inx} ${p2iny} ${p2inz}'
  variable =frac_P
[]

[p_out1]
  type = PointValue
  point = '${p1x} ${p1y} ${p1z}'
  variable =frac_P
[]
[p_out3]
  type = PointValue
  point = '${p3x} ${p3y} ${p3z}'
  variable =frac_P
[]
[t_out1]
  type = PointValue
  point = '${p1x} ${p1y} ${p1z}'
  variable = frac_T
[]
[t_out3]
  type = PointValue
  point = '${p3x} ${p3y} ${p3z}'
  variable = frac_T
[]
### this output named to be written first
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

  [inject_T]
    type = Receiver
    default = ${injection_temp}
    outputs = none
  []
[]

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
  l_tol      = 1e-4
  l_max_its  = 300
  nl_max_its = 50
  nl_abs_tol = 1e-4
  nl_rel_tol = 1e-5
  automatic_scaling = true
  off_diagonals_in_auto_scaling=true
  compute_scaling_once=true
  line_search = none
  [TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 25
    iteration_window = 10
    growth_factor = 1.2
    cutback_factor = 0.9
    cutback_factor_at_failure=0.5
    linear_iteration_ratio = 300
    dt=1
  []
[]

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
