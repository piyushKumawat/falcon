# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
# frac_permeability = 1e-13
endTime = 17673  # 462 days
dt_max = 100 # NOTE
dt_max2 = 10 # this is the timestep size after 90 days
# injection_rate1 = 5 #kg/s
# injection_rate2 = 5 #kg/s
# injection_rate3 = 5 #kg/s
# ft = 20000.0

[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = '3Frac.xdr'
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
  coupling_type = Hydro
  porepressure = porepressure
  dictator_name = dictator
  fp = true_water
  stabilization = full
[]
[FluidProperties]
  # [the_simple_fluid]
  #   type = SimpleFluidProperties
  #   bulk_modulus = 2E9
  #   viscosity = 1.0E-3
  #   density0 = 1000.0
  # []
  [true_water]
    type = Water97FluidProperties
  []
  # [tabulated_water]
  #   type = TabulatedBicubicFluidProperties
  #   fp = true_water
  #   fluid_property_file = ext_fluid_properties2.csv
  #   temperature_min = 280 #added new
  #   temperature_max = 600 #added new
  # []
[]

##############################################################
[Variables]
  [porepressure]
  []
[]

[ICs]
  [P]
    type = FunctionIC
    function = insitu_pp
    variable = porepressure
  []
  [permz]
    type = FunctionIC
    function = permz
    variable = permzz
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
  [porosity_fracture]
    type = PorousFlowPorosityConst
    porosity = 0.01
    block = 1
  []
  [permeability_fracture]
    type = PorousFlowPermeabilityConstFromVar
    perm_xx = permzz
    perm_yy = permzz
    perm_zz = permzz
    block = 1
  []
[]

# [AuxKernels]
#   [perm]
#     type = ParsedAux
#     variable=perm
#     coupled_variables = 'perm_md'
#     expression = '5*(1e-14)+(5.5278*(1e-16))*coord(z)'
#     execute_on= initial
#   []
# []

[AuxVariables]
  [permzz]
    order = CONSTANT
    family = MONOMIAL
  []
[]


##########################################################



[Functions]
  [dts]
    type = PiecewiseLinear
    x = '0   5.0  6.0 1500 1600 17673'
    y = '1.0 1.0  100 100  10   ${dt_max2}'
  []
  [mass_flux_in1]
    type = PiecewiseLinear
    x='0     1917   1946 2556  2576   4933   4963   10661   10673  17669   17673'
    y='2.207 2.207  0    0     2.207  2.207  4.425  4.425   6.625  6.625    0'
  []
  [mass_flux_in2]
    type = PiecewiseLinear
    x='0     1917   1946 2556  2576   4933   4963   10661   10673  17669    17673'
    y='2.207 2.207  0    0     2.207  2.207  4.425  4.425   6.625  6.625    0'
  []
  [mass_flux_in3]
    type = PiecewiseLinear
    x='0     1917   1946 2556  2576   4933   4963   10661   10673  17669   17673'
    y='2.207 2.207  0    0     2.207  2.207  4.425  4.425   6.625  6.625   0'
  []

  # [mass_flux_in1]
  #   type = PiecewiseLinear
  #   x='0  0.0 +${ft}   1917.0+${ft}   1946.0+${ft} 2556.0+${ft}  2576.0+${ft}   4933.0+${ft}   4963.0+${ft}   10661.0+${ft}   10673.0+${ft}  17669.0+${ft}  17673.0+${ft}'
  #   y='5  0.833        0.833          0            0             0.833          0.833          1.67           1.67            2.5            2.5            0'
  # []
  # [mass_flux_in2]
  #   type = PiecewiseLinear
  #   x='0  0.0 +${ft}   1917.0+${ft}   1946.0+${ft} 2556.0+${ft}  2576.0+${ft}   4933.0+${ft}   4963.0+${ft}   10661.0+${ft}   10673.0+${ft}  17669.0+${ft}  17673.0+${ft}'
  #   y='5  0.833        0.833          0            0             0.833          0.833          1.67           1.67            2.5            2.5            0'
  # []
  # [mass_flux_in3]
  #   type = PiecewiseLinear
  #   x='0  0.0 +${ft}   1917.0+${ft}   1946.0+${ft} 2556.0+${ft}  2576.0+${ft}   4933.0+${ft}   4963.0+${ft}   10661.0+${ft}   10673.0+${ft}  17669.0+${ft}  17673.0+${ft}'
  #   y='5  0.833        0.833          0            0             0.833          0.833          1.67           1.67            2.5            2.5            0'
  # []

# NOTE: because this is used in BCs, it should be reasonably physically correct,
# otherwise the BCs will be withdrawing or injecting heat-energy inappropriately
  [insitu_pp]
    type = ParsedFunction
    value = '1.6025e7-8500*(z-1150)' # NOTE: because this is used in BCs, it should be reasonably physically correct, otherwise the BCs will be withdrawing or injecting water inappropriately.  Note also that the 8500 should be the unit_weight in the PeacemanBoreholes
  []
  [insitu_pp_borehole]
    type = ParsedFunction
    value = '1.6025e7-8500*(z-1150) + 1e6' # NOTE, Lynn used + 1e6, but i want to be more agressive
  []
  [permz]
    type = ParsedFunction
    expression = '(-2.69e-16)*z+1.563e-13'
  []
[]

###########################################################

[UserObjects]
  [borehole_fluid_outflow_mass]
    type = PorousFlowSumQuantity
  []
[]

[DiracKernels]
  [source1]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src1
    point = '406.25 263.468 209.48'
  []
  [source2]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src2
    point = '351.25 257.54 235.05'
  []
  [source3]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src3
    point = '203 241.56 303.97'
  []
  [withdraw_fluid]
    type = PorousFlowPeacemanBorehole
    variable = porepressure
    bottom_p_or_t = insitu_pp_borehole
    SumQuantityUO = borehole_fluid_outflow_mass
    point_file = production_points_3frac.csv
    function_of = pressure
    fluid_phase = 0
    unit_weight = '0 0 -0.85e4' # NOTE: Lynn had -1e4, but 0.85e4 is equal to the insitu_pp
    use_mobility = true
    character = 1
  []
[]

[Postprocessors]
  [p_in1]
    type = PointValue
    point = '406.25 263.468 209.48'
    variable =porepressure 
  []
  [p_in2]
    type = PointValue
    point = '351.25 257.54 235.05'
    variable =porepressure
  []
  [p_in3]
    type = PointValue
    point = '203 241.56 303.97'
    variable =porepressure 
  []
  [p_out1]
    type = PointValue
    point = '406.25 263.468 300.923'
    variable =porepressure 
  []
  [p_out2]
    type = PointValue
    point = '351.25 257.54 326.493'
    variable =porepressure
  []
  [p_out3]
    type = PointValue
    point = '203 241.56 395.453'
    variable =porepressure
  []
  [perm1_in]
    type = PointValue
    point = '406.25 263.468 209.48'
    variable = permzz
  []
  [perm2_in]
    type = PointValue
    point = '351.25 257.54 235.05'
    variable = permzz
  []
  [perm3_in]
    type = PointValue
    point = '203 241.56 303.97'
    variable = permzz
  []
  [perm1_out]
    type = PointValue
    point = '406.25 263.468 300.923'
    variable =permzz 
  []
  [perm2_out]
    type = PointValue
    point = '351.25 257.54 326.493'
    variable =permzz
  []
  [perm3_out]
    type = PointValue
    point = '203 241.56 395.453'
    variable =permzz
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
  [mass_flux_src1]
      type = FunctionValuePostprocessor
      function = mass_flux_in1
      execute_on = 'initial timestep_end'
  []
  [mass_flux_src2]
    type = FunctionValuePostprocessor
    function = mass_flux_in2
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src3]
    type = FunctionValuePostprocessor
    function = mass_flux_in3
    execute_on = 'initial timestep_end'
  []
  # [permiadt]
  #   type = FunctionValuePostprocessor
  #   function = permz
  #   execute_on = 'initial timestep_end'
  # []
  [fluid_report]
    type = PorousFlowPlotQuantity
    uo = borehole_fluid_outflow_mass
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
    min_dt = 0.001
    interpolate = true
    growth_factor = 3
  []
[]

##############################################################
[Outputs]
  csv = true
  [exo]
    type = Exodus
    # sync_times = '1 2 3 4 5
    # 5.00E+04	1.00E+05	1.50E+05	2.00E+05	2.50E+05	3.00E+05
    # 3.50E+05	4.00E+05	4.50E+05	5.00E+05	5.50E+05	6.00E+05	6.50E+05
    # 7.00E+05	7.50E+05	8.00E+05	8.50E+05	9.00E+05	9.50E+05	1.00E+06
    # 1.05E+06	1.10E+06	1.15E+06	1.20E+06	1.25E+06	1.30E+06	1.35E+06
    # 1.40E+06	1.45E+06	1.50E+06	1.55E+06	1.60E+06	1.65E+06	1.70E+06
    # 1.75E+06	1.80E+06	1.85E+06	1.90E+06	1.95E+06	2.00E+06	2.05E+06
    # 2.10E+06	2.15E+06	2.20E+06	2.25E+06	2.30E+06	2.35E+06	2.40E+06
    # 2.45E+06	2.50E+06	2.55E+06	2.60E+06	2.65E+06	2.70E+06	2.75E+06
    # 2.80E+06	2.85E+06	2.90E+06	2.95E+06	3.00E+06	3.05E+06	3.10E+06
    # 3.15E+06	3.20E+06	3.25E+06	3.30E+06	3.35E+06	3.40E+06	3.45E+06
    # 3.50E+06	3.55E+06	3.60E+06	3.65E+06	3.70E+06	3.75E+06	3.80E+06
    # 3.85E+06	3.90E+06	3.95E+06	4.00E+06	4.05E+06	4.10E+06	4.15E+06
    # 4.20E+06	4.25E+06	4.30E+06	4.35E+06	4.40E+06	4.45E+06	4.50E+06
    # 4.55E+06	4.60E+06	4.65E+06	4.70E+06	4.75E+06	4.80E+06	4.85E+06
    # 4.90E+06	4.95E+06	5.00E+06	5.05E+06	5.10E+06	5.15E+06	5.20E+06
    # 5.25E+06	5.30E+06	5.35E+06	5.40E+06	5.45E+06	5.50E+06	5.55E+06
    # 5.60E+06	5.65E+06	5.70E+06	5.75E+06	5.80E+06	5.85E+06	5.90E+06
    # 5.95E+06	6.00E+06	6.05E+06	6.10E+06	6.15E+06	6.20E+06	6.25E+06
    # 6.30E+06	6.35E+06	6.40E+06	6.45E+06	6.50E+06	6.55E+06	6.60E+06
    # 6.65E+06	6.70E+06	6.75E+06	6.80E+06	6.85E+06	6.90E+06	6.95E+06
    # 7.00E+06	7.05E+06	7.10E+06	7.15E+06	7.20E+06	7.25E+06	7.30E+06
    # 7.35E+06	7.40E+06	7.45E+06	7.50E+06	7.55E+06	7.60E+06	7.65E+06
    # 7.70E+06	7.75E+06 8e6 9e6
    # 10e6 11e6 12e6 13e6 14e6 15e6 16e6 17e6 18e6 19e6
    # 20e6 21e6 22e6 23e6 24e6 25e6 26e6 27e6 28e6 29e6
    # 30e6 31e6 32e6 33e6 34e6 35e6 36e6 37e6 38e6 39e6
    # 40e6'
    # sync_only = true
  []
[]

# NOTE - following is useful for checking scaling
# NOTE [Debug]
# NOTE   show_var_residual_norms = true
# NOTE []
