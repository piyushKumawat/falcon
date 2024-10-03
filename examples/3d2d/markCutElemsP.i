refinement_level = 3


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
    mesh_file = 3frac_inc.e
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
  solve = false
[]

[Executioner]
  type = Transient #Steady
  solve_type = LINEAR
  num_steps = 10
[]


[Outputs]
  # csv = true
  [exo]
    file_base = 'marker_r_0.2${refinement_level}/result_mark'
    type = Exodus
  []
  [xdr]
    file_base = 'marker_r_0.2${refinement_level}/result_mark'
    type = XDR
  []
[]
