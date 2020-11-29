$fa=1;
$fs=0.4;
 
// base
module base()
{
    cube([12.5, 26, 3], center=false);
}

// side wall
module side_wall()
{
    hull(){
        cube([2.5, 26, 4.5], center=false);
        translate([0,4,12.5-2-4])
        rotate([0,90,0])
            cylinder(r=4, 2.5);
    }
}

module basic_edge(length=4.5)
{
    cube([12.5,1.6,length],center=false);
}

module protector()
{
    difference(){
        base();
        // holes
        //  hole 1
        translate([6.25,26-6,-.25])
            cylinder(r=3.5/2, 3.5);
        //  hole 1 chamfer
        translate([6.25,26-6,2])
            cylinder(r1=3.5/2, r2=8/2, 2);
        //  hole 2
        translate([6.25,26-18.25,-.25])
            cylinder(r=3.75/2, 3.5);
        //  hole2 chamfer
        translate([6.25,26-18.25,2])
            cylinder(r1=3.75/2, r2=9/2, 2);
    }
    side_wall();
    translate([10,0,0])
        side_wall();
    // front edge
    translate([0,26-1.6,0])
        basic_edge(4.5);
    // rear overhang
    translate([0,0,-2.6])
        basic_edge(8.6);

}

rotate([90,0,0])
    protector();