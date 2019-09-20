begin


integer procedure bairstow(poly,lp,a,b,iterm,eps,vr1,vr2,vim1,vim2);
real array poly;
integer lp,iterm;
real a,b,eps;
real vr1,vr2,vim1,vim2;
begin
   procedure trinomroots(a,b,c,vr1,vim1,vr2,vim2);
   comment find roots of a*x^2+b*x+c . reals parts are returned
        in vr1,vr2 and imaginary parts in vim1, vim2. a is supposed to be non
        zero (not tested);

   value a,b,c;
   real a,b,c,vr1,vr2,vim1,vim2;
	
   begin
      real delta;	
      delta := b*b-4.0*a*c;
      if delta <0.0 then
         begin
	    vr1 := vr2 := -b/(2*a)	;
	    vim1 :=  -sqrt(-delta)/(2*a);
	    vim2 :=  -vim1;
	 end
     else
         begin
	    vr1 :=  (-b-sqrt(delta))/(2*a);
	    vr2 :=  (-b+sqrt(delta))/(2*a);
	    vim1 := vim2 := 0.0;
	 end
		   
   end trinomroots;
   
   procedure divide2(p,div2,lp,quotient,rem);
   comment divide polynomial p (degree :  lp-1) by div2 trinom.;
   
   value lp;
   real array p,div2,quotient,rem;
   integer lp;
   begin
      integer degrep,i,j; real c;
      real array ploc[1:lp];
      degrep :=lp-1;
      for i:=1 step 1 until lp do ploc[i] := p[i];
      for i:=1 step 1 until lp-2 do quotient[i] := 0.0 ;
      for i:=1 step 1 until degrep-1 do
      begin
	 c:= ploc[i];
	 quotient[i]:= c;
	 ploc[i] := 0.0 ;
	 ploc[i+1]:= ploc[i+1]-c*div2[2];
	 ploc[i+2]:= ploc[i+2]-c*div2[3];
      end;
     rem[1]:= ploc[degrep]; rem[2]:= ploc[degrep+1];
   end divide2;
   boolean procedure Newton(p,a,b,degre,iterm,eps);
   comment the iterative procedure to find a quadratic factor x^2+ax+b
           a and b are both starting values and results;
   value degre,iterm,eps;
   real array p;
   real a,b,eps;
   integer degre,iterm;
   begin
      real procedure NewtonStep(p,lp,a,b,iterm);
      comment one step of the iterative procedure;
      
      value iterm,lp;
      real array p; real a,b; integer lp,iterm;
      begin
	 integer i;
	 real array  d[1:3], rema[1:lp],remb[1:lp];
	 real array  qa[1:lp-1],ra[1:2];
	 real array qb[1:lp-1],rb[1:2],quot[1:lp],m[1:2,1:2];
	 real delta, reta,retb;
	 d[1] :=1.0; d[2]:=a; d[3]:=b;
	 divide2(p,d,lp,quotient,rem);
	 for i:=1 step 1 until lp-2 do qa[i]:= -quotient[i];
	 qa[lp-1]:=0.0;
	 for i:=1 step 1 until lp-2 do qb[i]:= -quotient[i];
	 divide2(qa,d,lp-1,quot,rema);
	 m[1,1] := rema[1]; m[2,1] := rema[2];
	 divide2(qb,d,lp-2,quot,remb);
	 m[1,2] := remb[1];
	 m[2,2] := remb[2];
	 delta := m[1,1]*m[2,2]-m[1,2]*m[2,1];
	 reta :=(rem[1]*m[2,2]-rem[2]*m[1,2])/delta;
	 a := a- reta;	
	 retb :=(m[1,1]*rem[2]-m[2,1]*rem[1])/delta;
	 b := b- retb;
	 NewtonStep := reta*reta+retb*retb;
      end NewtonStep;
      comment ------------------- ;

	 real resid;
	 real array q[1 : degre+1];
	 integer i;
	 boolean ok;
	 resid :=1;
	 for i:=1 step 1 until degre+1 do q[i]:=p[i];
	 ok := false;
	 for  i:=1 step 1 until iterm do
	    begin
	       resid := NewtonStep(p,degre+1,a,b,iterm);
	       if sqrt(resid)<eps then
		  begin
		     ok := true;
		     goto outloop;
		  end;
	    end;

outloop:
	 Newton :=ok;
      end Newton;


   real array quotient[1:lp],rem[1:lp];
   integer degree,nroots;

   degree := lp-1;
   if degree=1 then
      begin
	 vr1:=-poly[2]/poly[1]; vim1:=0.0;
	 lp :=0;
	 nroots:=1;
      end
   else if degree=2 then
      begin
	 trinomroots(poly[1],poly[2],poly[3],vr,vr2,vim1,vim2);
	 lp :=0;
	 nroots:=2;
      end
   else
      begin
	 a := poly[2]/poly[1]+1;
	 b := poly[3]/poly[1]+1;

	 Newton(poly,a,b,degree,iterm,eps);
	 trinomroots(1.0,a,b,vr1,vr2,vim1,vim2);
	 lp:= lp-2;
	 nroots:=2;
	 for i:=1 step 1 until lp do
	    poly[i]:=quotient[i];
      end;
   bairstow:=nroots;
end bairstow;	   
   procedure  outRealArray(a,l);
   real array a;
   integer l;
   begin
      for i:=1 step 1 until l do
	 begin
	    outreal(1,a[i]);
	    outstring(1," ");
	 end;
      outstring(1,"\n");
   end outRealArray;

comment -------------------------main---------------------------------;
real a,b,c,vr,vi,wr,wi,eps;
boolean ok;
real array pol[1:50],div2[1:3];
integer i,lp,iterm,nr;      
a:=1; b:=1; c:=1;
lp:=12;
for i:=1 step 1 until lp do pol[i]:=1.0;
eps :=0.00001;
iterm :=50;
for iterm:=50 while lp>0 do
   begin
      nr:=bairstow(pol,lp,a,b,iterm,eps,vr,vi,wr,wi);
      outreal(1,vr);outstring(1," ");
      outreal(1,vi);outstring(1," "); outstring(1,"\n");
      if nr> 1 then
	 begin
	    outreal(1,wr);outstring(1," ");
	    outreal(1,wi);outstring(1," "); outstring(1,"\n");
	 end
   end
	 outstring(1,"fin")		
end
