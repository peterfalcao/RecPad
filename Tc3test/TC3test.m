clear; clc; close all;

X=load('datasetTC3.dat'); % Leitura do conjunto de dados
[X,L,C]=normalData(X);
kmin=2;
kmax=10;
nr=20;
valueold=0;
M=[];
N=[];
 for i=kmin:kmax;
  for j=1:nr;
  [BestProt,value,BestSSD,Bestlabel]=kmedias(L,i,X);     
  M(j).prot=BestProt;
  valueSSD(j)=value;
  MinSSD(j)=BestSSD;
  M(j).label=Bestlabel;
  end
  [minvalue ind]=min(valueSSD);
  N(i-1).protk=M(ind).prot;
end