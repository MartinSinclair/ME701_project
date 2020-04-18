function [report,controller_H2] = Calc_H2(plant,We,Wu)
% calcualtes the Hinf controler given We,Wu and the plant

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
[K_2,~,Gam,info_2] = h2syn(G,1,1);

controller_H2 = ss(K_2);
controller_H2.InputName = {'position'};
controller_H2.OutputName={'u force'};
H2_plant = feedback(plant,controller_H2,'name',+1);

report= test_plant(H2_plant);

end

