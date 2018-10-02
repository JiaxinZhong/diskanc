settings.outformat="png";
settings.render=16;
size(14cm,0);

import three;
import graph3;
import patterns;

pen label_fontsize = fontsize(12pt);

// Draw the coordinates
real xmax = 0.6;
real ymax = 0.6;
real zmax = 0.3;
draw(O--xmax*X, dashed);
draw(O-- -xmax*X, L=Label('$x$',position=EndPoint), align=-X,arrow=Arrow3(TeXHead2(normal=Y)));
draw(O--ymax*Y, L=Label('$z$',position=EndPoint), arrow=Arrow3(TeXHead2(normal=X)));
draw(O--zmax*Z, L=Label('$y$',position=EndPoint), arrow=Arrow3(TeXHead2(normal=X)));

//Direction of a point toward the camera.
triple cameradirection(triple pt, projection P=currentprojection) {
	if (P.infinity) {
		return unit(P.camera);
	} else {
		return unit(P.camera - pt);
	}
}

//Move a point closer to the camera.
triple towardcamera(triple pt, real distance=1, projection
P=currentprojection) {
	return pt + distance * cameradirection(pt, P);
}

// Draw the label of origin
label('$O$', O, align=-Z, position=towardcamera(O), p=fontsize(10pt));

// Draw the ground plane
draw(shift(-0.5*X-0.5*Y)*unitplane, mediumgray+opacity(0.2));
triple lb_loc_grd = (0.8*xmax, -0.8*ymax, 0);
label('Ground plane', lb_loc_grd, align=Y-X);

// Draw the semicircular disk
real plate_thick = 0.018;
path box2 = box((0,0), (0.2,-plate_thick));
path3 box3 = path3(box2, plane = XYplane);
surface diskshape = surface(box3, c=O, axis = Y, angle1 = 180, angle2 = 360);
draw(diskshape,cyan,light=nolight);
draw(box3);
draw(shift(-0.2X)*box3);
draw(arc(c=O,-0.2X,0.2X,normal=Y));
draw(shift(-plate_thick*Y)*arc(c=O,-0.2X,0.2X,normal=Y));

// Draw the label of the disk
triple loc_lb_disk = (0.05*xmax, -0.35*ymax, 0.18);
/* label('Semicircular disk', loc_lb_disk); */
draw(shift((0.08,0.001,0.08))*(O-- -0.08Y+0.08Z), L=Label('Semicircular disk', position=EndPoint));

// Draw the image of the semicircular disk
surface img_diskshape = surface(box3, c=O, axis = Y, angle1=0, angle2=180);
draw(img_diskshape, cyan, light=nolight);
draw(arc(c=O,-0.2X,0.2X,normal=-Y), dashed);
draw(shift(-plate_thick*Y)*arc(c=O,-0.2X,0.2X,normal=-Y), dashed);

// Label the radius of the disk
real PI = 3.14159;
real ang_rad = 30/180*PI;
triple loc_lb_rad = (0.2*cos(ang_rad), 0, 0.2*sin(ang_rad));
triple loc_lb_rad_O = (0.002*cos(ang_rad), 0, 0.002*sin(ang_rad));
draw(loc_lb_rad_O--loc_lb_rad, arrow = Arrows3(TeXHead2(normal=Y)), L = Label('$a$', position=MidPoint), align=Z+0.6Y);

// Location of the sources
triple loc_sec = (0, 0.1, 0.1);
triple loc_img_sec = (0, 0.1, -0.1);
triple loc_pri = (-0.3, 0.3, 0.05);
triple loc_img_pri = (-0.3, 0.3, -0.05);
dot(loc_pri-0.05Z);
dot(loc_sec-0.1Z);

// the prototype of the sources
real L_SRC = 0.015;
surface proto_pri = surface(circle(O,L_SRC,normal=X+0.8Y));
path3 frm_proto_pri = circle(O, L_SRC, normal=X+0.8Y);
surface proto_sec = surface(circle(O,L_SRC, normal=X+Y+0.7*Z));
path3 frm_proto_sec1 = circle(O, L_SRC, normal=X+Y+0.7*Z);
path3 frm_proto_sec2 = circle(O, 0.5*L_SRC, normal=X+Y+0.7*Z);

// Draw the sources
draw(shift(loc_pri) * proto_pri, mediumblue, light=nolight);
draw(shift(loc_pri) * frm_proto_pri);
draw(shift(loc_img_pri) * proto_pri, mediumblue, light=nolight);
draw(shift(loc_img_pri) * frm_proto_pri, linetype(new real[] {1,2}));
draw(loc_pri--loc_img_pri,dotted);

draw(shift(loc_sec) * proto_sec, mediumred, light=nolight);
draw(shift(loc_sec) * frm_proto_sec1);
draw(shift(loc_sec) * frm_proto_sec2);
draw(shift(loc_img_sec) * proto_sec, mediumred, light=nolight);
draw(shift(loc_img_sec) * frm_proto_sec1, linetype(new real[] {1,2}));
draw(shift(loc_img_sec) * frm_proto_sec2, linetype(new real[] {1,2}));
draw(O--loc_sec, dashed, L = Label('$l$', position=MidPoint), align=Z);
draw(loc_sec--loc_img_sec,dotted);

draw(loc_pri--loc_sec, dashed, L=Label('$d$',position=Relative(0.3)));
draw(loc_img_pri--loc_img_sec, dashed, L=Label('$d$',position=Relative(0.3)));

// Draw the label of primary source
draw(shift(loc_pri)*(O--0.08Z+0.02Y), L=Label('Primary source',position=EndPoint));
// Draw the label of secondary source
draw(shift(loc_sec)*(O--0.13Z+0.07Y), L=Label('Secondary source',position=EndPoint));
// Draw the label of the image sources
draw(shift(loc_img_sec)*(O-- -0.03Z+0.05Y), L=Label('Image sources', position=EndPoint));
draw(shift(loc_img_pri)*(O-- -0.14Z-0.05Y));
