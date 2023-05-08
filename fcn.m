function [s0,v] = fcn(time,kaiguan)
td=1.5;   %s;
% switch=1~5 represents ACC operating conditions
% switch=6~9 represents ACC/CC switching conditions
 
switch kaiguan
    
    case 1  %% *****************************Leading vehicle accelerates

        %leading car accelerate condition
        %t<9s leading car constant speed at 60km/h
        %ego car keep 27m distance following
        %t=9s leading car accelerates with 1.6m/s^2 to 90km/h .
        if time<9
            v=60;
        else
            v=60+1.6*(time-9)*3.6;  %?1.6m/s^2
            if v>90
                v=90;
            end
        end
        s0=60/3.6*td+2;% leading car initial location
    case 2  %% *************************** Leading vehicle decelerates

        % t<9s leading car constant speed at 90km/h 
        % keep distance of 90/3.6*td+2 following
        % t=9s   leading car decelerates with -1.6m/s2 to 60km/h
        if time<9
            v=90;
        else
            v=90-1.6*(time-9)*3.6;  %-1.6m/s^2 
            if v<60
                v=60;
            end
        end
        s0=90/3.6*td+2;% leading car initial location
    case 3  %% ************************************* Steady following

        % leading car speed fluctuating at 90km/h 
        % figure
        % x=0:0.001:50;
        % y=sin(x*0.1)+sin(x*0.4)-sin(x*0.2)+sin(x*0.8)-sin(x*0.3);
        % plot(x,y)
        x=time;
        v=sin(x*0.1)+sin(x*0.4)-sin(x*0.2)+sin(x*0.8)-sin(x*0.3)+90;
        s0=90/3.6*td+2;% leading car initial location	    
    case 4  %% ***************************** Leading vehicle departs, following another leading vehicle

        % t<15s leading car constant speed at 80km/h 
        % ego car following with 45m distance
        % t=15s car in other line cuts in at 80km/h with 20m ahead
        % causing preestablished safety distance
        if time<15
            s0=80/3.6*td+2;%leading car initial location
            v=80;
        else
            s0=80/3.6*td+2-15.3333;% leading car initial location(a car cuts in)
            v=80;
        end
    case 5  %% ******************************************* Other vehicle cuts in the front

        % leading car constant speed at 80km/h ego car following with 35m 
        % t=10s leading car departs ego line
        % ACC trace another leading car 70m ahead at 80km/h
        if time<10
            v=80;
            s0=80/3.6*td+2;%leading car initial location
        else
            v=80;
            s0=80/3.6*td+2+35; %leading car initial location(leading car    departs)
        end
    case 6 %% ********************* Encounter leading vehicle (CC to ACC)

        % ego car CC 80km/h, leading car CC 60km/h 200m ahead
        % ego car switch from CC to ACC
       
        v=60;
        s0=200;%initial location 
    case 7 %% ******************************************* Leading vehicle departs, no another   leading vehicle. (ACC to CC)
        % t<9s leading car CC 65km/h 35m ahead, ego car following at 65km/h 
        % t=9s leading car departs and no car ahead then
        % ego car switch from ACC to CC at 80km/h
        if time<9
            v=65;
            s0=v/3.6*td+2; % leading car initial location
        else
            v=0;
            s0=10000;% leading car initial location (leading car departs)
        end
        
    case 8 %% ******************************************* Leading vehicle departs, encountering another leading vehicle (ACC to CC)
        % t<9s leading car CC 100km/h ego car ACC following 9s 
        % t>9s leading car departs, 
        % ego car encounters another leading car 80m ahead at 70km/h
        % ego car switch from ACC to CC.
        if time<9
            v=100;
            s0=v/3.6*td+2;%leading car initial location
        else
            v=70;
            s0=80; %encounter another leading vehicle 80m ahead with 70km/h
        end
        
    otherwise %% ******************************************* Leading Vehicle overspeed and move far away (ACC to CC)
        % t<9s leading car CC 60km/h ego car following
        % t=9s leading car accelerates with 2.5m/s^2 to 90km/h
        % ego car switch from ACC to CC at 80km/h
        if time<9
            v=60;
        else
            v=60+2.5*(time-9)*3.6;  %leading car 2.5m/s^2
            if v>90
                v=90;
            end
        end
        s0=60/3.6*td+2;%leading car initial location 
end

