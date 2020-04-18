function [] = plotScores(score,We,Wu,name,decimation)

data_to_plot = squeeze(score(1,:,:));
%% make figures
figure()
surf(data_to_plot);
hA = gca;

xlabel('Wu cutoff');
ylabel('We cutoff');
zlabel('SettlingTime');

hA.YTick = 1:decimation.we:numel(We);
hA.YTickLabel = We(1:decimation.we:end);
hA.XTick = 1:decimation.wu:numel(Wu);
hA.XTickLabel = Wu(1:decimation.wu:end);

title(name);

end

