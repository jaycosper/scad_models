$fa=1;
$fs=0.4;

module base(width, length, height, overall_length)
{
    translate([0,0, height/2])
    hull()
    {
        rotate(90, [0,1,0])
            cylinder(r=height/2, width, center=true);
        translate([0,length-height/2-0.5,0])
            cube([width, 1, height], center=true);
        translate([0,overall_length-height/2-0.5,-height/2+0.5])
            cube([width, 1, 1], center=true);
    }
}

module base_cutout(width, length, height, overall_length,
    thickness, base_thickness,
    slot_width, slot_length, latch_width)
{
    difference()
    {
        // generate base block
        base(base_width, base_length, base_height, overall_length);
        // remove center
        cutout_width = width - 2*thickness;
        cutout_length = overall_length - thickness;
        cutout_height = 2*height;
        translate([0,cutout_length/2,height+base_thickness])
            cube([cutout_width, cutout_length, cutout_height], center=true);
        // remove slots
        translate([latch_width/2+slot_width/2,slot_length/2-height/2,height-0.1])
            cube([slot_width, slot_length, 2*height], center=true);
        translate([-latch_width/2-slot_width/2,slot_length/2-height/2,height-0.1])
            cube([slot_width, slot_length, 2*height], center=true);

    }

}

module mount_nubs(nub_radius, nub_length, height, nub_offset, base_width)
{
    translate([-base_width/2-nub_length/2,(height/2-nub_radius), height/2])
        rotate(90, [0,1,0])
            cylinder(r=nub_radius, nub_length, center=true);
    translate([base_width/2+nub_length/2,(height/2-nub_radius), height/2])
        rotate(90, [0,1,0])
            cylinder(r=nub_radius, nub_length, center=true);
}

base_width      = 11.25;
base_height     = 4.5;
overall_length  = 26;
base_length     = overall_length-4;
wall_thickness  = 1.5;
base_thickness  = 2.4;
latch_width     = 4.9;
slot_width      = (base_width-(2*wall_thickness+latch_width))/2; //1.325;
slot_length     = 8;
nub_radius      = 2.45/2;
nub_length      = 2.7;
nub_offset      = 2.6; // distance from rounded edge

base_cutout(base_width, base_length, base_height,
    overall_length, wall_thickness, base_thickness,
    slot_width, slot_length, latch_width);

mount_nubs(nub_radius, nub_length, base_height, nub_offset, base_width);
