function [report,controller_INF] = Calc_Hinf(plant,We,Wu)
% calcualtes the Hinf controler given We,Wu and the plant
try
% assume 
Winput = tf([0,1],[0,1]);
Wsensor = tf([0,1],[0,1]);

% calc plant
P = tf(plant);
% w = [sensor,input]
% z = [error,command]
G11hat = [We*Wsensor We*P*Winput;0 0]; % w->z % sensor all comes from u
G12hat = [We*P;Wu]; % u->z
G21hat = [eye(1) P];% w->y
G22hat = P; % u->y
Ghat = [G11hat G12hat;G21hat G22hat];
G = ss(Ghat,'minimal');

% solve controler
[K_inf,~,Gam,info_inf] = hinfsyn(G,1,1);

controller_INF = ss(K_inf);
controller_INF.InputName = {'position'};
controller_INF.OutputName={'u force'};
Hinf_plant = feedback(plant,controller_INF,'name',+1);

report = test_plant(Hinf_plant);
catch
   report.stepinfo(1).SettlingTime = NaN;
end
end

