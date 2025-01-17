function [BestProt,value,BestSSD,Bestlabel] = kmedias(L,K,X)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
I=randperm(L,K);
W=X(I,:); 
SSDold=0;
SSDnew=1;
MtxProt=[];
number=0;
while(SSDold ~= SSDnew)
    number=number+1;
    for t=1:L,
        for k=1:K
            Dist2(k)=norm(X(t,:)-W(k,:));
        end
        [Dmin(t) Icluster(t)]=min(Dist2);
    end
    SSDold=SSDnew;
    SSD=sum(Dmin.^2);
    SSDnew=SSD;
    for k=1:K,
    I=find(Icluster==k); % Indice de todos os exemplos mais proximos do prototipo W_k
    Particao{k}=X(I,:);  % Separa todos os exemplos da k-esima particao
    W(k,:) = mean(Particao{k});     % Atualiza posicoes dos prototipos
    end
        MtxProt(:,:,number)=W;
        SSDs(number)=SSD;
        Mtxlabel(number,:)=Icluster;       
end
[value BestSSD]=min(SSDs);
BestProt=MtxProt(:,:,BestSSD);
Bestlabel=Mtxlabel(BestSSD,:);

