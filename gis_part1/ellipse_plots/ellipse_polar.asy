import graph;
import geometry;
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


// Label the polar angle
draw("$\theta$",arc((0,0), r=0.5, angle1=0, angle2=atan2(z_1,x_1)*180/pi));

// Draw the line joining centre to P
draw((0,0)--(x_1,z_1));
// Give the equation for radius
l1 = Label(
    "$r(\theta) = \frac{ab}{\sqrt{b^2\cos^2\theta+a^2\sin^2\theta}}$"
);
label(l1,(x_1/2,2*z_1),align=Relative(NE));
draw((x_1/2,2*z_1)--(x_1/2,z_1/2),arrow=Arrow);

// Label P
dot(L=Label("$P$",align=Relative(NE)),(x_1,z_1));

// Indicate directly the x and z coordinates
draw("$r\cos \theta$",(0,0)--(x_1,0),blue,Arrows,PenMargins);
draw(L=Label("$r \sin \theta$",align=Relative(SW)),(x_1,0)--(x_1,z_1),red,Arrows,PenMargins);