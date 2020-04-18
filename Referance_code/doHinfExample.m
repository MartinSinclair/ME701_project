% H-inf example from SBA lecture notes

%% Set up plant, weighting, and G
clear all;close all;clc;
s = tf('s');
P = 50*(s+1.4)/((s+1)*(s+2));
We = 2/(s+0.2);
Wu = (s+1)/(s+10);

G11hat = [We We*P;0 0];
G12hat = [We*P;Wu];
G21hat = [1 P];
G22hat = P;

Ghat = [G11hat G12hat;G21hat G22hat];
G = ss(Ghat,'minimal');

%% Define the H-inf controller
[Kinf,G_cl,Gam,info_inf] = hinfsyn(G,1,1,'DISPLAY','on');
figure(1);step(G_cl);

%% Define the H2 controller
[K2,G_cl2,gam,info2] = h2syn(G,1,1);
figure(2);step(G_cl2);