% Welcome!


% There might be some tweaking with the amplitudes and phase shifts.

% Do not hit run! Only run sections.

% How did you get k?

% There should be no offset for initial

%% Constants



wd = 15; % rad/s

m_cyl = 0.1344; % kg
m_plate = 0.152; % kg

r = 150; % ohm

k = 136.25; % n/m

wn = sqrt(k/(m_cyl+m_plate)); % rad/s

zeta = sqrt(1-(wd/wn)^2); % damping ratio

cc = 2*sqrt((m_cyl+m_plate)*k);

c = zeta*cc;

%% Systematic Uncertainty

% Values from the optical sensor's datasheet
% analog output from 4 mA to 20 mA?
% assuming fast. what is it really?
% need to calibrate the sensor for a) distance and b) zeta
resd = 1; % mm
repeatability = 5; % mm
accuracy = 10; % mm
responsetime = 20; % ms
outputrate = 4; % ms
resb = 16; % bits
hyst = 10; % mm. Sheet says 10 ... 1000


%% 10

% Getting the fits

dr10_i1 = load('data/10_4_19.fig');
dr10_i2 = load('data/10_i2_4_19.fig');
dr10_i3 = load('data/10_i3_4_19.fig');
dr10_d1 = load('data/10d_4_19.fig');
dr10_d2 = load('data/10_d2_4_19.fig');
dr10_d3 = load('data/10_d3_4_19.fig');

a = [0.1 2 1 1];

r10_i1 = fit(dr10_i1,a);
r10_i2 = fit(dr10_i2,a);
r10_i3 = fit(dr10_i3,a);
r10_d1 = fit(dr10_d1,a);
r10_d2 = fit(dr10_d2,a);
r10_d3 = fit(dr10_d3,a);

vals = [r10_i1 r10_i2 r10_i3 r10_d1 r10_d2 r10_d3];

old_eles = [dr10_i1(2,:)',dr10_i2(2,:)',dr10_i3(2,:)',dr10_d1(2,:)',dr10_d2(2,:)',dr10_d3(2,:)'];

graph(dr10_i1,r10_i1,1);
graph(dr10_i2,r10_i2,2);
graph(dr10_i3,r10_i3,3);
graph(dr10_d1,r10_d1,4);
graph(dr10_d2,r10_d2,5);
graph(dr10_d3,r10_d3,6);

r10_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles); % V or mV?

%% 15

% Getting the fits

r15_i1 = load('data/15_4_19.fig');
r15_i2 = load('data/15_i2_4_19.fig');
r15_i3 = load('data/15_i3_4_19.fig');
r15_d1 = load('data/15d_4_19.fig');
r15_d2 = load('data/15_d2_4_19.fig');
r15_d3 = load('data/15_d3_4_19.fig');

a = [0.1 5.5 0 1.1];

r15_i1 = fit(r15_i1,a);
r15_i2 = fit(r15_i2,a);
r15_i3 = fit(r15_i3,a);
r15_d1 = fit(r15_d1,[-1 5.5 0.5 1.1]);
r15_d2 = fit(r15_d2,a);
r15_d3 = fit(r15_d3,a);

vals = [r15_i1 r15_i2 r15_i3 r15_d1 r15_d2 r15_d3];

old_eles = [dr15_i1(2,:)',dr15_i2(2,:)',dr15_i3(2,:)',dr15_d1(2,:)',dr15_d2(2,:)',dr15_d3(2,:)'];

graph(dr15_i1,r15_i1,1);
graph(dr15_i2,r15_i2,2);
graph(dr15_i3,r15_i3,3);
graph(dr15_d1,r15_d1,4);
graph(dr15_d2,r15_d2,5);
graph(dr15_d3,r15_d3,6);

r15_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);


%% 20

% Get the fits. i1 and i2 look a little strange

r20_i1 = load('data/20_4_19.fig');
r20_i2 = load('data/20_i2_4_19.fig');
r20_i3 = load('data/20_i3_4_19.fig');
r20_d1 = load('data/20d_4_19.fig');
r20_d2 = load('data/20_d2_4_19.fig');
r20_d3 = load('data/20_d3_4_19.fig');

a = [0.2 8.5 0 1];

r20_i1 = fit(r20_i1,a);
r20_i2 = fit(r20_i2,a);
r20_i3 = fit(r20_i3,a);
r20_d1 = fit(r20_d1,a);
r20_d2 = fit(r20_d2,a);
r20_d3 = fit(r20_d3,a);

vals = [r20_i1 r20_i2 r20_i3 r20_d1 r20_d2 r20_d3];

old_eles = [dr20_i1(2,:)',dr20_i2(2,:)',dr20_i3(2,:)',dr20_d1(2,:)',dr20_d2(2,:)',dr20_d3(2,:)'];

graph(dr20_i1,r20_i1,1);
graph(dr20_i2,r20_i2,2);
graph(dr20_i3,r20_i3,3);
graph(dr20_d1,r20_d1,4);
graph(dr20_d2,r20_d2,5);
graph(dr20_d3,r20_d3,6);

r20_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 25

% Getting the fit

dr25_i1 = load('data/25_4_19.fig');
dr25_i2 = load('data/25_i2_4_19.fig');
dr25_i3 = load('data/25_i3_4_19.fig');
dr25_d1 = load('data/25d_4_19.fig');
dr25_d2 = load('data/25_d2_4_19.fig');
dr25_d3 = load('data/25_d3_4_19.fig');

a = [0.25 12 -1 1];

r25_i1 = fit(dr25_i1,a);
r25_i2 = fit(dr25_i2,a);
r25_i3 = fit(dr25_i3,a);
r25_d1 = fit(dr25_d1,a);
r25_d2 = fit(dr25_d2,[0.25 12 1 1]);
r25_d3 = fit(dr25_d3,a);

vals = [r25_i1 r25_i2 r25_i3 r25_d1 r25_d2 r25_d3];

old_eles = [dr25_i1(2,:)',dr25_i2(2,:)',dr25_i3(2,:)',dr25_d1(2,:)',dr25_d2(2,:)',dr25_d3(2,:)'];

graph(dr25_i1,r25_i1,1);
graph(dr25_i2,r25_i2,2);
graph(dr25_i3,r25_i3,3);
graph(dr25_d1,r25_d1,4);
graph(dr25_d2,r25_d2,5);
graph(dr25_d3,r25_d3,6);

r25_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 30

% Getting the fit

dr30_i1 = load('data/30_4_19.fig');
dr30_i2 = load('data/30_i2_4_19.fig');
dr30_i3 = load('data/30_i3_4_19.fig');
dr30_d1 = load('data/30d_4_19.fig');
dr30_d2 = load('data/30_d2_4_19.fig');
dr30_d3 = load('data/30_d3_4_19.fig');

a = [0.5 15 0 1];

r30_i1 = fit(dr30_i1,a);
r30_i2 = fit(dr30_i2,a);
r30_i3 = fit(dr30_i3,a);
r30_d1 = fit(dr30_d1,a);
r30_d2 = fit(dr30_d2,a);
r30_d3 = fit(dr30_d3,[0.5 15 -1 1]);

vals = [r30_i1 r30_i2 r30_i3 r30_d1 r30_d2 r30_d3];

old_eles = [dr30_i1(2,:)',dr30_i2(2,:)',dr30_i3(2,:)',dr30_d1(2,:)',dr30_d2(2,:)',dr30_d3(2,:)'];

graph(dr30_i1,r30_i1,1);
graph(dr30_i2,r30_i2,2);
graph(dr30_i3,r30_i3,3);
graph(dr30_d1,r30_d1,4);
graph(dr30_d2,r30_d2,5);
graph(dr30_d3,r30_d3,6);

r30_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 35

% Getting the fit

dr35_i1 = load('data/35_4_19.fig');
dr35_i2 = load('data/35_i2_4_19.fig');
dr35_i3 = load('data/35_i3_4_19.fig');
dr35_d1 = load('data/35d_4_19.fig');
dr35_d2 = load('data/35_d2_4_19.fig');
dr35_d3 = load('data/35_d3_4_19.fig');

a = [0.7 18 0 1];

r35_i1 = fit(dr35_i1,a);
r35_i2 = fit(dr35_i2,a);
r35_i3 = fit(dr35_i3,a);
r35_d1 = fit(dr35_d1,a);
r35_d2 = fit(dr35_d2,a);
r35_d3 = fit(dr35_d3,a);

vals = [r35_i1 r35_i2 r35_i3 r35_d1 r35_d2 r35_d3];

old_eles = [dr35_i1(2,:)',dr35_i2(2,:)',dr35_i3(2,:)',dr35_d1(2,:)',dr35_d2(2,:)',dr35_d3(2,:)'];

graph(dr35_i1,r35_i1,1);
graph(dr35_i2,r35_i2,2);
graph(dr35_i3,r35_i3,3);
graph(dr35_d1,r35_d1,4);
graph(dr35_d2,r35_d2,5);
graph(dr35_d3,r35_d3,6);

r35_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 40

% Getting the fit

dr40_i1 = load('data/40_4_19.fig');
dr40_i2 = load('data/40_i2_4_19.fig');
dr40_i3 = load('data/40_i3_4_19.fig');
dr40_d1 = load('data/40d_4_19.fig');
dr40_d2 = load('data/40_d2_4_19.fig');
dr40_d3 = load('data/40_d3_4_19.fig');

a = [0.1 22 0 1];

r40_i1 = fit(dr40_i1,a);
r40_i2 = fit(dr40_i2,[0.1 21 0 1]);
r40_i3 = fit(dr40_i3,a);
r40_d1 = fit(dr40_d1,a);
r40_d2 = fit(dr40_d2,a);
r40_d3 = fit(dr40_d3,a);

vals = [r40_i1 r40_i2 r40_i3 r40_d1 r40_d2 r40_d3];

old_eles = [dr40_i1(2,:)',dr40_i2(2,:)',dr40_i3(2,:)',dr40_d1(2,:)',dr40_d2(2,:)',dr40_d3(2,:)'];

graph(dr40_i1,r40_i1,1);
graph(dr40_i2,r40_i2,2);
graph(dr40_i3,r40_i3,3);
graph(dr40_d1,r40_d1,4);
graph(dr40_d2,r40_d2,5);
graph(dr40_d3,r40_d3,6);

r40_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 45

% Getting the fit

dr45_i1 = load('data/45_4_19.fig');
dr45_i2 = load('data/45_i2_4_19.fig');
dr45_i3 = load('data/45_i3_4_19.fig');
dr45_d1 = load('data/45d_4_19.fig');
dr45_d2 = load('data/45_d2_4_19.fig');
dr45_d3 = load('data/45_d3_4_19.fig');

a = [0.2 25 0 1];

r45_i1 = fit(dr45_i1,a);
r45_i2 = fit(dr45_i2,a);
r45_i3 = fit(dr45_i3,a);
r45_d1 = fit(dr45_d1,[0.2 26 0 1]);
r45_d2 = fit(dr45_d2,a);
r45_d3 = fit(dr45_d3,a);

vals = [r45_i1 r45_i2 r45_i3 r45_d1 r45_d2 r45_d3];

old_eles = [dr45_i1(2,:)',dr45_i2(2,:)',dr45_i3(2,:)',dr45_d1(2,:)',dr45_d2(2,:)',dr45_d3(2,:)'];

graph(dr45_i1,r45_i1,1);
graph(dr45_i2,r45_i2,2);
graph(dr45_i3,r45_i3,3);
graph(dr45_d1,r45_d1,4);
graph(dr45_d2,r45_d2,5);
graph(dr45_d3,r45_d3,6);

r45_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 50

% Getting the fit

dr50_i1 = load('data/50_4_19.fig');
dr50_i2 = load('data/50_i2_4_19.fig');
dr50_i3 = load('data/50_i3_4_19.fig');
dr50_d1 = load('data/50d_4_19.fig');
dr50_d2 = load('data/50_d2_4_19.fig');
dr50_d3 = load('data/50_d3_4_19.fig');

a = [0.04 28 0 1];

r50_i1 = fit(dr50_i1,a);
r50_i2 = fit(dr50_i2,a);
r50_i3 = fit(dr50_i3,a);
r50_d1 = fit(dr50_d1,[0.05 30 0 1]);
r50_d2 = fit(dr50_d2,a);
r50_d3 = fit(dr50_d3,a);

vals = [r50_i1 r50_i2 r50_i3 r50_d1 r50_d2 r50_d3];

old_eles = [dr50_i1(2,:)',dr50_i2(2,:)',dr50_i3(2,:)',dr50_d1(2,:)',dr50_d2(2,:)',dr50_d3(2,:)'];

graph(dr50_i1,r50_i1,1);
graph(dr50_i2,r50_i2,2);
graph(dr50_i3,r50_i3,3);
graph(dr50_d1,r50_d1,4);
graph(dr50_d2,r50_d2,5);
graph(dr50_d3,r50_d3,6);

r50_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 55

% Getting the fit

dr55_i1 = load('data/55.fig');
dr55_i2 = load('data/55_i2_4_19.fig');
dr55_i3 = load('data/55_i3_4_19.fig');
dr55_d1 = load('data/55d_4_19.fig');
dr55_d2 = load('data/55_d2_4_19.fig');
dr55_d3 = load('data/55_d3_4_19.fig');

a = [0.04 31.5 0 1];

r55_i1 = fit(dr55_i1,a);
r55_i2 = fit(dr55_i2,a);
r55_i3 = fit(dr55_i3,a);
r55_d1 = fit(dr55_d1,[0.04 33 0 1]);
r55_d2 = fit(dr55_d2,a);
r55_d3 = fit(dr55_d3,[0.04 33 0 1]);

vals = [r55_i1 r55_i2 r55_i3 r55_d1 r55_d2 r55_d3];

old_eles = [dr55_i1(2,:)',dr55_i2(2,:)',dr55_i3(2,:)',dr55_d1(2,:)',dr55_d2(2,:)',dr55_d3(2,:)'];

graph(dr55_i1,r55_i1,1);
graph(dr55_i2,r55_i2,2);
graph(dr55_i3,r55_i3,3);
graph(dr55_d1,r55_d1,4);
graph(dr55_d2,r55_d2,5);
graph(dr55_d3,r55_d3,6);

r55_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 60

% Getting the fit

dr60_i1 = load('data/60_4_19.fig');
dr60_i2 = load('data/60_i2_4_19.fig');
dr60_i3 = load('data/60_i3_4_19.fig');
dr60_d1 = load('data/60d_4_19.fig');
dr60_d2 = load('data/60_d2_4_19.fig');
dr60_d3 = load('data/60_d3_4_19.fig');

a = [0.027 34 0 1.1];

r60_i1 = fit(dr60_i1,a);
r60_i2 = fit(dr60_i2,a);
r60_i3 = fit(dr60_i3,[0.027 35 0 1.1]);
r60_d1 = fit(dr60_d1,a);
r60_d2 = fit(dr60_d2,[0.027 33 0 1.1]);
r60_d3 = fit(dr60_d3,[0.027 35 0 1.1]);

vals = [r60_i1 r60_i2 r60_i3 r60_d1 r60_d2 r60_d3];

old_eles = [dr60_i1(2,:)',dr60_i2(2,:)',dr60_i3(2,:)',dr60_d1(2,:)',dr60_d2(2,:)',dr60_d3(2,:)'];

graph(dr60_i1,r60_i1,1);
graph(dr60_i2,r60_i2,2);
graph(dr60_i3,r60_i3,3);
graph(dr60_d1,r60_d1,4);
graph(dr60_d2,r60_d2,5);
graph(dr60_d3,r60_d3,6);

r60_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 65

% Getting the fit

dr65_i1 = load('data/65c');
dr65_i2 = load('data/65_i2_4_19.fig');
dr65_i3 = load('data/65_i3_4_19.fig');
dr65_d1 = load('data/65d_4_19.fig');
dr65_d2 = load('data/65_d2_4_19.fig');
dr65_d3 = load('data/65_d3_4_19.fig');

a = [0.027 34 0 1.1];

r65_i1 = fit(dr65_i1,a);
r65_i2 = fit(dr65_i2,a);
r65_i3 = fit(dr65_i3,[0.027 35 0 1.1]);
r65_d1 = fit(dr65_d1,a);
r65_d2 = fit(dr65_d2,a);
r65_d3 = fit(dr65_d3,[0.027 35 0 1.1]);

vals = [r65_i1 r65_i2 r65_i3 r65_d1 r65_d2 r65_d3];

old_eles = [dr65_i1(2,:)',dr65_i2(2,:)',dr65_i3(2,:)',dr65_d1(2,:)',dr65_d2(2,:)',dr65_d3(2,:)'];

graph(dr65_i1,r65_i1,1);
graph(dr65_i2,r65_i2,2);
graph(dr65_i3,r65_i3,3);
graph(dr65_d1,r65_d1,4);
graph(dr65_d2,r65_d2,5);
graph(dr65_d3,r65_d3,6);

r65_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 70

% Getting the fit

dr70_i1 = load('data/70_4_19.fig');
dr70_i2 = load('data/70_i2_4_19.fig');
dr70_i3 = load('data/70_i3_4_19.fig');
dr70_d1 = load('data/70d_4_19.fig');
dr70_d2 = load('data/70_d2_4_19.fig');
dr70_d3 = load('data/70_d3_4_19.fig');

a = [0.027 34 0 1.1];

r70_i1 = fit(dr70_i1,a);
r70_i2 = fit(dr70_i2,a);
r70_i3 = fit(dr70_i3,[0.027 35 0 1.1]);
r70_d1 = fit(dr70_d1,a);
r70_d2 = fit(dr70_d2,a);
r70_d3 = fit(dr70_d3,[0.027 35 0 1.1]);

vals = [r70_i1 r70_i2 r70_i3 r70_d1 r70_d2 r70_d3];

old_eles = [dr70_i1(2,:)',dr70_i2(2,:)',dr70_i3(2,:)',dr70_d1(2,:)',dr70_d2(2,:)',dr70_d3(2,:)'];

graph(dr70_i1,r70_i1,1);
graph(dr70_i2,r70_i2,2);
graph(dr70_i3,r70_i3,3);
graph(dr70_d1,r70_d1,4);
graph(dr70_d2,r70_d2,5);
graph(dr70_d3,r70_d3,6);

r70_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 75

% Getting the fit

dr75_i1 = load('data/75_4_19.fig');
dr75_i2 = load('data/75_i2_4_19.fig');
dr75_i3 = load('data/75_i3_4_19.fig');
dr75_d1 = load('data/75d_4_19.fig');
dr75_d2 = load('data/75_d2_4_19.fig');
dr75_d3 = load('data/75_d3_4_19.fig');

a = [0.027 34 0 1.1];

r75_i1 = fit(dr75_i1,a);
r75_i2 = fit(dr75_i2,a);
r75_i3 = fit(dr75_i3,[0.027 35 0 1.1]);
r75_d1 = fit(dr75_d1,a);
r75_d2 = fit(dr75_d2,a);
r75_d3 = fit(dr75_d3,[0.027 36 0 1.1]);

vals = [r75_i1 r75_i2 r75_i3 r75_d1 r75_d2 r75_d3];

old_eles = [dr75_i1(2,:)',dr75_i2(2,:)',dr75_i3(2,:)',dr75_d1(2,:)',dr75_d2(2,:)',dr75_d3(2,:)'];

graph(dr75_i1,r75_i1,1);
graph(dr75_i2,r75_i2,2);
graph(dr75_i3,r75_i3,3);
graph(dr75_d1,r75_d1,4);
graph(dr75_d2,r75_d2,5);
graph(dr75_d3,r75_d3,6);

r75_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 80

% Getting the fit

dr80_i1 = load('data/80_4_19.fig');
dr80_i2 = load('data/80_i2_4_19.fig');
dr80_i3 = load('data/80_i3_4_19.fig');
dr80_d1 = load('data/80d_4_19.fig');
dr80_d2 = load('data/80_d2_4_19.fig');
dr80_d3 = load('data/80_d3_4_19.fig');

a = [0.027 34 0 1.1];

r80_i1 = fit(dr80_i1,a);
r80_i2 = fit(dr80_i2,[0.027 35 0 1.1]);
r80_i3 = fit(dr80_i3,[0.027 36 0 1.1]);
r80_d1 = fit(dr80_d1,a);
r80_d2 = fit(dr80_d2,a);
r80_d3 = fit(dr80_d3,[0.027 36 0 1.1]);

vals = [r80_i1 r80_i2 r80_i3 r80_d1 r80_d2 r80_d3];

old_eles = [dr80_i1(2,:)',dr80_i2(2,:)',dr80_i3(2,:)',dr80_d1(2,:)',dr80_d2(2,:)',dr80_d3(2,:)'];

graph(dr80_i1,r80_i1,1);
graph(dr80_i2,r80_i2,2);
graph(dr80_i3,r80_i3,3);
graph(dr80_d1,r80_d1,4);
graph(dr80_d2,r80_d2,5);
graph(dr80_d3,r80_d3,6);

r80_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 85

% Getting the fit

dr85_i1 = load('data/85_4_19.fig');
dr85_i2 = load('data/85_i2_4_19.fig');
dr85_i3 = load('data/85_i3_4_19.fig');
dr85_d1 = load('data/85d_4_19.fig');
dr85_d2 = load('data/85_d2_4_19.fig');
dr85_d3 = load('data/85_d3_4_19.fig');

a = [0.027 34 0 1.1];

r85_i1 = fit(dr85_i1,a);
r85_i2 = fit(dr85_i2,[0.027 35 0 1.1]);
r85_i3 = fit(dr85_i3,[0.027 36 0 1.1]);
r85_d1 = fit(dr85_d1,a);
r85_d2 = fit(dr85_d2,[0.027 36 0 1.1]);
r85_d3 = fit(dr85_d3,[0.027 36 0 1.1]);

vals = [r85_i1 r85_i2 r85_i3 r85_d1 r85_d2 r85_d3];

old_eles = [dr85_i1(2,:)',dr85_i2(2,:)',dr85_i3(2,:)',dr85_d1(2,:)',dr85_d2(2,:)',dr85_d3(2,:)'];

graph(dr85_i1,r85_i1,1);
graph(dr85_i2,r85_i2,2);
graph(dr85_i3,r85_i3,3);
graph(dr85_d1,r85_d1,4);
graph(dr85_d2,r85_d2,5);
graph(dr85_d3,r85_d3,6);

r85_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 90

% Getting the fit

dr90_i1 = load('data/90_4_19.fig');
dr90_i2 = load('data/90_i2_4_19.fig');
dr90_i3 = load('data/90_i3_4_19.fig');
dr90_d1 = load('data/90d_4_19.fig');
dr90_d2 = load('data/90_d2_4_19.fig');
dr90_d3 = load('data/90_d3_4_19.fig');

a = [0.027 34 0 1.1];

r90_i1 = fit(dr90_i1,a);
r90_i2 = fit(dr90_i2,[0.027 35 0 1.1]);
r90_i3 = fit(dr90_i3,[0.027 36 0 1.1]);
r90_d1 = fit(dr90_d1,a);
r90_d2 = fit(dr90_d2,[0.027 36 0 1.1]);
r90_d3 = fit(dr90_d3,[0.027 36 0 1.1]);

vals = [r90_i1 r90_i2 r90_i3 r90_d1 r90_d2 r90_d3];

old_eles = [dr90_i1(2,:)',dr90_i2(2,:)',dr90_i3(2,:)',dr90_d1(2,:)',dr90_d2(2,:)',dr90_d3(2,:)'];

graph(dr90_i1,r90_i1,1);
graph(dr90_i2,r90_i2,2);
graph(dr90_i3,r90_i3,3);
graph(dr90_d1,r90_d1,4);
graph(dr90_d2,r90_d2,5);
graph(dr90_d3,r90_d3,6);

r90_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 95

% Getting the fit

dr95_i1 = load('data/95_4_19.fig');
dr95_i2 = load('data/95_i2_4_19.fig');
dr95_i3 = load('data/95_i3_4_19.fig');
dr95_d1 = load('data/95d_4_19.fig');
dr95_d2 = load('data/95_d2_4_19.fig');
dr95_d3 = load('data/95_d3_4_19.fig');

a = [0.027 34 0 1.1];

r95_i1 = fit(dr95_i1,a);
r95_i2 = fit(dr95_i2,[0.027 35 0 1.1]);
r95_i3 = fit(dr95_i3,[0.027 36 0 1.1]);
r95_d1 = fit(dr95_d1,a);
r95_d2 = fit(dr95_d2,[0.027 36 0 1.1]);
r95_d3 = fit(dr95_d3,[0.027 36 0 1.1]);

vals = [r95_i1 r95_i2 r95_i3 r95_d1 r95_d2 r95_d3];

old_eles = [dr95_i1(2,:)',dr95_i2(2,:)',dr95_i3(2,:)',dr95_d1(2,:)',dr95_d2(2,:)',dr95_d3(2,:)'];

graph(dr95_i1,r95_i1,1);
graph(dr95_i2,r95_i2,2);
graph(dr95_i3,r95_i3,3);
graph(dr95_d1,r95_d1,4);
graph(dr95_d2,r95_d2,5);
graph(dr95_d3,r95_d3,6);

r95_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 100

% Getting the fit

dr100_i1 = load('data/100_4_19.fig');
dr100_i2 = load('data/100_i2_4_19.fig');
dr100_i3 = load('data/100_i3_4_19.fig');
dr100_d1 = load('data/100d_4_19.fig');
dr100_d2 = load('data/100_d2_4_19.fig');
dr100_d3 = load('data/100_d3_4_19.fig');

a = [0.027 34 0 1.1];

r100_i1 = fit(dr100_i1,a);
r100_i2 = fit(dr100_i2,[0.027 35 0 1.1]);
r100_i3 = fit(dr100_i3,[0.027 36 0 1.1]);
r100_d1 = fit(dr100_d1,a);
r100_d2 = fit(dr100_d2,[0.027 36 0 1.1]);
r100_d3 = fit(dr100_d3,[0.027 36 0 1.1]);

vals = [r100_i1 r100_i2 r100_i3 r100_d1 r100_d2 r100_d3];

old_eles = [dr100_i1(2,:)',dr100_i2(2,:)',dr100_i3(2,:)',dr100_d1(2,:)',dr100_d2(2,:)',dr100_d3(2,:)'];

graph(dr100_i1,r100_i1,1);
graph(dr100_i2,r100_i2,2);
graph(dr100_i3,r100_i3,3);
graph(dr100_d1,r100_d1,4);
graph(dr100_d2,r100_d2,5);
graph(dr100_d3,r100_d3,6);

r100_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% Functions

% loads the graphs
function a=load(data) 
    c = openfig(data,'invisible');
    b = [findobj(c,'-property','XData'); findobj(c,'-property','YData')];
    a = [b(1).XData; b(2).YData];
end

% graphs the two graphs (main and fit)
function b=graph(data,fit,n)
    figure(n)
    plot(data(1,:),data(2,:));
    hold on
    fplot(@(x) fit(1)*sin(fit(2)*x+fit(3))+fit(4),[0 5])
    hold off
end

% fits the data
function c=fit(data,vals)
    b = statset('MaxIter',100000);
    b.RobustWgtFun = 'bisquare';
    c = fitnlm(data(1,:),data(2,:),@(a,x) a(1)*sin(a(2)*x+a(3))+a(4),vals,'Options',b);
    c = table2array(c.Coefficients(:,1));
end

% first column is the magnitude ratio, second is the phase shift
function d=secondvals(w,wn,zeta)
    a = (2*zeta*w/wn);
    b = (1-(w/wn).^2);

    d = zeros(6,2);
    d(:,1) = (1./sqrt(a.^2+b.^2))';
    d(:,2) = (-atan(a./b))';
end

% makes a matrix
function e=fetch(x,func)
    e = zeros(length(x),1);
    for i=1:length(func)
        e = [e,(func(1,i)*sin(func(2,i)*x+func(3,i))+func(4,i))'];
    end
    e = e(:,2:end);
end

function f=dev(fit,data)
    a = size(fit);
    a = a(2);
    b = a(1);
    e = zeros(1,a);
    for i=1:a
        for j=1:b
            e(i) = e(i) + (fit(j,i) - data(j,i))^2;
        end
    end
    f = 1.96*sqrt(e/(length(fit)-2));
end
