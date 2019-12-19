clear; clc; close all;

X=load('datasetTC3.dat'); % Leitura do conjunto de dados
[X,L,C]=normalData(X);
kmin=2;
kmax=10;
nr=20;
valueold=0;
M=[];
 for i=kmin:kmax;
  for j=1:nr;
  [BestProt,BestSSD,Bestlabel]=kmedias(L,i,X);     
  M(j).prot=BestProt;
  MinSSD(j)=BestSSD;
  M(j).label=Bestlabel;
  end
  
end