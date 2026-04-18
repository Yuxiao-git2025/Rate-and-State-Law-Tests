function RSF_Plots(Results,mu0,a,b,v0,vlp,State,Holdstart,Holdend)
% Plot: phase, displacement, time
% fprintf('# Now state is: %d\n',State);
time=Results.time;
mu=Results.mu;
theta=Results.theta;
vsl=Results.Vsl;
Dlp=Results.Dlp;
Dsl=Results.Dsl;


% >> Phase plot
figure;hold on;
plot(log(vsl./v0),mu,'k-','LineWidth',2); 
xlabel('ln(V/V0)');ylabel('\mu');
Fun_defaultAxes; grid on;
% >> Add steady-state line (when θ(ss)=Dc/V): μ=μ0+(a-b)*ln(V/V0)
xl=xlim;
yl=ylim;
xx=linspace(xl(1),xl(2),10);
mu_ss=mu0+(a-b)*xx;
plot(xx,mu_ss,'b--','LineWidth', 1.5);
% >> Add constant lines (μ=a*ln(V/V0)+const)
yline=a*xx;
for bconst=0:0.01:yl(2)
    yy=yline+bconst;
    if max(yy)>yl(1)
        plot(xx, yy, 'k--', 'LineWidth', 0.8);
    end
end
set(gcf,'position',[300,50,760,660])

% >> Displacement plots
% figure;
% tiledlayout(4,1,'TileSpacing','compact','Padding','compact');
% nexttile; plot(Dlp, mu, 'b','LineWidth',1.8); Fun_defaultAxes;ylabel('\mu');xticklabels([]);
% nexttile; plot(Dlp, theta, 'b','LineWidth',1.8); Fun_defaultAxes; ylabel('\theta');xticklabels([]);
% nexttile; plot(Dlp, vsl, 'b','LineWidth',1.8); Fun_defaultAxes; ylabel('V(sl)');xticklabels([]);
% nexttile; plot(Dlp, vlp, 'b','LineWidth',1.8); Fun_defaultAxes; ylabel('V(lp)');
% xlabel('Loadpoint displacement (\mum)');set(gcf,'position',[200,50,1100,760])

% >> Time plots
figure;
tiledlayout(4,1,'TileSpacing','compact','Padding','compact');
nexttile; hold on; plot(time, mu, 'b','LineWidth',1.8); 
xline(Holdstart,'Color','k','LineWidth',1.6,'LineStyle',':');
xline(Holdend,'Color','k','LineWidth',1.6,'LineStyle',':');
Fun_defaultAxes; ylabel('\mu');xticklabels([]);

nexttile; hold on; plot(time, theta, 'b','LineWidth',1.8); 
xline(Holdstart,'Color','k','LineWidth',1.6,'LineStyle',':');
xline(Holdend,'Color','k','LineWidth',1.6,'LineStyle',':');
Fun_defaultAxes; ylabel('\theta');xticklabels([]);
% cause velocity units is um/s so no need to transform again
ax=gca; ax.YScale='log'; 

nexttile; hold on;plot(time, vsl, 'b','LineWidth',1.8); 
xline(Holdstart,'Color','k','LineWidth',1.6,'LineStyle',':');
xline(Holdend,'Color','k','LineWidth',1.6,'LineStyle',':');
Fun_defaultAxes; ylabel('V(sl)');xticklabels([]);

nexttile; plot(time, vlp, 'b','LineWidth',1.8); Fun_defaultAxes; ylabel('V(lp)');
xlabel('Time (s)');set(gcf,'position',[200,50,1100,760])