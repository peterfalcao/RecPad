%%%***********************************************************
% Reconhecimento de Padroes
% Questão:K-médias
% Patrícia Jamile
% Data: 15/12/2017
%%***********************************************************
function [C,C_best, SSD] = seq_kmedias(dados,K)
% K médias, retorna os rótulos dos K clusters para os dados analisados
% Y novos rótulos
% C centróides atualizados

[NL, NC]=size(dados);
p = randperm(size(dados,1));

% Inicialização dos protótipos
C.prot = dados(p(1:K),:);
C_best.prot = dados(p(1:K),:);
C.labels = [];
C.N = zeros(1,K);
C_old = dados(p(1:K),:);
ssd_best = ssd(dados,C.prot);
C_old = C.prot;
cont =0;
M = 0;      % Número de repetições
SSD = [];
while(cont < 10)
    p = randperm(size(dados,1));
    dados = dados(p,:);
    M = M + 1;
    SSD(M) = ssd(dados,C.prot);
    if SSD(M) < ssd_best
        ssd_best = SSD(M);
        C_best.prot = C.prot;
        C_best.labels = C.labels;
        cont = 0;
    else
        cont = cont+1;
    end

    for i =1:NL
        % Cálculo das distâncias
        
        d = C.prot-repmat(dados(i,:),K,1);
        
        for k =1:K
            D(k) = norm(d(k),2);
        end
           
        [~,I] = min(D);
        C.N(I) = C.N(I)+1;
        alfa = 1/C.N(I);
        % Cálculo dos novos centróides
        C.prot(I,:)= C.prot(I,:)+ alfa*(dados(I,:)-C.prot(I,:));
    end
    
    dist = distn_euclidian(C.prot,dados);
    [~,C.labels] = min(dist);
    
    
    if sum(sum(C_old - C.prot)) == 0
        break;
    end
    
    
    C_old = C.prot;
    C.N = zeros(size(C.N));
end
end

