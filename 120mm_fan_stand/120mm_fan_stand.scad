use <MCAD/boxes.scad>

$fa=1;
$fs=0.4;

module fin_cutout(c_offset=17, f_height=27){
    fin_length=2.75;
    fin_width=20;
    fin_height=2*f_height+1;
    fin_offset=10;
    fin_lateral_offset=4;
    fin_depth=c_offset+7;

    // center
    translate([0,fin_depth+fin_lateral_offset,0])
    cube([fin_length, fin_width, fin_height], center=true);
    // side negative
    translate([-fin_offset,fin_depth,0])
    cube([2*fin_length, fin_width, fin_height], center=true);
    // side positive
    translate([fin_offset,fin_depth,0])
    cube([2*fin_length, fin_width, fin_height], center=true);
}

module leg(){
    leg_length=70;
    leg_width=20;
    leg_height=10;
    scaling_factor=.5;
    rear_height=20;
    rear_width=25;
//rotate([0,0,0])
//    translate([50,50,0]);
//    //linear_extrude(height=leg_length,center=true,scale=scaling_factor)
//        resize([leg_length,leg_width])
//        difference(){
//            circle(d=leg_height);
//            translate([-leg_height/2,0,0])
//            square([leg_height,leg_height],center=true);
//
//        }
    rotate([-90,0,90])
        rotate([90,90,0])
        linear_extrude(height=leg_length,center=false,scale=scaling_factor)
            difference(){
                resize([rear_height,rear_width]){
                    circle(d=rear_height);
                }
                translate([0,-rear_height/2,0])
                    square(size=rear_height, center=true);
            }
}

fan_radius=10;
fan_height=27;
screw_radius=2;
cylinder_offset=17;
short=false;

difference(){
    union(){
        translate([0,cylinder_offset,0])
        difference(){
            cylinder(r=fan_radius, h=fan_height);
            cylinder(r=screw_radius, h=2*fan_height+1, center=true);
            rotate([0,0,45])
            fin_cutout(4, fan_height);
            }

        leg();
    }
    if(short) { translate([0,0,55])
        cube([100,100,100], center=true);
    }
}