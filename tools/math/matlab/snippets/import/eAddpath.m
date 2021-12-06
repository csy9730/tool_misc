p = mfilename('fullpath');
i=findstr(p,'\');p2= p(1:i(end));
p3=[p2 'func'];%disp(p3);
addpath(genpath(p3));%path(p3);
p4=[p2 'fgrFunc'];%disp(p4);
addpath((p4));%path(p3);