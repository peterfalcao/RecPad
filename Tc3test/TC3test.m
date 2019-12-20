clear; clc; close all;
% d=load('datasetTC3.dat');
% load('datausermodeling.mat');
% data = datausermodeling;
% data = data(:,1:end-1); 

X=load('datasetTC3.dat'); % Leitura do conjunto de dados
[X,L,C]=normalData(X);
kmin=2;
kmax=10;
nr=5;
valueold=0;
ListRound=[];
BestRound=[];
 for i=kmin:kmax;
  for j=1:nr;
  [BestProt,value,BestSSD,Bestlabel]=kmedias(L,i,X);     
  ListRound(j).prot=BestProt;
  valueSSD(j)=value;
  MinSSD(j)=BestSSD;
  ListRound(j).label=Bestlabel;
  end
  [minvalue ind]=min(valueSSD);
  BestRound(i-1).protk=ListRound(ind).prot;
  BestRound(i-1).labelk=ListRound(ind).label;
  DB(i-1) = calculoDB(X, BestRound(i-1).labelk, i,BestRound(i-1).protk);
  DI(i-1) = calculoDunn(X, BestRound(i-1).labelk, i,BestRound(i-1).protk);
 end
% l=[];
 
 
% [db,IoptDB] = min(DB);
% [di,IoptDI]=max(DI);
