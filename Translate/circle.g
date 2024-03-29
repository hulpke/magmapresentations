#  File converted from Magma code -- requires editing and checking
#  Magma -> GAP converter, version 0.5, 11/5/18 by AH

#  Global Variables used: Append, Characteristic, ClassicalStandardGenerators,
#  ClassicalStandardPresentation, Degree, Eltseq, Evaluate, Factorial, GF, GL,
#  Identity, Integers, IsOdd, IsPrime, IsPrimePower, LHS, MatrixAlgebra, Ngens,
#  OmegaConvertToStandard, OmegaPresentationToStandard,
#  OmegaStandardToPresentation, Omega_PresentationForN,
#  Omega_PresentationForN1, PrimitiveElement, RHS, SLPGroup,
#  Setup_OmegaPresentation, SpecialWordForDelta,
#  Special_OmegaStandardToPresentation, Universe, WordForDelta, phi, tau

#  Defines: OmegaConvertToStandard, OmegaGenerators, OmegaPresentation,
#  OmegaPresentationToStandard, OmegaStandardToPresentation, Omega_OrderN,
#  Omega_OrderN1, Omega_PresentationForN, Omega_PresentationForN1,
#  Setup_OmegaPresentation, SpecialWordForDelta, WordForDelta

DeclareGlobalFunction("OmegaConvertToStandard");

DeclareGlobalFunction("OmegaStandardToPresentation");

DeclareGlobalFunction("OmegaPresentationToStandard");

#  Forward declaration of OmegaConvertToStandard
#  Forward declaration of OmegaStandardToPresentation
#  Forward declaration of OmegaPresentationToStandard
OmegaGenerators:=function(d,q)
local Delta,varE,F,MA,U,V,varZ,gens,n,sigma,tau,w;
  Assert(1,IsOddInt(d));
  Assert(1,IsOddInt(q));
  if d=3 then
    return ClassicalStandardGenerators("Omega",3,q);
  fi;
  n:=QuoInt(d,2);
  Assert(1,n > 1);
  F:=GF(q);
  MA:=MatrixAlgebra(F,d);
  varZ:=Identity(MA);
  varZ[1][1]:=0;
  varZ[1][2]:=1;
  varZ[2][1]:=1;
  varZ[2][2]:=0;
  varZ[d][d]:=-1;
  w:=PrimitiveElement(F);
  lvarDelta:=Identity(MA);
  lvarDelta[1][1]:=w^-1;
  lvarDelta[2][2]:=w;
  lvarDelta[3][3]:=w^1;
  lvarDelta[4][4]:=w^-1;
  lvarDelta:=lvarDelta*FORCEOne(GL(d,F));
  tau:=Identity(MA);
  tau[1][1]:=1;
  tau[1][2]:=1;
  tau[1][d]:=1;
  tau[d][2]:=2;
  tau[d][d]:=1;
  sigma:=Identity(MA);
  sigma[1][1]:=1;
  sigma[1][3]:=1;
  sigma[4][2]:=-1;
  sigma[4][4]:=1;
  varE:=ClassicalStandardGenerators("Omega",d,q);
  U:=varE[5];
  V:=varE[4];
  gens:=[lvarDelta,varZ,tau,sigma,U,V];
  return gens;
end;

Omega_PresentationForN1:=function(n)
local F,R,R1,Rels,S,U,V,varZ,phi;
  Assert(1,n > 1);
  F:=SLPGroup(3);
  varZ:=F.1;
  U:=F.2;
  V:=F.3;
  # =v= MULTIASSIGN =v=
  R:=SignedPermutations(n);
  S:=R.val1;
  R:=R.val2;
  # =^= MULTIASSIGN =^=
  phi:=GroupHomomorphismByImages(S,F,
    GeneratorsOfGroup(S),
    [U,V]);
  R:=List(R,r->phi(r));
  R1:=[];
  if n > 2 then
    Add(R1,Comm(varZ,U^V)=1);
  fi;
  if n > 3 then
    Add(R1,Comm(varZ,V*U^-1)=1);
  fi;
  Add(R1,varZ^2=1);
  Add(R1,Comm(varZ,U^2)=1);
  Add(R1,Comm(varZ,varZ^U)=1);
  Rels:=Concatenation(List(R1,r->LHS(r)*RHS(r)^-1),R);
  return rec(val1:=F,
    val2:=Rels);
end;

Omega_OrderN1:=function(n)
return 2^(2*n-1)*Factorial(n);
end;

Omega_PresentationForN:=function(n,q)
local Delta,F,OMIT,R,R1,Rels,S,U,V,varZ,phi;
  F:=SLPGroup(4);
  lvarDelta:=F.1;
  varZ:=F.2;
  U:=F.3;
  V:=F.4;
  # =v= MULTIASSIGN =v=
  R:=Omega_PresentationForN1(n);
  S:=R.val1;
  R:=R.val2;
  # =^= MULTIASSIGN =^=
  phi:=GroupHomomorphismByImages(S,F,
    GeneratorsOfGroup(S),
    [varZ,U,V]);
  R:=List(R,r->phi(r));
  R1:=[];
  if n > 3 then
    Add(R1,Comm(lvarDelta,U^(V^2))=1);
    Add(R1,Comm(lvarDelta,lvarDelta^(V^2))=1);
  fi;
  if n > 4 then
    Add(R1,Comm(lvarDelta,V*U*U^V)=1);
  fi;
  if n > 2 then
    Add(R1,Comm(lvarDelta,varZ^(V^2))=1);
    Add(R1,lvarDelta*lvarDelta^V=lvarDelta^(V*U));
    Add(R1,Comm(lvarDelta,lvarDelta^V)=1);
    Add(R1,Comm(lvarDelta,(U^2)^V)=1);
  fi;
  Add(R1,lvarDelta^U=lvarDelta^-1);
  OMIT:=true;
  if not OMIT then
    Add(R1,lvarDelta^(QuoInt((q-1),2))=U^2);
  fi;
  Add(R1,lvarDelta^(varZ*varZ^U)=lvarDelta^-1);
  if n=2 then
    Add(R1,Comm(lvarDelta,lvarDelta^varZ)=1);
  fi;
  Rels:=Concatenation(List(R1,r->LHS(r)*RHS(r)^-1),R);
  return rec(val1:=F,
    val2:=Rels);
end;

Omega_OrderN:=function(n,q)
return (q-1)^n*2^(n-1)*Factorial(n);
end;

Setup_OmegaPresentation:=function(d,q)
local 
   Delta,F,I,R1,R2,R3,R4,R5,R6,Rels,S,U,V,W,varZ,b,e,f,n,p,phi,sigma,tau,w,x;
  Assert(1,IsOddInt(d));
  Assert(1,IsOddInt(q));
  n:=QuoInt(d,2);
  Assert(1,n > 1);
  F:=GF(q);
  w:=PrimitiveElement(F);
  # =v= MULTIASSIGN =v=
  e:=IsPrimePower(q);
  f:=e.val1;
  p:=e.val2;
  e:=e.val3;
  # =^= MULTIASSIGN =^=
  F:=SLPGroup(6);
  lvarDelta:=F.1;
  varZ:=F.2;
  tau:=F.3;
  sigma:=F.4;
  U:=F.5;
  V:=F.6;
  R3:=[];
  #   additional relation needed for q = p to express Delta as word in sigma
  #  and U
  if IsPrimeInt(q) then
    I:=Integers();
    b:=(1/w)*FORCEOne(I);
    w:=w*FORCEOne(I);
    Add(R3,lvarDelta=(sigma^U)^(w-w^2)*sigma^(b)*(sigma^U)^((w-1))
     *sigma^-1);
  fi;
  if e=1 then
    # =v= MULTIASSIGN =v=
    R1:=Omega_PresentationForN1(n);
    S:=R1.val1;
    R1:=R1.val2;
    # =^= MULTIASSIGN =^=
    phi:=GroupHomomorphismByImages(S,F,
      GeneratorsOfGroup(S),
      [varZ,U,V]);
  else
    # =v= MULTIASSIGN =v=
    R1:=Omega_PresentationForN(n,q);
    S:=R1.val1;
    R1:=R1.val2;
    # =^= MULTIASSIGN =^=
    phi:=GroupHomomorphismByImages(S,F,
      GeneratorsOfGroup(S),
      [lvarDelta,varZ,U,V]);
  fi;
  R1:=List(R1,r->phi(r));
  # =v= MULTIASSIGN =v=
  R2:=PresentationForSL2(p,e);
  S:=R2.val1;
  R2:=R2.val2;
  # =^= MULTIASSIGN =^=
  if e=1 then
    phi:=GroupHomomorphismByImages(S,F,
      GeneratorsOfGroup(S),
      [sigma,U]);
  else
    phi:=GroupHomomorphismByImages(S,F,
      GeneratorsOfGroup(S),
      [lvarDelta,sigma,U]);
  fi;
  R2:=List(R2,r->phi(r));
  if e > 1 then
    Add(R3,Comm(sigma,lvarDelta^(varZ^U))=1);
  fi;
  #   centraliser of tau
  R5:=[];
  if n > 2 then
    Add(R5,Comm(tau,U^V)=1);
    if e > 1 then
      Add(R5,Comm(tau,lvarDelta^V)=1);
    fi;
  fi;
  if n > 3 then
    Add(R5,Comm(tau,V*U^-1)=1);
  fi;
  Add(R5,Comm(tau,U^2*varZ^U)=1);
  if e > 1 and n=2 then
    Add(R5,Comm(tau,lvarDelta*lvarDelta^varZ)=1);
  fi;
  R6:=[];
  # =v= MULTIASSIGN =v=
  R6:=PresentationForSL2(p,e:Projective:=true);
  S:=R6.val1;
  R6:=R6.val2;
  # =^= MULTIASSIGN =^=
  if e=1 then
    phi:=GroupHomomorphismByImages(S,F,
      GeneratorsOfGroup(S),
      [tau,varZ]);
  else
    x:=lvarDelta*lvarDelta^(varZ^U);
    phi:=GroupHomomorphismByImages(S,F,
      GeneratorsOfGroup(S),
      [x,tau,varZ]);
  fi;
  R6:=List(R6,r->phi(r));
  #   Steinberg relations
  R4:=[];
  if n > 2 then
    Add(R4,Comm(sigma,sigma^V)=sigma^(V*U^-1));
    Add(R4,Comm(sigma,sigma^(V*U^-1))=1);
    W:=U^(V*U^-1);
    Add(R4,Comm(sigma,sigma^W)=1);
    #   new relation June 2018
    Add(R4,Comm(sigma,tau^(V^2))=1);
  fi;
  if n > 3 then
    Add(R4,Comm(sigma,sigma^(V^2))=1);
  fi;
  Add(R4,Comm(sigma,sigma^(varZ^U))=1);
  Add(R4,Comm(tau,tau^U)=(sigma^(varZ^U))^2);
  Add(R4,Comm(sigma,tau)=1);
  Add(R4,Comm(sigma^varZ,tau)=sigma*tau^(varZ*U));
  #   Omega(7, 3) has multiplicator of order 6
  if d=7 and q=3 then
    Add(R3,Comm(tau,sigma^V)=1);
  fi;
  Rels:=Concatenation(List(Concatenation(R3,R4,R5),r->LHS(r)*RHS(r)^-1)
   ,R1,R2,R6);
  return rec(val1:=F,
    val2:=Rels);
end;

OmegaPresentation:=function(d,q)
local P,Presentation,Q,R,Rels,S;
  Presentation:=ValueOption("Presentation");
  if Presentation=fail then
    Presentation:=false;
  fi;
  Assert(1,IsOddInt(d) and d > 1);
  Assert(1,IsOddInt(q));
  if d=3 then
    # =v= MULTIASSIGN =v=
    R:=ClassicalStandardPresentation("SL",2,q:Projective:=true);
    Q:=R.val1;
    R:=R.val2;
    # =^= MULTIASSIGN =^=
    Q:=SLPGroup(5);
    R:=Evaluate(R,List([1,1,2,3],i->Q.i));
    Add(R,Q.4);
    Add(R,Q.5);
    return rec(val1:=Q,
      val2:=R);
  fi;
  # =v= MULTIASSIGN =v=
  R:=Setup_OmegaPresentation(d,q);
  P:=R.val1;
  R:=R.val2;
  # =^= MULTIASSIGN =^=
  if Presentation then
    return rec(val1:=P,
      val2:=R);
  fi;
  # =v= MULTIASSIGN =v=
  Rels:=OmegaConvertToStandard(d,q,R);
  S:=Rels.val1;
  Rels:=Rels.val2;
  # =^= MULTIASSIGN =^=
  Rels:=Filtered(Rels,w->w<>w^0);
  return rec(val1:=S,
    val2:=Rels);
end;

#   relations are on presentation generators;
#  convert to relations on standard generators 
InstallGlobalFunction(OmegaConvertToStandard,
function(d,q,Rels)
local A,B,C,Rels,T,U,W,tau;
  A:=OmegaStandardToPresentation(d,q);
  Rels:=Evaluate(Rels,A);
  B:=OmegaPresentationToStandard(d,q);
  C:=Evaluate(B,A);
  U:=Universe(C);
  W:=Universe(Rels);
  tau:=GroupHomomorphismByImages(U,W,
    GeneratorsOfGroup(U),List([1..Ngens(W)],i->W.i));
  T:=List([1..Ngens(W)],i->W.i^-1*tau(C[i]));
  Rels:=Concatenation(Rels,T);
  return rec(val1:=W,
    val2:=Rels);
end);

#   word for Delta in Sp(4, 9) generated by 5 specific elements
SpecialWordForDelta:=function()
local 
   G,w1,w10,w103,w104,w105,w106,w107,w108,w109,w11,w12,w13,w14,w15,w16,w17,w18,
   w19,w2,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w3,w30,w31,w32,w33,w34,w35,
   w36,w37,w38,w39,w4,w45,w5,w52,w57,w58,w59,w6,w60,w61,w7,w8,w9;
  G:=SLPGroup(5);
  w10:=G.4*G.5;
  w103:=w10*G.5;
  w7:=G.3*G.1;
  w52:=G.4*w7;
  w6:=G.2*G.4;
  w57:=G.1*w6;
  w4:=G.2^2;
  w58:=w57*w4;
  w59:=w52*w58;
  w26:=G.3^-1;
  w45:=G.2*w26;
  w32:=G.1^-2;
  w60:=w45*w32;
  w61:=w59*w60;
  w104:=w103*w61;
  w105:=w104*w61;
  w106:=w105*G.1;
  w107:=w106*G.1;
  w108:=w107*G.1;
  w1:=G.4*G.3;
  w2:=G.5*w1;
  w3:=w2*w1;
  w5:=G.3*w4;
  w8:=w6*w7;
  w9:=w8*G.4;
  w11:=w9*w10;
  w12:=w5*w11;
  w13:=w3*w12;
  w14:=G.2*G.1;
  w15:=w14*w2;
  w16:=w15*w9;
  w17:=w9*w16;
  w18:=w13*w17;
  w19:=w18*w5;
  w20:=G.5^-1;
  w21:=G.1^-1;
  w22:=w20*w21;
  w23:=G.4^-1;
  w24:=G.2*w23;
  w25:=w22*w24;
  w27:=w26*w21;
  w28:=w20*w23;
  w29:=w27*w28;
  w30:=w25*w29;
  w31:=G.2*w20;
  w33:=w31*w32;
  w34:=w23*w21;
  w35:=w23*G.2;
  w36:=w34*w35;
  w37:=w33*w36;
  w38:=w30*w37;
  w39:=w19*w38;
  w109:=w108*w39;
  return w109;
end;

#   word for Delta for q = 1 mod 4 and q not equal to 9
WordForDelta:=function(d,q)
local 
   A,B,C,Delta2,varE,F,I,Special_OmegaStandardToPresentation,U,V,W,varZ,a,b,c,e,
   sigma,tau,w,w_Delta,words;
  Special_OmegaStandardToPresentation:=function(d,q)
  local U,V,W,varZ,delta,p,s,sigma,t,tau;
    W:=SLPGroup(5);
    s:=W.1;
    t:=W.2;
    delta:=W.3;
    U:=W.5;
    V:=W.4;
    # rewritten select statement
    if d mod 4=3 then
      tau:=t^V;
    else
      tau:=(t^-1)^V;
    fi;
    varZ:=s^V;
    p:=Characteristic(GF(q));
    sigma:=Comm(tau^(varZ*U),tau^(QuoInt((p+1),2)));
    return [Comm(delta^V,U),varZ,tau,sigma,U,V];
  end;

  W:=SLPGroup(6);
  #   Delta2 = Delta^2
  Delta2:=W.1;
  varZ:=W.2;
  tau:=W.3;
  sigma:=W.4;
  U:=W.5;
  V:=W.6;
  F:=GF(q);
  e:=Degree(F);
  w:=PrimitiveElement(F);
  I:=Integers();
  varE:=SubStructure(F,w^4);
  c:=Eltseq((-w^3)*FORCEOne(varE));
  c:=List(c,x->x*FORCEOne(I));
  b:=Eltseq((1-w)*FORCEOne(varE));
  b:=List(b,x->x*FORCEOne(I));
  a:=Eltseq((-w^-1+1)*FORCEOne(varE));
  a:=List(a,x->x*FORCEOne(I));
  C:=Product(List([0..e-1],i->(sigma^(Delta2^i*U))^c[i+1]));
  B:=Product(List([0..e-1],i->(sigma^(Delta2^i*sigma^U))^b[i+1]));
  A:=Product(List([0..e-1],i->(sigma^(Delta2^i))^a[i+1]));
  w_Delta:=C*Delta2*sigma^U*B*A;
  words:=Special_OmegaStandardToPresentation(d,q);
  w_Delta:=Evaluate(w_Delta,words);
  return w_Delta;
end;

#   express presentation generators as words in standard generators 
InstallGlobalFunction(OmegaStandardToPresentation,
function(d,q)
local Delta,U,V,W,varZ,delta,gens,p,s,sigma,t,tau;
  W:=SLPGroup(5);
  s:=W.1;
  t:=W.2;
  delta:=W.3;
  U:=W.5;
  V:=W.4;
  # rewritten select statement
  if d mod 4=3 then
    tau:=t^V;
  else
    tau:=(t^-1)^V;
  fi;
  varZ:=s^V;
  p:=Characteristic(GF(q));
  sigma:=Comm(tau^(varZ*U),tau^(QuoInt((p+1),2)));
  #   need to sort out Delta
  if q mod 4=3 then
    lvarDelta:=U^2*Comm(delta^V,U)^(QuoInt((q+1),4));
  elif q=9 then
    gens:=[Comm(delta^V,U),s^V,U,tau,sigma];
    lvarDelta:=SpecialWordForDelta();
    lvarDelta:=Evaluate(lvarDelta,gens);
  else
    lvarDelta:=WordForDelta(d,q);
    #   ensure Delta is in the correct SLPGroup
    lvarDelta:=Evaluate(lvarDelta,List([1..5],i->W.i));
  fi;
  return [lvarDelta,varZ,tau,sigma,U,V];
end);

#   express standard generators as words in presentation generators 
InstallGlobalFunction(OmegaPresentationToStandard,
function(d,q)
local Delta,U,V,W,varZ,sigma,t,tau;
  W:=SLPGroup(6);
  lvarDelta:=W.1;
  varZ:=W.2;
  tau:=W.3;
  sigma:=W.4;
  U:=W.5;
  V:=W.6;
  # rewritten select statement
  if d mod 4=3 then
    t:=tau^(V^-1);
  else
    t:=(tau^-1)^(V^-1);
  fi;
  #   return [s, t, delta, V, U]
  return [varZ^(V^-1),t,Comm(varZ,lvarDelta^-1)^(V^-1),V,U];
end);


