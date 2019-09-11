#include("./Bairstow.jl")
using Printf
function Bairstow!(p,a,b,iterm,eps)
    #
    # Put everything in this "hat" procedure. 
    #
    function bairstow!(p,a,b,iterm,eps,Roots)
        # Actual computation:
        # find quadratic divisors and their roots. This is
        # a recursive procedure.
        function trinom_roots(a::Float64,b::Float64,c::Float64)
            # simple routine: a is never equal to zero, and
            # roots are supposed to be not to bad conditioned.
            # This should be improved, may be.
            delta = b^2-4.0*a*c
            if delta<0
                xreal = yreal = -b/(2*a)
                ximag = -sqrt(-delta)/(2*a)
                yimag = -ximag
            else
                xreal =  (-b-sqrt(delta))/(2*a)
                yreal =  (-b+sqrt(delta))/(2*a)
                ximag = yimag = 0.
            end
            xreal,ximag,yreal,yimag
        end
        function divide2(p,div2)
            # divide polynomial p by trinom div2.
            ploc = copy(p)
            degré_de_p =  degré(p)
            quotient =  zeros(Float64,degré_de_p-1)
            for i =  1:degré_de_p-1
                c = ploc[i]
                quotient[i] = c
                ploc[i] = 0.0
                ploc[i+1:i+2]-= c.*div2[2:3]
            end
            quotient,@views ploc[degré_de_p:degré_de_p+1]

        end
        function Newton(p,a,b,degré,iterm,eps)
            #
            # Newton is the iterative Newton procedure.
            #
            function Newton_step(p,a,b)
                # Do one Newton step (compute remainings,
                # solve linear system).
                d = [1.0 ,a ,b]
                q,r = divide2(p,d)
                qx = Array{Float64}(vcat(q ,  0))
                qa,ra = divide2(-qx,d)
                qb,rb = divide2(-q,d)
                m = hcat(ra,rb)
                udelta =1.0/( m[1,1]*m[2,2]-m[1,2]*m[2,1])
                reta = (r[1]*m[2,2]-r[2]*m[1,2])*udelta
                retb = (m[1,1]*r[2]-m[2,1]*r[1])*udelta
                a-reta, b-retb , q, reta^2+retb^2
            end

            # here, we are in baisrtowquad:
            resid = 1.0
            global q = p
            ok = false
            for i = 1:iterm
                a,b,q,resid = Newton_step(p,a,b);
 
                if sqrt(resid)<eps
                    ok = true
                    #println(i)
                    break
                end
            end
            if !ok
                error("No convergence, iterm =  $(iterm), residual= $(resid)")
            end
            return a,b,q,resid
        end

        # here, we are in bairstow!( ) :
        degré_p =  degré(p)
        if degré_p == 1
            PushRac(-p[2]/p[1],0.0)
            degré_p = 0
        else
            if degré_p == 2
                xreal,ximag,yreal,yimag = trinom_roots(p[1],p[2],p[3])
                degré_p = 0
            else
                a = p[2]/p[1]
                b = p[3]/p[1]
                a,b,pcop, resid = Newton(p,a,b,degré_p,iterm,eps)
                xreal,ximag,yreal,yimag = trinom_roots(1.0,a,b)
                degré_p = degré(pcop)
            end
            PushRac(xreal,ximag)
            PushRac(yreal,yimag)

        end
    
        if  degré_p>0
            bairstow!(pcop,a,b,iterm,eps,Roots)
        end

    end
    function PushRac(re,im)
        Roots[kpos]=(re,im)
        kpos += 1
    end

    # here we are in Bairstow!() . 
    # Allocate arrays, and do the actual computation with bairstow!()
    m = Array{Float64}(undef,2,2)
    Roots=Array{Tuple{Float64,Float64}}(undef,degré(p))
    kpos = 1
    bairstow!(p,a,b,iterm,eps,Roots)
    Roots
end
degré(p) = length(p)-1
#
# ---- main:
# Z! polynomial is *not* stored in the conventional order.
#   Here we store the coefficients by decreasing power
#   (zero order coefficient at the end of the array).
#   For example:
#   p= [3.,2.,1.,-1] stands for:
#       3x^3 + 2x^2 + x -1.
#p = [2., -3., 1., -1.,1.,-1.,1.,-1.,1.,-1. ,1.,1.,1.]
p=[1.0 for i in 1:5]
#
niter = 1
for i = 1:niter #loop to measure execution time.
    a = p[2]/p[1]
    b = p[3]/p[1]
    iterm = 150
    eps = 1.e-9


    @time Roots = Bairstow!(p,a,b,iterm,eps)

    if i == niter
        println("\ndegree : ",degré(p))
        print("\nRoots, real and imaginary parts:\n\n")
        sort!(Roots)
        for i in 1:degré(p)
             print(@sprintf  "%20.16f %20.16f \n" Roots[i][1] Roots[i][2])
         end
        println()
    end
end

