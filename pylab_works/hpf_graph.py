
from numpy import *
import scipy
# if available import pylab (from matlibplot)
try:
    from pylab import *
except ImportError:
    pass

w = linspace(1., 4000., 1000.)
tau = 1e-3
#H = (dot(dot(tau, 1j()), w)/(1.+dot(dot(tau, 1j()), w)))
H = (dot(dot(tau, 1j), w)/(1.+dot(dot(tau, 1j), w)))

re = real(H)
im = imag(H)
ampl = abs(H)
#fase = dot(matdiv(angle(H), dot(2., pi)), 360.)
fase = dot((angle(H) / dot(2., pi)), 360.)
v = array(c_[re.conj().T, im.conj().T, ampl.conj().T, fase.conj().T])
#subplot(221.)
subplot(221)
plot(w, re)
xlabel('w in rad/s')
#YLABEL('reeele deel')
ylabel('reeele deel')
#subplot(222.)
subplot(222)
plot(w, im)
xlabel('w in rad/s')
#YLABEL('imaginaire deel')
ylabel('imaginaire deel')
#subplot(223.)
subplot(223)
plot(w, ampl)
#YLABEL('amplitude')
ylabel('amplitude')
xlabel('w in rad/s')
#subplot(224.)
subplot(224)
plot(w, fase)
#YLABEL('fase verschil in graden')
ylabel('fase verschil in graden')
xlabel('w in rad/s')

show()  #<<<<< Not in Matlab