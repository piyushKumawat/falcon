####### INJECTION RATES AND POSTPROCESSORS
# created by write_diracs_input.py

inj_ratio_stage_1 = 0.051
inj_ratio_stage_1_1 = 0.051
inj_ratio_stage_1_4 = 0.051
inj_ratio_stage_2_1 = 0.051
inj_ratio_stage_3_1 = 0.051
inj_ratio_stage_4_1 = 0.051
inj_ratio_stage_6_2 = 0.0
inj_ratio_stage_7_1 = 0.0
inj_ratio_stage_8_2 = 0.261
inj_ratio_stage_9_1 = 0.031
inj_ratio_stage_9_2 = 0.01
inj_ratio_stage_9_3 = 0.05
inj_ratio_stage_9_4 = 0.045
inj_ratio_stage_9_5 = 0.025
inj_ratio_stage_9_6 = 0.014
inj_ratio_stage_10 = 0.258

[Postprocessors]
  [mass_flux_src_stage_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_1_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_1_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_1_4]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_1_4}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_2_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_2_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_3_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_3_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_4_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_4_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_6_2]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_6_2}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_7_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_7_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_2]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_2}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_9_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_9_2]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_2}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_9_3]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_3}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_9_4]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_4}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_9_5]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_5}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_9_6]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_6}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_10]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_10}
    execute_on = 'initial timestep_end'
  []
[]