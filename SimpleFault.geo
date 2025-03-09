// Gmsh project created on Thu Mar  6 09:18:02 2025
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 10, 0, 1.0};
//+
Point(3) = {0, 20, 0, 1.0};
//+
Point(4) = {10, 20, 0, 1.0};
//+
Point(5) = {20, 20, 0, 1.0};
//+
Point(6) = {0, 0, 0, 1.0};
//+
Point(7) = {20, 20, 0, 1.0};
//+
Point(8) = {20, 10, 0, 1.0};
//+
Point(9) = {20, 0, 0, 1.0};
//+
Point(10) = {10, 0, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 5};
//+
Line(5) = {5, 1};
//+
Line(6) = {6, 7};
//+
Line(7) = {7, 8};
//+
Line(8) = {8, 9};
//+
Line(9) = {9, 10};
//+
Line(10) = {10, 6};
//+
Curve Loop(1) = {1, 2, 3, 4, 5};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {6, 7, 8, 9, 10};
//+
Plane Surface(2) = {2};
//+
Physical Surface("top_rock", 11) = {1};
//+
Physical Surface("bottom_rock", 12) = {2};
//+
Physical Curve("left", 13) = {1, 2};
//+
Physical Curve("top", 14) = {3, 4};
//+
Physical Curve("right", 15) = {7, 8};
//+
Physical Curve("bottom", 16) = {9, 10};
//+
Physical Curve("top_fault", 17) = {5};
//+
Physical Curve("bottom_fault", 18) = {6};
//+
Physical Point("mb", 19) = {10};
//+
Physical Point("ml", 20) = {2};
//+
Physical Point("mt", 21) = {4};
//+
Physical Point("mr", 22) = {8};

