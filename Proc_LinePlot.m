% % Line plot format
% Performs the same plotting as the bar plot in the Processivity section,
% but plots data as a lineplot.

figure; hold on;
    % Plot over transcript length
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,seqlength, proc_all.("Pol_24-3"),'-r','LineWidth',1);hold on;
plot(ax1,seqlength, proc_all.("Pol_38-6"),'-b','LineWidth',1);hold on;
xlim([19,63])
xlabel('Transcript Length (nt)')
ax2 = axes(t);

    % plot over sequence
plot(ax2,seqlength, proc_all.("Pol_24-3"),'-r','LineWidth',1);hold on;
plot(ax2,seqlength, proc_all.("Pol_38-6"),'-b','LineWidth',1);hold on;
ax2.Color = 'none';
ax2.XAxisLocation = 'top';
xlabel('Terminal Nucleotide')
xlim([19,63])
xticks(seqlength)
xticklabels(seq')

    % Set y-axis and plot size.
ax1.YAxis.Exponent = 0;
ax2.YAxis.Exponent = 0;
ylabel('Fraction of Total Sequencing Reads')

legend('Pol 24-3', 'Pol 38-6','Location', 'northwest')
x0=10;
y0=10;
widthx=3000;
heightx=2000;
set(gcf,'position',[x0,y0,widthx,heightx]);
hold off;
