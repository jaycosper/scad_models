$fa=1;
$fs=0.4;

// base
module base(x=12, y=12, z=12)
{
    cube([x, y, z], center=false);
}

// stand cutout
module stand_cutout(width=1, length=1, height=1)
{
    cube([width, length, height], center=false);
}

// stand cutout
module pcb_cutout(width=1, length=1, height=1)
{
    cube([width, length, height], center=false);
}

module spacer(width=1, length=1, height=1, pcb_height, pcb_thickness)
{
    difference(){
        base(width, length, height);
        translate([-width/2,length/2,-0.1])
        #stand_cutout(2*width, length, 0.5*height);
        translate([-width/2,length/2, pcb_height])
        #pcb_cutout(2*width, length, pcb_thickness);
    }
}

// pcb thickness 3.2mm
// spacer height 17.5mm
pcb_height = 17.5;
pcb_thickness = 3.2;
spacer_width = 5;
spacer_length = 10;
spacer_height = pcb_height + 2*pcb_thickness;
rotate([0,-90,0])
    spacer(spacer_width, spacer_length, spacer_height, pcb_height, pcb_thickness);