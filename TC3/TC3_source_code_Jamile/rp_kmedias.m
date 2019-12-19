%%%***********************************************************
% Reconhecimento de Padroes
% Quest�o:K-m�dias
% Patr�cia Jamile
% Data: 15/12/2017
%%***********************************************************
function [C,C_best, SSD] = rp_kmedias(dados,K)
% K m�dias, retorna os r�tulos dos K clusters para os dados analisados
% Y novos r�tulos
% C centr�ides atualizados

[NL, NC]=size(dados);
p = randperm(size(dados,1));

% Inicializa��o dos prot�tipos
C.prot = dados(p(1:K),:);
C_best.prot = dados(p(1:K),:);
C.labels = [];
C_old = dados(p(1:K),:);
ssd_best = ssd(dados,C.prot);
C_old = C.prot;

M = 0;      % N�mero de repeti��es
SSD = [];
while(1)
    M = M + 1;
    SSD(M) = ssd(dados,C.prot);
    if SSD(M) < ssd_best
        ssd_best = SSD(M);
        C_best.prot = C.prot;
        C_best.labels = C.labels;
    end
    % C�lculo das dist�ncias
    D = distn_euclidian(C.prot,dados);
    [~,C.labels] = min(D);
    
    % C�lculo dos novos centr�ides
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

