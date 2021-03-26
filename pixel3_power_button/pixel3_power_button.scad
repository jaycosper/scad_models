$fa=1;
$fs=0.4;

module base(width, length, height)
{
    translate([0, width/2, height/2])
    hull()
    {
        cylinder(r=width/2, height, center=true);
        translate([0,length-width,0])
            cylinder(r=width/2, height, center=true);
    }
}

module mount_pegs(center_length, side_length, peg_radius, base_height, base_width, base_length)
{
    // first aligner
    translate([0, base_width/2, base_height+side_length/2])
        cylinder(r=peg_radius, side_length, center=true);
    // actuator
    translate([0, base_length/2, base_height+center_length/2])
        cylinder(r=peg_radius, center_length, center=true);
    // second aligner
    translate([0, base_length-base_width/2, base_height+side_length/2])
        cylinder(r=peg_radius, side_length, center=true);
}

base_width      = 1.75;
base_height     = 2;
base_length     = 9.75;

actuator_length = 4.7;
aligner_length  = 1.75;
peg_radius      = 1.2/2;

base(base_width, base_length, base_height);

mount_pegs(actuator_length, aligner_length, peg_radius, base_height, base_width, base_length);
