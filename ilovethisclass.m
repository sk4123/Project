clc
clear

%% Loading in the figures, getting the data into rows. Close the figures after!!

% rpm10data = load('10 RPM.fig');
% rpm20data = load('20 RPM.fig');
% rpm30data = load('30 RPM.fig');
% rpm40data = load('RPM 40.fig');
% rpm50data = load('RPM 50.fig');

r1 = load('data/10_4_19.fig');
r2 = load('data/10_i2_4_19.fig');
r3 = load('data/10_i3_4_19.fig');
r4 = load('data/10d_4_19.fig');
r5 = load('data/10_d2_4_19.fig');
r6 = load('data/10_d3_4_19.fig');

%% 10%

a = [0.1 2 1 1];

r_1 = fit(r1,a);
r_2 = fit(r2,a);
r_3 = fit(r3,a); % neg amp
r_4 = fit(r4,a);
r_5 = fit(r5,a); % neg amp
r_6 = fit(r6,a);

graph('data/10_4_19.fig',r_1,1);
graph('data/10_i2_4_19.fig',r_2,2);
graph('data/10_i3_4_19.fig',r_3,3);
graph('data/10d_4_19.fig',r_4,4);
graph('data/10_d2_4_19.fig',r_5,5);
graph('data/10_d3_4_19.fig',r_6,6);

%% Getting the fit data

% r1f = fitnlm(rpm10data(1,:),rpm10data(2,:),@(a,x) a(1)*sin(a(2)*x+a(3))+a(4),[1 1 1 1]);
% r2f = fitnlm(rpm20data(1,:),rpm20data(2,:),@(b,x) b(1)*sin(b(2)*x+b(3))+b(4),[0.035 7.9 1 0.7]); % a little scuffed
% r3f = fitnlm(rpm30data(1,:),rpm30data(2,:),@(c,x) c(1)*sin(c(2)*x+c(3))+c(4),[0.1 15 -1 0.7]);
% r4f = fitnlm(rpm40data(1,:),rpm40data(2,:),@(d,x) d(1)*sin(d(2)*x+d(3))+d(4),[1 22 0 0.7]); % negative amplitude
% r5f = fitnlm(rpm50data(1,:),rpm50data(2,:),@(e,x) e(1)*sin(e(2)*x+e(3))+e(4),[0.1 30 1 0.7]);

% r1f = table2array(r1f.Coefficients(:,1));
% r2f = table2array(r2f.Coefficients(:,1));
% r3f = table2array(r3f.Coefficients(:,1));
% r4f = table2array(r4f.Coefficients(:,1));
% r5f = table2array(r5f.Coefficients(:,1));


% graph('10 RPM.fig',r1f,1)
% graph('20 RPM.fig',r2f,2)
% graph('30 RPM.fig',r3f,3)
% graph('RPM 40.fig',r4f,4)
% graph('RPM 50.fig',r5f,5)


%% Functions

function a=load(data)
    c = openfig(data);
    b = [findobj(c,'-property','XData'); findobj(c,'-property','YData')];
    a = [b(1).XData; b(2).YData];
end

function b=graph(data,fit,n)
    figure(n)
    openfig(data);
    hold on
    fplot(@(x) fit(1)*sin(fit(2)*x+fit(3))+fit(4),[0 5])
    hold off
end

function c=fit(data,vals)
    c = fitnlm(data(1,:),data(2,:),@(a,x) a(1)*sin(a(2)*x+a(3))+a(4),vals);
    c = table2array(c.Coefficients(:,1));
end
