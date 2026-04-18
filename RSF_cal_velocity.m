function v=RSF_cal_velocity(mu,theta,mu0,a,b,Dc,v0)
% Formula: v=v0*exp((mu-mu0-b*log(vref*theta/Dc))/a)
arg=v0.*theta./Dc;
arg=max(arg,eps);
v=v0.*exp((mu-mu0-b.*log(arg))./a);
end