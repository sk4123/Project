k = 77.2519130329163; % n/m
m = 0.1344+0.152;
c = 1.20997241160126;
z = 0.122577900107217;
wn = sqrt(k/m);

K = 1/0.135507074135309;
A0 = 1.12363937301633*K;

gg = 2.5-A0/K;

fuck = [0.693417557279208 0.893131666956441 1.14481674399265 1.79444562053933 3.27727594400827 1.80113990266293 0.837280705564465]/0.693417557279208;
fuckme = [0.70215 0.93807 1.2452 2.4204 3.1853 1.6332 0.70587]/0.693417557279208;
fuck2 = [2.46949864591053 5.57563197604477 8.25326730510455 11.4403259591822 15.625912972468940 18.4022973216009 21.6174127924086]/wn;

error = [0.485 0.232 0.1343 0.104 0.091 0.084 0.093];
error2 = [0.35 0.22 0.15 0.09 0.1 0.07 0.1];

figure(1)
fplot(@(x) 1/(sqrt((1-(x)^2)^2+(2*z*x)^2)),[0,2],'b')
% fplot(@(x) 1/(sqrt((wn^2-(x)^2)^2+(2*z*x*wn)^2)),[0,4])
hold on
title("Magnitude Ratio vs Frequency Ratio")
xlabel("Frequency Ratio")
ylabel("Magnitude Ratio")
scatter(fuck2,fuck)
scatter(fuck2,fuckme)
errorbar(fuck2,fuck,error,"LineStyle","none")
errorbar(fuck2,fuckme,error2,"LineStyle","none")
legend("Theoretical","Actual Increasing","Actual Decreasing")
hold on

figure(2)
fplot(@(x) -atan((2*z*x)/(1-x^2)),[0,0.9999999],'b')
hold on
fplot(@(x) -atan((2*z*x)/(1-x^2))-pi,[1.00000001,2],'b')
xlabel("Frequency Ratio")
ylabel("Phase shift")
title("Theoretical Phase Shift")
hold off