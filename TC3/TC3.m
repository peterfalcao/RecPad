clear; clc; close all;

X=load('datasetTC3.dat'); % Leitura do conjunto de dados
[X,L,C]=normalData(X);

Kmin = 2;
Kmax = 20;
% DB = zeros(1,Kmax-1);
% DI = zeros(1,Kmax-1);
SSD = zeros(1,Kmax-1);
for k = Kmin:Kmax
    [MtxProt,MtxSSDs,Mtxlabel]=kmedias(L,k,X);
    [BestSSD ind]=min(MtxSSDs);
    BestProt=MtxProt(:,:,ind);
    Bestlabel=Mtxlabel(ind,:);
    Cdb(k-1)=calculoDB(X,Bestlabel,k,BestProt);
    %CH(k-1)=calculoCH(X,Bestlabel,k,BestProt);
    Cdunn(k-1)=calculoDunn(X,Bestlabel,k,BestProt);
end
[db,IoptDB] = min(Cdb);
KoptDB = IoptDB+1;

% [ch,IoptCH] = max(CH);
% KoptCH = IoptCH+1;

[di,IoptDI] = max(Cdunn);
KoptDI = IoptDI+1;

[MtxProt,MtxSSDs,Mtxlabel]=kmedias(L,KoptDB,X);
[BestSSD ind]=min(MtxSSDs);
 BestProt=MtxProt(:,:,ind);
 Bestlabel=Mtxlabel(ind,:);
for k=1:KoptDB,
    I=find(Bestlabel==k); % Indice de todos os exemplos mais proximos do prototipo W_k
    Particao{k}=X(I,:);  % Separa todos os exemplos da k-esima particao
    TamanhoDB(k) = length(Particao{k});
    MediaDB(k,:) = mean(Particao{k});
    DesvioDB(k,:) = std(Particao{k});        
    MinimoDB(k,:) = min(Particao{k});
    MaximoDB(k,:) = max(Particao{k});
    MedianaDB(k,:) = median(Particao{k});
end
figure,plot(Kmin:Kmax,Cdb); title('Indice DB'); xlabel('Clusters'); ylabel('Indices');
figure,plot(Kmin:Kmax,Cdunn); title('Indice DI'); xlabel('Clusters'); ylabel('Indices');
figure,plot(Kmin:Kmax,CH); title('Indice CH'); xlabel('Clusters'); ylabel('Indices');

[MtxProt,MtxSSDs,Mtxlabel]=kmedias(L,KoptDI,X);
[BestSSD ind]=min(MtxSSDs);
 BestProt=MtxProt(:,:,ind);
 Bestlabel=Mtxlabel(ind,:);
for k=1:KoptDI,
    I=find(Bestlabel==k); % Indice de todos os exemplos mais proximos do prototipo W_k
    Particao{k}=X(I,:);  % Separa todos os exemplos da k-esima particao
    TamanhoDI(k) = length(Particao{k});
    MediaDI(k,:) = mean(Particao{k});
    DesvioDI(k,:) = std(Particao{k});        
    MinimoDI(k,:) = min(Particao{k});
    MaximoDI(k,:) = max(Particao{k});
    MedianaDI(k,:) = median(Particao{k});
end