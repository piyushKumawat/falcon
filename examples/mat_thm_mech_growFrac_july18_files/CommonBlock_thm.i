# This has everything that is common with all simulations

# This reads in the mesh created by ReadSpatialProperties.

# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
# fraction of total into each zone
inj_ratio_zn2 = 0.25 # zone gets 50% of total flow, then cut in half again for half symmetry model
endTime = 20000
dt_max = 100
# offset = 10
injection_temp = 323.15
#These are the injections points used to create the fractures in make_zone_frac_meshes.i
#zone 1:
p1inx = 4.080888831e+02
p1iny = 2.57e2  # shifted over by 1 from actual injection of 2.584756670e+02 for y symmetry plane
p1inz = 2.098508678e+02
id=0
#--------- mesh and read in data -------------
[Mesh]
  [fmg]
    type = FileMeshGenerator
    file='readSpatialProps_initialize_1frac_out.e'
    use_for_exodus_restart = true
  []
[]
[Problem]
  allow_initial_conditions_with_restart = true
[]

[AuxVariables]
  [permeability]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = permeability_total
    initial_from_file_timestep = 'LATEST'
  []
  [porosity]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = porosity
    initial_from_file_timestep = 'LATEST'
  []
[]
[Variables]
  [frac_P]
    order = FIRST
    family = LAGRANGE
  []
[]

#----------------------------------------

[GlobalParams]
  PorousFlowDictator = dictator
[]

[AuxVariables]
  [Pdiff]
    initial_condition = 0
  []
  [density]
    order = CONSTANT
    family = MONOMIAL
  []
  [viscosity]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[AuxKernels]
  [Pdiff]
    type = ParsedAux
    use_xyzt = true
    variable = Pdiff
    coupled_variables = 'frac_P'
    expression = 'frac_P-(1.6025e7-9810*(z-1150))'
    execute_on = TIMESTEP_END
  []
  [density]
    type = MaterialRealAux
    variable = density
    property = PorousFlow_fluid_phase_density_qp0
    execute_on = TIMESTEP_END
  []
  [viscosity]
    type = MaterialRealAux
    variable = viscosity
    property = PorousFlow_viscosity_qp0
    execute_on = TIMESTEP_END
  []
[]

[ICs]
  [frac_P]
    type = FunctionIC
    variable = frac_P
    function = insitu_pp
  []
[]

[BCs]
  # NOTE: these BCs prevent water from exiting or entering the model from its sides,
  # while providing water from the model top and bottom boundaries to ensure those
  # boundaries remain at insitu pressure
  [porepressure_top]
    type = FunctionDirichletBC
    variable = frac_P
    boundary = 'front'
    function = insitu_pp
  []
  [porepressure_bottom]
    type = FunctionDirichletBC
    variable = frac_P
    boundary = 'back'
    function = insitu_pp
  []
[]

[FluidProperties]
  [the_simple_fluid]
    type = SimpleFluidProperties
    bulk_modulus = 2E8
    viscosity = 1.0E-3
    density0 = 850.0
  []

  [true_water]
    type = Water97FluidProperties
  []
[]

[Reporters]
  [inj_zn2]
    type = ConstantReporter
    real_vector_names = 'pt_x pt_y pt_z'
    real_vector_values = '${p1inx}; ${p1iny}; ${p1inz}'
    outputs = none
  []
  [prod_zn2]
    type = ConstantReporter
    real_vector_names = 'w pt_x pt_y pt_z'
    real_vector_values = '0.1; ${p1inx}; ${p1iny}; ${fparse p1inz+offset}'
    outputs = none
  []
[]

[DiracKernels]
  [inject_fluid_mass_zn2]
    type = PorousFlowReporterPointSourcePP
    variable = frac_P
    mass_flux = mass_flux_src_zn2
    x_coord_reporter = 'inj_zn2/pt_x'
    y_coord_reporter = 'inj_zn2/pt_y'
    z_coord_reporter = 'inj_zn2/pt_z'
  []
  [withdraw_fluid_zn2]
    type = PorousFlowPeacemanBorehole
    variable = frac_P
    SumQuantityUO = kg_out_uo_zn2
    function_of = pressure
    bottom_p_or_t = insitu_pp_borehole
    weight_reporter = 'prod_zn2/w'
    x_coord_reporter = 'prod_zn2/pt_x'
    y_coord_reporter = 'prod_zn2/pt_y'
    z_coord_reporter = 'prod_zn2/pt_z'
    line_length = 1 # what should this be?
    unit_weight = '0 0 -9.81e3'# This from insitu_pp function
    fluid_phase = 0
    use_mobility = true
    character = 1
    block = 'frac'
  []
[]

[UserObjects]
  [kg_out_uo_zn2]
    type = PorousFlowSumQuantity
  []
[]

[Functions]
  # NOTE: because this is used in BCs, it should be reasonably physically correct,
  # otherwise the BCs will be withdrawing or injecting water inappropriately.
  # Note also that the 9810 (g*rho) should be the unit_weight in the PeacemanBoreholes
  [insitu_pp]
    type = ParsedFunction
    expression = '1.6025e7-9810*(z-1150)'
  []
  [insitu_pp_borehole]
    type = ParsedFunction
    expression = '1.6025e7-9810*(z-1150)+1e6'
  []
  #Circulation 2, Day 1, July 18, 2023
  #UtahForge16AJuly18.xlsx
  [mass_flux_in_zn2]
    type = PiecewiseLinear
    x='0   3599 3600  27729 27730 31356 34859 34860 100000'
    y='2.5 2.5  5.0   5.0   5.8   7.3   7.3   0     0'
    # x='0 100 500 1000 2000'
    # y='0.0 0.1   2.5 2.5  5.0 '
    scale_factor=${fparse 2.65*inj_ratio_zn2} #convert barrels/minute to kg/s
  []
  #Circulation 2, Day 2, July 19/20, 2023
  #UtahForge16AJuly19.xlsx
  # [mass_flux_in_zn2]
  #   type = PiecewiseLinear
  #   x='0   1917 1946 2556 2576 4933 4963 10661 10673 17669 17673'
  #   y='2.5 2.5  0    0    2.5  2.5  5    5     7.5   7.5   0'
  #   #  1 barrel = 0.1589872949 m^3
  #   #  1 brl/min= (0.1589872949 m^3) * (1 min/60s)=0.00264978824 m^3/s
  #   #  0.0026497882488 m3/s * 1000kg/m3 = 2.6497882488 kg/s
  #   scale_factor=${fparse 2.65*inj_ratio_zn2} #convert barrels/minute to kg/s
  # []
[]

[Postprocessors]
  [mass_flux_src_zn2]
    type = FunctionValuePostprocessor
    function = mass_flux_in_zn2
    execute_on = 'initial timestep_end'
  []
  [output_mass_zn2]
    type = PorousFlowPlotQuantity
    uo = kg_out_uo_zn2
  []
  [p1_in]
    type = PointValue
    point = '${p1inx} ${p1iny} ${p1inz}'
    variable = Pdiff
  []
  [p1_out]
    type = PointValue
    point = '${p1inx} ${p1iny} ${fparse p1inz+offset}'
    variable = Pdiff
  []
  [a1_dt]
    type = TimestepSize
  []
  [a0_wall_time]
    type = PerfGraphData
    section_name = "Root"
    data_type = total
  []
  [a2_id]
    type = ConstantPostprocessor
    value = ${id}
  []
  [inject_T]
    type = Receiver
    default = ${injection_temp}
    outputs=none
  []
[]

[Preconditioning]
  # NOTE: the following is how i would use hypre - probably worth an experiment on the full problem
  [hypre]
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-pc_type -pc_hypre_type'
    petsc_options_value = ' hypre    boomeramg'
  []
  [asm_ilu] #uses less memory
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-ksp_type -ksp_grmres_restart -pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
    petsc_options_value = 'gmres 30 asm ilu NONZERO 2'
  []
  [asm_lu] #uses less memory
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-ksp_type -ksp_grmres_restart -pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
    petsc_options_value = 'gmres 30 asm lu NONZERO 2'
  []
  [superlu]
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-ksp_type -pc_type -pc_factor_mat_solver_package'
    petsc_options_value = 'gmres lu superlu_dist'
  []
  [preferred]
    type = SMP
    full = true
    petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
    petsc_options_value = ' lu       mumps'
  []
[]

# [Executioner]
#   type = Steady
#   solve_type = NEWTON
#   l_max_its  = 100
#   line_search = none
# []
[Executioner]
  type = Transient
  solve_type = NEWTON
  error_on_dtmin = false
  end_time = ${endTime}
  dtmin = 1
  dtmax = ${dt_max}
  l_tol = 1e-4
  l_max_its = 300
  nl_max_its = 50
  nl_abs_tol = 1e-4
  nl_rel_tol = 1e-5
  # automatic_scaling = true
  # off_diagonals_in_auto_scaling = true
  # compute_scaling_once = true
  line_search = none
  reuse_preconditioner=true
  reuse_preconditioner_max_linear_its = 25
  [TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 25
    iteration_window = 10
    growth_factor = 1.2
    cutback_factor = 0.9
    cutback_factor_at_failure = 0.5
    linear_iteration_ratio = 300
    dt = 1
    force_step_every_function_point = true
    
    timestep_limiting_function='mass_flux_in_zn2'
  []
[]
