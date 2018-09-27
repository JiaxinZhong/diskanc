%% import data
load exp/data/exp_cmpall.mat


%% plot the figure
% set the marker
num_crv = 4;
num_mkr = 10;

f = cell(num_crv,1);
NR = cell(num_crv,1);
f{1} = f_a0p1;
f{2} = f_a0p2;
f{3} = f_inf;
f{4} = f_grd;
NR{1} = NR_a0p1;
NR{2} = NR_a0p2;
NR{3} = NR_inf;
NR{4} = NR_grd;
stp_mkr = zeros(num_crv,1);
stt_mkr = zeros(num_crv,1);
idx_mkr = cell(num_crv,1);
for i = 1:num_crv
   stp_mkr(i) = ceil(length(f{i}) / num_mkr);
   stt_mkr(i) = ceil(stp_mkr(i) * i / num_crv);
   idx_mkr{i} = stt_mkr(i) : stp_mkr(i) : length(f{i});
end

figure
plot(f{1}(stt_mkr(1)), NR{1}(stt_mkr(1)), '-o', 'color', ca1);
hold on
plot(f{2}(stt_mkr(2)), NR{2}(stt_mkr(2)), '-*', 'color', ca2);
plot(f{3}(stt_mkr(3)), NR{3}(stt_mkr(3)), '-^', 'color', ca3);
plot(f{4}(stt_mkr(4)), NR{4}(stt_mkr(4)), '-d', 'color', ca4);

plot(f{1}(idx_mkr{1}), NR{1}(idx_mkr{1}), 'o', 'color', ca1);
plot(f{2}(idx_mkr{2}), NR{2}(idx_mkr{2}), '*', 'color', ca2);
plot(f{3}(idx_mkr{3}), NR{3}(idx_mkr{3}), '^', 'color', ca3);
plot(f{4}(idx_mkr{4}), NR{4}(idx_mkr{4}), 'd', 'color', ca4);

plot(f{1}, NR{1}, '-', 'color', ca1);
plot(f{2}, NR{2}, '-', 'color', ca2);
plot(f{3}, NR{3}, '-', 'color', ca3);
plot(f{4}, NR{4}, '-', 'color', ca4);


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
print(sprintf('%s_cache.jpg',mfilename('fullpath')), '-djpeg',...
    '-r300');
