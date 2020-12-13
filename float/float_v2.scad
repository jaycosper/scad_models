$fa=1;
$fs=0.4;
 
module half_cylinder(radius=5, height=5)
{
    difference(){
        cylinder(r=radius, height);
        // halved
        translate([0, radius, -0.1])
            cube([2*radius,2*radius,3*height],center=true);
    }  
}

// base
module base(radius=5, height=5)
{
    base_t = 1;
    airpocket_t = height-base_t;
    // hollow half-cylinder    
    difference(){
        //half_cylinder(radius, height);
        cylinder(r=radius,height);
        translate([0,0,base_t])
            //half_cylinder(1*(radius-base_t), 1.1*height);
            cylinder(r=radius-base_t, 1.1*height);
    }
    // backplate
    //translate([0,-0.5,height/2])
    //cube([radius*2,1,height],center=true);
}

module depressor(width=5, height=20, thickness=1)
{
    radius = width/2;
    
    translate([0,radius,0])
    hull(){
        cube([width, width, thickness], center=true);
        translate([0,height,0])
            cylinder(r=radius, thickness, center=true);
    }
}

module plunger(radius=10, height=50, thickness=1)
{
    
    //half_cylinder(radius, thickness);
    cylinder(r=radius,thickness);
    //translate([0,-thickness/2,0])
        rotate([90,0,0])
        depressor(radius, height, thickness);
}

module cage(width=10, height=50)
{
    cage_overlap=3;
    cage_width = width*2;
    cage_height = height+cage_overlap;
    post_thickness = 2;
    bottom_thickness = 2;
    cutout_xy = cage_width-2*post_thickness;
    cutout_z = cage_height;// + bottom_thickness - cage_overlap;
    
    translate([0,0,(height+cage_overlap)/2])
    difference(){
        // outer
        cube([cage_width, cage_width, cage_height], center=true);
        // inner
        translate([0, 0, bottom_thickness])
            cube([2*cutout_xy, cutout_xy, cutout_z], center=true);
        translate([0, 0, bottom_thickness])
            cube([cutout_xy, 2*cutout_xy, cutout_z], center=true);
    }
}

module enclosure(width=10, height=50, margin=2)
{
    // detect box (upper)
    detect_x = width*2;
    detect_y = width*4;
    detect_z = height;
    // slot cutout
    slot_x = width + margin*3;
    slot_y = margin*2;
    slot_z = detect_z*2;
    // mount box (lower)
    mount_x = detect_x;
    mount_y = detect_y;
    mount_z = 10;
    // combined
    box_x = detect_x;
    box_y = detect_y;
    box_z = detect_z + mount_z;
    // detect box
    translate([0,0,box_z/2])
    difference(){
        // outer
        cube([box_x, box_y, box_z], center=true);
        // inner
        translate([0, -box_y/4, 0])
            cube([slot_x, slot_y, slot_z], center=true);
 
        // led cutouts
        translate([0,0,box_z/3])
            rotate([90,0,0])
                cylinder(r=2.5, h=4*box_z, center=true);
        translate([0,0,-box_z/3+mount_z])
            rotate([90,0,0])
                cylinder(r=2.5, h=4*box_z, center=true);
        // mount cutout
        translate([0,mount_y/3,-box_z/4-mount_z])
            cube([mount_x*1.1,10,mount_z*1.1],center=true);
        // screw hole
        translate([0,mount_y/2,-mount_z-detect_z/4])
            rotate([90,0,0])
                cylinder(r=1.0, h=mount_x/2, center=true);    
    }
}

module enclosure_final(width=10, height=50, cheight=50, margin=3)
{
    difference()
    {
        enclosure(width, height,2);
        translate([45-3*capsule_radius,-15,-plunger_height-capsule_height])
            cage(width+0.1, cheight);
    }
}

capsule_radius = 15;
capsule_height = 15;
plunger_height = 50;
plunger_thickness = 2;

color("blue")
cage(capsule_radius, plunger_height+capsule_height);
translate([0,0,plunger_thickness])
base(capsule_radius, capsule_height);
translate([0,0,plunger_thickness+capsule_height])
plunger(capsule_radius, plunger_height, plunger_thickness);

translate([2.5*capsule_radius,0,0])
base(capsule_radius, capsule_height);

translate([-3*capsule_radius,0,0])
enclosure(capsule_radius, plunger_height,2);

translate([-3*capsule_radius,-15,-plunger_height-capsule_height])
{
    color("green")
    cage(capsule_radius, plunger_height+capsule_height);
    
    translate([0,0,2])
    color("brown")
    base(capsule_radius, capsule_height);
    
    translate([0,0,capsule_height+2])
    color("red")
    plunger(capsule_radius, plunger_height, plunger_thickness);
}

translate([100,0,0])
enclosure_final(capsule_radius, plunger_height, plunger_height+capsule_height, 2);

// STL builds
// CAGE
//cage(capsule_radius, plunger_height+capsule_height);

// BASE
//base(capsule_radius, capsule_height);

// PLUNGER
//plunger(capsule_radius, plunger_height, plunger_thickness);

// ENCLOSURE
//rotate([180,0,0])
//translate([0,0,-plunger_height-10])
//enclosure_final(capsule_radius, plunger_height, plunger_height+capsule_height, 2);