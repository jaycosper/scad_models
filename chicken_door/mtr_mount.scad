$fa=1;
$fs=0.4;

module mounting_holes(radius, hole_count, hole_rad, hole_depth)
{
    r = radius;
    n = hole_count; // number of holes
    step = 360/n;
    for (i=[0:step:359]) {
        angle = i;
        dx = r*cos(angle);
        dy = r*sin(angle);
        translate([dx,dy,-0.1])
            cylinder(r=hole_rad, h=1.1*hole_depth);
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
        // mounting holes
        translate([0,0,width2/2])
            mounting_holes((outer_rad+inner_rad+mount_thickness+1.75)/2, 6, 1, 10);//mount_thickness);
    }
}

module wall_mount(inner_rad=34, width=15, outer_rad=40, width2=6, bracket_length=100)
{
    difference(){
        union(){
            translate([0,-inner_rad,0])
                cube([bracket_length, inner_rad*2, width2]);
                rotate(-90,[0,0,1])
                    translate([0,-inner_rad,0])
                        cube([bracket_length, inner_rad*2, width2]);
            rotate(45,[0,0,1])
                translate([-bracket_length/2-inner_rad,-(bracket_length)/2-inner_rad,0])
                    cube([sqrt(2*(bracket_length*bracket_length)), inner_rad, width2]);
        }
        translate([0,0,-0.1])
            cylinder(r=outer_rad+width, width+width2+0.1);
    }
}

module motor_fastner(inner_rad=34, thickness=15, outer_rad=40, width2=6)
{
    difference(){
        // outer
        cylinder(r=outer_rad+thickness, thickness);
        translate([0,0,-0.1])
            // inner
            cylinder(r=inner_rad, 2*thickness);
        // mounting holes
        inner_mount_rad=35.8/2;
        mounting_holes((outer_rad+inner_mount_rad+thickness+1.75)/2, 6, 1, thickness);
    }
}

inner_mount_rad=35.8/2;
inner_mount_width=6;
outer_mount_rad=39.5/2;
outer_mount_width=6.75;
motor_rad=30.5/2;
bracket_length=100;
fastner_width=2;
fastner_thickness=3;

motor_mount(inner_mount_rad, inner_mount_width, outer_mount_rad, outer_mount_width);

translate([0,-75,0])
    wall_mount(inner_mount_rad, inner_mount_width, outer_mount_rad, outer_mount_width, bracket_length);

translate([0,75,0])
    motor_fastner(motor_rad, inner_mount_width, outer_mount_rad, fastner_width);