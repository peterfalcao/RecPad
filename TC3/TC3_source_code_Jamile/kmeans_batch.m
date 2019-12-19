%%%***********************************************************
% Reconhecimento de Padroes	
% Questão: K-means batch
% Patrícia Jamile
% Data: 15/12/2017
%%***********************************************************

clear;
clc;
close all;

%% Passo 1 - Normalização dos dados
% Algoritmo K médias

d=load('datasetTC3.dat');
load('datausermodeling.mat');
data = datausermodeling;
data = data(:,1:end-1); % Removendo os rótulos
[NL, NC] = size(data);

% Normalização dos atributos
Ymin = repmat(min(data),NL,1);
Ymax = repmat(max(data),NL,1);
data = (data - Ymin)./(Ymax - Ymin);     % Dados normalizados

%% Passo 2 - Executar K médias

Nr = 10;  % Número de rodadas
Kmin = 2;
Kmax = 10;
% Kmax = floor(sqrt(NL));
DB = zeros(1,Kmax-1);
DI = zeros(1,Kmax-1);
SSD = zeros(1,Kmax-1);
Result = [];

 for K = Kmin:Kmax
     NovosRotulosK = [];
     CentroidesK = [];
     C_bestK = [];
     SSDK = [];
     SSD_bestK = [];    
    for R = 1:Nr
       [Centroides,C_best, SSD] = rp_kmedias(data,K);
        CentroidesK = [CentroidesK; Centroides];
        C_bestK     = [C_bestK; C_best];
        SSDK = [SSDK; SSD(end)];
        SSD_bestK = [SSD_bestK; min(SSD)];
        % plotSSD(SSD_bestK,R,K)
    end  
    % Escolhendo a melhor rodada
    [M,I] = min(SSD_bestK);
    %plotSSD(SSD_bestK,1,K);
    % Passo 2: Encontrar DB máximos
    DB(K-1) = calculoDB(data, C_bestK(I).labels, K, C_bestK(I).prot);
    DI(K-1) = calculoDunn(data, C_bestK(I).labels, K, C_bestK(I).prot);
 end
 
%% Passo 3 - Escolher Kopt
[db,IoptDB] = min(DB);
KoptDB = IoptDB+1;


%figure,plot(Kmin:Kmax,DB); title('Indice DB'); xlabel('Clusters'); ylabel('Indices');

%% Passo 4: Divisão dos dados em Kopt clusters
[Centroides,C_best, SSD] = rp_kmedias(data,KoptDB);
for i = 1:KoptDB
    if isempty(find(C_best.labels == i,1))~=1
        Cluster = data(find(C_best.labels == i),:);
        Tamanho(i) = length(find(C_best.labels == i));
        Media(i,:) = mean(Cluster);
        Desvio(i,:) = std(Cluster);        
        Minimo(i,:) = min(Cluster);
        Maximo(i,:) = max(Cluster);
        Mediana(i,:) = median(Cluster);
    end
end
Tamanho
Media
Desvio
Minimo
Maximo
Mediana


figure,plot(Kmin:Kmax,DB); title('Indice DB'); xlabel('Clusters'); ylabel('Indices');

[di,IoptDI] = max(DI);
KoptDI = IoptDI+1;

[Centroides,C_best, SSD] = rp_kmedias(data,KoptDI);
for i = 1:KoptDI
    if isempty(find(C_best.labels == i,1))~=1
        Cluster = data(find(C_best.labels == i),:);
        Tamanho(i) = length(find(C_best.labels == i));
        Media(i,:) = mean(Cluster);
        Desvio(i,:) = std(Cluster);        
        Minimo(i,:) = min(Cluster);
        Maximo(i,:) = max(Cluster);
        Mediana(i,:) = median(Cluster);
    end
end
Tamanho
Media
Desvio
Minimo
Maximo
Mediana
figure,plot(Kmin:Kmax,DI); title('Indice DI'); xlabel('Clusters'); ylabel('Indices');
