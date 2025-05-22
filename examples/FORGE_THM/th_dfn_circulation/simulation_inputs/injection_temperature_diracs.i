# created by write_diracs_input.py
[DiracKernels]
  [source_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_1
    point = '353.5111224981 257.7846849660 234.0018868730'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_2_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_2
    point = '303.5317107184 252.3980565069 257.2377552851'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_3_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_3
    point = '181.6170835199 239.2584700838 313.9169384571'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_4_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_4
    point = '165.5465189959 237.5264336884 321.3882853436'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_5_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_5
    point = '151.6925840461 236.0332988632 327.8291016321'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_6_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_6_1
    point = '136.9800917750 234.4476313503 334.6690687756'
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
    point = '134.0844260657 234.1355453381 336.0152892490'
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
    point = '118.3182615910 232.4363162510 343.3451178735'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_7_2_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_7_2
    point = '105.0184840034 231.0029068149 349.5283015271'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_7_3_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_7_3
    point = '90.6103917408 229.4500466059 356.2267504276'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_1_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_1
    point = '67.8626171948 226.9983608939 366.8023910204'
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
    point = '60.9356497397 226.2517934834 370.0227991555'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_3_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_3
    point = '54.0086822932 225.5052260739 373.2432072865'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_4_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_4
    point = '47.0817148282 224.7586586624 376.4636154262'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_5_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_5
    point = '40.1547473731 224.0120912519 379.6840235613'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_6_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_6
    point = '33.2277799180 223.2655238414 382.9044316963'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_7_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_7
    point = '26.3008124530 222.5189564299 386.1248398360'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_8_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_8
    point = '19.3738449979 221.7723890194 389.3452479711'
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
    point = '4.1345165890 220.1299407155 396.4301458718'
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
    point = '-1.4070573753 219.5326867871 399.0064723800'
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
    point = '-8.3340248344 218.7861193762 402.2268805169'
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
    point = '-15.2609922875 218.0395519660 405.4472886511'
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
    point = '-22.1879597525 217.2929845544 408.6676967907'
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
    point = '-29.1149272076 216.5464171439 411.8881049258'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_7_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_7
    point = '-36.0418946627 215.7998497335 415.1085130609'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_9_8_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_9_8
    point = '-42.9688621277 215.0532823219 418.3289212006'
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
    point = '-56.9749970273 213.5437438507 424.8404965853'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
[]
