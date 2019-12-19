function [MtxProt,MtxSSDs,Mtxlabel] = kmedias(L,K,X)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
I=randperm(L,K);
W=X(I,:); 
SDDold=0;
SDDnew=1;
while(SDDold != SDDnew)
    for t=1:L,
        for k=1:K
            Dist2(k)=norm(X(t,:)-W(k,:));
        end
        [Dmin(t) Icluster(t)]=min(Dist2);
    end
    SSD=sum(Dmin.^2);
    for k=1:K,
    I=find(Icluster==k); % Indice de todos os exemplos mais proximos do prototipo W_k
    Particao{k}=X(I,:);  % Separa todos os exemplos da k-esima particao
    W(k,:) = mean(Particao{k});     % Atualiza posicoes dos prototipos
    end

end


