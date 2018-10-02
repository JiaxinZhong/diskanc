settings.outformat="png";
settings.render=8;
size(7cm,0);

import three;
import graph3;

pen label_fontsize = fontsize(8pt);

// Draw the primary and secondary sources
real w = 0.038;
real h = 0.024;
real rpc = 0.1;
triple loc_c = (0,w,h);
triple loc_p = (0,w+rpc,h);
dot(loc_c,black);
dot(loc_p,orange);

// draw the loudspeakers sketch
surface loudspeaker = zscale3(2*h)*yscale3(w)*xscale3(2*h)*unitcube;
path3[] loudspekaer_frame = box(O,2*h*X+w*Y+2*h*Z);

surface sec_spk = shift(-h*X)*loudspeaker;
draw(sec_spk,lightblue+opacity(0.5),nolight);
path3[] sec_frm = shift(-h*X)*loudspekaer_frame;
draw(sec_frm);
surface pri_spk = shift((w+rpc)*Y)*shift(-h*X)*loudspeaker;
draw(pri_spk,lightblue+opacity(0.5),nolight);
path3[] pri_frm = shift((w+rpc)*Y)*shift(-h*X)*loudspekaer_frame;
draw(pri_frm);

// Draw the surface where the error points lie
real r_err = 0.5; // the radius of the error point
path3 err_cyc = arc(c=O,r_err*X,r_err*Z) -- O -- cycle;
/* draw(err_cyc); */
surface err_surf = surface(err_cyc,c=O,axis=Z,angle1=0,angle2=360);
draw(err_surf, green+opacity(0.2));

// Draw the label about the loudspeakers
draw(w*Y+2*h*X -- (w+rpc)*Y+2*h*X, bar=Bars3(dir=X), arrow=Arrows3(TeXHead2(normal=Z)), L=Label('0.1m',position=Relative(0.8),p=label_fontsize), align=X-0.5*Z);
triple leg_shift = (0.6Z+0.5Y);
draw(shift(leg_shift)*sec_spk,lightblue+opacity(0.5),nolight);
draw(shift(leg_shift)*sec_frm);
dot(shift(leg_shift)*loc_c,black);
draw(shift(leg_shift)*(2*h*X--2*h*X+w*Y),L=Label('3.8cm',p=label_fontsize,align=X-Z),arrow=None,bar=Bars3(dir=X));
draw(shift(leg_shift)*(-w*Y+h*X-- -w*Y+h*X+2*h*Z),L=Label('4.8cm',p=label_fontsize,align=-Y),arrow=None,bar=Bars3(dir=Y));
draw(shift(leg_shift)*((w+h)*Y+h*X-- (w+h)*Y-h*X),L=Label('4.8cm',p=label_fontsize,align=1.5*Y-0.5*Z),arrow=None,bar=Bars3(dir=Y));
draw(shift(leg_shift)*(loc_c -- loc_c+2*w*Z), L=Label('Sound center',p=label_fontsize,position=EndPoint));
/* draw(shift(leg_shift)*(loc_c -- loc_c+2*w*Y+w*Z), L=Label('Sound center',p=label_fontsize,position=EndPoint)); */

// Draw the error points
real[] theta = {0,45,45,45,45,90,90,90,90};
real[] phi = {90,0,90,180,270,45,135,225,315};
real PI = 3.14159;
triple[] loc_e = {};
for (int i=0; i<theta.length; ++i)
{
	real cosp = cos(phi[i]/180*PI);
	real cost = cos(theta[i]/180*PI);
	real sinp = sin(phi[i]/180*PI);
	real sint = sin(theta[i]/180*PI);
	loc_e.push((r_err*cosp*sint, r_err*sinp*sint, r_err*cost));
}
for (int i=0; i<loc_e.length; ++i)
{
	/* write(loc_e[i]); */
	dot(loc_e[i], purple);
	draw(O--loc_e[i], gray+dashed);
	label(string(i+1),loc_e[i],align=-0.2X+0.35Z+1.5Y,p=label_fontsize+2pt);
}
// Draw the label for error microphones
draw(shift(0.5Z)*(O--0.02Z-0.06Y), L=Label('Error mic.',p=label_fontsize,position=EndPoint),align=-Y);

// draw the frame passing through the error points
// horizontal
draw(circle(r_err/sqrt(2)*Z, r_err/sqrt(2)), gray+dashed);
draw(circle(O, r_err), gray+dashed);
// vertical


// Draw the coordinates
real xmax = 0.6;
real ymax = 0.6;
real zmax = 0.55;
draw(O--xmax*X, dashed);
draw(O-- -xmax*X, L=Label('$x$',position=EndPoint), align=-X,arrow=Arrow3(TeXHead2(normal=Y)));
draw(O--ymax*Y, L=Label('$z$',position=EndPoint), arrow=Arrow3(TeXHead2(normal=X)));
draw(O--zmax*Z, L=Label('$y$',position=EndPoint), arrow=Arrow3(TeXHead2(normal=X)));

// Draw the ground plane
draw(shift(-0.5*X-0.5*Y)*unitplane, mediumgray+opacity(0.2));
/* draw(0.5*X--0.5*X+0.5Y,arrow=Arrows); */
draw(0.5*X--0.5*X+0.5Y, arrow=Arrows3(TeXHead2(normal=Z)), bar=Bars3(dir=X),L=Label('0.5m',p=label_fontsize),align=X);

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
