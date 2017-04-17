

w  = linspace(1,4000,1000)
tau = 1e-3


H    = tau*i*w ./ ( 1 + tau*i*w )

re   = real(H)
im   = imag(H)
ampl = abs(H)
fase = angle(H) / (2*pi) * 360 
v = [re',im',ampl',fase']


subplot(221)
plot(w,re)
xlabel('w in rad/s')
YLABEL('reëele deel')
subplot(222)
plot(w,im)
xlabel('w in rad/s')
YLABEL('imaginaire deel')
subplot(223)
plot(w,ampl)
YLABEL('amplitude')
xlabel('w in rad/s')
subplot(224)
plot(w,fase)
YLABEL('fase verschil in graden')
xlabel('w in rad/s')
