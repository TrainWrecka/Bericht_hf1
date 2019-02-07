%Richtcharakteristik.m

%Thomas Frei & Simon Zoller

%Kugelkoordinaten
theta=0:0.01:2*pi;
phi = 0:0.01:2*pi;

%Richtcharakteristik
C = cell(6);

%Titel
plotTitle = cell(6);
plotTitle{1} = 'Vertikales Richtdiagramm z-Dipol';
plotTitle{2} = 'Horizontales Richtdiagramm z-Dipol';
plotTitle{3} = 'Vertikales Richtdiagramm x-Dipol';
plotTitle{4} = 'Horizontales Richtdiagramm x-Dipol';
plotTitle{5} = 'Vertikales Richtdiagramm y-Dipol';
plotTitle{6} = 'Horizontales Richtdiagramm y-Dipol';

%z-Dipol
C{1} = abs(sin(theta));
C{2} = ones(size(theta));

%x-Dipol
C{3} = abs(sqrt(1-sin(theta).^2.*cos(pi/2).^2));
C{4} = abs(sqrt(1-sin(pi/2).^2.*cos(phi).^2));

%y-Dipol
C{5} = abs(sqrt(1-sin(theta).^2.*sin(pi).^2));
C{6} = abs(sqrt(1-sin(pi/2).^2.*sin(phi).^2));

%Plot in Schleife
for ind=1:6
    subplot(3, 2, ind) ;
    polarplot(theta,C{ind});
    pax = gca;
    pax.ThetaDir = 'clockwise';
    pax.ThetaZeroLocation = 'top';
    rlim([0 1]);
    title(plotTitle{ind});
end