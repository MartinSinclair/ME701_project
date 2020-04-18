function [] = plot_map(map_to_plot)
    keys = map_to_plot.keys;
    for itr = 1:numel(keys)
        signal_out = map_to_plot(keys{itr}).get('yout').get('SensorReading').Values;
        subplot(numel(keys),1,itr);
        plot(signal_out);
        title(keys{itr},'interpreter','none')

    end
end

