close all
clc
clear all

c1 = 100e-15;
c2 = 50e-12;
fs = 9.4e3;
f = logspace(-2, 2, 1e5);
z = exp(j*2*pi*f*1/fs);

H = c1.*z./((c2+c1).*z-c2);

H2 = c1/c2.*z./(z-1+c1/c2);

loglog(f, abs(H))
hold on
loglog(f, ones(1,1e5)*1/sqrt(2))
yaxis = ylim;
loglog( ones(1,1e5)*50, logspace( log10(yaxis(1)), log10(yaxis(2)), 1e5 ) )
loglog( ones(1,1e5)*3, logspace( log10(yaxis(1)), log10(yaxis(2)), 1e5 ) )

grid on

title('Transferfunction')
xlabel('Frequency')
ylabel('V_{out}')

%ylim([1e-3, 1e0])

figure()
loglog(f, abs(H2))
hold on
loglog(f, ones(1,1e5)*1/sqrt(2))
yaxis = ylim;
loglog( ones(1,1e5)*50, logspace( log10(yaxis(1)), log10(yaxis(2)), 1e5 ) )
loglog( ones(1,1e5)*3, logspace( log10(yaxis(1)), log10(yaxis(2)), 1e5 ) )

grid on

title('Transferfunction')
xlabel('Frequency')
ylabel('V_{out}')

