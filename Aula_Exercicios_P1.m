
%% Exercício 3
clc
clear all
close all


p = 0.1;
qo = 0.05
q1 = 0.2;
px = 0.5;
py = 0.5;

pe = ((1-p)*qo + p*q1)*(px) + ((1-p)*q1 + p*qo)*(py);

He = pe*log2(1/pe);

%% Exercício 4

p = 1/4;
q = 1/5;

%pyx
poo = (1-p)*(1-q) + p*q;
pii = (1-p)*(1-q) + p*q;
poi = (1-p)*q + p*(1-q);
pio = (1-p)*q + p*(1-q);

Hydadox = (0.65)*log2(1/0.65) + (0.35)*log2(1/0.35);
Hy = 1;

Cp = 1+p*log2(p)+(1-p)*log2(1-p);
Cq = 1+q*log2(q)+(1-q)*log2(1-q);

C = min(Cp,Cq);

C = Hy - Hydadox

%% Exercício extra: 

clc
clear all
close all

p = 0.05;
q = 0.025;
z0 = 0.1;
z1 = 0.1;
z4 = 0.25;
z3 = 1-(z1+z4);

px = 0.5;
py = 0.5;

py0x0 = 1*(1-q)*(1-p)+z0*q*(1-p)+z0*q*p;
py1x0 = 1*(1-q)*p + z1*q*(1-p) + z1*q*p;
py3x0 = z3*q*(1-p) + z3*q*p;
py4x0 = z4*q*(1-p) + z4*q*p;

py0x1 = z0*q*(1-p) + z0*q*p + 1*(1-q)*p;
py1x1 = 1*(1-q)*(1-p) + z1*q*p + z1*q*(1-p);
py3x1 = z3*q*p + z3*q*(1-p);
py4x1 = z4*q*p + z4*q*(1-p);

py0 = py0x0 + py0x1;
py1 = py1x1 + py1x0;
py3 = py3x1 + py3x0;
py4 = py4x1 + py4x0;

hy = 2*(py0*log2(1/py0) + py3*log2(1/py3));









