function [fid,hA] = plot_cutoff_search(settle_data,varargin)
 
%% process input data
 settle_data = squeeze(settle_data);
 p = inputParser;
 addParameter(p,'x_array',1:size(settle_data,1));
 addParameter(p,'y_array',1:size(settle_data,2));
 addParameter(p,'title','Response Signal');
 addParameter(p,'x_label','x');
 addParameter(p,'y_label','y');
 addParameter(p,'z_label','z');
 parse(p,varargin{:});
 
 plot_title = matlab.lang.makeValidName(p.Results.title);

 %% size figure to be saved using the print command
 fid = figure('Name',plot_title);
 fid.PaperPositionMode = 'auto';
 fig_pos = fid.PaperPosition;
 fid.PaperSize = [fig_pos(3) fig_pos(4)];
 
 %% contents of the figure
hA(1) = subplot(2,2,3);
plot_sub_func(settle_data,p);view([90,0]);
hA(2) = subplot(2,2,4);
plot_sub_func(settle_data,p);view([0,0]);
hA(3) = subplot(2,2,1:2);
plot_sub_func(settle_data,p);view([130,45])
 %% find minimum value
 min_val = min(settle_data,[],'all');
[x,y]=find(settle_data==min_val);
 Wx = p.Results.x_array(x);
 Wy = p.Results.y_array(y);
 
  title([plot_title,': min value (',num2str(min_val),') at ',...
      p.Results.x_label,'=',num2str(Wx),' and ',...
      p.Results.y_label,'=',num2str(Wy)])

 %% clean up axis on figure
%  outerpos = hA.OuterPosition;
%  ti = [0.030,0.030,0.030,0.030];
%  left = outerpos(1) + ti(1);
%  bottom = outerpos(2) + ti(2);
%  ax_width = outerpos(3) - ti(1) - ti(3);
%  ax_height = outerpos(4) - ti(2) - ti(4);
%  hA.Position = [left bottom ax_width ax_height];
end
function [] = plot_sub_func(settle_data,p)
 surf(p.Results.x_array,p.Results.y_array,settle_data');
 shading interp
 caxis([5 12])
 
 hA = gca;
 % label figure
 xlabel(hA,p.Results.x_label);
 ylabel(hA,p.Results.y_label);
 zlabel(hA,p.Results.z_label);
 zlim([5,20])
 
end
