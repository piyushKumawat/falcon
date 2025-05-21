# created by write_txt_for_3D_fracture_mesher.py
# This is a MOOSE input file to remove duplicate elements from sidesets created by Andy's script
# Run it using:  falcon-opt -i msh_to_exodus_rm_duplicate.i mesh_size=20 --mesh-only Case_B_Fractures_Local_20m.e
# mesh_size='20'
[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = 27frac.msh
  []
  [rename]
    type = RenameBlockGenerator
    input = fmg
    old_block = '50'
    new_block = '1000'
  []
  [rmDuplicateSS]
    type = RemoveDuplicateFacesFromSidesets
    input = rename
  []
  [fracture1]
    type = LowerDBlockFromSidesetGenerator
    input = rmDuplicateSS
    new_block_id = 1
    new_block_name = 'fracture1'
    sidesets = 'disk1'
  []
  [fracture2]
    type = LowerDBlockFromSidesetGenerator
    input = fracture1
    new_block_id = 2
    new_block_name = 'fracture2'
    sidesets = 'disk2'
  []
  [fracture3]
    type = LowerDBlockFromSidesetGenerator
    input = fracture2
    new_block_id = 3
    new_block_name = 'fracture3'
    sidesets = 'disk3'
  []
  [fracture4]
    type = LowerDBlockFromSidesetGenerator
    input = fracture3
    new_block_id = 4
    new_block_name = 'fracture4'
    sidesets = 'disk4'
  []
  [fracture5]
    type = LowerDBlockFromSidesetGenerator
    input = fracture4
    new_block_id = 5
    new_block_name = 'fracture5'
    sidesets = 'disk5'
  []
  [fracture6]
    type = LowerDBlockFromSidesetGenerator
    input = fracture5
    new_block_id = 6
    new_block_name = 'fracture6'
    sidesets = 'disk6'
  []
  [fracture7]
    type = LowerDBlockFromSidesetGenerator
    input = fracture6
    new_block_id = 7
    new_block_name = 'fracture7'
    sidesets = 'disk7'
  []
  [fracture8]
    type = LowerDBlockFromSidesetGenerator
    input = fracture7
    new_block_id = 8
    new_block_name = 'fracture8'
    sidesets = 'disk8'
  []
  [fracture9]
    type = LowerDBlockFromSidesetGenerator
    input = fracture8
    new_block_id = 9
    new_block_name = 'fracture9'
    sidesets = 'disk9'
  []
  [fracture10]
    type = LowerDBlockFromSidesetGenerator
    input = fracture9
    new_block_id = 10
    new_block_name = 'fracture10'
    sidesets = 'disk10'
  []
  [fracture11]
    type = LowerDBlockFromSidesetGenerator
    input = fracture10
    new_block_id = 11
    new_block_name = 'fracture11'
    sidesets = 'disk11'
  []
  [fracture12]
    type = LowerDBlockFromSidesetGenerator
    input = fracture11
    new_block_id = 12
    new_block_name = 'fracture12'
    sidesets = 'disk12'
  []
  [fracture13]
    type = LowerDBlockFromSidesetGenerator
    input = fracture12
    new_block_id = 13
    new_block_name = 'fracture13'
    sidesets = 'disk13'
  []
  [fracture14]
    type = LowerDBlockFromSidesetGenerator
    input = fracture13
    new_block_id = 14
    new_block_name = 'fracture14'
    sidesets = 'disk14'
  []
  [fracture15]
    type = LowerDBlockFromSidesetGenerator
    input = fracture14
    new_block_id = 15
    new_block_name = 'fracture15'
    sidesets = 'disk15'
  []
  [fracture16]
    type = LowerDBlockFromSidesetGenerator
    input = fracture15
    new_block_id = 16
    new_block_name = 'fracture16'
    sidesets = 'disk16'
  []
  [fracture17]
    type = LowerDBlockFromSidesetGenerator
    input = fracture16
    new_block_id = 17
    new_block_name = 'fracture17'
    sidesets = 'disk17'
  []
  [fracture18]
    type = LowerDBlockFromSidesetGenerator
    input = fracture17
    new_block_id = 18
    new_block_name = 'fracture18'
    sidesets = 'disk18'
  []
  [fracture19]
    type = LowerDBlockFromSidesetGenerator
    input = fracture18
    new_block_id = 19
    new_block_name = 'fracture19'
    sidesets = 'disk19'
  []
  [fracture20]
    type = LowerDBlockFromSidesetGenerator
    input = fracture19
    new_block_id = 20
    new_block_name = 'fracture20'
    sidesets = 'disk20'
  []
  [fracture21]
    type = LowerDBlockFromSidesetGenerator
    input = fracture20
    new_block_id = 21
    new_block_name = 'fracture21'
    sidesets = 'disk21'
  []
  [fracture22]
    type = LowerDBlockFromSidesetGenerator
    input = fracture21
    new_block_id = 22
    new_block_name = 'fracture22'
    sidesets = 'disk22'
  []
  [fracture23]
    type = LowerDBlockFromSidesetGenerator
    input = fracture22
    new_block_id = 23
    new_block_name = 'fracture23'
    sidesets = 'disk23'
  []
  [fracture24]
    type = LowerDBlockFromSidesetGenerator
    input = fracture23
    new_block_id = 24
    new_block_name = 'fracture24'
    sidesets = 'disk24'
  []
  [fracture25]
    type = LowerDBlockFromSidesetGenerator
    input = fracture24
    new_block_id = 25
    new_block_name = 'fracture25'
    sidesets = 'disk25'
  []
  [fracture26]
    type = LowerDBlockFromSidesetGenerator
    input = fracture25
    new_block_id = 26
    new_block_name = 'fracture26'
    sidesets = 'disk26'
  []
  [fracture27]
    type = LowerDBlockFromSidesetGenerator
    input = fracture26
    new_block_id = 27
    new_block_name = 'fracture27'
    sidesets = 'disk27'
  []
[]