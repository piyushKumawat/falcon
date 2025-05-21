# created by write_frac_materials_input.py
# see Materials Property section in porous flow notes:
# https://mooseframework.inl.gov/modules/porous_flow/multiapp_fracture_flow_PorousFlow_3D.html
# DFN from fname
all_frac_ids = "fracture1 fracture2 fracture3 fracture4 fracture5 fracture6 fracture7 fracture8 "
               "fracture9 fracture10 fracture11 fracture12 fracture13 fracture14 fracture15 "
               "fracture16 fracture17 fracture18 fracture19 fracture20 fracture21 fracture22 "
               "fracture23 fracture24 fracture25 fracture26 fracture27 fracture28 fracture29 "
               "fracture30 fracture31 fracture32 fracture33 fracture34 fracture35 fracture36 "
               "fracture37 fracture38 fracture39 fracture40 fracture41 fracture42 fracture43 "
               "fracture44 fracture45 fracture46 fracture47 fracture48 fracture49 "

frac_aperture_1 = ${frac_aperature}
frac_aperture_2 = 3e-4
frac_aperture_3 = ${frac_aperature}
frac_aperture_4 = ${frac_aperature}
frac_aperture_5 = ${frac_aperature}
frac_aperture_6 = ${frac_aperature}
frac_aperture_7 = ${frac_aperature}
frac_aperture_8 = ${frac_aperature}
frac_aperture_9 = ${frac_aperature}
frac_aperture_10 = ${frac_aperature}
frac_aperture_11 = ${frac_aperature}
frac_aperture_12 = ${frac_aperature}
frac_aperture_13 = ${frac_aperature}
frac_aperture_14 = ${frac_aperature}
frac_aperture_15 = ${frac_aperature}
frac_aperture_16 = ${frac_aperature}
frac_aperture_17 = ${frac_aperature}
frac_aperture_18 = ${frac_aperature}
frac_aperture_19 = ${frac_aperature}
frac_aperture_20 = ${frac_aperature}
frac_aperture_21 = ${frac_aperature}
frac_aperture_22 = ${frac_aperature}
frac_aperture_23 = ${frac_aperature}
frac_aperture_24 = ${frac_aperature}
frac_aperture_25 = ${frac_aperature}
frac_aperture_26 = ${frac_aperature}
frac_aperture_27 = ${frac_aperature}
frac_aperture_28 = ${frac_aperature}
frac_aperture_29 = ${frac_aperature}
frac_aperture_30 = ${frac_aperature}
frac_aperture_31 = ${frac_aperature}
frac_aperture_32 = ${frac_aperature}
frac_aperture_33 = ${frac_aperature}
frac_aperture_34 = ${frac_aperature}
frac_aperture_35 = ${frac_aperature}
frac_aperture_36 = ${frac_aperature}
frac_aperture_37 = 3e-4
frac_aperture_38 = ${frac_aperature}
frac_aperture_39 = 3e-4
frac_aperture_40 = ${frac_aperature}
frac_aperture_41 = 3e-4
frac_aperture_42 = 3e-4
frac_aperture_43 = 3e-4
frac_aperture_44 = ${frac_aperature}
frac_aperture_45 = ${frac_aperature}
frac_aperture_46 = ${frac_aperature}
frac_aperture_47 = ${frac_aperature}
frac_aperture_48 = ${frac_aperature}
frac_aperture_49 = ${frac_aperature}

frac_roughness_1 = ${frac_roughness}
frac_roughness_2 = ${frac_roughness}
frac_roughness_3 = ${frac_roughness}
frac_roughness_4 = ${frac_roughness}
frac_roughness_5 = ${frac_roughness}
frac_roughness_6 = ${frac_roughness}
frac_roughness_7 = ${frac_roughness}
frac_roughness_8 = ${frac_roughness}
frac_roughness_9 = ${frac_roughness}
frac_roughness_10 = ${frac_roughness}
frac_roughness_11 = ${frac_roughness}
frac_roughness_12 = ${frac_roughness}
frac_roughness_13 = ${frac_roughness}
frac_roughness_14 = ${frac_roughness}
frac_roughness_15 = ${frac_roughness}
frac_roughness_16 = ${frac_roughness}
frac_roughness_17 = ${frac_roughness}
frac_roughness_18 = ${frac_roughness}
frac_roughness_19 = ${frac_roughness}
frac_roughness_20 = ${frac_roughness}
frac_roughness_21 = ${frac_roughness}
frac_roughness_22 = ${frac_roughness}
frac_roughness_23 = ${frac_roughness}
frac_roughness_24 = ${frac_roughness}
frac_roughness_25 = ${frac_roughness}
frac_roughness_26 = ${frac_roughness}
frac_roughness_27 = ${frac_roughness}
frac_roughness_28 = ${frac_roughness}
frac_roughness_29 = ${frac_roughness}
frac_roughness_30 = ${frac_roughness}
frac_roughness_31 = ${frac_roughness}
frac_roughness_32 = ${frac_roughness}
frac_roughness_33 = ${frac_roughness}
frac_roughness_34 = ${frac_roughness}
frac_roughness_35 = ${frac_roughness}
frac_roughness_36 = ${frac_roughness}
frac_roughness_37 = ${frac_roughness}
frac_roughness_38 = ${frac_roughness}
frac_roughness_39 = ${frac_roughness}
frac_roughness_40 = ${frac_roughness}
frac_roughness_41 = ${frac_roughness}
frac_roughness_42 = ${frac_roughness}
frac_roughness_43 = ${frac_roughness}
frac_roughness_44 = ${frac_roughness}
frac_roughness_45 = ${frac_roughness}
frac_roughness_46 = ${frac_roughness}
frac_roughness_47 = ${frac_roughness}
frac_roughness_48 = ${frac_roughness}
frac_roughness_49 = ${frac_roughness}

one_over_bulk = 1.4e-11 #bulk modulus = 70GPa

[Materials]
  [porosity_fracture1]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_1}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_1/10}'
    block = fracture1
  []
  [porosity_fracture2]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_2}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_2/10}'
    block = fracture2
  []
  [porosity_fracture3]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_3}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_3/10}'
    block = fracture3
  []
  [porosity_fracture4]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_4}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_4/10}'
    block = fracture4
  []
  [porosity_fracture5]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_5}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_5/10}'
    block = fracture5
  []
  [porosity_fracture6]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_6}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_6/10}'
    block = fracture6
  []
  [porosity_fracture7]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_7}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_7/10}'
    block = fracture7
  []
  [porosity_fracture8]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_8}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_8/10}'
    block = fracture8
  []
  [porosity_fracture9]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_9}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_9/10}'
    block = fracture9
  []
  [porosity_fracture10]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_10}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_10/10}'
    block = fracture10
  []
  [porosity_fracture11]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_11}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_11/10}'
    block = fracture11
  []
  [porosity_fracture12]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_12}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_12/10}'
    block = fracture12
  []
  [porosity_fracture13]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_13}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_13/10}'
    block = fracture13
  []
  [porosity_fracture14]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_14}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_14/10}'
    block = fracture14
  []
  [porosity_fracture15]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_15}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_15/10}'
    block = fracture15
  []
  [porosity_fracture16]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_16}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_16/10}'
    block = fracture16
  []
  [porosity_fracture17]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_17}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_17/10}'
    block = fracture17
  []
  [porosity_fracture18]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_18}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_18/10}'
    block = fracture18
  []
  [porosity_fracture19]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_19}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_19/10}'
    block = fracture19
  []
  [porosity_fracture20]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_20}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_20/10}'
    block = fracture20
  []
  [porosity_fracture21]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_21}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_21/10}'
    block = fracture21
  []
  [porosity_fracture22]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_22}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_22/10}'
    block = fracture22
  []
  [porosity_fracture23]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_23}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_23/10}'
    block = fracture23
  []
  [porosity_fracture24]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_24}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_24/10}'
    block = fracture24
  []
  [porosity_fracture25]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_25}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_25/10}'
    block = fracture25
  []
  [porosity_fracture26]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_26}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_26/10}'
    block = fracture26
  []
  [porosity_fracture27]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_27}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_27/10}'
    block = fracture27
  []
  [porosity_fracture28]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_28}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_28/10}'
    block = fracture28
  []
  [porosity_fracture29]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_29}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_29/10}'
    block = fracture29
  []
  [porosity_fracture30]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_30}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_30/10}'
    block = fracture30
  []
  [porosity_fracture31]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_31}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_31/10}'
    block = fracture31
  []
  [porosity_fracture32]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_32}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_32/10}'
    block = fracture32
  []
  [porosity_fracture33]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_33}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_33/10}'
    block = fracture33
  []
  [porosity_fracture34]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_34}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_34/10}'
    block = fracture34
  []
  [porosity_fracture35]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_35}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_35/10}'
    block = fracture35
  []
  [porosity_fracture36]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_36}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_36/10}'
    block = fracture36
  []
  [porosity_fracture37]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_37}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_37/10}'
    block = fracture37
  []
  [porosity_fracture38]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_38}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_38/10}'
    block = fracture38
  []
  [porosity_fracture39]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_39}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_39/10}'
    block = fracture39
  []
  [porosity_fracture40]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_40}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_40/10}'
    block = fracture40
  []
  [porosity_fracture41]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_41}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_41/10}'
    block = fracture41
  []
  [porosity_fracture42]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_42}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_42/10}'
    block = fracture42
  []
  [porosity_fracture43]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_43}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_43/10}'
    block = fracture43
  []
  [porosity_fracture44]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_44}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_44/10}'
    block = fracture44
  []
  [porosity_fracture45]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_45}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_45/10}'
    block = fracture45
  []
  [porosity_fracture46]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_46}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_46/10}'
    block = fracture46
  []
  [porosity_fracture47]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_47}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_47/10}'
    block = fracture47
  []
  [porosity_fracture48]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_48}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_48/10}'
    block = fracture48
  []
  [porosity_fracture49]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_49}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = '${fparse frac_aperture_49/10}'
    block = fracture49
  []
  [permeability_fracture1]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_1/12*frac_aperture_1^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_1}
    block = fracture1
  []
  [permeability_fracture2]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_2/12*frac_aperture_2^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_2}
    block = fracture2
  []
  [permeability_fracture3]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_3/12*frac_aperture_3^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_3}
    block = fracture3
  []
  [permeability_fracture4]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_4/12*frac_aperture_4^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_4}
    block = fracture4
  []
  [permeability_fracture5]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_5/12*frac_aperture_5^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_5}
    block = fracture5
  []
  [permeability_fracture6]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_6/12*frac_aperture_6^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_6}
    block = fracture6
  []
  [permeability_fracture7]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_7/12*frac_aperture_7^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_7}
    block = fracture7
  []
  [permeability_fracture8]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_8/12*frac_aperture_8^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_8}
    block = fracture8
  []
  [permeability_fracture9]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_9/12*frac_aperture_9^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_9}
    block = fracture9
  []
  [permeability_fracture10]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_10/12*frac_aperture_10^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_10}
    block = fracture10
  []
  [permeability_fracture11]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_11/12*frac_aperture_11^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_11}
    block = fracture11
  []
  [permeability_fracture12]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_12/12*frac_aperture_12^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_12}
    block = fracture12
  []
  [permeability_fracture13]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_13/12*frac_aperture_13^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_13}
    block = fracture13
  []
  [permeability_fracture14]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_14/12*frac_aperture_14^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_14}
    block = fracture14
  []
  [permeability_fracture15]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_15/12*frac_aperture_15^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_15}
    block = fracture15
  []
  [permeability_fracture16]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_16/12*frac_aperture_16^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_16}
    block = fracture16
  []
  [permeability_fracture17]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_17/12*frac_aperture_17^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_17}
    block = fracture17
  []
  [permeability_fracture18]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_18/12*frac_aperture_18^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_18}
    block = fracture18
  []
  [permeability_fracture19]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_19/12*frac_aperture_19^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_19}
    block = fracture19
  []
  [permeability_fracture20]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_20/12*frac_aperture_20^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_20}
    block = fracture20
  []
  [permeability_fracture21]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_21/12*frac_aperture_21^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_21}
    block = fracture21
  []
  [permeability_fracture22]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_22/12*frac_aperture_22^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_22}
    block = fracture22
  []
  [permeability_fracture23]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_23/12*frac_aperture_23^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_23}
    block = fracture23
  []
  [permeability_fracture24]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_24/12*frac_aperture_24^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_24}
    block = fracture24
  []
  [permeability_fracture25]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_25/12*frac_aperture_25^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_25}
    block = fracture25
  []
  [permeability_fracture26]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_26/12*frac_aperture_26^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_26}
    block = fracture26
  []
  [permeability_fracture27]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_27/12*frac_aperture_27^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_27}
    block = fracture27
  []
  [permeability_fracture28]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_28/12*frac_aperture_28^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_28}
    block = fracture28
  []
  [permeability_fracture29]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_29/12*frac_aperture_29^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_29}
    block = fracture29
  []
  [permeability_fracture30]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_30/12*frac_aperture_30^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_30}
    block = fracture30
  []
  [permeability_fracture31]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_31/12*frac_aperture_31^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_31}
    block = fracture31
  []
  [permeability_fracture32]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_32/12*frac_aperture_32^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_32}
    block = fracture32
  []
  [permeability_fracture33]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_33/12*frac_aperture_33^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_33}
    block = fracture33
  []
  [permeability_fracture34]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_34/12*frac_aperture_34^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_34}
    block = fracture34
  []
  [permeability_fracture35]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_35/12*frac_aperture_35^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_35}
    block = fracture35
  []
  [permeability_fracture36]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_36/12*frac_aperture_36^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_36}
    block = fracture36
  []
  [permeability_fracture37]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_37/12*frac_aperture_37^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_37}
    block = fracture37
  []
  [permeability_fracture38]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_38/12*frac_aperture_38^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_38}
    block = fracture38
  []
  [permeability_fracture39]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_39/12*frac_aperture_39^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_39}
    block = fracture39
  []
  [permeability_fracture40]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_40/12*frac_aperture_40^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_40}
    block = fracture40
  []
  [permeability_fracture41]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_41/12*frac_aperture_41^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_41}
    block = fracture41
  []
  [permeability_fracture42]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_42/12*frac_aperture_42^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_42}
    block = fracture42
  []
  [permeability_fracture43]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_43/12*frac_aperture_43^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_43}
    block = fracture43
  []
  [permeability_fracture44]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_44/12*frac_aperture_44^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_44}
    block = fracture44
  []
  [permeability_fracture45]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_45/12*frac_aperture_45^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_45}
    block = fracture45
  []
  [permeability_fracture46]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_46/12*frac_aperture_46^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_46}
    block = fracture46
  []
  [permeability_fracture47]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_47/12*frac_aperture_47^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_47}
    block = fracture47
  []
  [permeability_fracture48]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_48/12*frac_aperture_48^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_48}
    block = fracture48
  []
  [permeability_fracture49]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = '${fparse frac_roughness_49/12*frac_aperture_49^3}'
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_49}
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
