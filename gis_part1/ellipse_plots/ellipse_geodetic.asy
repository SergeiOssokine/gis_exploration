import graph;
import geometry;
unitsize(x=1cm,y=1cm);
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


dot((x_1,z_1));

// The slope of the tangent line
real tan_slope = -b*b/(a*a)*x_1/z_1;

// Slope of the normal
real norm_slope = -1/tan_slope;

// Draw the tange line
draw(((a*a*z_1*z_1+b*b*x_1*x_1)/(b*b*x_1),0)--(0,(a*a*z_1*z_1+b*b*x_1*x_1)/(a*a*z_1)),dashed);
real x_end = x_1+0.3;
real intercept_norm = z_1-x_1*norm_slope;
// Draw the normal
draw((0,intercept_norm)--(x_end,norm_slope*x_end+intercept_norm),red);
markrightangle((x_end,norm_slope*x_end+intercept_norm),(x_1,z_1),(0,(a*a*z_1*z_1+b*b*x_1*x_1)/(a*a*z_1)));
dot(L=Label("$P$",align=Relative(E)),(x_1,z_1));
dot(L=Label("$Q$",align=Relative(E)),(0,intercept_norm));
// The intersection of the normal with the x-axis
real z_i = 0.0;
real x_i = -intercept_norm/norm_slope;
draw("$\phi$",arc((x_i,z_i),r=0.5,angle1=0,angle2=atan(norm_slope)*180/pi),red);
Label N_l = Label("$N(\phi)=\frac{a^{2}}{\sqrt{a^{2}\cos^2\phi+b^{2}\sin^2\phi}}$",red);
label(N_l, (1.0,intercept_norm+b/2),align=Relative(E));