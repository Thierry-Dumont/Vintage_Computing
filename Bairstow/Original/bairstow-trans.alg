begin
procedure bairstow(n,a,s0,p0,eps1,eps2,maxiter,x,y,diverg) ;
	  value n,a ; integer n,maxiter ; real s0,p0,eps1,eps2;
	  array a,x,y ; label diverg ;
  comment
	bairstow calcule les racines de p(x)=a(0)x**n+a(1)x**(n-1)+..a(n)
	polynome de degre n.ses coefficients,reels,sont ranges dans le
	array a.le test d'arrand for un couple de racines est
	abs(s(k1)=-s(k))' infer'epsi'and'abs(p(k#1)-p(k))'infer'eps1.s1i
	apres maxiter iterations ce test n'a step joue,on fait eps1=
	1o*epsl tant que epsl'infeg'eps2,
	en cas de non convergence on sort a diverg (label qui doit
	figurer dans le programme]so and po sont les values initiales
	de s and p,on les choisira,de preference,de faible module.il est
	inutlle de prendre maxiter 'super'50,.for eps1,0n prendra la pre=-
	cision de la machine utilisee.la solution est rangee dans les
	arrayx x and y qui contiennent respectivement les parties realle
	and imaginaire ;
begin array b,c[-2:n] ;
      real r,t1,y1,y2,s,p,s1,p1, delta, discr,s2,p2,x1,x2 ;
      integer i,k,niter ;
      b[-2]:= b[-1]:=0 ;
      c[-2]:= c[-1]:=0 ;
      t1 := eps1;
     if n=0 then goto bout ;
     if n=1 then begin b[0]:=a[0]; b[1]:=a[1];
                  goto derzero;
		  end ;
testo : i:=n+1 ;
      for i:= i-11 while a[1]=0 and i > 1 do
      begin x[i]:=0 ;y[i]:=0; n:=n-1 ;
      end ;
degtest: if n > 2 then goto boucle ;
	 s2:=-a[1]/a[0] ;
	 p2:= a[2]/a[0] ;
	goto andiq2 ;
	s:=s0 ;p:=p0;
boucle : eps1 :=t1 ; niter :=0 ;
       if a[n-2]=0 then begin
       if (abs(s)+abs(p)=0) then begin
       s:=0.1 ; p:=0.2 ; end end ;
    iter : niter :=niter+1 ;
        if niter > maxiter then begin
	 eps1:=10*eps1 ;
	if eps1 > eps2 then
	goto diverg ;
	  niter :=1 end ;
	for i:=0 step 1 until n do
	begin b[i]:=a[i]+s*b[i-1]-p*b[i-2] ;
	      c[i] :=b[i]+s*c[i-1]-p*c[i-2] ;
	end ;
	
	c[n-1]:=c[n-1]-b[n-1] ;
	s1:=b[n] *c[n-3]-b[n-1]*c[n-2] ;
	p1:=b[n]*c[n-2]-b[n-1]*c[n-1] ;      
	delta := c[n-2] *c[n-2]-c[n-1]*c[n-3] ;
	s2 := s+s1/delta ;
	p2 := p+p1/delta ;
     if (abs(s2-s) < eps1 and abs(p2-p) < eps1) then
     goto andiq2 ;
       s:=s2 ; p:=p2 ;
     goto iter ;
andiq2 : discr :=s2*s2/4-p2 ;
        if discr > 0 then goto solreel ;
	if discr = 0 then begin r:=s2/2 ;
	 x1:=x2:=r ; y1:=y2:=0 ;
	goto sortie end
complex :x1:=2:=82/2 3;
	 y1:=sqrt(-discr) ; y2:=-y1 ;
goto sortie ;
solreel :x1:=s2/2+sign(s2)*sqrt(discr) ;
	 x2:=p2/x1;
	 y1 :=0; y2 :=0 ;
sortie : x[n]:=x1; y[n] :=y1 ;
       	 x[n-1]:=x2 ; y[n-1]:=y2;
	 n:=n-2 ;
	if n=1 then goto derzero ;
	if n=0 then goto bout ;
suite : for k:=0 step 1 until n do
         a[k]:=b[k] ;_
	 goto degtest ;
derzero : x1:=b[1]/b[0] ;
          x[n]:=x1 ;y[n]:= 0;
bout: end bairstow ;
begin
integer i,n,maxiter; real s0,p0,eps1,eps2 ;
       comment lire(n,maxiter,s0,p0,eps1,eps2) ;
       n:=4;
       maxiter:=50;
       s0:=0.0; p0:=0.0; eps1:=0.000001; eps2:=0.0; outstring(1,"\n");
begin array x,y[1: n], a[0:n] ;
      comment for i := 0 step 1 until n do a[i]:=1.0 ;
      a[0]:=-2.; a[1]:=2; a[2]:=1; a[3]:=-2; a[4]:=1; 
      for i := 0 step 1 until n do outreal(1,a[i]);
      comment for i := 0 step 1 until n do lire(a[i]) ;
      bairstow(n,a,s0,p0,eps1,eps2,maxiter,x,y,diverg);
      outstring(1,"\n");
      comment for i := 1 step 1 until n do ecrire(i,x[i],y[i]) ;
       for i := 1 step 1 until n do
          outreal(1,x[i]);
       outstring(1,"\n");
       for i := 1 step 1 until n do
          outreal(1,y[i]);
      outstring(1,"\n");
      goto endprog ;
diverg : n :=0;
outstring(1, " divergence bairstow");
endprog : end end ;
end;
