import graph;
unitsize(x=1.0cm,y=1.0cm);
settings.outformat="svg";

// Draw the x-z axes
real limit = 4.5;
draw((0,-limit)--(0,limit),dotted);
draw((-limit,0)--(limit,0),dotted);



// Define the parameters of the ellipse
real a = 3; // semi-major
real b = 1.5; //semi-minor

// Label these
Label l1 = Label("$b$",align=Relative(NE));
label(l1,(0,b));

Label l2 = Label("$a$",align=Relative(NE));
label(l2,(a,0));

// Determine a point P on the ellipse using the standard parametrization
real theta = pi/4; 

real x(real t) {return a*cos(t);}
real z(real t) {return b*sin(t);}


real x_1 = x(theta);
real z_1 = z(theta);


// Draw ellipse
draw(graph(x,z,0,2*pi));


// Draw the circles
draw(circle(0,b),red+dashed);
draw(circle(0,a),blue+dashed);

// Find the coordinates of the intersections with inner and outer spherer
real x_outer = x_1;
real z_outer = sqrt(a*a-x_outer*x_outer);
real x_inner = sqrt(b*b-z_1*z_1);



// Line to the outer intersection
draw((0,0)--(x_outer,z_outer));
// Indicate the angle
draw("$t$",arc((0,0), r=0.5, angle1=0, angle2=theta*180/pi));
// Indicate the x coordinate
draw("$a\cos t$",(0,0)--(x_1,0),blue,Arrows,PenMargins);

// Indicate the z coordinate
draw(L=Label("$b\sin t$",align=Relative(W)),(0,0)--(0,z_1),red,Arrows,PenMargins);

// Line from x axis to outer intersection
draw((x_1,0)--(x_1,z_outer),blue);
// Line from z axis to inner intersection
draw((x_1,z_1)--(0,z_1),red);


// Indicate some points
dot((x_1,z_outer),blue);
dot((x_inner,z_1),red);
dot(L=Label("$P$",align=Relative(NE)),(x_1,z_1));
