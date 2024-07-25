refinement_level = 7

#-------------------Regular mesh limits
# Mesh Limits:
# Min X = -2.058283636E+02, Max X =  4.811977137E+02, Range =  6.870260773E+02
# Min Y = -3.379717494E+02, Max Y =  7.568266152E+02, Range =  1.094798365E+03
# Min Z = -1.759243478E+01, Max Z =  8.907733835E+02, Range =  9.083658183E+02
# [Mesh]
#   [gen]
#     type = GeneratedMeshGenerator
#     dim = 3
#     nx = 88
#     ny = 128
#     nz = 104
#     xmin = -400
#     xmax = 700
#     ymin = -600
#     ymax = 1000
#     zmin = -200
#     zmax = 1100
#     elem_type = HEX8
#   []
#   [dummy]
#     type = SubdomainBoundingBoxGenerator
#     input = 'gen'
#     block_id = 100
#     block_name = 'inner_frac'
#     bottom_left = '-210 -340 -20'
#     top_right = '490 760 900'
#     location = inside
#   []
# []
#----------------------------------

#-------------------Big mesh limits
# Mesh Limits:
# Min X = -1.100000000E+03, Max X =  1.100000000E+03, Range =  2.200000000E+03
# Min Y = -1.000000000E+03, Max Y =  1.400000000E+03, Range =  2.400000000E+03
# Min Z = -5.000000000E+02, Max Z =  1.400000000E+03, Range =  1.900000000E+03
[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 22
    ny = 24
    nz = 19
    xmin = -1100
    xmax = 1100
    ymin = -1000
    ymax = 1400
    zmin = -500
    zmax = 1400
    elem_type = HEX8
  []
  [dummy]
    type = SubdomainBoundingBoxGenerator
    input = 'gen'
    block_id = 100
    block_name = 'inner_frac'
    bottom_left = '-210 -340 -20'
    top_right = '490 760 900'
    location = inside
  []
[]
#----------------------------------

[Problem]
  solve = False
[]

[AuxVariables]
  [c]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[AuxKernels]
  [ls]
    type = MarkCutElems
    mesh_file = frac_planes_python.e
    variable = c
    block = 100
  []
[]

[Adaptivity]
  marker = marker_c
  initial_marker = marker_c
  max_h_level = ${refinement_level}
  stop_time = 10
  [Markers]
    [marker_c]
      type = ValueThresholdMarker
      coarsen = 0.01
      variable = c
      refine = 0.1
    []
  []
[]

[UserObjects]
  [DFN]
    type = CoupledVarThresholdElementSubdomainModifier
    coupled_var = 'c'
    criterion_type = ABOVE
    threshold = 0.9
    subdomain_id = 100
    complement_subdomain_id = 0
  []
[]

[Executioner]
  type = Transient #Steady
  solve_type = LINEAR
  num_steps = 10
[]

# [AuxVariables]
#   [pid]
#     family = MONOMIAL
#     order = CONSTANT
#   []
#   [npid]
#     family = Lagrange
#     order = first
#   []
# []

# [AuxKernels]
#   [pid_aux]
#     type = ProcessorIDAux
#     variable = pid
#     execute_on = 'INITIAL'
#   []
#   [npid_aux]
#     type = ProcessorIDAux
#     variable = npid
#     execute_on = 'INITIAL'
#   []
# []

[Outputs]
  # csv = true
  [exo]
    file_base = 'marker_r${refinement_level}/result_mark'
    type = Exodus
  []
  [xdr]
    file_base = 'marker_r${refinement_level}/result_mark'
    type = XDR
  []
[]
