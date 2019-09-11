# Used to verify the results of Bairstow.
# Just copy here p from main program in Bairstow.
#p=[5., -3., 1., -1.,1.,-1.,1.,-1.,1.,-1. ,1.,1.,1.]
p=[1.0*(-i)^i for i in range(1,16)]
#
# -----------------------------------------------------------
c=[Integer(i) for i in p]
c.reverse()
#
# we compute in QQbar, so all the computations are
# exact!
#
R.<x>=QQbar[]
deg=len(c)-1
p=sum([c[i]*x^i for i in range(0,deg+1)])
#
print("Polynomial :")
print(p)
# As we are in QQbar (algebraic numbers), results are shown
# using interval arithmetic:
print("Roots (and their muliplicity):")
for x in sorted(p.roots()):
    print(x)
#-----------------------------------------------------------

# You can simply do: sage certify.sage

