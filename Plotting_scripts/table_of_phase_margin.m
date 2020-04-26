function [my_data] = table_of_phase_margin(controllers,plants,varargin)

 p = inputParser;
 addParameter(p,'plant',{'plant_u'});
 addParameter(p,'controller',{'controller_INF'});
 addParameter(p,'title',{'Title'});
 addParameter(p,'FigureTitle',{'StepReponce'});
 addParameter(p,'feedback',[-1]);
 parse(p,varargin{:});

 n_cases = numel(p.Results.plant);
 
 
 for itr = 1:n_cases
    itr_control = controllers.(p.Results.controller{itr});
    itr_plant = plants.(p.Results.plant{itr});
    itr_feedback = p.Results.feedback(itr);
    itr_title = p.Results.title{itr};  
    
    CL = feedback(itr_plant,itr_control,itr_feedback,'name');
    CL = CL('position','u force');
    stability_info(itr) = allmargin(CL);
    info(itr) = stepinfo(CL);
    
    if isempty(stability_info(itr).PhaseMargin)
        % results to match the plot output name
        stability_info(itr).PhaseMargin = inf;
    else
        stability_info(itr).PhaseMargin  = stability_info(itr).PhaseMargin(end);
    end

 end
 my_data = array2table([stability_info.PhaseMargin;stability_info.Stable],...
            'VariableNames',p.Results.title,...
            'RowNames',{'PhaseMargin','isStable'});
end
