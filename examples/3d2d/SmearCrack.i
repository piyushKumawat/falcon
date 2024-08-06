# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
endTime = 200000  
dt_max = 100 
dt_max2 = 100 # this is the timestep size after 90 days
injection_rate = 15 #kg/s

#FRACTURE PROPERTIES
# permeability fit y=a*exp(b*x) with a=k_inj
# k=(Transmsivity/element_length)*viscosity/(density*gravity)
# k = (Transmisivity/2)*1e-3/(1000*9.81)
# k=Transmisvity*5.09683996e-8
ic_frac_perm=1e-14
ic_matrix_perm=1e-16
ic_frac_poro=0.0033
ic_matrix_poro=0.001

# NONLINEAR PART OF FRACTURE
# MECHANICS
rock_young = 5e10 # NOTE, a guess
rock_poisson = 0.3 # NOTE, a guess
three_s_over_a0 =  250 #1000 drops too fast
rock_gravitational_density = 0

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

[PorousFlowFullySaturated]
    coupling_type = HYDROMECHANICAL
    displacements = 'disp_x disp_y disp_z'
    porepressure = porepressure
    fp = the_simple_fluid
    pressure_unit = Pa
    stabilization = full
    biot_coefficient = 0.47
    use_displaced_mesh = false
    gravity = '0 0 -9.81'
    multiply_by_density = true
    dictator_name = dictator
[]

##############################################################
[Variables]
    [porepressure]
    []
    [disp_x]
      order = FIRST
      family = LAGRANGE
      # initial_from_file_var = disp_x
      # initial_from_file_timestep = 'LATEST'
      scaling = 1E-6
    []
    [disp_y]
      order = FIRST
      family = LAGRANGE
      # initial_from_file_var = disp_y
      # initial_from_file_timestep = 'LATEST'
      scaling = 1E-6
    []
    [disp_z]
      order = FIRST
      family = LAGRANGE
      # initial_from_file_var = disp_z
      # initial_from_file_timestep = 'LATEST'
      scaling = 1E-6
    []
[]

[ICs]
  [P]
    type = FunctionIC
    function = insitu_pp
    variable = porepressure
  []
  [ic_frac_perm]
    type = ConstantIC
    variable = permeability
    value = ${ic_frac_perm}
    block = '1'
  []
  [ic_matrix_perm]
    type = ConstantIC
    variable = permeability
    value = ${ic_matrix_perm}
    block = '0'
  []
  [ic_frac_poro]
    type = ConstantIC
    variable = porosity
    value = ${ic_frac_poro}
    block = '1'
  []
  [ic_matrix_poro]
    type = ConstantIC
    variable = porosity
    value = ${ic_matrix_poro}
    block = '0'
  []
[]


[Materials]
  [porosity_frac]
    type = PorousFlowPorosityConst
    porosity = porosity #lagged_poro
    block = '1'
  []
  [permeability_frac]
    type = PorousFlowPermeabilityConstFromVar
    perm_xx = lagged_perm
    perm_yy = lagged_perm
    perm_zz = lagged_perm
    block = '1'
  []
  [permeability_matrix]
    type = PorousFlowPermeabilityConstFromVar
    perm_xx = lagged_perm
    perm_yy = lagged_perm
    perm_zz = lagged_perm
    block = '0'
  []
  [porosity_matrix]
    type = PorousFlowPorosityConst
    porosity = porosity
    block = '0'
  []
  [elasticity_fracture]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = ${rock_young}
    poissons_ratio = ${rock_poisson}
    block = '1'
    # elasticity_tensor_prefactor = ${frac_elastic_scale}
  []
  [elasticity_matrix]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = ${rock_young}
    poissons_ratio = ${rock_poisson}
    block = '0'
  []  
  [strain]
    type = ComputeIncrementalSmallStrain
    displacements = 'disp_x disp_y disp_z'
  []
  [elastic_stress]
    type = ComputeSmearedCrackingStress
    cracking_stress = 1.2e7 
    softening_models = abrupt_softening
    max_stress_correction = 0
    shear_retention_factor = 0.1
    cracked_elasticity_type = FULL
    output_properties = true
    perform_finite_strain_rotations=false
  []
  [abrupt_softening]
    type = AbruptSoftening
    residual_stress = 0.05 #increase (check units)
  []
  [undrained_density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = ${rock_gravitational_density}
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
  [elem_length_min]
    order = CONSTANT
    family = MONOMIAL
  []
  [aperture]
    order = CONSTANT
    family = MONOMIAL
  []
  [lagged_perm]
    order = CONSTANT
    family = MONOMIAL
  []
  [lagged_poro]
    order = CONSTANT
    family = MONOMIAL
  []
  [permeability]
    order = CONSTANT
    family = MONOMIAL
  []
  [porosity]
    order = CONSTANT
    family = MONOMIAL
  []
  [lagged_vol_strain]
    order = CONSTANT
    family = MONOMIAL
  []
  [vonmises]
    order = CONSTANT
    family = MONOMIAL
  []
  [maxPrinc]
    order = CONSTANT
    family = MONOMIAL
  []
  [maxShear]
    order = CONSTANT
    family = MONOMIAL
  []
  [./crack_damage1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./crack_damage2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./crack_damage3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./crack_max_strain1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./crack_max_strain2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./crack_max_strain3]
    order = CONSTANT
    family = MONOMIAL
  [../]
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
  [elem_length_min]
    type = ElementLengthAux
    variable = elem_length_min
    method = min
    execute_on = initial
  []
  [lagged_vol_strain]
    type = RankTwoScalarAux
    variable = lagged_vol_strain
    rank_two_tensor = total_strain
    scalar_type = VolumetricStrain
    execute_on = timestep_end
  []
  [vonmises]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = vonmises
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [maxPrinc]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = maxPrinc
    scalar_type = MaxPrincipal
    execute_on = timestep_end
  []
  [maxShear]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = maxShear
    scalar_type = MaxShear
    execute_on = timestep_end
  []
  [./crack_damage1]
    type = MaterialRealVectorValueAux
    property = crack_damage
    variable = crack_damage1
    component = 0
  [../]
  [./crack_damage2]
    type = MaterialRealVectorValueAux
    property = crack_damage
    variable = crack_damage2
    component = 1
  [../]
  [./crack_damage3]
    type = MaterialRealVectorValueAux
    property = crack_damage
    variable = crack_damage3
    component = 2
  [../]
  [./crack_strain1]
    type = MaterialRealVectorValueAux
    property = crack_max_strain
    variable = crack_max_strain1
    component = 0
  [../]
  [./crack_strain2]
    type = MaterialRealVectorValueAux
    property = crack_max_strain
    variable = crack_max_strain2
    component = 1
  [../]
  [./crack_strain3]
    type = MaterialRealVectorValueAux
    property = crack_max_strain
    variable = crack_max_strain3
    component = 2
  [../]
  [lagged_perm]
    type = ParsedAux
    variable = lagged_perm
    coupled_variables = 'permeability crack_max_strain1'
    expression = 'permeability *(1 + ${three_s_over_a0} * max(0, crack_max_strain1)* max(0, crack_max_strain1))'
    execute_on = NONLINEAR
  []  
#   [lagged_perm]
#     type = ParsedAux
#     variable = lagged_perm
#     coupled_variables = 'permeability crack_max_strain1 elem_length_min'
#     expression = 'a:=(crack_max_strain1*elem_length_min); permeability + (*0.01)^2/12'
#     execute_on = TIMESTEP_END
#   []
  [aperture]
    type = ParsedAux
    variable = aperture
    coupled_variables = 'crack_max_strain1 elem_length_min'
    expression = '(crack_max_strain1*elem_length_min)'
    execute_on = TIMESTEP_END
  []
  [lagged_poro]
    type = ParsedAux
    variable = lagged_poro
    coupled_variables = 'porosity lagged_vol_strain'
    expression = 'porosity * (1 + max(0, lagged_vol_strain))'
    execute_on = NONLINEAR
  []
[]
    

##############################################################
[BCs]
# NOTE: these BCs prevent water from exiting or entering the model
# from its sides, while providing water from the model top and bottom
# boundaries to ensure those boundaries remain at insitu pressure
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

  [roller_top_and_bottom]
    type = DirichletBC
    boundary = 'front back'
    variable = disp_z
    value = 0
  []
  [roller_sides_x]
    type = DirichletBC
    boundary = 'right left'
    variable = disp_x
    value = 0
  []
  [roller_sides_y]
    type = DirichletBC
    boundary = 'top bottom'
    variable = disp_y
    value = 0
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
#   [asm_ilu] #uses less memory
#     type = SMP
#     full = true
#     petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
#     petsc_options_iname = '-ksp_type -ksp_grmres_restart -pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
#     petsc_options_value = 'gmres 30 asm ilu NONZERO 2'
#   []
#   [asm_lu] #uses less memory
#     type = SMP
#     full = true
#     petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
#     petsc_options_iname = '-ksp_type -ksp_grmres_restart -pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
#     petsc_options_value = 'gmres 30 asm lu NONZERO 2'
#   []
#   [superlu]
#     type = SMP
#     full = true
#     petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
#     petsc_options_iname = '-ksp_type -pc_type -pc_factor_mat_solver_package'
#     petsc_options_value = 'gmres lu superlu_dist'
#   []
#   [preferred]
#     type = SMP
#     full = true
#     petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
#     petsc_options_value = ' lu       mumps'
#   []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = ${endTime}
  dt = 1
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
    min_dt = 0.0001
    interpolate = true
    growth_factor = 3 #changed from 3
  []
[]

# Units K,m,Pa,Kg,s


[Postprocessors]
  [three_s_over_a0]
    type = ConstantPostprocessor
    value = ${three_s_over_a0}
  []
  [p1_vol_strain]
    type = PointValue
    point = '404.616 258.1823 221.3399'
    variable = lagged_vol_strain
  []
  [p1_lagged_perm]
    type = PointValue
    point = '404.616 258.1823 221.3399'
    variable = lagged_perm
  []
  [p1_lagged_poro]
    type = PointValue
    point = '404.616 258.1823 221.3399'
    variable = lagged_poro
  []
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



[Outputs]
  csv = true
  exodus=true
  # [exo_out]
  #   type=Exodus
  #   sync_times = '0 1 3600 27730 31356 34860 100000'
  #   sync_only = true
  # []
[]


