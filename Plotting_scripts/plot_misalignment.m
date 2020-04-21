function [fid] = plot_misalignment(map_to_plot,varargin)

 p = inputParser;
 addParameter(p,'keys','None');
 addParameter(p,'title','None');
 addParameter(p,'misalignment',1:10);
 addParameter(p,'FigureTitle','SimulationResponce');
 parse(p,varargin{:});
 
 n_cases = numel(map_to_plot);
 
 fid = figure('Name',p.Results.FigureTitle);
 fid.PaperPositionMode = 'auto';
 fig_pos = fid.PaperPosition;
 fid.PaperSize = [fig_pos(3) fig_pos(4)];
 
 misalignment = cellstr(num2str(p.Results.misalignment));
 
 key = p.Results.keys;
    for itr = 1:n_cases
        signal_out = map_to_plot{itr}(key).get('yout').get('SensorReading').Values;
        subplot(n_cases,1,itr);
        plot(signal_out);
        ylabel('x')
        title(['Controller: ' p.Results.title,...
               ' with plant misaligned by: ',misalignment{itr}, ' degrees']);
    end
end

