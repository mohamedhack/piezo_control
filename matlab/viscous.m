%% Find Baseline Damping

R = @(run) rms(run.g-mean(run.g));
D = @(run) DSP.get_damping(run.T,run.t,run.g);
K = @(run) run.control.K(2);

arg_list = {R,D,K};
directory = 'db/Viscous/';

d2 = [directory,'1e2/'];
d3 = [directory,'1e3/'];
d4 = [directory,'1e4/'];

out2 = Run.map(d2,D,R,K);
out3 = Run.map(d3,D,R,K);
out4 = Run.map(d4,D,R,K);

%%

K7 = @(run) (run.control.K(2) == -7e3);
list = Run.find(d3,K7);



f   = @(i) [[out2{i,:}] [out3{i,:}]]'; % [out4{i,:}]]';
d   = f(1);
RMS = f(2);
KK  = f(3);


x = d;

Ku = unique(KK);
n_points = length(Ku);
m = zeros(n_points,1);
s = zeros(n_points,1);
for i = 1:n_points
    aux = x(KK==Ku(i));
    m(i) = mean(aux);
    s(i) = std(aux);
end

%%

plot(-Ku,s,'o')