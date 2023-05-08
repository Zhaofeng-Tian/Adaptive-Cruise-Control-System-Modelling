m=1500  ; %Vehicle Mass kg
Jm=0.25;  %Enigne rotational inertia kg.m2
Jw=4; % rotational inertia kg.m2 wheel
rw=0.28; %rolling radium m
ig=5;   %Gear
efficetive=1;  % motor torque efficency
g=9.8;% gravity
a=0;  % slop
CD=0.35; % areodynamic resistance coefficient
p=1.226;  % air desnity .m-3
A=0.5;  % front area m^2

%% *****
f=0.015;% rolling resisitence coefficent
% (rad/s), speed range of the engine (11 values)
fc_map_spd=[701 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500]*2*pi/60; 
eng_idle_spd=min(fc_map_spd);
fc_map_trq=[ 0.0  14.2  29.8  43.1  57.9  72.0  85.1  100.1 ]*1.75671;
fc_fuel_map =[
         0.1935  0.343   0.430   0.503   0.585   0.664   0.736   0.750
         0.1935  0.306   0.429   0.534   0.651   0.763   0.866   1.088
         0.1935  0.406   0.591   0.749   0.925   1.092   1.247   1.650
         0.1935  0.547   0.793   1.004   1.238   1.461   1.668   2.270
         0.1935  0.695   1.003   1.266   1.559   1.837   2.334   2.852
         0.1935  0.855   1.225   1.540   1.891   2.421   3.022   3.446
         0.1935  1.029   1.460   1.828   2.249   3.132   3.564   4.039
         0.1935  1.338   2.042   2.543   3.101   3.632   4.126   4.541
         0.1935  1.576   2.369   2.933   3.561   4.158   4.714   5.036
         0.1935  1.843   2.726   3.352   4.049   4.714   5.331   5.528
         0.1935  1.843   2.726   3.352   4.049   4.714   5.331   5.528 ];

fc_fuel_den=0.749*1000; % (g/l), density of the fuel 
fc_fuel_lhv=42.6*1000; % (J/g), lower heating value of the fuel
fc_inertia=0.1; % (kg*m^2), rotational inertia of the engine; unknown
fc_accpower=200;    
% create *gpkWh maps for plotting purposes
[T,w]=meshgrid(fc_map_trq, fc_map_spd);
fc_map_kW=T.*w/1000;
fc_fuel_map_gpkWh=fc_fuel_map./(fc_map_kW+eps)*3600;

% (N*m), max torque curve of the engine indexed by fc_map_spd (11 values).
fc_max_trq=[83.5 101.4 105.8 107.0 106.5 106.5 106.5 102.5 93.6 86.9 80.2]*1.35671;


% figure
% [fc_map_spd,fc_map_trq]=meshgrid(fc_map_spd,fc_map_trq);
% surf (fc_map_spd',fc_map_trq',fc_fuel_map)
% xlabel ·rotation speed rad/s
% ylabel ·Torque N.m
% zlabel   
% % figure
% % contour(w,T,fc_fuel_map_gpkWh,'ShowText','on')
% % hold on
% figure
% plot(fc_map_spd,fc_max_trq,'k','LineWidth',2)
% hold on
% xlabel ·rotation speed rad/s
% ylabel ·torque N.m

throttle=[0;20;30;40;50;60;70;80;90;100];
ne=[800,1200,1600,2000,2400,2800,3200,3600,4000,4400,4800];
T=[-40,-44,-49,-53,-57,-61,-65,-70,-74,-78,-82;
    215,117,85,66,44,29,10,-2,-13,-22,-32;
    245,208,178,148,122,104,85,66,48,33,18;
    264,260,241,219,193,167,152,133,119,96,85;
    264,279,282,275,260,238,223,208,189,171,152;
    267,290,293,297,290,275,260,256,234,212,193;
    267,297,305,305,305,301,293,282,267,249,226;
    267,301,308,312,319,323,319,316,297,279,253;
    267,301,312,319,327,327,327,327,312,293,267;
    267,301,312,319,327,334,334,334,319,305,275];















