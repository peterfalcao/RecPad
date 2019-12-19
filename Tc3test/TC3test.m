clear; clc; close all;

X=load('datasetTC3.dat'); % Leitura do conjunto de dados
[X,L,C]=normalData(X);
k = 2;
[MtxProt,MtxSSDs,Mtxlabel]=kmedias(L,k,X);
