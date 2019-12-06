import math

x = 3 # example values
y = -4

# forward pass
sigy = 1.0 / (1 + math.exp(-y)) # sigmoid in numerator   #(1)
num = x + sigy # numerator                               #(2)
sigx = 1.0 / (1 + math.exp(-x)) # sigmoid in denominator #(3)
xpy = x + y                                              #(4)
xpysqr = xpy**2                                          #(5)
den = sigx + xpysqr # denominator                        #(6)
invden = 1.0 / den                                       #(7)
f = num * invden # done!                                 #(8)

print(f)

# backprop

ini = 1.0
dnum = ini * invden
dinvden = ini * num
dden = -dinvden * (1.0 / den)**2
dsigx = 1.0 * dden
dx = sigx * (1 - sigx) * dsigx

dxpysqr = dden * 1.0
dxpy = 2 * xpy * dxpysqr
dx += dxpy * 1.0
dy = dxpy * 1.0

dsigy = dnum * 1.0
dy += sigy * (1 - sigy) * dsigy

print(dy)
print(dx)
