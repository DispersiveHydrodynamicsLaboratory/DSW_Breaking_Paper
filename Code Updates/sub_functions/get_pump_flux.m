function [ dq ] = get_pump_flux( Qq )
trials = 1:6;
Q = [0.25,1,1.6,2.25,3.1,4];
flow   = cell(size(trials));
data_dir = '/Volumes/APPM-DHL/Pump_Calib/Low_Flow/2017_05_16_Dalton_LF_Calib/';
for tr = trials;
    folder = sprintf('Trial%02d/',tr);
    file   = sprintf('Trial%0.0f.csv',tr);
    fid = fopen([data_dir,folder,file]);
    str = fgetl(fid);
    ii = 1;
    fl = 0;
    while ischar(str)
        if strcmp(str,'"Sample #","Relative Time[s]","Flow [ul/min]"')
            str = fgetl(fid);
        end
        ind1 = find(str == ','); ind1 = ind1(end) + 1;
        nstr = str(ind1:end);
        if strcmp(nstr(1),'"')
            ind1 = ind1+1;
            nstr = str(ind1:end);
        end
        if strcmp(nstr(end),'"')
            nstr = nstr(1:end-1);
        end
        fl(ii) = str2double(nstr);
        ii = ii + 1;
        str = fgetl(fid);
    end
    fclose(fid);
    inds = find(fl./1000<0.1);
    [~,start] = max(diff(inds));
    stop = inds(start+1)-100;
    if isempty(start)
        start = 1;
    else 
        start = start + 100;
    end
    if isempty(stop)
        stop = length(fl);
    end
    
    fl = fl(start:stop)./1000;
%     figure
%         plot(fl);
%         title(sprintf('Trial %0.0f: Q = %0.2f ml/min',tr,Q(tr)))
%     pause(1)
    flow{tr} = fl; 
    Qerr(tr) = 2*std(fl);
end

dq = interp1(Q,Qerr,Qq);

end

