# Units K,m,Pa,Kg,s

#FRACTURE PROPERTIES
# permeability fit y=a*exp(b*x) with a=k_inj
# k=(Transmsivity/element_length)*viscosity/(density*gravity)
# k = (Transmisivity/2)*1e-3/(1000*9.81)
# k=Transmisvity*5.09683996e-8


k_inj = 1e-13 # 0.5e-14
k_prod = 3e-15
phi_frac = 0.0033
# z-offset of production from injection point
offset = 100
r_prod = 10 # region around production well with low permeability (k_prod)


# NONLINEAR PART OF FRACTURE
# MECHANICS
rock_young = 5e10 # NOTE, a guess
rock_poisson = 0.3 # NOTE, a guess
three_s_over_a0 =  250 #1000 drops too fast
rock_gravitational_density = 0
[Postprocessors]
  [k_inj]
    type = ConstantPostprocessor
    value = ${k_inj}
  []
  [phi_frac]
    type = ConstantPostprocessor
    value = ${phi_frac}
  []
  [three_s_over_a0]
    type = ConstantPostprocessor
    value = ${three_s_over_a0}
  []
  [p1_vol_strain]
    type = PointValue
    point = '${p1inx} ${p1iny} ${fparse p1inz}'
    variable = lagged_vol_strain
  []
  [p1_lagged_perm]
    type = PointValue
    point = '${p1inx} ${p1iny} ${fparse p1inz}'
    variable = lagged_perm
  []
  [p1_lagged_poro]
    type = PointValue
    point = '${p1inx} ${p1iny} ${fparse p1inz}'
    variable = lagged_poro
  []
[]

#--------- Include everything in n with all simulations -------------
# mesh, reading initial conditions from mesh, sources, sinks, functiosn, postprocessors
!include CommonBlock_thm.i
[Preconditioning]
  active =hypre   #hypre #superlu
[]

######-------------- Initially scale fields -----------------#########
[AuxKernels]
  # [permeability_frac]
  #   type = ParsedAux
  #   variable = permeability
  #   expression = 'radiusZone2:=sqrt((x-${p1inx})^2+(y-${p1iny})^2+(z-${p1inz})^2)-${localFracRadius};
  #                if(radiusZone2<0,${a},${a}*exp(${b}*radiusZone2))'
  #   use_xyzt = true
  #   block = 'frac'
  #   execute_on = 'INITIAL'
  # []
  [permeability_frac]
    type = ParsedAux
    variable = permeability
    expression = 'r_prod:=sqrt((x-${p1inx})^2+(y-${p1iny})^2+(z-${p1inz}-100)^2)-${r_prod};
                 if(r_prod<0,${k_prod},${k_inj})'
    use_xyzt = true
    block = 'frac'
    execute_on = 'INITIAL'
  []

  [porosity_frac]
    type = ParsedAux
    variable = porosity
    expression = ${phi_frac}
    block = 'frac'
    execute_on = 'INITIAL'
  []
    [elem_length_min]
      type = ElementLengthAux
      variable = elem_length_min
      method = min
      execute_on = initial
    []
[]

[AuxVariables]
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
[]

[AuxKernels]
[lagged_perm]
  type = ParsedAux
  variable = lagged_perm
  coupled_variables = 'permeability crack_max_strain1'
  expression = 'permeability *(1 + ${three_s_over_a0} * max(0, crack_max_strain1))'
  execute_on = NONLINEAR
[]

# [lagged_perm]
#   type = ParsedAux
#   variable = lagged_perm
#   coupled_variables = 'permeability crack_max_strain1 elem_length_min'
#   expression = 'a:=(crack_max_strain1*elem_length_min); permeability + (*0.01)^2/12'
#   execute_on = TIMESTEP_END
# []

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

#----------------------------------------
[Variables]
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

[AuxVariables]
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
[]

[BCs]
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

[PorousFlowFullySaturated]
  coupling_type = HYDROMECHANICAL
  displacements = 'disp_x disp_y disp_z'
  porepressure = frac_P
  fp = the_simple_fluid
  pressure_unit = Pa
  stabilization = full
  biot_coefficient = 0.47
  use_displaced_mesh = false
  gravity = '0 0 -9.81'
  multiply_by_density = true
  dictator_name = dictator
[]

  # # from the mechanical coupling in PorousFlowFullySaturated
  # [./PorousFlowActionBase_VolumetricStrain]
  #   type = PorousFlowVolumetricStrain
  #   PorousFlowDictator = dictator
  #   displacements = 'disp_x disp_y disp_z'
  #   consistent_with_displaced_mesh = false
  # [../]
  # [./PorousFlowUnsaturated_EffStressCoupling0]
  #     type = PorousFlowEffectiveStressCoupling
  #     PorousFlowDictator = dictator
  #     biot_coefficient = 0.47
  #     component = 0
  #     variable = disp_x
  # [../]
  # [./PorousFlowUnsaturated_EffStressCoupling1]
  #     type = PorousFlowEffectiveStressCoupling
  #     PorousFlowDictator = dictator
  #     biot_coefficient = 0.47
  #     component = 1
  #     variable = disp_y
  # [../]
  # [./PorousFlowUnsaturated_EffStressCoupling2]
  #     type = PorousFlowEffectiveStressCoupling
  #     PorousFlowDictator = dictator
  #     biot_coefficient = 0.47
  #     component = 2
  #     variable = disp_z
  # [../]


[Materials]
  [porosity_frac]
    type = PorousFlowPorosityConst
    porosity = porosity #lagged_poro
    block = 'frac'
  []
  [permeability_frac]
    type = PorousFlowPermeabilityConstFromVar
    perm_xx = lagged_perm
    perm_yy = lagged_perm
    perm_zz = lagged_perm
    block = 'frac'
  []
  [permeability_matrix]
    type = PorousFlowPermeabilityConstFromVar
    perm_xx = lagged_perm
    perm_yy = lagged_perm
    perm_zz = lagged_perm
    block = 'matrix'
  []
  [porosity_matrix]
    type = PorousFlowPorosityConst
    porosity = porosity
    block = 'matrix'
  []

  [elasticity_fracture]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = ${rock_young}
    poissons_ratio = ${rock_poisson}
    block = 'frac'
    # elasticity_tensor_prefactor = ${frac_elastic_scale}
  []
  [elasticity_matrix]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = ${rock_young}
    poissons_ratio = ${rock_poisson}
    block = 'matrix'
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
    residual_stress = 0.05
  []

  [undrained_density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = ${rock_gravitational_density}
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
