% =========================================================================
% >> Solver of RSF spring-slider model
% Here interpolation is used to calculate the displacement and velocity 
% of the loading points
function Results=RSF_Solve(mu0,a,b,Dc,k,v0,time,vlp,State)
% Make sure Row to Col
time=time(:);
vlp=vlp(:);
if numel(time) ~= numel(vlp) % Same length
    error('# time and load-Velocity must have same length');
end
% =========================================================================
% >> Initial conditions
mu_ini=mu0;
v_ini=v0;
theta_ini=Dc/v_ini; % make stable
Param_ini=[mu_ini;theta_ini];
% =========================================================================
% >> Do Solver
TolHandle=odeset('RelTol',1e-6,'AbsTol',1e-8);
% Integrate and Solve equation
FuncHandle=@(times,Params) RSF_ODESolver(times,Params,mu0,a,b,Dc,k,v0,time,vlp,State);
[ti,Parami]=ode113(FuncHandle,time,Param_ini,TolHandle);

% =========================================================================
% >> Obtained
mu=Parami(:,1);
theta=Parami(:,2);
vsl=RSF_cal_velocity(mu,theta,mu0,a,b,Dc,v0); % Recompute
Dlp=cumtrapz(ti,interp1(time,vlp,ti,'previous','extrap'));
Dsl=cumtrapz(ti,vsl);
% =========================================================================
% >> Save Data
Results.time=ti;
Results.mu=mu;
Results.theta=theta;
Results.Vsl=vsl;
Results.Vlp=vlp;
Results.Dsl=Dsl;
Results.Dlp=Dlp;
end