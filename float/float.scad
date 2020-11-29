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
        half_cylinder(radius, height);
        translate([0,0,base_t])
            half_cylinder(1*(radius-base_t), 1.1*height);
    }
    // backplate
    translate([0,-0.5,height/2])
    cube([radius*2,1,height],center=true);
}

module depressor(width=5, height=20, thickness=1)
{
    base_t = thickness;
    radius = width/2;
    
    translate([0,radius,0])
    hull(){
        cube([radius*2, radius*2, 1], center=true);
        translate([0,height,0])
            cylinder(r=radius, base_t, center=true);
    }
}

module indicator(o_rad=10, i_width=8, height=50)
{
    offset=i_width;
    //difference(){
        depressor(o_rad,height,1);
        //translate([0, i_width*4.5+offset,-0.1])
            //cube([i_width, height-i_width*2,2],center=true);
    //}
}

module plunger(radius=10, height=50)
{
    
    half_cylinder(radius, 1);
    translate([0,-0.5,0])
    rotate([90,0,0])
        indicator(radius, radius/2, height);
}

module enclosure(width=10, height=50)
{
    // main box
    translate([0,0,height/2])
    difference(){
        difference(){
            // outer
            cube([width, width*1.5, height], center=true);
            // inner
            translate([0, 0, 0])
                cube([width*0.8, 4, height*2], center=true);
        }
    // led cutouts
    translate([0,0,height/3])
        rotate([90,0,0])
            cylinder(r=2.5, h=4*width, center=true);
    translate([0,0,-height/8])
        rotate([90,0,0])
            cylinder(r=2.5, h=4*width, center=true);

    // attachment cutout
    translate([0,width/2.5,-width*2])
        cube([width*1.1,10,height/1.2],center=true);
    // screw hole
    translate([0,width,-24])
        rotate([90,0,0])
            cylinder(r=1.0, h=width, center=true);
    }
}

capsule_radius = 15;
capsule_height = 15;
plunger_height = 50;

plunger(capsule_radius, plunger_height);
//indicator();
//depressor();
translate([2.5*capsule_radius,0,0])
base(capsule_radius, capsule_height);

translate([-3*capsule_radius,0,0])
enclosure(capsule_radius*1.5, plunger_height*1.2);