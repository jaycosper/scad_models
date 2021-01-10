$fa=1;
$fs=0.4;

module spool_mount(rad_in=5, rad_out=10, height=5)
{
    difference(){
        cylinder(r=rad_out, height);
        translate([0, 0, 1.1])
            cylinder(r=rad_in, height-1);
        translate([0, 0, height/2+(rad_out-rad_in)+0.1]){
            cube([rad_out*2, 1.3,height], center=true);
            cube([1.3, rad_out*2, height], center=true);
    }
    }
}

module motor_mount(shaft_rad=2.5, shaft_length=15)
{
    coupler_slop = 0.5;
    coupler_rad = shaft_rad + coupler_slop;
    coupler_height = shaft_length * 0.8;

    difference(){
        // outer
        cylinder(r=coupler_rad+1, coupler_height);
        translate([0,0,2])
            // inner
            cylinder(r=coupler_rad, coupler_height);
        translate([0,0,4])
        rotate([90,00,0])
            // setscrew hole
            cylinder(r=1.5, 10);
    }


}

align_hole = 0.5;
difference(){
    spool_mount(19/2, 21/2, 10);
    // alignment hole
    cylinder(r=align_hole, 10, center=true);
}
translate([25, 0,0])
difference(){
    motor_mount(2.5, 13);
    // alignment hole
    cylinder(r=align_hole, 10, center=true);
}