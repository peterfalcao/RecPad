%%%***********************************************************
% Reconhecimento de Padroes
% Questão:K-médias
% Patrícia Jamile
% Data: 15/12/2017
%%***********************************************************
function [C,C_best, SSD] = rp_kmedias(dados,K)
% K médias, retorna os rótulos dos K clusters para os dados analisados
% Y novos rótulos
% C centróides atualizados

[NL, NC]=size(dados);
p = randperm(size(dados,1));

% Inicialização dos protótipos
C.prot = dados(p(1:K),:);
C_best.prot = dados(p(1:K),:);
C.labels = [];
C_old = dados(p(1:K),:);
ssd_best = ssd(dados,C.prot);
C_old = C.prot;

M = 0;      % Número de repetições
SSD = [];
while(1)
    M = M + 1;
    SSD(M) = ssd(dados,C.prot);
    if SSD(M) < ssd_best
        ssd_best = SSD(M);
        C_best.prot = C.prot;
        C_best.labels = C.labels;
    end
    % Cálculo das distâncias
    D = distn_euclidian(C.prot,dados);
    [~,C.labels] = min(D);
    
    % Cálculo dos novos centróides
    for i = 1:K
         if isempty(find(C.labels == i,1))~=1
            Cluster = dados(find(C.labels == i),:);
            C.prot(i,:) = mean(Cluster,1);           
         end       
    end
    if sum(sum(C_old - C.prot)) == 0
        break;
    end
    C_old = C.prot;
end
end

