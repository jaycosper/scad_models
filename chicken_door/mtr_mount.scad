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

module motor_mount(inner_rad=34, width=15, outer_rad=40, width2=6)
{
    mount_thickness = 6;

    difference(){
        // outer
        cylinder(r=outer_rad+mount_thickness, width+width2);
        translate([0,0,width])
            // inner
            cylinder(r=outer_rad, width2+0.1);
            translate([-9/2,-42.85/2,width])
                // cutout
                cube([9,42.85,6.75+0.1]);
            translate([0,0,-0.1])
                // innermost
                cylinder(r=inner_rad, 2*width);

    }
}

module motor_fastner(inner_rad=34, thickness=15, outer_rad=40, width2=6)
{
    difference(){
        union(){
        // outer
        cylinder(r=outer_rad+thickness, thickness);
        translate([-2*outer_rad,-thickness,0])
            // brackets
            cube([outer_rad*4, 2*thickness, thickness]);
        }
        translate([0,0,-0.1])
            cylinder(r=inner_rad, 2*thickness);
    }
}

inner_mount_rad=35.8/2;
inner_mount_width=5;
outer_mount_rad=39.5/2;
outer_mount_width=6.75;
motor_rad=30.5/2;
fastner_width=2;
fastner_thickness=3;

motor_mount(inner_mount_rad, inner_mount_width, outer_mount_rad, outer_mount_width);

translate([0,0,50])
    motor_fastner(motor_rad, inner_mount_width, outer_mount_rad, fastner_width);