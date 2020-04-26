function [fid] = plot_map(map_to_plot,varargin)

 p = inputParser;
 addParameter(p,'keys',map_to_plot.keys);
 addParameter(p,'title',map_to_plot.keys);
 addParameter(p,'FigureTitle','SimulationResponce');
 parse(p,varargin{:});
 
 n_cases = numel(p.Results.keys);
 
 fid = figure('Name',p.Results.FigureTitle);
 fid.PaperPositionMode = 'auto';
 fig_pos = fid.PaperPosition;
 fid.PaperSize = [fig_pos(3) fig_pos(4)];
 
    for itr = 1:n_cases
        key = p.Results.keys{itr};
        signal_out = map_to_plot(key).get('yout').get('SensorReading').Values;
        subplot(n_cases,1,itr);
        plot(signal_out);
        title(p.Results.title{itr})
        p1 = gca;
       if itr ~= n_cases
            p1.XLabel.String='';
            p1.XLabel.Color =[1,1,1];
            p1.XTickLabel=[];
        end
    end
end

