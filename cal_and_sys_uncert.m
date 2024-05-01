%% Distance calibration

clear
clc

in_16_5 = loadin('data/16.5_in.fig');
in_18_625 = loadin('data/18.625_in.fig');
in_20_375 = loadin('data/20.375_in.fig');
in_22_625 = loadin('data/22.625_in.fig');
in_24_75 = loadin('data/24.75_in.fig');

l = [16.5 18.625 20.375 22.625 24.75];

v16 = [mean(in_16_5(2,:)) std(in_16_5(2,:))];
v18 = [mean(in_18_625(2,:)) std(in_18_625(2,:))];
v20 = [mean(in_20_375(2,:)) std(in_20_375(2,:))];
v22 = [mean(in_22_625(2,:)) std(in_22_625(2,:))];
v24 = [mean(in_24_75(2,:)) std(in_24_75(2,:))];

vals = [v16(1) v18(1) v20(1) v22(1) v24(1)];
std = [v16(2) v18(2) v20(2) v22(2) v24(2)];

[b m] = doit(std,l,vals);

% Random Uncertainty
exp = m*l+b;

u_r = dev(exp,vals); % volts

figure(1)
scatter(l,vals,'b')
hold on
scatter(l,exp,'r')
fplot(@(x) m*x+b,[15,25])
errorbar(l,exp,u_r,'LineStyle','none','Color','b')
legend("Experimental","Fit",['V = ' num2str(m) 'd  ' num2str(b)],'Location','southeast')
title("Optical Sensor Calibration")
xlabel("Distance (inches)")
ylabel("Voltage (V)")
hold off

% Systematic uncertainty is calculated in the dedicated section

%% Systematic Uncertainty

% Values from the optical sensor's datasheet
% analog output from 4 mA to 20 mA?
% assuming fast.
resd = 1; % mm
repeatability = 5; % mm
accuracy = 10; % mm
responsetime = 20; % ms
outputrate = 4; % ms
resb = 16; % bits
hyst = 10; % mm. Sheet says 10 ... 1000

% from the measuring
res = 1/8; % in