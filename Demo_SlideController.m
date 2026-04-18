% =========================================================================
% >> RSF-Parameters
mu0=0.6;   % μ0
v0=10;     % Reference velocity (um/s)
a=0.005;   % Make sure a<b
b=0.01;
Dc=10;     % um
k=1e-3;    % Normalized stiffness (=K/σ; 1/um)

% >> State-Type: 1=Dieterich; 2=Ruina
State=1;

% >> Timespan-settings (s)
tstart=0;
tend=50;
Dt=1e-2;
time=(tstart:Dt:tend)';
% >> Hold time setting (s)
Holdstart=20;
Holdend=30;
% >> Loading-point velocity (um/s)
vlp=10*ones(size(time));   
HID=time>=Holdstart & time<Holdend+1e-6;
vlp(HID)=0;

% =========================================================================
% Do Solve and Plots
Results=RSF_Solve(mu0,a,b,Dc,k,v0,time,vlp,State);
RSF_Plots(Results,mu0,a,b,v0,vlp,State,Holdstart,Holdend);

