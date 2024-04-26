% Welcome!


% Do not hit run! Only run sections.

% How did you get k? - mass + deflection

% There should be no offset for initial?????


%% To do

% sanity checking wn: go backwards from our data with mag ratio
% sanity checking wd: go backwards
% input amplitude: a hw, work backwards
% align the phase shifts: 
% (https://www.mathworks.com/help/signal/ug/align-signals-using-cross-correlation.html)
% (https://www.mathworks.com/help/signal/ref/alignsignals.html)


%% Envelope

% envelope = loadin('data/enve.fig');

envelope = loadin('data/lab4_12_data1.fig');

wd = env(envelope(2,:),envelope(1,:));

%% Constants

% wd = 15; % rad/s

m_cyl = 0.1344; % kg
m_plate = 0.152; % kg

r = 150; % ohm

k = 136.25; % n/m

wn = sqrt(k/(m_cyl+m_plate)); % rad/s

zeta = sqrt(1-(wd(:,1)./wn).^2); % damping ratio

cc = 2*sqrt((m_cyl+m_plate)*k);

c = zeta*cc;

%% 10

% Getting the fitins

dr10_i1 = loadin('data/10_4_19.fig');
dr10_i2 = loadin('data/10_i2_4_19.fig');
dr10_i3 = loadin('data/10_i3_4_19.fig');
dr10_d1 = loadin('data/10d_4_19.fig');
dr10_d2 = loadin('data/10_d2_4_19.fig');
dr10_d3 = loadin('data/10_d3_4_19.fig');

a = [0.1 2 1 1];

r10_i1 = fitin(dr10_i1,a);
r10_i2 = fitin(dr10_i2,a);
r10_i3 = fitin(dr10_i3,a);
r10_d1 = fitin(dr10_d1,a);
r10_d2 = fitin(dr10_d2,a);
r10_d3 = fitin(dr10_d3,a);

vals = [r10_i1 r10_i2 r10_i3 r10_d1 r10_d2 r10_d3];

old_eles = [dr10_i1(2,:)',dr10_i2(2,:)',dr10_i3(2,:)',dr10_d1(2,:)',dr10_d2(2,:)',dr10_d3(2,:)'];

graphit(dr10_i1,r10_i1,1);
graphit(dr10_i2,r10_i2,2);
graphit(dr10_i3,r10_i3,3);
graphit(dr10_d1,r10_d1,4);
graphit(dr10_d2,r10_d2,5);
graphit(dr10_d3,r10_d3,6);

r10_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles); % V or mV?

%% 15

% Getting the fitins

r15_i1 = loadin('data/15_4_19.fig');
r15_i2 = loadin('data/15_i2_4_19.fig');
r15_i3 = loadin('data/15_i3_4_19.fig');
r15_d1 = loadin('data/15d_4_19.fig');
r15_d2 = loadin('data/15_d2_4_19.fig');
r15_d3 = loadin('data/15_d3_4_19.fig');

a = [0.1 5.5 0 1.1];

r15_i1 = fitin(r15_i1,a);
r15_i2 = fitin(r15_i2,a);
r15_i3 = fitin(r15_i3,a);
r15_d1 = fitin(r15_d1,[-1 5.5 0.5 1.1]);
r15_d2 = fitin(r15_d2,a);
r15_d3 = fitin(r15_d3,a);

vals = [r15_i1 r15_i2 r15_i3 r15_d1 r15_d2 r15_d3];

old_eles = [dr15_i1(2,:)',dr15_i2(2,:)',dr15_i3(2,:)',dr15_d1(2,:)',dr15_d2(2,:)',dr15_d3(2,:)'];

graphit(dr15_i1,r15_i1,1);
graphit(dr15_i2,r15_i2,2);
graphit(dr15_i3,r15_i3,3);
graphit(dr15_d1,r15_d1,4);
graphit(dr15_d2,r15_d2,5);
graphit(dr15_d3,r15_d3,6);

r15_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 20

% Get the fitins. i1 and i2 look a little strange

r20_i1 = loadin('data/20_4_19.fig');
r20_i2 = loadin('data/20_i2_4_19.fig');
r20_i3 = loadin('data/20_i3_4_19.fig');
r20_d1 = loadin('data/20d_4_19.fig');
r20_d2 = loadin('data/20_d2_4_19.fig');
r20_d3 = loadin('data/20_d3_4_19.fig');

a = [0.2 8.5 0 1];

r20_i1 = fitin(r20_i1,a);
r20_i2 = fitin(r20_i2,a);
r20_i3 = fitin(r20_i3,a);
r20_d1 = fitin(r20_d1,a);
r20_d2 = fitin(r20_d2,a);
r20_d3 = fitin(r20_d3,a);

vals = [r20_i1 r20_i2 r20_i3 r20_d1 r20_d2 r20_d3];

old_eles = [dr20_i1(2,:)',dr20_i2(2,:)',dr20_i3(2,:)',dr20_d1(2,:)',dr20_d2(2,:)',dr20_d3(2,:)'];

graphit(dr20_i1,r20_i1,1);
graphit(dr20_i2,r20_i2,2);
graphit(dr20_i3,r20_i3,3);
graphit(dr20_d1,r20_d1,4);
graphit(dr20_d2,r20_d2,5);
graphit(dr20_d3,r20_d3,6);

r20_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 25

% Getting the fitin

dr25_i1 = loadin('data/25_4_19.fig');
dr25_i2 = loadin('data/25_i2_4_19.fig');
dr25_i3 = loadin('data/25_i3_4_19.fig');
dr25_d1 = loadin('data/25d_4_19.fig');
dr25_d2 = loadin('data/25_d2_4_19.fig');
dr25_d3 = loadin('data/25_d3_4_19.fig');

a = [0.25 12 -1 1];

r25_i1 = fitin(dr25_i1,a);
r25_i2 = fitin(dr25_i2,a);
r25_i3 = fitin(dr25_i3,a);
r25_d1 = fitin(dr25_d1,a);
r25_d2 = fitin(dr25_d2,[0.25 12 1 1]);
r25_d3 = fitin(dr25_d3,a);

vals = [r25_i1 r25_i2 r25_i3 r25_d1 r25_d2 r25_d3];

old_eles = [dr25_i1(2,:)',dr25_i2(2,:)',dr25_i3(2,:)',dr25_d1(2,:)',dr25_d2(2,:)',dr25_d3(2,:)'];

graphit(dr25_i1,r25_i1,1);
graphit(dr25_i2,r25_i2,2);
graphit(dr25_i3,r25_i3,3);
graphit(dr25_d1,r25_d1,4);
graphit(dr25_d2,r25_d2,5);
graphit(dr25_d3,r25_d3,6);

r25_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 30

% Getting the fitin

dr30_i1 = loadin('data/30_4_19.fig');
dr30_i2 = loadin('data/30_i2_4_19.fig');
dr30_i3 = loadin('data/30_i3_4_19.fig');
dr30_d1 = loadin('data/30d_4_19.fig');
dr30_d2 = loadin('data/30_d2_4_19.fig');
dr30_d3 = loadin('data/30_d3_4_19.fig');

a = [0.5 15 0 1];

r30_i1 = fitin(dr30_i1,a);
r30_i2 = fitin(dr30_i2,a);
r30_i3 = fitin(dr30_i3,a);
r30_d1 = fitin(dr30_d1,a);
r30_d2 = fitin(dr30_d2,a);
r30_d3 = fitin(dr30_d3,[0.5 15 -1 1]);

vals = [r30_i1 r30_i2 r30_i3 r30_d1 r30_d2 r30_d3];

old_eles = [dr30_i1(2,:)',dr30_i2(2,:)',dr30_i3(2,:)',dr30_d1(2,:)',dr30_d2(2,:)',dr30_d3(2,:)'];

graphit(dr30_i1,r30_i1,1);
graphit(dr30_i2,r30_i2,2);
graphit(dr30_i3,r30_i3,3);
graphit(dr30_d1,r30_d1,4);
graphit(dr30_d2,r30_d2,5);
graphit(dr30_d3,r30_d3,6);

r30_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 35

% Getting the fitin

dr35_i1 = loadin('data/35_4_19.fig');
dr35_i2 = loadin('data/35_i2_4_19.fig');
dr35_i3 = loadin('data/35_i3_4_19.fig');
dr35_d1 = loadin('data/35d_4_19.fig');
dr35_d2 = loadin('data/35_d2_4_19.fig');
dr35_d3 = loadin('data/35_d3_4_19.fig');

a = [0.7 18 0 1];

r35_i1 = fitin(dr35_i1,a);
r35_i2 = fitin(dr35_i2,a);
r35_i3 = fitin(dr35_i3,a);
r35_d1 = fitin(dr35_d1,a);
r35_d2 = fitin(dr35_d2,a);
r35_d3 = fitin(dr35_d3,a);

vals = [r35_i1 r35_i2 r35_i3 r35_d1 r35_d2 r35_d3];

old_eles = [dr35_i1(2,:)',dr35_i2(2,:)',dr35_i3(2,:)',dr35_d1(2,:)',dr35_d2(2,:)',dr35_d3(2,:)'];

graphit(dr35_i1,r35_i1,1);
graphit(dr35_i2,r35_i2,2);
graphit(dr35_i3,r35_i3,3);
graphit(dr35_d1,r35_d1,4);
graphit(dr35_d2,r35_d2,5);
graphit(dr35_d3,r35_d3,6);

r35_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 40

% Getting the fitin

dr40_i1 = loadin('data/40_4_19.fig');
dr40_i2 = loadin('data/40_i2_4_19.fig');
dr40_i3 = loadin('data/40_i3_4_19.fig');
dr40_d1 = loadin('data/40d_4_19.fig');
dr40_d2 = loadin('data/40_d2_4_19.fig');
dr40_d3 = loadin('data/40_d3_4_19.fig');

a = [0.1 22 0 1];

r40_i1 = fitin(dr40_i1,a);
r40_i2 = fitin(dr40_i2,[0.1 21 0 1]);
r40_i3 = fitin(dr40_i3,a);
r40_d1 = fitin(dr40_d1,a);
r40_d2 = fitin(dr40_d2,a);
r40_d3 = fitin(dr40_d3,a);

vals = [r40_i1 r40_i2 r40_i3 r40_d1 r40_d2 r40_d3];

old_eles = [dr40_i1(2,:)',dr40_i2(2,:)',dr40_i3(2,:)',dr40_d1(2,:)',dr40_d2(2,:)',dr40_d3(2,:)'];

graphit(dr40_i1,r40_i1,1);
graphit(dr40_i2,r40_i2,2);
graphit(dr40_i3,r40_i3,3);
graphit(dr40_d1,r40_d1,4);
graphit(dr40_d2,r40_d2,5);
graphit(dr40_d3,r40_d3,6);

r40_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 45

% Getting the fitin

dr45_i1 = loadin('data/45_4_19.fig');
dr45_i2 = loadin('data/45_i2_4_19.fig');
dr45_i3 = loadin('data/45_i3_4_19.fig');
dr45_d1 = loadin('data/45d_4_19.fig');
dr45_d2 = loadin('data/45_d2_4_19.fig');
dr45_d3 = loadin('data/45_d3_4_19.fig');

a = [0.2 25 0 1];

r45_i1 = fitin(dr45_i1,a);
r45_i2 = fitin(dr45_i2,a);
r45_i3 = fitin(dr45_i3,a);
r45_d1 = fitin(dr45_d1,[0.2 26 0 1]);
r45_d2 = fitin(dr45_d2,a);
r45_d3 = fitin(dr45_d3,a);

vals = [r45_i1 r45_i2 r45_i3 r45_d1 r45_d2 r45_d3];

old_eles = [dr45_i1(2,:)',dr45_i2(2,:)',dr45_i3(2,:)',dr45_d1(2,:)',dr45_d2(2,:)',dr45_d3(2,:)'];

graphit(dr45_i1,r45_i1,1);
graphit(dr45_i2,r45_i2,2);
graphit(dr45_i3,r45_i3,3);
graphit(dr45_d1,r45_d1,4);
graphit(dr45_d2,r45_d2,5);
graphit(dr45_d3,r45_d3,6);

r45_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 50

% Getting the fitin

dr50_i1 = loadin('data/50_4_19.fig');
dr50_i2 = loadin('data/50_i2_4_19.fig');
dr50_i3 = loadin('data/50_i3_4_19.fig');
dr50_d1 = loadin('data/50d_4_19.fig');
dr50_d2 = loadin('data/50_d2_4_19.fig');
dr50_d3 = loadin('data/50_d3_4_19.fig');

a = [0.04 28 0 1];

r50_i1 = fitin(dr50_i1,a);
r50_i2 = fitin(dr50_i2,a);
r50_i3 = fitin(dr50_i3,a);
r50_d1 = fitin(dr50_d1,[0.05 30 0 1]);
r50_d2 = fitin(dr50_d2,a);
r50_d3 = fitin(dr50_d3,a);

vals = [r50_i1 r50_i2 r50_i3 r50_d1 r50_d2 r50_d3];

old_eles = [dr50_i1(2,:)',dr50_i2(2,:)',dr50_i3(2,:)',dr50_d1(2,:)',dr50_d2(2,:)',dr50_d3(2,:)'];

graphit(dr50_i1,r50_i1,1);
graphit(dr50_i2,r50_i2,2);
graphit(dr50_i3,r50_i3,3);
graphit(dr50_d1,r50_d1,4);
graphit(dr50_d2,r50_d2,5);
graphit(dr50_d3,r50_d3,6);

r50_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 55

% Getting the fitin

dr55_i1 = loadin('data/55.fig');
dr55_i2 = loadin('data/55_i2_4_19.fig');
dr55_i3 = loadin('data/55_i3_4_19.fig');
dr55_d1 = loadin('data/55d_4_19.fig');
dr55_d2 = loadin('data/55_d2_4_19.fig');
dr55_d3 = loadin('data/55_d3_4_19.fig');

a = [0.04 31.5 0 1];

r55_i1 = fitin(dr55_i1,a);
r55_i2 = fitin(dr55_i2,a);
r55_i3 = fitin(dr55_i3,a);
r55_d1 = fitin(dr55_d1,[0.04 33 0 1]);
r55_d2 = fitin(dr55_d2,a);
r55_d3 = fitin(dr55_d3,[0.04 33 0 1]);

vals = [r55_i1 r55_i2 r55_i3 r55_d1 r55_d2 r55_d3];

old_eles = [dr55_i1(2,:)',dr55_i2(2,:)',dr55_i3(2,:)',dr55_d1(2,:)',dr55_d2(2,:)',dr55_d3(2,:)'];

graphit(dr55_i1,r55_i1,1);
graphit(dr55_i2,r55_i2,2);
graphit(dr55_i3,r55_i3,3);
graphit(dr55_d1,r55_d1,4);
graphit(dr55_d2,r55_d2,5);
graphit(dr55_d3,r55_d3,6);

r55_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 60

% Getting the fitin

dr60_i1 = loadin('data/60_4_19.fig');
dr60_i2 = loadin('data/60_i2_4_19.fig');
dr60_i3 = loadin('data/60_i3_4_19.fig');
dr60_d1 = loadin('data/60d_4_19.fig');
dr60_d2 = loadin('data/60_d2_4_19.fig');
dr60_d3 = loadin('data/60_d3_4_19.fig');

a = [0.027 34 0 1.1];

r60_i1 = fitin(dr60_i1,a);
r60_i2 = fitin(dr60_i2,a);
r60_i3 = fitin(dr60_i3,[0.027 35 0 1.1]);
r60_d1 = fitin(dr60_d1,a);
r60_d2 = fitin(dr60_d2,[0.027 33 0 1.1]);
r60_d3 = fitin(dr60_d3,[0.027 35 0 1.1]);

vals = [r60_i1 r60_i2 r60_i3 r60_d1 r60_d2 r60_d3];

old_eles = [dr60_i1(2,:)',dr60_i2(2,:)',dr60_i3(2,:)',dr60_d1(2,:)',dr60_d2(2,:)',dr60_d3(2,:)'];

graphit(dr60_i1,r60_i1,1);
graphit(dr60_i2,r60_i2,2);
graphit(dr60_i3,r60_i3,3);
graphit(dr60_d1,r60_d1,4);
graphit(dr60_d2,r60_d2,5);
graphit(dr60_d3,r60_d3,6);

r60_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 65

% Getting the fitin

dr65_i1 = loadin('data/65c');
dr65_i2 = loadin('data/65_i2_4_19.fig');
dr65_i3 = loadin('data/65_i3_4_19.fig');
dr65_d1 = loadin('data/65d_4_19.fig');
dr65_d2 = loadin('data/65_d2_4_19.fig');
dr65_d3 = loadin('data/65_d3_4_19.fig');

a = [0.027 34 0 1.1];

r65_i1 = fitin(dr65_i1,a);
r65_i2 = fitin(dr65_i2,a);
r65_i3 = fitin(dr65_i3,[0.027 35 0 1.1]);
r65_d1 = fitin(dr65_d1,a);
r65_d2 = fitin(dr65_d2,a);
r65_d3 = fitin(dr65_d3,[0.027 35 0 1.1]);

vals = [r65_i1 r65_i2 r65_i3 r65_d1 r65_d2 r65_d3];

old_eles = [dr65_i1(2,:)',dr65_i2(2,:)',dr65_i3(2,:)',dr65_d1(2,:)',dr65_d2(2,:)',dr65_d3(2,:)'];

graphit(dr65_i1,r65_i1,1);
graphit(dr65_i2,r65_i2,2);
graphit(dr65_i3,r65_i3,3);
graphit(dr65_d1,r65_d1,4);
graphit(dr65_d2,r65_d2,5);
graphit(dr65_d3,r65_d3,6);

r65_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 70

% Getting the fitin

dr70_i1 = loadin('data/70_4_19.fig');
dr70_i2 = loadin('data/70_i2_4_19.fig');
dr70_i3 = loadin('data/70_i3_4_19.fig');
dr70_d1 = loadin('data/70d_4_19.fig');
dr70_d2 = loadin('data/70_d2_4_19.fig');
dr70_d3 = loadin('data/70_d3_4_19.fig');

a = [0.027 34 0 1.1];

r70_i1 = fitin(dr70_i1,a);
r70_i2 = fitin(dr70_i2,a);
r70_i3 = fitin(dr70_i3,[0.027 35 0 1.1]);
r70_d1 = fitin(dr70_d1,a);
r70_d2 = fitin(dr70_d2,a);
r70_d3 = fitin(dr70_d3,[0.027 35 0 1.1]);

vals = [r70_i1 r70_i2 r70_i3 r70_d1 r70_d2 r70_d3];

old_eles = [dr70_i1(2,:)',dr70_i2(2,:)',dr70_i3(2,:)',dr70_d1(2,:)',dr70_d2(2,:)',dr70_d3(2,:)'];

graphit(dr70_i1,r70_i1,1);
graphit(dr70_i2,r70_i2,2);
graphit(dr70_i3,r70_i3,3);
graphit(dr70_d1,r70_d1,4);
graphit(dr70_d2,r70_d2,5);
graphit(dr70_d3,r70_d3,6);

r70_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 75

% Getting the fitin

dr75_i1 = loadin('data/75_4_19.fig');
dr75_i2 = loadin('data/75_i2_4_19.fig');
dr75_i3 = loadin('data/75_i3_4_19.fig');
dr75_d1 = loadin('data/75d_4_19.fig');
dr75_d2 = loadin('data/75_d2_4_19.fig');
dr75_d3 = loadin('data/75_d3_4_19.fig');

a = [0.027 34 0 1.1];

r75_i1 = fitin(dr75_i1,a);
r75_i2 = fitin(dr75_i2,a);
r75_i3 = fitin(dr75_i3,[0.027 35 0 1.1]);
r75_d1 = fitin(dr75_d1,a);
r75_d2 = fitin(dr75_d2,a);
r75_d3 = fitin(dr75_d3,[0.027 36 0 1.1]);

vals = [r75_i1 r75_i2 r75_i3 r75_d1 r75_d2 r75_d3];

old_eles = [dr75_i1(2,:)',dr75_i2(2,:)',dr75_i3(2,:)',dr75_d1(2,:)',dr75_d2(2,:)',dr75_d3(2,:)'];

graphit(dr75_i1,r75_i1,1);
graphit(dr75_i2,r75_i2,2);
graphit(dr75_i3,r75_i3,3);
graphit(dr75_d1,r75_d1,4);
graphit(dr75_d2,r75_d2,5);
graphit(dr75_d3,r75_d3,6);

r75_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 80

% Getting the fitin

dr80_i1 = loadin('data/80_4_19.fig');
dr80_i2 = loadin('data/80_i2_4_19.fig');
dr80_i3 = loadin('data/80_i3_4_19.fig');
dr80_d1 = loadin('data/80d_4_19.fig');
dr80_d2 = loadin('data/80_d2_4_19.fig');
dr80_d3 = loadin('data/80_d3_4_19.fig');

a = [0.027 34 0 1.1];

r80_i1 = fitin(dr80_i1,a);
r80_i2 = fitin(dr80_i2,[0.027 35 0 1.1]);
r80_i3 = fitin(dr80_i3,[0.027 36 0 1.1]);
r80_d1 = fitin(dr80_d1,a);
r80_d2 = fitin(dr80_d2,a);
r80_d3 = fitin(dr80_d3,[0.027 36 0 1.1]);

vals = [r80_i1 r80_i2 r80_i3 r80_d1 r80_d2 r80_d3];

old_eles = [dr80_i1(2,:)',dr80_i2(2,:)',dr80_i3(2,:)',dr80_d1(2,:)',dr80_d2(2,:)',dr80_d3(2,:)'];

graphit(dr80_i1,r80_i1,1);
graphit(dr80_i2,r80_i2,2);
graphit(dr80_i3,r80_i3,3);
graphit(dr80_d1,r80_d1,4);
graphit(dr80_d2,r80_d2,5);
graphit(dr80_d3,r80_d3,6);

r80_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 85

% Getting the fitin

dr85_i1 = loadin('data/85_4_19.fig');
dr85_i2 = loadin('data/85_i2_4_19.fig');
dr85_i3 = loadin('data/85_i3_4_19.fig');
dr85_d1 = loadin('data/85d_4_19.fig');
dr85_d2 = loadin('data/85_d2_4_19.fig');
dr85_d3 = loadin('data/85_d3_4_19.fig');

a = [0.027 34 0 1.1];

r85_i1 = fitin(dr85_i1,a);
r85_i2 = fitin(dr85_i2,[0.027 35 0 1.1]);
r85_i3 = fitin(dr85_i3,[0.027 36 0 1.1]);
r85_d1 = fitin(dr85_d1,a);
r85_d2 = fitin(dr85_d2,[0.027 36 0 1.1]);
r85_d3 = fitin(dr85_d3,[0.027 36 0 1.1]);

vals = [r85_i1 r85_i2 r85_i3 r85_d1 r85_d2 r85_d3];

old_eles = [dr85_i1(2,:)',dr85_i2(2,:)',dr85_i3(2,:)',dr85_d1(2,:)',dr85_d2(2,:)',dr85_d3(2,:)'];

graphit(dr85_i1,r85_i1,1);
graphit(dr85_i2,r85_i2,2);
graphit(dr85_i3,r85_i3,3);
graphit(dr85_d1,r85_d1,4);
graphit(dr85_d2,r85_d2,5);
graphit(dr85_d3,r85_d3,6);

r85_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 90

% Getting the fitin

dr90_i1 = loadin('data/90_4_19.fig');
dr90_i2 = loadin('data/90_i2_4_19.fig');
dr90_i3 = loadin('data/90_i3_4_19.fig');
dr90_d1 = loadin('data/90d_4_19.fig');
dr90_d2 = loadin('data/90_d2_4_19.fig');
dr90_d3 = loadin('data/90_d3_4_19.fig');

a = [0.027 34 0 1.1];

r90_i1 = fitin(dr90_i1,a);
r90_i2 = fitin(dr90_i2,[0.027 35 0 1.1]);
r90_i3 = fitin(dr90_i3,[0.027 36 0 1.1]);
r90_d1 = fitin(dr90_d1,a);
r90_d2 = fitin(dr90_d2,[0.027 36 0 1.1]);
r90_d3 = fitin(dr90_d3,[0.027 36 0 1.1]);

vals = [r90_i1 r90_i2 r90_i3 r90_d1 r90_d2 r90_d3];

old_eles = [dr90_i1(2,:)',dr90_i2(2,:)',dr90_i3(2,:)',dr90_d1(2,:)',dr90_d2(2,:)',dr90_d3(2,:)'];

graphit(dr90_i1,r90_i1,1);
graphit(dr90_i2,r90_i2,2);
graphit(dr90_i3,r90_i3,3);
graphit(dr90_d1,r90_d1,4);
graphit(dr90_d2,r90_d2,5);
graphit(dr90_d3,r90_d3,6);

r90_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 95

% Getting the fitin

dr95_i1 = loadin('data/95_4_19.fig');
dr95_i2 = loadin('data/95_i2_4_19.fig');
dr95_i3 = loadin('data/95_i3_4_19.fig');
dr95_d1 = loadin('data/95d_4_19.fig');
dr95_d2 = loadin('data/95_d2_4_19.fig');
dr95_d3 = loadin('data/95_d3_4_19.fig');

a = [0.027 34 0 1.1];

r95_i1 = fitin(dr95_i1,a);
r95_i2 = fitin(dr95_i2,[0.027 35 0 1.1]);
r95_i3 = fitin(dr95_i3,[0.027 36 0 1.1]);
r95_d1 = fitin(dr95_d1,a);
r95_d2 = fitin(dr95_d2,[0.027 36 0 1.1]);
r95_d3 = fitin(dr95_d3,[0.027 36 0 1.1]);

vals = [r95_i1 r95_i2 r95_i3 r95_d1 r95_d2 r95_d3];

old_eles = [dr95_i1(2,:)',dr95_i2(2,:)',dr95_i3(2,:)',dr95_d1(2,:)',dr95_d2(2,:)',dr95_d3(2,:)'];

graphit(dr95_i1,r95_i1,1);
graphit(dr95_i2,r95_i2,2);
graphit(dr95_i3,r95_i3,3);
graphit(dr95_d1,r95_d1,4);
graphit(dr95_d2,r95_d2,5);
graphit(dr95_d3,r95_d3,6);

r95_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

%% 100

% Getting the fitin

dr100_i1 = loadin('data/100_4_19.fig');
dr100_i2 = loadin('data/100_i2_4_19.fig');
dr100_i3 = loadin('data/100_i3_4_19.fig');
dr100_d1 = loadin('data/100d_4_19.fig');
dr100_d2 = loadin('data/100_d2_4_19.fig');
dr100_d3 = loadin('data/100_d3_4_19.fig');

a = [0.027 34 0 1.1];

r100_i1 = fitin(dr100_i1,a);
r100_i2 = fitin(dr100_i2,[0.027 35 0 1.1]);
r100_i3 = fitin(dr100_i3,[0.027 36 0 1.1]);
r100_d1 = fitin(dr100_d1,a);
r100_d2 = fitin(dr100_d2,[0.027 36 0 1.1]);
r100_d3 = fitin(dr100_d3,[0.027 36 0 1.1]);

vals = [r100_i1 r100_i2 r100_i3 r100_d1 r100_d2 r100_d3];

old_eles = [dr100_i1(2,:)',dr100_i2(2,:)',dr100_i3(2,:)',dr100_d1(2,:)',dr100_d2(2,:)',dr100_d3(2,:)'];

graphit(dr100_i1,r100_i1,1);
graphit(dr100_i2,r100_i2,2);
graphit(dr100_i3,r100_i3,3);
graphit(dr100_d1,r100_d1,4);
graphit(dr100_d2,r100_d2,5);
graphit(dr100_d3,r100_d3,6);

r100_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);
