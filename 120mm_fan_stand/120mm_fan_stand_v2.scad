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

module body(fan_radius, fan_height, screw_radius){
    difference(){
        cylinder(r=fan_radius, h=fan_height);
        cylinder(r=screw_radius, h=2*fan_height+1, center=true);
        rotate([0,0,45])
            fin_cutout(4, fan_height);
    }
}

module leg(leg_length=70){
    width = 10;
    height = 7;
    rotate([-90,0,0])
    translate([0,-leg_length-5,0])
    union(){     
        difference(){
            
            hull(){
                translate([0, width/2,0])
                    cube([width, width, height], center=true);
                    translate([0,leg_length + width/2, 0])
                        rotate([90,0,0])
                            cylinder(r=width, h=1);
            }
            translate([0,0,-25])
                rotate([-5,0,0])
                cube([200,200,50],center=true);
        }
    }
}

module fan_stand(leg_length=70, fan_radius=10, fan_height=27, screw_radius=2, cylinder_offset=17, test_print=false){

    difference(){
        union(){
            translate([0,cylinder_offset,0])
            body(fan_radius, fan_height, screw_radius);
            leg(leg_length);
        }
        if(test_print) { translate([0,0,55])
            cube([100,100,100], center=true);
        }
    }
}

leg_length=70;
fan_radius=10;
fan_height=27;
screw_radius=2;
cylinder_offset=17;
test_print=false;

fan_stand(leg_length, fan_radius, fan_height, screw_radius, cylinder_offset, test_print);