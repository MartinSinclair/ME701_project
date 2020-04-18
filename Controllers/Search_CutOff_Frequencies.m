%% nominal plant parameters
k = 1;
m = 1;
b = 0.2;
%% define array of plants
plant_count = 1;

plant_array = repmat(struct('nominal',ss(0),'augmented',ss(0)),1,1);

%% calculate plants
A = [0,1;-k/m,-b/m];
B = [0;1/m];
C = [1,0];
D = [0];
Ca = [C;eye(size(A))];
Da = [D;zeros(length(A),1)];
plant_array(1).nominal = ss(A,B,C,D);
plant_array(1).nominal.InputName = {'u force'};
plant_array(1).nominal.StateName={'x','xdot'};
plant_array(1).nominal.OutputName={'position'};

plant_array(1).augmented = ss(A,B,Ca,Da);
plant_array(1).augmented.InputName = {'u force'};
plant_array(1).augmented.StateName={'x','xdot'};
plant_array(1).augmented.OutputName={'position','x','xdot'};


A = [1,1;1,1];
B = [0;1];
C = [1,0];
D = [0];
Ca = [C;eye(size(A))];
Da = [D;zeros(length(A),1)];

plant_array(2).augmented = ss(A,B,Ca,Da);
plant_array(2).augmented.InputName = {'u force'};
plant_array(2).augmented.StateName={'x','xdot'};
plant_array(2).augmented.OutputName={'position','x','xdot'};

 high_pass = @(Wc) tf([1,0],[1,2*pi*Wc]);
 low_pass = @(Wc) tf([0,2*pi*Wc],[1,2*pi*Wc]);


 
 We_array = linspace(-0.1,3,400);
 Wu_array = [linspace(-1,10,53),linspace(10,1000,100)];
 
 N_we = numel(We_array);
 N_wu = numel(Wu_array);
 
 score_h_h = NaN(numel(plant_array),N_we,N_wu);
 score_l_l = NaN(numel(plant_array),N_we,N_wu);
 score_h_l = NaN(numel(plant_array),N_we,N_wu);
 score_l_h = NaN(numel(plant_array),N_we,N_wu);
 
 dataStore.score_h_h = cell(numel(plant_array),N_we,N_wu);
 dataStore.score_l_l = cell(numel(plant_array),N_we,N_wu);
 dataStore.score_h_l = cell(numel(plant_array),N_we,N_wu);
 dataStore.score_l_h = cell(numel(plant_array),N_we,N_wu);
 
for itr_plant = 1:numel(plant_count)
    plant = plant_array(itr_plant);
    for itr_we = 1:numel(We_array)
        for itr_wu = 1:numel(Wu_array)
            We = We_array(itr_we);
            Wu = Wu_array(itr_wu);
            %% low pass on both
%             temp = Calc_Hinf(plant.nominal,low_pass(We),low_pass(Wu));
%             score_l_l(itr_plant,itr_we,itr_wu) = temp.stepinfo(1).SettlingTime;
%             dataStore.score_l_l{itr_plant,itr_we,itr_wu} = temp;
            %% low pass on Wu highpass on We
%             temp = Calc_Hinf(plant.nominal,high_pass(We),low_pass(Wu));
%             score_h_l(itr_plant,itr_we,itr_wu) = temp.stepinfo(1).SettlingTime;
%             dataStore.score_h_l{itr_plant,itr_we,itr_wu} = temp;
            %% low pass on We high pass on Wu
            temp = Calc_Hinf(plant.nominal,low_pass(We),high_pass(Wu));
            score_l_h(itr_plant,itr_we,itr_wu) = temp.stepinfo(1).SettlingTime;
            dataStore.score_l_h{itr_plant,itr_we,itr_wu} = temp;
            %% high pass on both
%             temp = Calc_Hinf(plant.nominal,high_pass(We),high_pass(Wu));
%             score_h_h(itr_plant,itr_we,itr_wu) = temp.stepinfo(1).SettlingTime;
%             dataStore.score_h_h{itr_plant,itr_we,itr_wu} = temp;
        end
    end
end

save('dataLogging.mat','dataStore','score_h_h','score_l_l','score_h_l','score_l_h','We_array','Wu_array');

%% plots
decimation.we = 10;
decimation.wu = 10;
plotScores(score_h_h,We_array,Wu_array,'high pass on both',decimation)
plotScores(score_l_l,We_array,Wu_array,'low pass on both',decimation)
plotScores(score_l_h,We_array,Wu_array,'high pass Wu low pass We',decimation)
plotScores(score_h_l,We_array,Wu_array,'low pass Wu high pass We',decimation)
