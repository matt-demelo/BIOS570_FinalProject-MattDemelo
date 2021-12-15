%% Processivity analysis without sequencing read normalization

% Processivity data obtained using the processivity.m function:
[proc24_3,lengths_24] = process_unN(data24_3);
[proc38_6,lengths_38] = process_unN(data38_6);

% Add "Zero read" fields to 38-6 table
proc_38ends = proc24_3(end-3:end,:);
proc_38ends.Length = zeros(4,1);
proc38_6 = vertcat(proc38_6,proc_38ends);

% Combine to one table
proc24_3.Properties.VariableNames = {'Pol_24-3','Sequence'};
proc38_6.Properties.VariableNames = {'Pol_38-6','Sequence'};
proc_all = horzcat(proc38_6(:,1),proc24_3);

% Plot Processivity over sequence length and sequence identity:
seqlength = lengths_24;
sequencefull = proc_all.Sequence{end};
seq = dna2rna(sequencefull(seqlength));


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
ylabel('Sequencing Reads')

legend('Pol 24-3', 'Pol 38-6')
x0=10;
y0=10;
width=3000;
height=2000;
set(gcf,'position',[x0,y0,width,height]);
hold off;
