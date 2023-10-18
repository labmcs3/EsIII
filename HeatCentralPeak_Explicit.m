function HeatCentralPeak_Explicit
  % Parametri fisici
  eta = 0.30;  L = 0.5; kappa = 10;
  % Delta x, Delta t
  N   = 101;  
  x   = linspace(0.0,L,N); 
  dx  = x(2)-x(1);
  dt  = (eta*dx^2)/kappa;
  % Impulso di calore iniziale
  T0           = 20;
  DeltaT       = 80;
  T            = ones(1,N)*T0;
  T((N-1)/2+1) = T0+DeltaT;
  % Evoluzione temporale
  t    = 0; tend = 1e-3;
  while t<tend
    plot(x,T);
    T(2:N-1) = T(2:N-1)+eta*(T(3:N)+T(1:N-2)-2*T(2:N-1));
    drawnow limitrate nocallbacks
    t = t+dt;
  end
  % Confronto con soluzione analitica
  sigma = sqrt(2*kappa*t);
  Tteo = T0+DeltaT*dx*normpdf(x,L/2,sigma);
  hold on;
  plot(x,Tteo);
  hold off;
end