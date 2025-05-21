# created by write_diracs_input.py
[DiracKernels]
  [source_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_1
    point = '374.8019845734 260.0793490986 224.1035777104'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_1_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_1_1
    point = '319.7609007737 254.1471890778 249.6926619930'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_1_4_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_1_4
    point = '308.9456689926 252.9815564057 254.7207584344'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_2_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_2_1
    point = '287.1700531759 250.6346469945 264.8444338778'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_3_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_3_1
    point = '188.3086515666 239.9796668645 310.8059695788'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_4_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_4_1
    point = '141.9673955409 234.9851477284 332.3504273609'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_6_2_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_6_2
    point = '110.8073574546 231.6268139272 346.8370033110'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_7_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_7_1
    point = '77.7242685860 228.0612195821 362.2176224949'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_2_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_2
    point = '7.9018287875 220.5359701260 394.6786892741'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_1
    point = '-12.3288929929 218.3555646789 404.0841298832'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_2_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_2
    point = '-19.1303161523 217.6225280494 407.2461713702'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_3_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_3
    point = '-25.8098193692 216.9026315792 410.3515312030'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_4_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_4
    point = '-31.7620011861 216.2611235897 413.1187529157'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_5_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_5
    point = '-43.6984280427 214.9746519343 418.6681028154'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_6_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_6
    point = '-66.1462300074 212.5552963516 429.1042835150'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_10_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_10
    point = '-92.0366809207 209.7649025726 441.1409820101'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
[]
