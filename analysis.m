% Welcome!


% Do not hit run! Only run sections.

% How did you get k? - mass + deflection

% There should be no offset for initial?????

% K is the slope of the calibration line


%% To do

% sanity checking wn: go backwards from our data with mag ratio
% sanity checking wd: go backwards - fft vs hand counting
% input amplitude: a hw, work backwards
% align the phase shifts: 
% (https://www.mathworks.com/help/signal/ug/align-signals-using-cross-correlation.html)
% (https://www.mathworks.com/help/signal/ref/alignsignals.html)

%% Springs

% n = 9.81*[0.1
% 0.2
% 0.3
% 0.4
% 0.5
% 0.6
% 0.7
% 0.8
% 0.9
% 1
% 0.9
% 0.8
% 0.7
% 0.6
% 0.5
% 0.4
% 0.3
% 0.2
% 0.1];
% 
% dx = [0.9
% 1.8
% 2.1
% 3.1
% 4.2
% 5.4
% 7
% 8.7
% 9.3
% 10.5
% 9.4
% 8.2
% 6.7
% 5.7
% 4.6
% 3.5
% 2
% 1
% 0.3]/100;

n = 9.81*[0.5
0.6
0.7
0.8
0.9
1
0.9
0.8
0.7
0.6
0.5];

dx = [4.2
5.4
7
8.7
9.3
10.5
9.4
8.2
6.7
5.7
4.6]/100;

fit = polyfit(dx,n,1);

exp = fit(1)*dx+fit(2);

ur = dev(exp,n); % N

figure(1)
scatter(dx(1:6),n(1:6),'b')
hold on
scatter(dx(7:end),n(7:end),'g')
fplot(@(x) fit(1)*x+fit(2),[0.04,0.115])
title("Spring Calibration")
xlabel("Displacement (m)")
ylabel("Compressive Force (N)")
legend("Increasing Data","Decreasing Data",['N = ' num2str(fit(1)) 'x  + ' num2str(fit(2))],'Location','southeast')
hold off

%% Envelope

% envelope = loadin('data/enve.fig');

% envelope = loadin('data/lab4_12_data2.fig');
% 
% val = envelope(2,:);
% t = envelope(1,:);

% wd = env(val,t);

% t = 5-[4.355 3.93 3.475 3.04 2.46 1.825];
% v = log([0.931858 0.816733 0.778742 0.755553 0.738777]);
v1 = [0.931858 0.633685 0.816733 0.686478 0.778742 0.710489 0.755553 0.724304 0.738777]-0.7334;
v = real(log(v1));
t = [0 0.21 0.405 0.62 0.815 1.005 1.21 1.395 1.56];

giveus = polyfit(t,v,1);

giveus = real(giveus);

exp = giveus(1)*t+giveus(2);

ur = sqrt(sum((exp-v).^2)/(length(t)-2));

% figure(1)
% scatter(t,v)
% hold on
% fplot(@(x) giveus(1)*x+giveus(2),[0,1.7])
% title("Natural log of Voltage vs Time for Damping Ratio")
% ylabel("Natural log of Voltage (V)")
% xlabel("Time (s)")
% legend("Experimental Values",['ln(V) = ' num2str(giveus(1)) 't + ' num2str(giveus(2))])
% hold off

% favg = (length(t)-1)/max(t);
% wd2 = 2*pi()*favg;

% uncertainty

%% Constants

% wd = 15; % rad/s

m_cyl = 0.1344; % kg
m_plate = 0.152; % kg
% m_cyl = 0.2;
% m_plate = 0.2;

r = 150; % ohm

k = fit(1); % n/m

wn = sqrt(k/(m_cyl+m_plate)); % rad/s

zeta = -giveus(1)/wn;

cc = 2*sqrt((m_cyl+m_plate)*k);

c = zeta*cc;

K = 1/0.135507074135309;
A0 = 1.12363937301633*K;


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

volts = [dr10_i1(2,:);dr10_i2(2,:);dr10_i3(2,:);dr10_d1(2,:);dr10_d2(2,:);dr10_d3(2,:)];
time = [dr10_i1(1,:);dr10_i2(1,:);dr10_i3(1,:);dr10_d1(1,:);dr10_d2(1,:);dr10_d3(1,:)];

% graphit(dr10_i1,r10_i1,1);
% graphit(dr10_i2,r10_i2,2);
% graphit(dr10_i3,r10_i3,3);
% graphit(dr10_d1,r10_d1,4);
% graphit(dr10_d2,r10_d2,5);
% graphit(dr10_d3,r10_d3,6);

% r10_mag_shi = secondvals(vals(2,:),wn,zeta);

freq = vals(2,:);

% new_t = zombie_train(volts(1:5,:),time(1:5,:),freq(1:5));

% Random Uncertainty
old_eles = [dr10_i1(2,:)',dr10_i2(2,:)',dr10_i3(2,:)',dr10_d1(2,:)',dr10_d2(2,:)',dr10_d3(2,:)'];

eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

avgf = mean(freq(1:5)); % excluding the last point

rpm = avgf*30/pi();

inc = 1.96*std(dr10_i1(2,:))/sqrt(length(dr10_i1(2,:)));

dec = 1.96*std(dr10_d1(2,:))/sqrt(length(dr10_d1(2,:)));

%% testing

test = [dr10_i2(1,:);dr10_i2(2,:)*K+A0];

test3 = [dr10_d1(1,:);dr10_d1(2,:)*K+A0];

a = [0.1*K 2 1 1];

test2 = fitin(test,a);

test4 = fitin(test3,a);

graphit(test,test2,1)
graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

%% 15

% Getting the fitins

dr15_i1 = loadin('data/15_4_19.fig');
dr15_i2 = loadin('data/15_i2_4_19.fig');
dr15_i3 = loadin('data/15_i3_4_19.fig');
dr15_d1 = loadin('data/15d_4_19.fig');
dr15_d2 = loadin('data/15_d2_4_19.fig');
dr15_d3 = loadin('data/15_d3_4_19.fig');

a = [0.1 5.5 0 1.1];

r15_i1 = fitin(dr15_i1,a);
r15_i2 = fitin(dr15_i2,a);
r15_i3 = fitin(dr15_i3,a);
r15_d1 = fitin(dr15_d1,[-1 5.5 0.5 1.1]);
r15_d2 = fitin(dr15_d2,a);
r15_d3 = fitin(dr15_d3,a);

vals = [r15_i1 r15_i2 r15_i3 r15_d1 r15_d2 r15_d3];

old_eles = [dr15_i1(2,:)',dr15_i2(2,:)',dr15_i3(2,:)',dr15_d1(2,:)',dr15_d2(2,:)',dr15_d3(2,:)'];

% graphit(dr15_i1,r15_i1,1);
% graphit(dr15_i2,r15_i2,2);
% graphit(dr15_i3,r15_i3,3);
% graphit(dr15_d1,r15_d1,4);
% graphit(dr15_d2,r15_d2,5);
% graphit(dr15_d3,r15_d3,6);

r15_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

inc = 1.96*std(dr15_i1(2,:))/sqrt(length(dr15_i1(2,:)));

dec = 1.96*std(dr15_d1(2,:))/sqrt(length(dr15_d1(2,:)));


freq = vals(2,:);

avgf = mean(freq(1:5)); % excluding the last point

rpm = avgf*30/pi();

%%

test = [dr15_i2(1,:);dr15_i2(2,:)*K+A0];
test3 = [dr15_d1(1,:);dr15_d1(2,:)*K+A0];

a = [0.1*K 5.5 0 1.1];

test2 = fitin(test,a);
test4 = fitin(test3,[-1*K 5.5 0.5 1.1]);

graphit(test,test2,1)
graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

%% 20

% Get the fitins. i1 and i2 look a little strange

dr20_i1 = loadin('data/20_4_19.fig');
dr20_i2 = loadin('data/20_i2_4_19.fig');
dr20_i3 = loadin('data/20_i3_4_19.fig');
dr20_d1 = loadin('data/20d_4_19.fig');
dr20_d2 = loadin('data/20_d2_4_19.fig');
dr20_d3 = loadin('data/20_d3_4_19.fig');

a = [0.2 8.5 0 1];

r20_i1 = fitin(dr20_i1,a);
r20_i2 = fitin(dr20_i2,a);
r20_i3 = fitin(dr20_i3,a);
r20_d1 = fitin(dr20_d1,a);
r20_d2 = fitin(dr20_d2,a);
r20_d3 = fitin(dr20_d3,a);

vals = [r20_i1 r20_i2 r20_i3 r20_d1 r20_d2 r20_d3];

old_eles = [dr20_i1(2,:)',dr20_i2(2,:)',dr20_i3(2,:)',dr20_d1(2,:)',dr20_d2(2,:)',dr20_d3(2,:)'];

% graphit(dr20_i1,r20_i1,1);
% graphit(dr20_i2,r20_i2,2);
% graphit(dr20_i3,r20_i3,3);
% graphit(dr20_d1,r20_d1,4);
% graphit(dr20_d2,r20_d2,5);
% graphit(dr20_d3,r20_d3,6);

r20_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

inc = 1.96*std(dr20_i1(2,:))/sqrt(length(dr20_i1(2,:)));

dec = 1.96*std(dr20_d1(2,:))/sqrt(length(dr20_d1(2,:)));

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr20_i3(1,:);dr20_i3(2,:)*K+A0];
test3 = [dr20_d2(1,:);dr20_d2(2,:)*K+A0];

a = [0.2*K 8.5 0 1];

test2 = fitin(test,a);
test4 = fitin(test3,a);

graphit(test,test2,1)
graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr25_i1,r25_i1,1);
% graphit(dr25_i2,r25_i2,2);
% graphit(dr25_i3,r25_i3,3);
% graphit(dr25_d1,r25_d1,4);
% graphit(dr25_d2,r25_d2,5);
% graphit(dr25_d3,r25_d3,6);

r25_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

inc = 1.96*std(dr25_i1(2,:))/sqrt(length(dr25_i1(2,:)));

dec = 1.96*std(dr25_d1(2,:))/sqrt(length(dr25_d1(2,:)));

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr25_i3(1,:);dr25_i3(2,:)*K+A0];

a = [0.25*K 12 -1 1];

test3 = [dr25_d2(1,:);dr25_d2(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,[0.25*K 12 1 1]);

graphit(test,test2,1)
graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];


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

% graphit(dr30_i1,r30_i1,1);
% graphit(dr30_i2,r30_i2,2);
% graphit(dr30_i3,r30_i3,3);
% graphit(dr30_d1,r30_d1,4);
% graphit(dr30_d2,r30_d2,5);
% graphit(dr30_d3,r30_d3,6);

r30_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);
freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

inc = 1.96*std(dr30_i1(2,:))/sqrt(length(dr30_i1(2,:)));

dec = 1.96*std(dr30_d1(2,:))/sqrt(length(dr30_d1(2,:)));

%%

test = [dr30_i3(1,:);dr30_i3(2,:)*K+A0];

a = [0.5*K 15 0 1];

test3 = [dr30_d1(1,:);dr30_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

graphit(test,test2,1)
graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];



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

% graphit(dr35_i1,r35_i1,1);
% graphit(dr35_i2,r35_i2,2);
% graphit(dr35_i3,r35_i3,3);
% graphit(dr35_d1,r35_d1,4);
% graphit(dr35_d2,r35_d2,5);
% graphit(dr35_d3,r35_d3,6);

r35_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

test = [dr35_i1(1,:);dr35_i1(2,:)*K+A0];

a = [0.7*K 18 0 1];

test2 = fitin(test,a);

inc = 1.96*std(dr35_i1(2,:))/sqrt(length(dr35_i1(2,:)));

dec = 1.96*std(dr35_d1(2,:))/sqrt(length(dr35_d1(2,:)));

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr35_i1(1,:);dr35_i1(2,:)*K+A0];

a = [0.7*K 18 0 1];

test3 = [dr35_d1(1,:);dr35_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

graphit(test,test2,1)
graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];


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

% graphit(dr40_i1,r40_i1,1);
% graphit(dr40_i2,r40_i2,2);
% graphit(dr40_i3,r40_i3,3);
% graphit(dr40_d1,r40_d1,4);
% graphit(dr40_d2,r40_d2,5);
% graphit(dr40_d3,r40_d3,6);

r40_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr40_i1(1,:);dr40_i1(2,:)*K+A0];

a = [0.1*K 22 0 1];

test3 = [dr40_d1(1,:);dr40_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

graphit(test,test2,1)
graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

%%

test = [dr40_i3(1,:);dr40_i3(2,:)*K+A0];

a = [0.1*K 22 0 1];

test3 = [dr40_d2(1,:);dr40_d2(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

graphit(test,test2,1)
graphit(test3,test4,2)

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

% graphit(dr45_i1,r45_i1,1);
% graphit(dr45_i2,r45_i2,2);
% graphit(dr45_i3,r45_i3,3);
% graphit(dr45_d1,r45_d1,4);
% graphit(dr45_d2,r45_d2,5);
% graphit(dr45_d3,r45_d3,6);

r45_mag_shi = secondvals(vals(2,:),wn,zeta);

freq = vals(2,:);

% avgf = mean(freq(1:6)); % excluding the last point
% 
% rpm = avgf*30/pi();
% 
% test = dr45_i2(2,:)*K+A0;
% 
% figure(7)
% scatter(dr40_i2(1,:),test)
% hold on
% title("Input")
% xlabel("Time (s)")
% ylabel("Distance (in)")
% hold off

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr45_i1(1,:);dr45_i1(2,:)*K+A0];

a = [0.2*K 25 0 1];

test3 = [dr45_d1(1,:);dr45_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,[0.2*K 26 0 1]);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr50_i1,r50_i1,1);
% graphit(dr50_i2,r50_i2,2);
% graphit(dr50_i3,r50_i3,3);
% graphit(dr50_d1,r50_d1,4);
% graphit(dr50_d2,r50_d2,5);
% graphit(dr50_d3,r50_d3,6);

r50_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr50_i1(1,:);dr50_i1(2,:)*K+A0];

a = [0.04*K 28 0 1];

test3 = [dr50_d1(1,:);dr50_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,[0.05*K 30 0 1]);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr55_i1,r55_i1,1);
% graphit(dr55_i2,r55_i2,2);
% graphit(dr55_i3,r55_i3,3);
% graphit(dr55_d1,r55_d1,4);
% graphit(dr55_d2,r55_d2,5);
% graphit(dr55_d3,r55_d3,6);

r55_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr55_i1(1,:);dr55_i1(2,:)*K+A0];

a = [0.04*K 31.5 0 1];

test3 = [dr55_d1(1,:);dr55_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,[0.04*K 33 0 1]);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr60_i1,r60_i1,1);
% graphit(dr60_i2,r60_i2,2);
% graphit(dr60_i3,r60_i3,3);
% graphit(dr60_d1,r60_d1,4);
% graphit(dr60_d2,r60_d2,5);
% graphit(dr60_d3,r60_d3,6);

r60_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr60_i1(1,:);dr60_i1(2,:)*K+A0];

a = [0.027*K 34 0 1.1];

test3 = [dr60_d1(1,:);dr60_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr65_i1,r65_i1,1);
% graphit(dr65_i2,r65_i2,2);
% graphit(dr65_i3,r65_i3,3);
% graphit(dr65_d1,r65_d1,4);
% graphit(dr65_d2,r65_d2,5);
% graphit(dr65_d3,r65_d3,6);

r65_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr65_i1(1,:);dr65_i1(2,:)*K+A0];

a = [0.027*K 34 0 1.1];

test3 = [dr65_d1(1,:);dr65_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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
% 
% graphit(dr70_i1,r70_i1,1);
% graphit(dr70_i2,r70_i2,2);
% graphit(dr70_i3,r70_i3,3);
% graphit(dr70_d1,r70_d1,4);
% graphit(dr70_d2,r70_d2,5);
% graphit(dr70_d3,r70_d3,6);

r70_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr70_i1(1,:);dr70_i1(2,:)*K+A0];

a = [0.027*K 34 0 1.1];

test3 = [dr70_d1(1,:);dr70_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr75_i1,r75_i1,1);
% graphit(dr75_i2,r75_i2,2);
% graphit(dr75_i3,r75_i3,3);
% graphit(dr75_d1,r75_d1,4);
% graphit(dr75_d2,r75_d2,5);
% graphit(dr75_d3,r75_d3,6);

r75_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr75_i1(1,:);dr75_i1(2,:)*K+A0];

a = [0.027*K 34 0 1];

test3 = [dr75_d1(1,:);dr75_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr80_i1,r80_i1,1);
% graphit(dr80_i2,r80_i2,2);
% graphit(dr80_i3,r80_i3,3);
% graphit(dr80_d1,r80_d1,4);
% graphit(dr80_d2,r80_d2,5);
% graphit(dr80_d3,r80_d3,6);

r80_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr80_i1(1,:);dr80_i1(2,:)*K+A0];

a = [0.027*K 34 0 1];

test3 = [dr80_d1(1,:);dr80_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr85_i1,r85_i1,1);
% graphit(dr85_i2,r85_i2,2);
% graphit(dr85_i3,r85_i3,3);
% graphit(dr85_d1,r85_d1,4);
% graphit(dr85_d2,r85_d2,5);
% graphit(dr85_d3,r85_d3,6);

r85_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr85_i1(1,:);dr85_i1(2,:)*K+A0];

a = [0.027*K 34 0 1];

test3 = [dr85_d1(1,:);dr85_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr90_i1,r90_i1,1);
% graphit(dr90_i2,r90_i2,2);
% graphit(dr90_i3,r90_i3,3);
% graphit(dr90_d1,r90_d1,4);
% graphit(dr90_d2,r90_d2,5);
% graphit(dr90_d3,r90_d3,6);

r90_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr90_i1(1,:);dr90_i1(2,:)*K+A0];

a = [0.027*K 34 0 1];

test3 = [dr90_d1(1,:);dr90_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr95_i1,r95_i1,1);
% graphit(dr95_i2,r95_i2,2);
% graphit(dr95_i3,r95_i3,3);
% graphit(dr95_d1,r95_d1,4);
% graphit(dr95_d2,r95_d2,5);
% graphit(dr95_d3,r95_d3,6);

r95_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr95_i1(1,:);dr95_i1(2,:)*K+A0];

a = [0.027*K 34 0 1];

test3 = [dr95_d1(1,:);dr95_d1(2,:)*K+A0];

test2 = fitin(test,a);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];

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

% graphit(dr100_i1,r100_i1,1);
% graphit(dr100_i2,r100_i2,2);
% graphit(dr100_i3,r100_i3,3);
% graphit(dr100_d1,r100_d1,4);
% graphit(dr100_d2,r100_d2,5);
% graphit(dr100_d3,r100_d3,6);

r100_mag_shi = secondvals(vals(2,:),wn,zeta);

% Random Uncertainty
eles = linspace(0,4.995,1000);

new_eles = fetch(eles,vals);

standdev = dev(new_eles,old_eles);

freq = vals(2,:);

avgf = mean(freq(1:6));

rpm = avgf*30/pi();

%%

test = [dr100_i1(1,:);dr100_i1(2,:)*K+A0];

a = [0.027*K 34 0 1];

test3 = [dr100_d1(1,:);dr100_d1(2,:)*K+A0];

test2 = fitin(test,[0.027*K 35 0 1.1]);
test4 = fitin(test3,a);

% graphit(test,test2,1)
% graphit(test3,test4,2)

eles = linspace(0,4.995,1000);

mat = [test2,test4];
mat2 = [test(2,:)',test3(2,:)'];

new_eles = fetch(eles,mat);

standdev = dev(new_eles,mat2);

look = [standdev;test2(1),test4(1);rpm,0];
