%% import experimental data
exp_data_0922_import;

%% parameters
h = 0.024; % the height of the sound center of the loudspeaker
w = 0.038; % the distance between the sound center of the loudspeaker and the vertical reflecting surface
rpc = 0.1; % the distance between the primary and secondary sources
loc_p = [0;h;w+rpc];
loc_c = [0;h;w];

%% plot the figure
num_fig = 2;
switch num_fig
    case 1
        figure
        plot(f, NR_a0p2_l0p038, '-o', 'color', ca1, 'markersize', 12);
        hold on
        plot(f, NR_a0p2_l0p088, '-*', 'color', ca2, 'markersize', 12);
        plot(f, NR_a0p2_l0p138, '-^', 'color',ca3, 'markersize', 12);
%         plot(f, NR_grd, '-d', 'color', ca4, 'markersize', 8)
        
        xlabel('Frequency (Hz)')
        ylabel('NR (dB)')
        legend({'$$a=0.2$$ m, $$l = 0.038$$ m', ...
            '$$a=0.2$$ m, $$l = 0.088$$ m',  ...
            '$$a=0.2$$ m, $$l = 0.138$$ m'});
        f_tick = [400:200:2000];
        set(gca,'xtick',f_tick);
        ylim([-2,18]);
        set(gca,'ytick',-2:2:18)
        xlim([300,2000])
        print(sprintf('%s_case1_cache.jpg',mfilename('fullpath')), '-djpeg',...
            '-r300');
        
    case 2
        figure
        plot(f, NR_a0p1, '-o', 'color', ca1, 'markersize', 12);
        hold on
        plot(f, NR_a0p2_l0p038, '-*', 'color', ca2, 'markersize', 12);
        plot(f, NR_inf, '-^', 'color',ca3, 'markersize', 12);
        plot(f, NR_grd, '-d', 'color',ca4, 'markersize', 12);

        xlabel('Frequency (Hz)')
        ylabel('NR (dB)')
        legend({'Semicircular disk, $$a=0.1$$ m',...
            'Semicircular disk, $$a=0.2$$ m',...
            'Infinitely large', 'Only ground'},...
            'location', 'northeast')
        f_tick = 400:200:2000;
        set(gca,'xtick',f_tick);
        xlim([300,2000])
        ylim([-2,20])
        set(gca,'ytick',-2:2:20);
        print(sprintf('%s_case2_cache.jpg',mfilename('fullpath')), '-djpeg',...
            '-r300');
end