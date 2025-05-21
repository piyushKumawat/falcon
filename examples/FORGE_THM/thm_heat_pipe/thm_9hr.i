######################################
#--------Geometric Parameters--------#
######################################

water_weight = 9300 #9300 = density(T=490K,P=23MPa) * gravity(9.8m/s2)

# these use the coordinate system from the Falcon DFN simulations
#surface in falcon dfn simulations
x_surf=-808.7301375
y_surf=156.2795117
z_surf=2800


# straight pipe 1 length, [l1]=[m]
l1 = 1935
# dipping pipe 2 length, [l2]=[m]; distance to middle of perfs in 16b
l2 = 1100


# pipe 2 dips at 25 degrees (0.436332 Radians) with respect to x-axis
cos_theta = '${fparse cos(0.436332)}'
# pipe 2 dips at 25 degrees (0.436332 Radians) with respect to x-axis
sin_theta = '${fparse sin(0.436332)}'
#inclined pipe orientation for going up the borehole from bottom to top
neg_ori = '${fparse -cos_theta} 0 ${fparse sin_theta}'

# inlet pipe 1, [p1] = [m]
p1 = '${x_surf} ${y_surf} ${z_surf}'
# outlet pipe 1/inlet pipe 2, [p2] = [m]
p2 = '${x_surf} ${y_surf} ${fparse z_surf-l1}'
# outlet pipe 2/inlet pipe 3, [p3] = [m]
p3 = '${fparse x_surf+l2*cos_theta} ${y_surf} ${fparse (z_surf-l1-l2*sin_theta)}'

# inner pipe radius, [Rpi] = [m]
Rpi = 0.09
# pipe-wall width, [wp] = [m]
wp = 0.00635
# cement width, [wc] = [m]
wc = 0.0051
# rock width, [wr] = [m]
wr = 49.95

# wetted area for the well pipes
Ap = '${fparse pi*Rpi^2}'
# wetted perimeter for the well pipes
P_hfp = '${fparse 2 * pi * Rpi}'
# hydraulic diameter for the well pipes
D_hp = '${fparse 4 * Ap/P_hfp}'

# number of elements for each pipe (~ one element at each 10 meters)
# to increase the number of elements in the entire pipe you can re-

n1 = 190
n2 = 32

pipes = 'pipe_1 pipe_2'
all = 'pipe_1 pipe_2'

######################################
#---------Physical Parameters--------#
######################################

# underground temperature, [Tun]=[K] for z=429m in this coordinate system
Tun = 479

######################################
#---------Material Properties--------#
######################################

# mild steel density, [rho_s]=[kg/m^3]
rho_s = 7850
# mild steel heat capacity, [cp_s]=[J/(kg.K)]
cp_s = 510.8
# mild steel thermal conductivity, [k_s]=[W/(m.K)]
k_s = 60
# cement density, [rho_c]=[kg/m^3]
rho_c = 2400
# cement heat capacity, [cp_c]=[J/(kg.K)]
cp_c = 920
# cement thermal conductivity, [k_c]=[W/(m.K)]
k_c = 0.29
# rock density, [rho_r]=[kg/m^3]
rho_r = 2750
# rock heat capacity, [cp_r]=[J/(kg.K)]
cp_r = 830
# rock thermal conductivity, [k_r]=[W/(m.K)]
k_r = 3

######################################
#----------Global Parameters---------#
######################################
[GlobalParams]
  rdg_slope_reconstruction = full
  closures = no_closures
  fp = fp
  f_D = f_D
  T = T
  T_wall = T_wall
  gravity_vector = '0 0 -9.81'
  # scaling_factor_1phase = '1 1e-3 1e-5'

  initial_p = initial_p_fn
  initial_T = temp_with_elevation
  initial_vel = 0.0
  initial_vel_x = 0.0
  initial_vel_y = 0.0
  initial_vel_z = 0.0
[]

######################################
#----------Fluid Properties----------#
######################################
[FluidProperties]
  [fp]
    type = IAPWS95LiquidFluidProperties
  []
[]

######################################
#--------------Materials-------------#
######################################
[Materials]
  #----------Friction factor----------#
  [f_pipe]
    type = ADWallFrictionChurchillMaterial
    block = ${pipes}
    mu = mu
    rho = rho
    vel = vel
    D_h = ${D_hp}
  []
  #----------Heat conductance---------#
  [Hw_pipe]
    type = ADWallHeatTransferCoefficient3EqnDittusBoelterMaterial
    block = ${pipes}
    rho = rho
    cp = cp
    mu = mu
    k = k
    vel = vel
    D_h = ${D_hp}
  []
  [mass_flow_rate]
    type = ADParsedMaterial
    property_name = mass_flow_rate
    coupled_variables = A
    material_property_names = 'rho vel'
    expression = 'vel*rho*A'
    # outputs = exodus
    block = ${all}
  []
[]

######################################
#------Heat Structure Materials------#
######################################
[HeatStructureMaterials]
  #-----------Pipe material-----------#
  [mild_steel]
    type = SolidMaterialProperties
    rho = ${rho_s}
    k = ${k_s}
    cp = ${cp_s}
  []
  #-------Cement around the pipe------#
  [cement]
    type = SolidMaterialProperties
    rho = ${rho_c}
    k = ${k_c}
    cp = ${cp_c}
  []
  #--------Rock around the well-------#
  [rock]
    type = SolidMaterialProperties
    rho = ${rho_r}
    k = ${k_r}
    cp = ${cp_r}
  []
[]

######################################
#--------------Closures--------------#
######################################
[Closures]
  [no_closures]
    type = Closures1PhaseNone
  []
[]

######################################
#--------------Functions-------------#
######################################
[Functions]
  [temp_injection]
      type = PiecewiseLinear
      x_index_in_file=0
      y_index_in_file = 3
      xy_in_file_only = false
      data_file = 2dFrac_10zone_9hr_5m_fracInj_9hr.csv
      format = columns
  []
  #---temperature as a function of Z--#
  [temp_with_elevation]
    type = ParsedFunction
    expression = '410-0.073333*(z-1150)' #'426.67-0.0733333*(z-1150)'
  []
  #----pressure as a function of Z----#
  [initial_p_fn]
    type = ParsedFunction
    expression = '1.6025e7-${water_weight}*(z-1150)'
  []
  #-Mass flow rate as a function of t-#
  [mdot]
    type = PiecewiseLinear
    x_index_in_file=0
    y_index_in_file = 2
    xy_in_file_only = false
    data_file = 2dFrac_10zone_9hr_5m_fracInj_9hr.csv
    format = columns
  []
  #---Total mass entering the pipe----#
  [m_in_pp]
    type = ParsedFunction
    expression = 'dt * mdot'
    symbol_names = 'dt mdot'
    symbol_values = 'dt m_dot_in'
  []
  [m_in]
    type = ParsedFunction
    expression = 'if(m_in_pp<0,0,m_in_pp)'
    symbol_names = 'm_in_pp'
    symbol_values = 'm_in_pp'
  []
  #----Total mass leaving the pipe----#
  [m_dot_out_1_func]
    type = ParsedFunction
    expression = 'dt * mdot'
    symbol_names = 'dt mdot'
    symbol_values = 'dt m_dot_out_1'
  []
  [m_out_surface_func]
    type = ParsedFunction
    expression = 'if(t<10,0,if(mout<0,0,mout))'
    symbol_names = 'mout'
    symbol_values = 'm_dot_out_1_func'
  []
[]

######################################
#----------Pipe Components----------#
######################################
[Components]
  #---------------Pipe 1--------------#
  #    Vertical pipe from p2 to p1    #
  #-----------------------------------#
  [pipe_1]
    type = FlowChannel1Phase
    position = ${p2}
    orientation = '0 0 1'
    length = ${l1}
    n_elems = ${n1}
    A = ${Ap}
  []
  [pipe_1_hs]
    type = HeatStructureCylindrical
    position = ${p2}
    orientation = '0 0 1'
    length = ${l1}
    n_elems = ${n1}
    names = 'steel cement rock'
    materials = 'mild_steel cement rock'
    widths = '${wp} ${wc} ${wr}'
    n_part_elems = '5 5 10'
    offset_mesh_by_inner_radius = true
    inner_radius = ${Rpi}
  []
  #---------------Pipe 2--------------#
  #   Inclined pipe from p3 to p2     #
  #-----------------------------------#
  [pipe_2]
    type = FlowChannel1Phase
    position = ${p3}
    orientation = ${neg_ori}
    length = ${l2}
    n_elems = ${n2}
    A = ${Ap}
  []
  [pipe_2_hs]
    type = HeatStructureCylindrical
    position = ${p3}
    orientation = ${neg_ori}
    length = ${l2}
    n_elems = ${n2}
    names = 'steel cement rock'
    materials = 'mild_steel cement rock'
    widths = '${wp} ${wc} ${wr}'
    n_part_elems = '5 5 10'
    offset_mesh_by_inner_radius = true
    inner_radius = ${Rpi}
  []

  #-------------Junction 1------------#
  #        Connect pipe 1 to 2        #
  #-----------------------------------#
  [junction_1]
    type = VolumeJunction1Phase
    connections = 'pipe_2:out pipe_1:in'
    position = ${p2}
    volume = 0.01832
  []

  #--------------Pipe BCs-------------#
  [inlet]
    type = InletMassFlowRateTemperature1Phase
    input = 'pipe_2:in'
    m_dot = 10
    T = ${Tun}
    reversible = false
  []
  [outlet]
    type = Outlet1Phase
    input = 'pipe_1:out'
    p = 2e6 #fixme outlet pressure at surface
  []

  #---------Heat Structure BCs--------#
  [pipe_1_BC]
    type = HSBoundarySpecifiedTemperature
    hs = pipe_1_hs
    boundary = pipe_1_hs:outer
    T = temp_with_elevation
  []
  [pipe_2_BC]
    type = HSBoundarySpecifiedTemperature
    hs = pipe_2_hs
    boundary = pipe_2_hs:outer
    T = temp_with_elevation
  []

  #----Heat Structure Heat Transfer---#
  [pipe_1_ht]
    type = HeatTransferFromHeatStructure1Phase
    flow_channel = 'pipe_1'
    hs = 'pipe_1_hs'
    hs_side = INNER
  []
  [pipe_2_ht]
    type = HeatTransferFromHeatStructure1Phase
    flow_channel = 'pipe_2'
    hs = 'pipe_2_hs'
    hs_side = INNER
  []
[]

######################################
#------------Executioner-------------#
######################################
[Preconditioning]
  [pc]
    type = SMP
    full = true
  []
[]
[Executioner]
  type = Transient
  start_time = 0
  end_time = 32400
  dtmin = 1e-3
  dtmax = 200

  line_search = basic
  solve_type = Newton
  scheme = 'bdf2'
  l_max_its = 200
  nl_rel_tol = 1e-4
  nl_abs_tol = 1e-6
  nl_max_its = 20
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu mumps'
  # fixed_point_max_its = 10
  # accept_on_max_fixed_point_iteration = true

  [TimeStepper]
    type = IterationAdaptiveDT
    dt = 1e-3
    optimal_iterations = 10
  []
  # automatic_scaling = true
  # off_diagonals_in_auto_scaling = true
  # compute_scaling_once = false #true

  # resid_vs_jac_scaling_param = 0.5
[]

######################################
#------------Control Logic-----------#
######################################

[ControlLogic]
  [set_inlet_value_mdot_ctrl]
    type = SetComponentRealValueControl
    component = inlet
    parameter = m_dot
    value = m_inlet_ctrl:value
  []
  [m_inlet_ctrl]
    type = GetFunctionValueControl
    function = mdot
  []
  [set_inlet_value_T_ctrl]
    type = SetComponentRealValueControl
    component = inlet
    parameter = T
    value = T_inlet_ctrl:value
  []
  [T_inlet_ctrl] #fixme this should come from simulation
    type = GetFunctionValueControl
    function = temp_injection
  []
[]

# ######################################
# #------------Postprocessors----------#
# ######################################
[Postprocessors]

  # mass flow rate in
  [m_dot_in]
    type = ADFlowBoundaryFlux1Phase
    boundary = 'inlet'
    equation = mass
  []
  # mass flow rate out
  [m_dot_out_1]
    type = ADFlowBoundaryFlux1Phase
    boundary = 'outlet'
    equation = mass
  []
  [surface_out_temp]
    type = SideAverageValue
    variable = T
    boundary = 'outlet'
  []
  [dt]
    type = TimestepSize
  []
  [pressure_surface]
    type = FunctionValuePostprocessor
    function = initial_p_fn
    point = ${p1}
  []
[]

######################################
#---------------Outputs--------------#
######################################

[Outputs]
  csv = true
  exodus = true
  [console]
    type = Console
    show = 'm_dot_in m_dot_out_1'
  []
[]
