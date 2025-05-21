// Gmsh project created on Tue Jun 13 21:37:15 2023
// Things to change per case: all dimensions!!!

// rock and soil box
x1 = -100;
x2 = 1400;
y1 = 0;
y2 = 0;
z1 = 0;
z2 = -3000;

l1 = 2057.;
l2 = 1030.;
l3 = 134.;
l4 = Sqrt(1122.6^2 + (2632.1-2057)^2)-l2-l3;

cos_teta = 1122.6/(l2+l3+l4);
sin_teta = (-2632.1-(-2057))/(l2+l3+l4);

// fracture width:
w = 0.18;


// # outlet pipe 3/inlet pipe 4, [p4] = [m]
// p4 = '${fparse (l2+l3)*cos_teta} 0 ${fparse (l2+l3)*sin_teta - l1}'
// # outlet pipe 4 [p4] = [m]
// p5 = '${fparse (l2+l3+l4)*cos_teta} 0 ${fparse (l2+l3+l4)*sin_teta - l1}'

//  fracture 1
f1x1 = l2*cos_teta - w/2;
f1x2 = l2*cos_teta + w/2;
f1y1 = 0;
f1y2 = 0;
f1z1 = (l2*sin_teta - l1);
f1z2 = f1z1 + 100;

//  fracture 2
f2x1 = (l2+l3)*cos_teta - w/2;
f2x2 = (l2+l3)*cos_teta + w/2;
f2y1 = 0;
f2y2 = 0;
f2z1 = (l2+l3)*sin_teta - l1;
f2z2 = (l2+l3)*sin_teta - l1 +100;

//  fracture 3
f3x1 = (l2+l3+l4)*cos_teta - w/2;
f3x2 = (l2+l3+l4)*cos_teta + w/2;
f3y1 = 0;
f3y2 = 0;
f3z1 = (l2+l3+l4)*sin_teta - l1;
f3z2 = (l2+l3+l4)*sin_teta - l1 +100;

Point(57) = {x1,y1,z1};   Point(58) = {f1x1,y1,z1};   Point(59) = {f1x2,y1,z1};   Point(60) = {f2x1,y1,z1};   Point(61) = {f2x2,y1,z1};   Point(62) = {f3x1,y1,z1};   Point(63) = {f3x2,y1,z1};   Point(64) = {x2,y1,z1};
Point(49) = {x1,y1,f1z2}; Point(50) = {f1x1,y1,f1z2}; Point(51) = {f1x2,y1,f1z2}; Point(52) = {f2x1,y1,f1z2}; Point(53) = {f2x2,y1,f1z2}; Point(54) = {f3x1,y1,f1z2}; Point(55) = {f3x2,y1,f1z2}; Point(56) = {x2,y1,f1z2};
Point(41) = {x1,y1,f2z2}; Point(42) = {f1x1,y1,f2z2}; Point(43) = {f1x2,y1,f2z2}; Point(44) = {f2x1,y1,f2z2}; Point(45) = {f2x2,y1,f2z2}; Point(46) = {f3x1,y1,f2z2}; Point(47) = {f3x2,y1,f2z2}; Point(48) = {x2,y1,f2z2};
Point(33) = {x1,y1,f1z1}; Point(34) = {f1x1,y1,f1z1}; Point(35) = {f1x2,y1,f1z1}; Point(36) = {f2x1,y1,f1z1}; Point(37) = {f2x2,y1,f1z1}; Point(38) = {f3x1,y1,f1z1}; Point(39) = {f3x2,y1,f1z1}; Point(40) = {x2,y1,f1z1};
Point(25) = {x1,y1,f3z2}; Point(26) = {f1x1,y1,f3z2}; Point(27) = {f1x2,y1,f3z2}; Point(28) = {f2x1,y1,f3z2}; Point(29) = {f2x2,y1,f3z2}; Point(30) = {f3x1,y1,f3z2}; Point(31) = {f3x2,y1,f3z2}; Point(32) = {x2,y1,f3z2};
Point(17) = {x1,y1,f2z1}; Point(18) = {f1x1,y1,f2z1}; Point(19) = {f1x2,y1,f2z1}; Point(20) = {f2x1,y1,f2z1}; Point(21) = {f2x2,y1,f2z1}; Point(22) = {f3x1,y1,f2z1}; Point(23) = {f3x2,y1,f2z1}; Point(24) = {x2,y1,f2z1};
Point(9) = {x1,y1,f3z1};  Point(10) = {f1x1,y1,f3z1}; Point(11) = {f1x2,y1,f3z1}; Point(12) = {f2x1,y1,f3z1}; Point(13) = {f2x2,y1,f3z1}; Point(14) = {f3x1,y1,f3z1}; Point(15) = {f3x2,y1,f3z1}; Point(16) = {x2,y1,f3z1};
Point(1) = {x1,y1,z2};    Point(2) = {f1x1,y1,z2};    Point(3) = {f1x2,y1,z2};    Point(4) = {f2x1,y1,z2};    Point(5) = {f2x2,y1,z2};    Point(6) = {f3x1,y1,z2};    Point(7) = {f3x2,y1,z2};    Point(8) = {x2,y1,z2};

n1 = 50;
nf = 5;
n2 = 10;
n3 = 5;
n4 = 20;
n6 = 30;
n7 = 5;
n8 = 5;
n9 = 2;
n10 = 5;
n11 = 6;
n12 = 60;

// Outlines Lines
Line(1) = {1, 2}; Transfinite Curve {1} = n1;
Line(2) = {2, 3}; Transfinite Curve {2} = nf;
Line(3) = {3, 4}; Transfinite Curve {3} = n2;
Line(4) = {4, 5}; Transfinite Curve {4} = nf;
Line(5) = {5, 6}; Transfinite Curve {5} = n3;
Line(6) = {6, 7}; Transfinite Curve {6} = nf;
Line(7) = {7, 8}; Transfinite Curve {7} = n4;

Line(8) = {8, 16}; Transfinite Curve {8} = n6;
Line(9) = {16, 15}; Transfinite Curve {9} = n4;
Line(10) = {15, 14}; Transfinite Curve {10} = nf;
Line(11) = {14, 13}; Transfinite Curve {11} = n3;
Line(12) = {13, 12}; Transfinite Curve {12} = nf;
Line(13) = {12, 11}; Transfinite Curve {13} = n2;
Line(14) = {11, 10}; Transfinite Curve {14} = nf;
Line(15) = {10, 9}; Transfinite Curve {15} = n1;
Line(16) = {9, 1}; Transfinite Curve {16} = n6;
Line(17) = {10, 2}; Transfinite Curve {17} = n6;
Line(18) = {11, 3}; Transfinite Curve {18} = n6;
Line(19) = {12, 4}; Transfinite Curve {19} = n6;
Line(20) = {13, 5}; Transfinite Curve {20} = n6;
Line(21) = {14, 6}; Transfinite Curve {21} = n6;
Line(22) = {15, 7}; Transfinite Curve {22} = n6;

Line(23) = {16, 24}; Transfinite Curve {23} = n7;
Line(24) = {24, 23}; Transfinite Curve {24} = n4;
Line(25) = {23, 22}; Transfinite Curve {25} = nf;
Line(26) = {22, 21}; Transfinite Curve {26} = n3;
Line(27) = {21, 20}; Transfinite Curve {27} = nf;
Line(28) = {20, 19}; Transfinite Curve {28} = n2;
Line(29) = {19, 18}; Transfinite Curve {29} = nf;
Line(30) = {18, 17}; Transfinite Curve {30} = n1;
Line(31) = {17, 9}; Transfinite Curve {31} = n7;
Line(32) = {18, 10}; Transfinite Curve {32} = n7;
Line(33) = {19, 11}; Transfinite Curve {33} = n7;
Line(34) = {20, 12}; Transfinite Curve {34} = n7;
Line(35) = {21, 13}; Transfinite Curve {35} = n7;
Line(36) = {22, 14}; Transfinite Curve {36} = n7;
Line(37) = {23, 15}; Transfinite Curve {37} = n7;

Line(38) = {24, 32}; Transfinite Curve {38} = n8;
Line(39) = {32, 31}; Transfinite Curve {39} = n4;
Line(40) = {31, 30}; Transfinite Curve {40} = nf;
Line(41) = {30, 29}; Transfinite Curve {41} = n3;
Line(42) = {29, 28}; Transfinite Curve {42} = nf;
Line(43) = {28, 27}; Transfinite Curve {43} = n2;
Line(44) = {27, 26}; Transfinite Curve {44} = nf;
Line(45) = {26, 25}; Transfinite Curve {45} = n1;
Line(46) = {25, 17}; Transfinite Curve {46} = n8;
Line(47) = {26, 18}; Transfinite Curve {47} = n8;
Line(48) = {27, 19}; Transfinite Curve {48} = n8;
Line(49) = {28, 20}; Transfinite Curve {49} = n8;
Line(50) = {29, 21}; Transfinite Curve {50} = n8;
Line(51) = {30, 22}; Transfinite Curve {51} = n8;
Line(52) = {31, 23}; Transfinite Curve {52} = n8;

Line(53) = {32, 40}; Transfinite Curve {53} = n9;
Line(54) = {40, 39}; Transfinite Curve {54} = n4;
Line(55) = {39, 38}; Transfinite Curve {55} = nf;
Line(56) = {38, 37}; Transfinite Curve {56} = n3;
Line(57) = {37, 36}; Transfinite Curve {57} = nf;
Line(58) = {36, 35}; Transfinite Curve {58} = n2;
Line(59) = {35, 34}; Transfinite Curve {59} = nf;
Line(60) = {34, 33}; Transfinite Curve {60} = n1;
Line(61) = {33, 25}; Transfinite Curve {61} = n9;
Line(62) = {34, 26}; Transfinite Curve {62} = n9;
Line(63) = {35, 27}; Transfinite Curve {63} = n9;
Line(64) = {36, 28}; Transfinite Curve {64} = n9;
Line(65) = {37, 29}; Transfinite Curve {65} = n9;
Line(66) = {38, 30}; Transfinite Curve {66} = n9;
Line(67) = {39, 31}; Transfinite Curve {67} = n9;

Line(68) = {40, 48}; Transfinite Curve {68} = n10;
Line(69) = {48, 47}; Transfinite Curve {69} = n4;
Line(70) = {47, 46}; Transfinite Curve {70} = nf;
Line(71) = {46, 45}; Transfinite Curve {71} = n3;
Line(72) = {45, 44}; Transfinite Curve {72} = nf;
Line(73) = {44, 43}; Transfinite Curve {73} = n2;
Line(74) = {43, 42}; Transfinite Curve {74} = nf;
Line(75) = {42, 41}; Transfinite Curve {75} = n1;
Line(76) = {41, 33}; Transfinite Curve {76} = n10;
Line(77) = {42, 34}; Transfinite Curve {77} = n10;
Line(78) = {43, 35}; Transfinite Curve {78} = n10;
Line(79) = {44, 36}; Transfinite Curve {79} = n10;
Line(80) = {45, 37}; Transfinite Curve {80} = n10;
Line(81) = {46, 38}; Transfinite Curve {81} = n10;
Line(82) = {47, 39}; Transfinite Curve {82} = n10;

Line(83) = {48, 56}; Transfinite Curve {83} = n11;
Line(84) = {56, 55}; Transfinite Curve {84} = n4;
Line(85) = {55, 54}; Transfinite Curve {85} = nf;
Line(86) = {54, 53}; Transfinite Curve {86} = n3;
Line(87) = {53, 52}; Transfinite Curve {87} = nf;
Line(88) = {52, 51}; Transfinite Curve {88} = n2;
Line(89) = {51, 50}; Transfinite Curve {89} = nf;
Line(90) = {50, 49}; Transfinite Curve {90} = n1;
Line(91) = {49, 41}; Transfinite Curve {91} = n11;
Line(92) = {50, 42}; Transfinite Curve {92} = n11;
Line(93) = {51, 43}; Transfinite Curve {93} = n11;
Line(94) = {52, 44}; Transfinite Curve {94} = n11;
Line(95) = {53, 45}; Transfinite Curve {95} = n11;
Line(96) = {54, 46}; Transfinite Curve {96} = n11;
Line(97) = {55, 47}; Transfinite Curve {97} = n11;

Line(98) = {56, 64}; Transfinite Curve {98} = n12;
Line(99) = {64, 63}; Transfinite Curve {99} = n4;
Line(100) = {63, 62}; Transfinite Curve {100} = nf;
Line(101) = {62, 61}; Transfinite Curve {101} = n3;
Line(102) = {61, 60}; Transfinite Curve {102} = nf;
Line(103) = {60, 59}; Transfinite Curve {103} = n2;
Line(104) = {59, 58}; Transfinite Curve {104} = nf;
Line(105) = {58, 57}; Transfinite Curve {105} = n1;
Line(106) = {57, 49}; Transfinite Curve {106} = n12;
Line(107) = {58, 50}; Transfinite Curve {107} = n12;
Line(108) = {59, 51}; Transfinite Curve {108} = n12;
Line(109) = {60, 52}; Transfinite Curve {109} = n12;
Line(110) = {61, 53}; Transfinite Curve {110} = n12;
Line(111) = {62, 54}; Transfinite Curve {111} = n12;
Line(112) = {63, 55}; Transfinite Curve {112} = n12;













// surfaces
Curve Loop(1) = {1, -17, 15, 16}; Plane Surface(1) = {1};
Curve Loop(2) = {2, -18, 14, 17}; Plane Surface(2) = {2};
Curve Loop(3) = {3, -19, 13, 18}; Plane Surface(3) = {3};
Curve Loop(4) = {4, -20, 12, 19}; Plane Surface(4) = {4};
Curve Loop(5) = {5, -21, 11, 20}; Plane Surface(5) = {5};
Curve Loop(6) = {6, -22, 10, 21}; Plane Surface(6) = {6};
Curve Loop(7) = {7, 8, 9, 22}; Plane Surface(7) = {7};

Curve Loop(8) = {-15, -32, 30, 31}; Plane Surface(8) = {8};
Curve Loop(9) = {-14, -33, 29, 32}; Plane Surface(9) = {9};
Curve Loop(10) = {-13, -34, 28, 33}; Plane Surface(10) = {10};
Curve Loop(11) = {-12, -35, 27, 34}; Plane Surface(11) = {11};
Curve Loop(12) = {-11, -36, 26, 35}; Plane Surface(12) = {12};
Curve Loop(13) = {-10, -37, 25, 36}; Plane Surface(13) = {13};
Curve Loop(14) = {-9, 23, 24, 37}; Plane Surface(14) = {14};

Curve Loop(15) = {-30, -47, 45, 46}; Plane Surface(15) = {15};
Curve Loop(16) = {-29, -48, 44, 47}; Plane Surface(16) = {16};
Curve Loop(17) = {-28, -49, 43, 48}; Plane Surface(17) = {17};
Curve Loop(18) = {-27, -50, 42, 49}; Plane Surface(18) = {18};
Curve Loop(19) = {-26, -51, 41, 50}; Plane Surface(19) = {19};
Curve Loop(20) = {-25, -52, 40, 51}; Plane Surface(20) = {20};
Curve Loop(21) = {-24, 38, 39, 52}; Plane Surface(21) = {21};

Curve Loop(22) = {-45, -62, 60, 61}; Plane Surface(22) = {22};
Curve Loop(23) = {-44, -63, 59, 62}; Plane Surface(23) = {23};
Curve Loop(24) = {-43, -64, 58, 63}; Plane Surface(24) = {24};
Curve Loop(25) = {-42, -65, 57, 64}; Plane Surface(25) = {25};
Curve Loop(26) = {-41, -66, 56, 65}; Plane Surface(26) = {26};
Curve Loop(27) = {-40, -67, 55, 66}; Plane Surface(27) = {27};
Curve Loop(28) = {-39, 53, 54, 67}; Plane Surface(28) = {28};

Curve Loop(29) = {-60, -77, 75, 76}; Plane Surface(29) = {29};
Curve Loop(30) = {-59, -78, 74, 77}; Plane Surface(30) = {30};
Curve Loop(31) = {-58, -79, 73, 78}; Plane Surface(31) = {31};
Curve Loop(32) = {-57, -80, 72, 79}; Plane Surface(32) = {32};
Curve Loop(33) = {-56, -81, 71, 80}; Plane Surface(33) = {33};
Curve Loop(34) = {-55, -82, 70, 81}; Plane Surface(34) = {34};
Curve Loop(35) = {-54, 68, 69, 82}; Plane Surface(35) = {35};

Curve Loop(36) = {-75, -92, 90, 91}; Plane Surface(36) = {36};
Curve Loop(37) = {-74, -93, 89, 92}; Plane Surface(37) = {37};
Curve Loop(38) = {-73, -94, 88, 93}; Plane Surface(38) = {38};
Curve Loop(39) = {-72, -95, 87, 94}; Plane Surface(39) = {39};
Curve Loop(40) = {-71, -96, 86, 95}; Plane Surface(40) = {40};
Curve Loop(41) = {-70, -97, 85, 96}; Plane Surface(41) = {41};
Curve Loop(42) = {-69, 83, 84, 97}; Plane Surface(42) = {42};

Curve Loop(43) = {-90, -107, 105, 106}; Plane Surface(43) = {43};
Curve Loop(44) = {-89, -108, 104, 107}; Plane Surface(44) = {44};
Curve Loop(45) = {-88, -109, 103, 108}; Plane Surface(45) = {45};
Curve Loop(46) = {-87, -110, 102, 109}; Plane Surface(46) = {46};
Curve Loop(47) = {-86, -111, 101, 110}; Plane Surface(47) = {47};
Curve Loop(48) = {-85, -112, 100, 111}; Plane Surface(48) = {48};
Curve Loop(49) = {-84, 98, 99, 112}; Plane Surface(49) = {49};




Transfinite Surface {1}; Recombine Surface {1};
Transfinite Surface {2}; Recombine Surface {2};
Transfinite Surface {3}; Recombine Surface {3};
Transfinite Surface {4}; Recombine Surface {4};
Transfinite Surface {5}; Recombine Surface {5};
Transfinite Surface {6}; Recombine Surface {6};
Transfinite Surface {7}; Recombine Surface {7};
Transfinite Surface {8}; Recombine Surface {8};
Transfinite Surface {9}; Recombine Surface {9};
Transfinite Surface {10}; Recombine Surface {10};
Transfinite Surface {11}; Recombine Surface {11};
Transfinite Surface {12}; Recombine Surface {12};
Transfinite Surface {13}; Recombine Surface {13};
Transfinite Surface {14}; Recombine Surface {14};
Transfinite Surface {15}; Recombine Surface {15};
Transfinite Surface {16}; Recombine Surface {16};
Transfinite Surface {17}; Recombine Surface {17};
Transfinite Surface {18}; Recombine Surface {18};
Transfinite Surface {19}; Recombine Surface {19};
Transfinite Surface {20}; Recombine Surface {20};
Transfinite Surface {21}; Recombine Surface {21};
Transfinite Surface {22}; Recombine Surface {22};
Transfinite Surface {23}; Recombine Surface {23};
Transfinite Surface {24}; Recombine Surface {24};
Transfinite Surface {25}; Recombine Surface {25};
Transfinite Surface {26}; Recombine Surface {26};
Transfinite Surface {27}; Recombine Surface {27};
Transfinite Surface {28}; Recombine Surface {28};
Transfinite Surface {29}; Recombine Surface {29};
Transfinite Surface {30}; Recombine Surface {30};
Transfinite Surface {31}; Recombine Surface {31};
Transfinite Surface {32}; Recombine Surface {32};
Transfinite Surface {33}; Recombine Surface {33};
Transfinite Surface {34}; Recombine Surface {34};
Transfinite Surface {35}; Recombine Surface {35};
Transfinite Surface {36}; Recombine Surface {36};
Transfinite Surface {37}; Recombine Surface {37};
Transfinite Surface {38}; Recombine Surface {38};
Transfinite Surface {39}; Recombine Surface {39};
Transfinite Surface {40}; Recombine Surface {40};
Transfinite Surface {41}; Recombine Surface {41};
Transfinite Surface {42}; Recombine Surface {42};
Transfinite Surface {43}; Recombine Surface {43};
Transfinite Surface {44}; Recombine Surface {44};
Transfinite Surface {45}; Recombine Surface {45};
Transfinite Surface {46}; Recombine Surface {46};
Transfinite Surface {47}; Recombine Surface {47};
Transfinite Surface {48}; Recombine Surface {48};
Transfinite Surface {49}; Recombine Surface {49};

Physical Surface("fracture_1", 115) = {30, 37};
Physical Surface("fracture_2", 114) = {18, 25, 32};
Physical Surface("fracture_3", 113) = {13, 20};
Physical Surface("rock", 116) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 19, 21, 22, 23, 24, 26, 27, 28, 29, 31, 33, 34, 35, 36, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49};
Physical Curve("rock_bot", 117) = {1, 2, 3, 4, 5, 6, 7};
Physical Curve("rock_top", 118) = {105, 104, 103, 102, 101, 99, 100};
Physical Curve("rock_left", 119) = {106, 91, 76, 61, 46, 31, 16};
Physical Curve("rock_right", 120) = {8, 23, 38, 53, 68, 83, 98};
Physical Curve("frac_3_inlet", 121) = {10};
Physical Curve("frac_3_left", 122) = {36, 51};
Physical Curve("frac_3_right", 123) = {52, 37};
Physical Curve("frac_3_outlet", 124) = {40};
Physical Curve("frac_2_inlet", 125) = {27};
Physical Curve("frac_2_left", 126) = {49, 64, 79};
Physical Curve("frac_2_right", 127) = {50, 65, 80};
Physical Curve("frac_2_outlet", 128) = {72};
Physical Curve("frac_1_inlet", 129) = {59};
Physical Curve("frac_1_left", 130) = {77, 92};
Physical Curve("frac_1_right", 131) = {78, 93};
Physical Curve("frac_1_outlet", 132) = {89};


// Converting elements from Hex8 to Hex20
Mesh.ElementOrder = 2;
Mesh.MshFileVersion = 2.16;
Mesh 2;
Hide "*";
Show "*";


//+
Show "*";



