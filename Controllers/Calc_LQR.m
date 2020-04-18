function [report,controller_LQR] = Calc_LQR(plant,Q,R)
% calcualtes the Hinf controler given We,Wu and the plant


[K_LQR,S_LQR,e_LQR] = lqr(plant,Q,R,[0,0]');
controller_LQR = ss(K_LQR);
controller_LQR.InputName = {'x','xdot'};
controller_LQR.OutputName={'u force'};

LQR_plant = feedback(plant,controller_LQR,'name',-1);

report= test_plant(LQR_plant);

end

