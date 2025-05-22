####### INJECTION RATES AND POSTPROCESSORS
# created by write_diracs_input.py

inj_ratio_stage_1 = 0.037
inj_ratio_stage_2 = 0.037
inj_ratio_stage_3 = 0.037
inj_ratio_stage_4 = 0.037
inj_ratio_stage_5 = 0.037
inj_ratio_stage_6_1 = 0.037
inj_ratio_stage_6_2 = 0.037
inj_ratio_stage_7_1 = 0.037
inj_ratio_stage_7_2 = 0.037
inj_ratio_stage_7_3 = 0.037
inj_ratio_stage_8_1 = 0.037
inj_ratio_stage_8_2 = 0.037
inj_ratio_stage_8_3 = 0.037
inj_ratio_stage_8_4 = 0.037
inj_ratio_stage_8_5 = 0.037
inj_ratio_stage_8_6 = 0.037
inj_ratio_stage_8_7 = 0.037
inj_ratio_stage_8_8 = 0.037
inj_ratio_stage_9_1 = 0.037
inj_ratio_stage_9_2 = 0.037
inj_ratio_stage_9_3 = 0.037
inj_ratio_stage_9_4 = 0.037
inj_ratio_stage_9_5 = 0.037
inj_ratio_stage_9_6 = 0.037
inj_ratio_stage_9_7 = 0.037
inj_ratio_stage_9_8 = 0.037
inj_ratio_stage_10 = 0.037

[Postprocessors]
  [mass_flux_src_stage_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_2]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_2}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_3]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_3}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_4]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_4}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_5]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_5}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_6_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_6_1}
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
  [mass_flux_src_stage_7_2]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_7_2}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_7_3]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_7_3}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_1]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_1}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_2]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_2}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_3]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_3}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_4]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_4}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_5]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_5}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_6]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_6}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_7]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_7}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_8_8]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_8_8}
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
  [mass_flux_src_stage_9_7]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_7}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_9_8]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_9_8}
    execute_on = 'initial timestep_end'
  []
  [mass_flux_src_stage_10]
    type = FunctionValuePostprocessor
    function = mass_flux_src
    scale_factor = ${inj_ratio_stage_10}
    execute_on = 'initial timestep_end'
  []
[]