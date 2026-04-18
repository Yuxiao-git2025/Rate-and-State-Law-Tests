function dParams_dt=RSF_ODESolver(times,Params,mu0,a,b,Dc,k,v0,tgrid,vlpgrid,State)
% >> Obtain the slider and loading point velocities based on the current moment
mu=Params(1);
theta=Params(2);
vlp=interp1(tgrid, vlpgrid, times, 'previous', 'extrap'); % just interp
vsl=RSF_cal_velocity(mu,theta,mu0,a,b,Dc,v0);             % From RSF-law
% =========================================================================
% (1) Friction evolution:
% τ=k(δlp-δsl)
% dτ/dt=k(vlp-vsl)
% and: τ=μσ, so that:
% dμ/dt=k/σ(vlp-vsl)
% Here normalised stiffness: k'=k/σ (1/um)
dmu_dt=k*(vlp-vsl);
% (2) State evolution
term=(vsl*theta)/Dc;
term=max(term,realmin);
switch State
    case 1 % Dieterich
        dtheta_dt=1-term;
    case 2 % Ruina
        dtheta_dt=-term*log(term);
end
% =========================================================================
% Obtained
dParams_dt=[dmu_dt;dtheta_dt];
end