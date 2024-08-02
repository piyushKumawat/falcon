# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
endTime = 20000  # 462 days
dt_max = 100 # NOTE, Lynn had 50000, but i want to check convergence for more agressive cases
dt_max2 = 100 # this is the timestep size after 90 days
# injection_temp = 323.15
injection_rate = 10 #kg/s

# NOTES FROM LYNN

# Step 2:  Run readWriteProps.i to read in upscaled permeabilities onto a
#          uniform mesh and output it an exodus file of it.
#
# seacas explore output
[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = 'forge123.xdr'
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

# [PorousFlowFullySaturated]
#   coupling_type = Hydro
#   porepressure = porepressure
#   dictator_name = dictator
#   fp = true_water
#   stabilization = full
# []

[FluidProperties]
  [the_simple_fluid]
    type = SimpleFluidProperties
    bulk_modulus = 2E8
    viscosity = 1.0E-3
    density0 = 850.0
  []

  # [true_water]
  #   type = Water97FluidProperties
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
    coupled_variables = 'porepressure'
    expression = 'porepressure-(1.6025e7-9810*(z-1150))'
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
[]

[DiracKernels]
  [source]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src
    point = '404.616 258.1823 221.3399'
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
  [mass_flux_src]
      type = FunctionValuePostprocessor
      function = mass_flux_in
      execute_on = 'initial timestep_end'
  []
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
    min_dt = 1
    interpolate = true
    growth_factor = 3
  []
[]