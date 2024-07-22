# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
frac_permeability = 1e-12
injection_rate_a = 100 # kg/s
injection_rate_b = 100 # kg/s
endTime = 40e6  # 462 days
depth = 3000
dt_max = 20000
[Mesh]
  [fmg] #this is block 0, the matrix
    type = FileMeshGenerator
    file='msh_to_exodus_in.e'
  []
  [fracture]
    input = fmg
    type = LowerDBlockFromSidesetGenerator
    new_block_id = 11
    new_block_name = 'fracture'
    sidesets = 'disk1 disk2 disk3 disk4 disk5 disk6 disk7 disk8 disk9 disk10 disk11 disk12 disk13 disk14 disk15'
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
  [tracer_1]
    initial_condition = 0.001
  []
  [tracer_2]
    initial_condition = 0.001
  []
[]

[AuxVariables]
  [insitu_pp]
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
  [insitu_pp]
    type = FunctionAux
    execute_on = initial
    variable = insitu_pp
    function = insitu_pp
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
  mass_fraction_vars = 'tracer_1 tracer_2'
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

[DiracKernels]
  [inject_fluid_mass]
    type = PorousFlowPointSourceFromPostprocessor
    mass_flux = mass_flux_src_a
    variable = tracer_1
    point = '4.046160e+02 2.581823e+02 2.213399e+02'
  []
  [inject_fluid_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = frac_T
    mass_flux = mass_flux_src_a
    T_in = 323
    pressure = frac_P
    point = '4.046160e+02 2.581823e+02 2.213399e+02'
    fp = true_water #the_simple_fluid
  []

  [inject_fluid_mass2]
    type = PorousFlowPointSourceFromPostprocessor
    mass_flux = mass_flux_src_b
    variable = tracer_2
    point = '3.165507e+02 2.507420e+02 2.591004e+02'
  []
  [inject_fluid_h2]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = frac_T
    mass_flux = mass_flux_src_b
    T_in = 323
    pressure = frac_P
    point = '3.165507e+02 2.507420e+02 2.591004e+02'
    fp = true_water #the_simple_fluid
  []

  [withdraw_tracer_a]
    type = PorousFlowPeacemanBorehole
    SumQuantityUO = tracer_a_kg_out_uo
    bottom_p_or_t = insitu_pp_borehole
    point_file = production_z75.csv
    unit_weight = '0 0 -1e4'
    fluid_phase = 0
    mass_fraction_component = 0
    use_mobility = true
    variable = tracer_1
    character = 1
  []

  [withdraw_tracer_b]
    type = PorousFlowPeacemanBorehole
    SumQuantityUO = tracer_b_kg_out_uo
    bottom_p_or_t = insitu_pp_borehole
    point_file = production_z75.csv
    unit_weight = '0 0 -1e4'
    fluid_phase = 0
    mass_fraction_component = 1
    use_mobility = true
    variable = tracer_2
    character = 1
  []

  [withdraw_insitu_fluid]
    type = PorousFlowPeacemanBorehole
    SumQuantityUO = kg_out_uo
    bottom_p_or_t = insitu_pp_borehole
    point_file = production_z75.csv
    unit_weight = '0 0 -1e4'
    fluid_phase = 0
    mass_fraction_component = 2
    use_mobility = true
    variable = frac_P
    character = 1
  []

  [withdraw_heat]
    type = PorousFlowPeacemanBorehole
    SumQuantityUO = J_out_uo
    bottom_p_or_t = insitu_pp_borehole
    point_file = production_z75.csv
    unit_weight = '0 0 -1e4'
    fluid_phase = 0
    use_mobility = true
    use_enthalpy = true
    variable = frac_T
    character = 1
    # block = 1  fixme rob:  do we want to limit extraction to fracture?
  []
[]

[UserObjects]
  [kg_out_uo]
    type = PorousFlowSumQuantity
  []
  [J_out_uo]
    type = PorousFlowSumQuantity
  []
  [tracer_a_kg_out_uo]
    type = PorousFlowSumQuantity
  []
  [tracer_b_kg_out_uo]
    type = PorousFlowSumQuantity
  []
[]

[Materials]
  [porosity_frac]
    type = PorousFlowPorosity
    porosity_zero = 0.9
    # block = fracture
  []
  [permeability_frac]
    type = PorousFlowPermeabilityConst
    permeability = '${frac_permeability} 0 0   0 ${frac_permeability} 0   0 0 ${frac_permeability}'
    # block = fracture
  []
  [internal_energy_frac]
    type = PorousFlowMatrixInternalEnergy
    density = 2700
    specific_heat_capacity = 0
    # block = fracture
  []
  [aq_thermal_conductivity_frac]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '0.6E-4 0 0  0 0.6E-4 0  0 0 0.6E-4'
    # block = fracture
  []

  # [porosity_matrix]
  #   type = PorousFlowPorosity
  #   porosity_zero = 0.001
  #   block = matrix
  # []
  # [permeability_matrix]
  #   type = PorousFlowPermeabilityConst
  #   permeability = '1e-18 0 0   0 1e-18 0   0 0 1e-18'
  #   block = matrix
  # []
  # [internal_energy_matrix]
  #   type = PorousFlowMatrixInternalEnergy
  #   density = 2750
  #   specific_heat_capacity = 790
  #   block = matrix
  # []
  # [aq_thermal_conductivity_matrix]
  #   type = PorousFlowThermalConductivityIdeal
  #   dry_thermal_conductivity = '3.05 0 0  0 3.05 0  0 0 3.05'
  #   block = matrix
  # []

[]

[Functions]
  [insitu_pp]
    type = ParsedFunction
    value = '9.81*1000*(${depth} - z)'
  []
  [insitu_pp_borehole]
    type = ParsedFunction
    value = '9.810*1000*(${depth} - z) + 100' # Approximate hydrostatic in Pa + 1MPa
  []
  [insitu_T]
    type = ParsedFunction
    value = '0.1384*(${depth} - z)'
  []
  [mass_flux_in_a]
    type = PiecewiseLinear
    xy_data = '
    0    0.0
    500 ${injection_rate_a}'
  []
  [mass_flux_in_b]
    type = PiecewiseLinear
    xy_data = '
    0    0.0
    500 ${injection_rate_b}'
  []
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
  [tracer_a_kg_out]
    type = PorousFlowPlotQuantity
    uo = tracer_a_kg_out_uo
  []
  [tracer_b_kg_out]
    type = PorousFlowPlotQuantity
    uo = tracer_b_kg_out_uo
  []
  [j_out]
    type = PorousFlowPlotQuantity
    uo = J_out_uo
  []

###  These are hard coded for production being 75m above injection
[p1_in]
  type = PointValue
  point = '404.616 258.1823 221.3399'
  variable =frac_P
[]
[p_out1]
  type = PointValue
  point = '3.879982e+02 2.567783e+02 3.034653e+02'
  variable =frac_P
[]
[p_out2]
  type = PointValue
  point = '3.775368e+02 2.558945e+02 3.079509e+02'
  variable =frac_P
[]
[p_out3]
  type = PointValue
  point = '3.250460e+02 2.514597e+02 3.304578e+02'
  variable =frac_P
[]
[p_out4]
  type = PointValue
  point = '2.023419e+02 2.410930e+02 3.830706e+02'
  variable = frac_P
[]
[t_out1]
  type = PointValue
  point = '3.879982e+02 2.567783e+02 3.034653e+02'
  variable = frac_T
[]
[t_out2]
  type = PointValue
  point = '3.775368e+02 2.558945e+02 3.079509e+02'
  variable = frac_T
[]
[t_out3]
  type = PointValue
  point = '3.250460e+02 2.514597e+02 3.304578e+02'
  variable = frac_T
[]
[t_out4]
  type = PointValue
  point = '2.023419e+02 2.410930e+02 3.830706e+02'
  variable = frac_T
[]
[tracer_a_out1]
  type = PointValue
  point = '3.879982e+02 2.567783e+02 3.034653e+02'
  variable = tracer_1
[]
[tracer_a_out2]
  type = PointValue
  point = '3.775368e+02 2.558945e+02 3.079509e+02'
  variable = tracer_1
[]
[tracer_a_out3]
  type = PointValue
  point = '3.250460e+02 2.514597e+02 3.304578e+02'
  variable = tracer_1
[]
[tracer_a_out4]
  type = PointValue
  point = '2.023419e+02 2.410930e+02 3.830706e+02'
  variable = tracer_1
[]
[tracer_b_out1]
  type = PointValue
  point = '3.879982e+02 2.567783e+02 3.034653e+02'
  variable = tracer_2
[]
[tracer_b_out2]
  type = PointValue
  point = '3.775368e+02 2.558945e+02 3.079509e+02'
  variable = tracer_2
[]
[tracer_b_out3]
  type = PointValue
  point = '3.250460e+02 2.514597e+02 3.304578e+02'
  variable = tracer_2
[]
[tracer_b_out4]
  type = PointValue
  point = '2.023419e+02 2.410930e+02 3.830706e+02'
  variable = tracer_2
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
