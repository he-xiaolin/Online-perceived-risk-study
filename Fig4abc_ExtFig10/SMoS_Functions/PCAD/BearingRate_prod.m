function looming_prod=BearingRate_prod(omega,x_s,vx_s,y_s,vy_s,x_n,vx_n,y_n,vy_n)
%% Reference point position
% p1--p2 ^
% |   |  ^
% p3--p4 ^
w=[0;0;omega];
pj=[x_n;y_n;0];
p_i=[x_s;y_s;0];% the center of the vehicle

p_i1=p_i+[2;1;0]; % front left
p_i2=p_i+[2;-1;0]; % front right
p_i3=p_i+[-2;1;0]; % back left
p_i4=p_i+[-2;-1;0]; % back right

pj1=pj+[2;1;0];% front left
pj2=pj+[2;-1;0]; % front right
pj3=pj+[-2;1;0]; % back left
pj4=pj+[-2;-1;0]; % back right


%% Velocity
vi=[vx_s;vy_s;0];
vi1=vi+cross((p_i1-p_i),w);
vi2=vi+cross((p_i2-p_i),w);
vi3=vi+cross((p_i3-p_i),w);
vi4=vi+cross((p_i4-p_i),w);

vj=[vx_n;vy_n;0];

%% Looming rate calculation
theta11=(-cross((pj1-p_i1),vi1)+cross((pj1-p_i1),vj))./norm(pj1-p_i1).^2;
theta12=(-cross((pj2-p_i1),vi1)+cross((pj2-p_i1),vj))./norm(pj2-p_i1).^2;
theta13=(-cross((pj3-p_i1),vi1)+cross((pj3-p_i1),vj))./norm(pj3-p_i1).^2;
theta14=(-cross((pj4-p_i1),vi1)+cross((pj4-p_i1),vj))./norm(pj4-p_i1).^2;

theta21=(-cross((pj1-p_i2),vi2)+cross((pj1-p_i2),vj))./norm(pj1-p_i2).^2;
theta22=(-cross((pj2-p_i2),vi2)+cross((pj2-p_i2),vj))./norm(pj2-p_i2).^2;
theta23=(-cross((pj3-p_i2),vi2)+cross((pj3-p_i2),vj))./norm(pj3-p_i2).^2;
theta24=(-cross((pj4-p_i2),vi2)+cross((pj4-p_i2),vj))./norm(pj4-p_i2).^2;

theta31=(-cross((pj1-p_i3),vi3)+cross((pj1-p_i3),vj))./norm(pj1-p_i3).^2;
theta32=(-cross((pj2-p_i3),vi3)+cross((pj2-p_i3),vj))./norm(pj2-p_i3).^2;
theta33=(-cross((pj3-p_i3),vi3)+cross((pj3-p_i3),vj))./norm(pj3-p_i3).^2;
theta34=(-cross((pj4-p_i3),vi3)+cross((pj4-p_i3),vj))./norm(pj4-p_i3).^2;


theta41=(-cross((pj1-p_i4),vi4)+cross((pj1-p_i4),vj))./norm(pj1-p_i4).^2;
theta42=(-cross((pj2-p_i4),vi4)+cross((pj2-p_i4),vj))./norm(pj2-p_i4).^2;
theta43=(-cross((pj3-p_i4),vi4)+cross((pj3-p_i4),vj))./norm(pj3-p_i4).^2;
theta44=(-cross((pj4-p_i4),vi4)+cross((pj4-p_i4),vj))./norm(pj4-p_i4).^2;

th11 = theta11(3);
th12 = theta12(3);
th13 = theta13(3);
th14 = theta14(3);

th21 = theta21(3);
th22 = theta22(3);
th23 = theta23(3);
th24 = theta24(3);

th31 = theta31(3);
th32 = theta32(3);
th33 = theta33(3);
th34 = theta34(3);

th41 = theta41(3);
th42 = theta42(3);
th43 = theta43(3);
th44 = theta44(3);


th_matrix = [th11,th12,th13,th14,th21,th22,th23,th24,th31,th32,th33,th34,th41,th42,th43,th44];

looming_prod=max(th_matrix).*min(th_matrix);

end

