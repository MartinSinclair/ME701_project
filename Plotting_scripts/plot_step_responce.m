function [] = plot_step_responce(controllers,plants,varargin)

 p = inputParser;
 addParameter(p,'plant',{'plant_u'});
 addParameter(p,'controller',{'controller_INF'});
 addParameter(p,'title',{'Title'});
 addParameter(p,'FigureTitle',{'StepReponce'});
 addParameter(p,'feedback',[-1]);
 parse(p,varargin{:});

 n_cases = numel(p.Results.plant);
 [subplot_dims] = FindClosestFactorization(n_cases);
 
 fid = figure('Name',p.Results.FigureTitle);
 fid.PaperPositionMode = 'auto';
 fig_pos = fid.PaperPosition;
 fid.PaperSize = [fig_pos(3) fig_pos(4)];
 
 for itr = 1:n_cases
    itr_control = controllers.(p.Results.controller{itr});
    itr_plant = plants.(p.Results.plant{itr});
    itr_feedback = p.Results.feedback(itr);
    itr_title = p.Results.title{itr};
    
    subplot(n_cases,1,itr);
    
    CL = feedback(itr_plant,itr_control,itr_feedback,'name');
    CL = CL('position','u force');
    stepplot(CL,30,stepDataOptions('StepAmplitude',2));
    grid on

    info = stepinfo(CL);
       
    hA=gca;hA.Title.String = [itr_title,...
        ' SettlingTime:' num2str(info.SettlingTime),...
        ' Overshoot:' num2str(info.Overshoot)];
 end
 
end
