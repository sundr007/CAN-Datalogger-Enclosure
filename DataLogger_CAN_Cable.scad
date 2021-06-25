$fn=100;

include </home/evan/github/BOSL2/std.scad>; 
include </home/evan/github/BOSL2/bottlecaps.scad>; 


overlap=2;

// PCB
xpcb=49;
ypcb=22;
zpcb=3;
off = 3;

// 9V battery
xbatt=17.5;
ybatt=26.5;
zbatt=48.5;
// Enclosure
Dia=33;
cavOffset=5.5;

Main();
//lid();



module Main(){

    //pcb();
        difference(){
            screwtop();
            translate([0,0,3])
            BatteryCutout();
        }
        difference(){
            bottom();
            translate([0,0,3])
            BatteryCutout();
        }
        difference(){
            DT();
            BatteryCutout();
        }
        //DTsnapTab();
        difference(){
            ends();
            translate([0,0,3])
            BatteryCutout();
        }
        Battery();

    //threads();
    
}


module lid(){
    translate([0,xbatt+11.5,-zbatt])
    linear_extrude(zbatt+1)
    difference(){
        polygon([   
                    [ybatt/2+6,0],
                    [ybatt/2+6,-7],
                    [ybatt/2+1.6,-7],
                    [ybatt/2+1.6,-5],
                    [ybatt/2+1.6+2.1,-6.3],
                    [ybatt/2+1.6+2.1,-3],
    
                    [-ybatt/2-1.6-2.1,-3],
                    [-ybatt/2-1.6-2.1,-6.3],
                    [-ybatt/2-1.6,-5],
                    [-ybatt/2-1.6,-7],
                    [-ybatt/2-6,-7],
                    [-ybatt/2-6,0],
                ]);
    }
    translate([0,xbatt+1.8,1])
        linear_extrude(2)
        difference(){
            square([ybatt+6*2,xbatt+2],true);
            translate([0,-19,0])
                circle(d=30);
        }
                
    
            
}

module Battery(){
    translate([0,xbatt/2+9,-zbatt/2])
        difference(){
            cube([ybatt+3,xbatt-1,zbatt+2],center=true);
            translate([0,0,1.5])
            cube([ybatt,xbatt,zbatt+3],center=true);
        }
        
    translate([ybatt/2+1.5,xbatt+6.5,-zbatt])
        linear_extrude(zbatt)
            polygon([[-1,2],[2,2],[2,0]]);
    translate([-ybatt/2-1.5,xbatt+6.5,-zbatt])
        linear_extrude(zbatt)
            mirror([1,0,0])
                polygon([[-1,2],[2,2],[2,0]]);
        
}

module BatteryCutout(){
    translate([0,xbatt/2+9,-zbatt/2])
        cube([ybatt,xbatt,zbatt],center=true);
}

module DTsnapTab(){
    translate([0,-8.75-0.5-3,-xpcb+5+5+1-Ldt])
    linear_extrude(1)
    square([10,0.2],true);  
}

module ends(){
    translate([0,0,-xpcb-Ldt+10+1])
    linear_extrude(10)
    difference(){
        circle(d=Dia*1.2, $fn=6);
        circle(d=Dia);
    }
    
    translate([0,0,-10+1])
    linear_extrude(10)
    difference(){
        circle(d=Dia*1.2, $fn=6);
        circle(d=Dia);
    }
}

module threads(){
    h=xpcb-5-5;
    translate([0,0,-xpcb+5+5+5+2])
      for(g=[[Dia/2,0],[0,Dia/2],[-Dia/2,0],[0,-Dia/2]])
    linear_extrude(height=h, center=true, convexity=1, twist=720)translate(g)   scale(g[0]==0?[3, 1]:[1,3])circle(r = 1); 
}

module pcb(){
    translate([0,0,-xpcb/2+10+1])
        rotate([90,90,0])
            cube([xpcb,ypcb,zpcb],true); 
}

module screwtop(){
    //translate([0,Dia/4+zpcb-cavOffset,5])
    pco1881_neck();
}

module bottom(){
    h=xpcb-5-5;
    translate([0,0,-xpcb+5+5+1])
    linear_extrude(h)

        difference(){
            circle(d=Dia);
            translate([0,zpcb-7.5+1.5,0])
                minkowski(){
                    square([ypcb,zpcb*3+1],true);
                    circle(r=5,true);
                }
            
        }

}


Htriangle=14.9;
Ltriangle=16.0;
Lwires=5;
Ldt=22.25+Lwires;
rdt=3.0*1.45;

A=4;
B=3;
C=7.5;
D=6.5;

module DT(){
    translate([0,0,-xpcb+5+5+1-Ldt])
    linear_extrude(Ldt)
    difference(){
        circle(d=Dia);
        translate([0,-3,0]){
            hull(){
                translate([0,5.1,0]) circle(r=rdt);
                translate([4.4,-2.6,0]) circle(r=rdt);
                translate([-4.4,-2.5,0]) circle(r=rdt);
            }
            translate([0,-8.75,0]) square([12.5*1.1,1.31],true);
            translate([0,-7.5,0]) square([11*1.1,1.31*1.5],true);
    }
    }
}