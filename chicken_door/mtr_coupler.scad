$fa=1;
$fs=0.4;

module spool_mount(rad_in=5, rad_out=10, height=5)
{
    difference(){
        cylinder(r=rad_out, height);
        translate([0, 0, 1.1])
            cylinder(r=rad_in, height-1);
        translate([0, 0, height/2+(rad_out-rad_in)+0.6]){
            cube([rad_out*2, 1.8,height], center=true);
            cube([1.8, rad_out*2, height], center=true);
    }
    }
}

module motor_mount(shaft_rad=2.5, shaft_length=15, outer_rad=5)
{
    coupler_slop = 0.5;
    shroud_rad = outer_rad;
    coupler_rad = shaft_rad + coupler_slop;
    coupler_height = shaft_length * 0.8;

    difference(){
        // outer
        cylinder(r=shroud_rad, coupler_height);
        translate([0,0,2])
            // inner
            cylinder(r=coupler_rad, coupler_height);
        translate([0,0,8])
        rotate([90,00,0])
            // setscrew hole
            cylinder(r=1.5, 15);
    }


}

thickness = 2;
align_hole = 1;
spool_rad = 9.5;
shaft_rad=2.75;
shaft_length=17;

translate([0, 0, shaft_length*0.8])
spool_mount(spool_rad, spool_rad+thickness, 20);

rotate([0,180,0])
translate([0,0,-shaft_length*0.8])
motor_mount(shaft_rad, shaft_length, spool_rad+thickness);