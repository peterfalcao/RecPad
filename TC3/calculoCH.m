function CH = calculoCH(data,ind,K,C )
n=size(data,1);
me=mean(data);
for k=1:K,
    I=find(ind==k); % Indice de todos os exemplos mais proximos do prototipo W_k
    Particao{k}=data(I,:);
    for i=1:length(Particao{k})
        x=Particao{k};
        x1(i)=norm((x(i,:))-C(k,:))^2;
    end
        w(k)=sum(x1);
    for j=1:length(data)
        x2(j)=norm((data(j,:))-me)^2;
    end
        t(k)=sum(x2);
end
    W=sum(w);
    T=sum(t);
    B=T-W;
up=((n-K)*B);
down=(K-1)*W;
CH=up/down;
end
