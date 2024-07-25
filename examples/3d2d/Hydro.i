# Units K,m,Pa,Kg,s
# Cold water injection into one side of the fracture network, and production from the other side
frac_permeability = 1e-12
endTime = 40e6  # 462 days
dt_max = 10000 # NOTE, Lynn had 50000, but i want to check convergence for more agressive cases
dt_max2 = 50000 # this is the timestep size after 90 days
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
  coupling_type = Hydro
  porepressure = porepressure
  dictator_name = dictator
  fp = true_water
  stabilization = full
[]
[FluidProperties]
  [true_water]
    type = Water97FluidProperties
  []
  [tabulated_water]
    type = TabulatedFluidProperties
    fp = true_water
    fluid_property_file = tabulated_fluid_properties_v2.csv
  []
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
    type = PorousFlowPermeabilityConst
    block = 1
    permeability = '${frac_permeability} 0 0 0 ${frac_permeability} 0 0 0 ${frac_permeability}'
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
    variable = porepressure 
  []
  [p_out1]
    type = PointValue
    point = '3.879982e+02 2.567783e+02 3.034653e+02'
    variable = porepressure 
  []
  [p_out2]
    type = PointValue
    point = '3.775368e+02 2.558945e+02 3.079509e+02'
    variable = porepressure
  []
  [p_out3]
    type = PointValue
    point = '3.250460e+02 2.514597e+02 3.304578e+02'
    variable = porepressure
  []
  [p_out4]
    type = PointValue
    point = '2.023419e+02 2.410930e+02 3.830706e+02'
    variable = porepressure
  []
  [pmin_ts]
    type = Extremum
    variable = porepressure
    vtp_output = true
  []
  [output_mass]
    type = PorousFlowQuantity
    variable = porepressure
    SumQuantityUO = borehole_fluid_outflow_mass
  []
[]
[Executioner]
  type = Transient
  start_time = 0.0
  end_time = '${endTime}'
  solve_type = PJFNK
  automatic_scaling = true
  l_max_its = 50
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_ilu_levels'
  petsc_options_value = '30             ilu     20'

  [TimeStepper]
    type = FunctionDT
    dt = dts
  []
[]
[Outputs]
  exodus = true
  perf_graph = true
  csv = true
  #max_output_frequency = 5000
[]
