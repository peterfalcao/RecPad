%%%***********************************************************
% Reconhecimento de Padroes
% Questão:Cálculo do índice DB
% Patrícia Jamile
% Data: 06/12/2014
%%***********************************************************

function DB = calculoDB( data,y,K,C )
% data dadosde entrada
% y rótulos
% K classes
% C matriz com os centróides

for i = 1:K
    if isempty(find(y == i,1))~=1
        Cluster = data(find(y == i),:);
        aux = 0;
        % Passo 2.1: Cálculo dos índices DB
        for h = 1:size(Cluster,1)
            % DB
            aux = aux+ norm(Cluster(h,:)-C(i,:),2);
        end
        S(K)=aux/size(Cluster,1);
        % Silhueta
    else
        S(K)= 0;
        
    end
        
end

R = zeros(K,K);
Mij = zeros(K,K);
DBaux = zeros(K,1);
for i = 1:K
    for j = 1:K
        if j ~=i
            Mij(i,j) = norm(C(i,:)-C(j,:),2);
            R(i,j) = (S(i)+S(j))/Mij(i,j);
        end;
        
    end
end
for i = 1:K
    DBaux(i)= max(R(i,:));
end
DB = max(DBaux);

end

