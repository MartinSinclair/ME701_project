function [] = plot_step_responce(controllers,plants,varargin)

 p = inputParser;
 addParameter(p,'plant_use',{'plant_u'});
 addParameter(p,'controller_use',{'controller_INF'});
 addParameter(p,'title',{'Title'});
 addParameter(p,'feedback_array',[-1]);
 parse(p,varargin{:});

 n_cases = numel(p.plant_use);
 
 for itr = 1:n_cases
    itr_control = controllers.(p.Results.controller_use{itr});
    itr_plant = plants(p.Results.plant_use{itr});
    itr_feedback = p.Results.feedback_array(itr);
    itr_title = p.Results.title{itr};
    
 end
 
end
