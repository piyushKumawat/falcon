# created by write_frac_materials_input.py
# DFN from fname 
all_frac_ids = "fracture1 fracture2 fracture3 fracture4 fracture5 fracture6 fracture7 fracture8 fracture9 fracture10 fracture11 fracture12 fracture13 fracture14 fracture15 fracture16 fracture17 fracture18 fracture19 fracture20 fracture21 fracture22 fracture23 fracture24 fracture25 fracture26 fracture27 fracture28 fracture29 fracture30 fracture31 fracture32 fracture33 fracture34 fracture35 fracture36 fracture37 fracture38 fracture39 fracture40 fracture41 fracture42 fracture43 fracture44 fracture45 fracture46 fracture47 fracture48 fracture49 "

poro_fracture1 = ${frac_poro}
poro_fracture2 = ${frac_poro}
poro_fracture3 = ${frac_poro}
poro_fracture4 = ${frac_poro}
poro_fracture5 = ${frac_poro}
poro_fracture6 = ${frac_poro}
poro_fracture7 = ${frac_poro}
poro_fracture8 = ${frac_poro}
poro_fracture9 = ${frac_poro}
poro_fracture10 = ${frac_poro}
poro_fracture11 = ${frac_poro}
poro_fracture12 = ${frac_poro}
poro_fracture13 = ${frac_poro}
poro_fracture14 = ${frac_poro}
poro_fracture15 = ${frac_poro}
poro_fracture16 = ${frac_poro}
poro_fracture17 = ${frac_poro}
poro_fracture18 = ${frac_poro}
poro_fracture19 = ${frac_poro}
poro_fracture20 = ${frac_poro}
poro_fracture21 = ${frac_poro}
poro_fracture22 = ${frac_poro}
poro_fracture23 = ${frac_poro}
poro_fracture24 = ${frac_poro}
poro_fracture25 = ${frac_poro}
poro_fracture26 = ${frac_poro}
poro_fracture27 = ${frac_poro}
poro_fracture28 = ${frac_poro}
poro_fracture29 = ${frac_poro}
poro_fracture30 = ${frac_poro}
poro_fracture31 = ${frac_poro}
poro_fracture32 = ${frac_poro}
poro_fracture33 = ${frac_poro}
poro_fracture34 = ${frac_poro}
poro_fracture35 = ${frac_poro}
poro_fracture36 = ${frac_poro}
poro_fracture37 = ${frac_poro}
poro_fracture38 = ${frac_poro}
poro_fracture39 = ${frac_poro}
poro_fracture40 = ${frac_poro}
poro_fracture41 = ${frac_poro}
poro_fracture42 = ${frac_poro}
poro_fracture43 = ${frac_poro}
poro_fracture44 = ${frac_poro}
poro_fracture45 = ${frac_poro}
poro_fracture46 = ${frac_poro}
poro_fracture47 = ${frac_poro}
poro_fracture48 = ${frac_poro}
poro_fracture49 = ${frac_poro}

perm_fracture1 = ${frac_perm}
perm_fracture2 = ${frac_perm}
perm_fracture3 = ${frac_perm}
perm_fracture4 = ${frac_perm}
perm_fracture5 = ${frac_perm}
perm_fracture6 = ${frac_perm}
perm_fracture7 = ${frac_perm}
perm_fracture8 = ${frac_perm}
perm_fracture9 = ${frac_perm}
perm_fracture10 = ${frac_perm}
perm_fracture11 = ${frac_perm}
perm_fracture12 = ${frac_perm}
perm_fracture13 = ${frac_perm}
perm_fracture14 = ${frac_perm}
perm_fracture15 = ${frac_perm}
perm_fracture16 = ${frac_perm}
perm_fracture17 = ${frac_perm}
perm_fracture18 = ${frac_perm}
perm_fracture19 = ${frac_perm}
perm_fracture20 = ${frac_perm}
perm_fracture21 = ${frac_perm}
perm_fracture22 = ${frac_perm}
perm_fracture23 = ${frac_perm}
perm_fracture24 = ${frac_perm}
perm_fracture25 = ${frac_perm}
perm_fracture26 = ${frac_perm}
perm_fracture27 = ${frac_perm}
perm_fracture28 = ${frac_perm}
perm_fracture29 = ${frac_perm}
perm_fracture30 = ${frac_perm}
perm_fracture31 = ${frac_perm}
perm_fracture32 = ${frac_perm}
perm_fracture33 = ${frac_perm}
perm_fracture34 = ${frac_perm}
perm_fracture35 = ${frac_perm}
perm_fracture36 = ${frac_perm}
perm_fracture37 = ${frac_perm}
perm_fracture38 = ${frac_perm}
perm_fracture39 = ${frac_perm}
perm_fracture40 = ${frac_perm}
perm_fracture41 = ${frac_perm}
perm_fracture42 = ${frac_perm}
perm_fracture43 = ${frac_perm}
perm_fracture44 = ${frac_perm}
perm_fracture45 = ${frac_perm}
perm_fracture46 = ${frac_perm}
perm_fracture47 = ${frac_perm}
perm_fracture48 = ${frac_perm}
perm_fracture49 = ${frac_perm}


[Materials]
  [porosity_fracture1]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture1}
    block = fracture1
  []
  [porosity_fracture2]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture2}
    block = fracture2
  []
  [porosity_fracture3]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture3}
    block = fracture3
  []
  [porosity_fracture4]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture4}
    block = fracture4
  []
  [porosity_fracture5]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture5}
    block = fracture5
  []
  [porosity_fracture6]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture6}
    block = fracture6
  []
  [porosity_fracture7]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture7}
    block = fracture7
  []
  [porosity_fracture8]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture8}
    block = fracture8
  []
  [porosity_fracture9]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture9}
    block = fracture9
  []
  [porosity_fracture10]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture10}
    block = fracture10
  []
  [porosity_fracture11]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture11}
    block = fracture11
  []
  [porosity_fracture12]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture12}
    block = fracture12
  []
  [porosity_fracture13]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture13}
    block = fracture13
  []
  [porosity_fracture14]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture14}
    block = fracture14
  []
  [porosity_fracture15]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture15}
    block = fracture15
  []
  [porosity_fracture16]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture16}
    block = fracture16
  []
  [porosity_fracture17]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture17}
    block = fracture17
  []
  [porosity_fracture18]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture18}
    block = fracture18
  []
  [porosity_fracture19]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture19}
    block = fracture19
  []
  [porosity_fracture20]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture20}
    block = fracture20
  []
  [porosity_fracture21]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture21}
    block = fracture21
  []
  [porosity_fracture22]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture22}
    block = fracture22
  []
  [porosity_fracture23]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture23}
    block = fracture23
  []
  [porosity_fracture24]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture24}
    block = fracture24
  []
  [porosity_fracture25]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture25}
    block = fracture25
  []
  [porosity_fracture26]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture26}
    block = fracture26
  []
  [porosity_fracture27]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture27}
    block = fracture27
  []
  [porosity_fracture28]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture28}
    block = fracture28
  []
  [porosity_fracture29]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture29}
    block = fracture29
  []
  [porosity_fracture30]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture30}
    block = fracture30
  []
  [porosity_fracture31]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture31}
    block = fracture31
  []
  [porosity_fracture32]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture32}
    block = fracture32
  []
  [porosity_fracture33]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture33}
    block = fracture33
  []
  [porosity_fracture34]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture34}
    block = fracture34
  []
  [porosity_fracture35]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture35}
    block = fracture35
  []
  [porosity_fracture36]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture36}
    block = fracture36
  []
  [porosity_fracture37]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture37}
    block = fracture37
  []
  [porosity_fracture38]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture38}
    block = fracture38
  []
  [porosity_fracture39]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture39}
    block = fracture39
  []
  [porosity_fracture40]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture40}
    block = fracture40
  []
  [porosity_fracture41]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture41}
    block = fracture41
  []
  [porosity_fracture42]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture42}
    block = fracture42
  []
  [porosity_fracture43]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture43}
    block = fracture43
  []
  [porosity_fracture44]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture44}
    block = fracture44
  []
  [porosity_fracture45]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture45}
    block = fracture45
  []
  [porosity_fracture46]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture46}
    block = fracture46
  []
  [porosity_fracture47]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture47}
    block = fracture47
  []
  [porosity_fracture48]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture48}
    block = fracture48
  []
  [porosity_fracture49]
    type = PorousFlowPorosityConst
    porosity = ${poro_fracture49}
    block = fracture49
  []
  [permeability_fracture1]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture1} 0 0 0 ${perm_fracture1} 0 0 0 ${perm_fracture1}'
    block = fracture1
  []
  [permeability_fracture2]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture2} 0 0 0 ${perm_fracture2} 0 0 0 ${perm_fracture2}'
    block = fracture2
  []
  [permeability_fracture3]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture3} 0 0 0 ${perm_fracture3} 0 0 0 ${perm_fracture3}'
    block = fracture3
  []
  [permeability_fracture4]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture4} 0 0 0 ${perm_fracture4} 0 0 0 ${perm_fracture4}'
    block = fracture4
  []
  [permeability_fracture5]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture5} 0 0 0 ${perm_fracture5} 0 0 0 ${perm_fracture5}'
    block = fracture5
  []
  [permeability_fracture6]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture6} 0 0 0 ${perm_fracture6} 0 0 0 ${perm_fracture6}'
    block = fracture6
  []
  [permeability_fracture7]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture7} 0 0 0 ${perm_fracture7} 0 0 0 ${perm_fracture7}'
    block = fracture7
  []
  [permeability_fracture8]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture8} 0 0 0 ${perm_fracture8} 0 0 0 ${perm_fracture8}'
    block = fracture8
  []
  [permeability_fracture9]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture9} 0 0 0 ${perm_fracture9} 0 0 0 ${perm_fracture9}'
    block = fracture9
  []
  [permeability_fracture10]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture10} 0 0 0 ${perm_fracture10} 0 0 0 ${perm_fracture10}'
    block = fracture10
  []
  [permeability_fracture11]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture11} 0 0 0 ${perm_fracture11} 0 0 0 ${perm_fracture11}'
    block = fracture11
  []
  [permeability_fracture12]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture12} 0 0 0 ${perm_fracture12} 0 0 0 ${perm_fracture12}'
    block = fracture12
  []
  [permeability_fracture13]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture13} 0 0 0 ${perm_fracture13} 0 0 0 ${perm_fracture13}'
    block = fracture13
  []
  [permeability_fracture14]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture14} 0 0 0 ${perm_fracture14} 0 0 0 ${perm_fracture14}'
    block = fracture14
  []
  [permeability_fracture15]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture15} 0 0 0 ${perm_fracture15} 0 0 0 ${perm_fracture15}'
    block = fracture15
  []
  [permeability_fracture16]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture16} 0 0 0 ${perm_fracture16} 0 0 0 ${perm_fracture16}'
    block = fracture16
  []
  [permeability_fracture17]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture17} 0 0 0 ${perm_fracture17} 0 0 0 ${perm_fracture17}'
    block = fracture17
  []
  [permeability_fracture18]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture18} 0 0 0 ${perm_fracture18} 0 0 0 ${perm_fracture18}'
    block = fracture18
  []
  [permeability_fracture19]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture19} 0 0 0 ${perm_fracture19} 0 0 0 ${perm_fracture19}'
    block = fracture19
  []
  [permeability_fracture20]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture20} 0 0 0 ${perm_fracture20} 0 0 0 ${perm_fracture20}'
    block = fracture20
  []
  [permeability_fracture21]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture21} 0 0 0 ${perm_fracture21} 0 0 0 ${perm_fracture21}'
    block = fracture21
  []
  [permeability_fracture22]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture22} 0 0 0 ${perm_fracture22} 0 0 0 ${perm_fracture22}'
    block = fracture22
  []
  [permeability_fracture23]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture23} 0 0 0 ${perm_fracture23} 0 0 0 ${perm_fracture23}'
    block = fracture23
  []
  [permeability_fracture24]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture24} 0 0 0 ${perm_fracture24} 0 0 0 ${perm_fracture24}'
    block = fracture24
  []
  [permeability_fracture25]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture25} 0 0 0 ${perm_fracture25} 0 0 0 ${perm_fracture25}'
    block = fracture25
  []
  [permeability_fracture26]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture26} 0 0 0 ${perm_fracture26} 0 0 0 ${perm_fracture26}'
    block = fracture26
  []
  [permeability_fracture27]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture27} 0 0 0 ${perm_fracture27} 0 0 0 ${perm_fracture27}'
    block = fracture27
  []
  [permeability_fracture28]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture28} 0 0 0 ${perm_fracture28} 0 0 0 ${perm_fracture28}'
    block = fracture28
  []
  [permeability_fracture29]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture29} 0 0 0 ${perm_fracture29} 0 0 0 ${perm_fracture29}'
    block = fracture29
  []
  [permeability_fracture30]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture30} 0 0 0 ${perm_fracture30} 0 0 0 ${perm_fracture30}'
    block = fracture30
  []
  [permeability_fracture31]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture31} 0 0 0 ${perm_fracture31} 0 0 0 ${perm_fracture31}'
    block = fracture31
  []
  [permeability_fracture32]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture32} 0 0 0 ${perm_fracture32} 0 0 0 ${perm_fracture32}'
    block = fracture32
  []
  [permeability_fracture33]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture33} 0 0 0 ${perm_fracture33} 0 0 0 ${perm_fracture33}'
    block = fracture33
  []
  [permeability_fracture34]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture34} 0 0 0 ${perm_fracture34} 0 0 0 ${perm_fracture34}'
    block = fracture34
  []
  [permeability_fracture35]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture35} 0 0 0 ${perm_fracture35} 0 0 0 ${perm_fracture35}'
    block = fracture35
  []
  [permeability_fracture36]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture36} 0 0 0 ${perm_fracture36} 0 0 0 ${perm_fracture36}'
    block = fracture36
  []
  [permeability_fracture37]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture37} 0 0 0 ${perm_fracture37} 0 0 0 ${perm_fracture37}'
    block = fracture37
  []
  [permeability_fracture38]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture38} 0 0 0 ${perm_fracture38} 0 0 0 ${perm_fracture38}'
    block = fracture38
  []
  [permeability_fracture39]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture39} 0 0 0 ${perm_fracture39} 0 0 0 ${perm_fracture39}'
    block = fracture39
  []
  [permeability_fracture40]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture40} 0 0 0 ${perm_fracture40} 0 0 0 ${perm_fracture40}'
    block = fracture40
  []
  [permeability_fracture41]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture41} 0 0 0 ${perm_fracture41} 0 0 0 ${perm_fracture41}'
    block = fracture41
  []
  [permeability_fracture42]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture42} 0 0 0 ${perm_fracture42} 0 0 0 ${perm_fracture42}'
    block = fracture42
  []
  [permeability_fracture43]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture43} 0 0 0 ${perm_fracture43} 0 0 0 ${perm_fracture43}'
    block = fracture43
  []
  [permeability_fracture44]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture44} 0 0 0 ${perm_fracture44} 0 0 0 ${perm_fracture44}'
    block = fracture44
  []
  [permeability_fracture45]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture45} 0 0 0 ${perm_fracture45} 0 0 0 ${perm_fracture45}'
    block = fracture45
  []
  [permeability_fracture46]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture46} 0 0 0 ${perm_fracture46} 0 0 0 ${perm_fracture46}'
    block = fracture46
  []
  [permeability_fracture47]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture47} 0 0 0 ${perm_fracture47} 0 0 0 ${perm_fracture47}'
    block = fracture47
  []
  [permeability_fracture48]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture48} 0 0 0 ${perm_fracture48} 0 0 0 ${perm_fracture48}'
    block = fracture48
  []
  [permeability_fracture49]
    type = PorousFlowPermeabilityConst
    permeability = '${perm_fracture49} 0 0 0 ${perm_fracture49} 0 0 0 ${perm_fracture49}'
    block = fracture49
  []

  [rock_internal_energy_fracture]
    type = PorousFlowMatrixInternalEnergy
    density = 2500
    specific_heat_capacity = 100.0
    block = ${all_frac_ids}
  []

  [thermal_conductivity_fracture]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '3 0 0 0 3 0 0 0 3'
    block = ${all_frac_ids}
  []
[]
