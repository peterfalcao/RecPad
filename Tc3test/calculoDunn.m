function DI = calculoDunn( data,ind,K,C )
% data dadosde entrada
% y r�tulos
% K classes
% C matriz com os centr�ides

% C�lculo da matriz de dissimilaridade
distM = squareform( pdist(data,'euclidean').^2 );  % dist�ncia euclidiana
i = K;
denominator = [];

for i2=1:i
    indi = find(ind==i2);
    indj = find(ind~=i2);
    x = indi;
    y = indj;
    temp = distM(x,y);
    denominator = [denominator;temp(:)];
end
% C�lculo do numerador
num = min(min(denominator)); 
neg_obs = zeros(size(distM,1),size(distM,2));

for ix=1:i
    indxs=find(ind==ix);
    neg_obs(indxs,indxs)=1;
end

% C�lculo do denominador
dem = neg_obs.*distM;
dem = max(max(dem));

DI = num/dem;    
end
% function DI = calculoDunn(data,ind,K,C )
%  for i=1:K,
%      for k=1:i
%          I=find(ind==k);
%          Particao{k}=data(I,:);
%          sizePart(k)=length(Particao{k});
%      end
%  end
% 
%  for m=1:K
% 	for n=1:sizePart(m)
% 	a=0;
% 	lk=0;
% 		for o=1:K
% 			if(o~=m)
% 			a=a+1;
% 				for p=1:sizePart(o),
% 				b(p)=norm(Particao{m}(n,:)-Particao{o}(p,:));
% 				end
% 				lkmin(a)=min(b);
%             end
%                 
% 		end
% 		ljmin(n)=min(lkmin);
% 	end
% 	lhmin(m)=min(ljmin);
%  end
% 
%  up=min(lhmin);
% 
%  for m=1:K
% 	for n=1:sizePart(m)
% 	a=0;
% 	lk=0;
% 		for o=1:K
% 			if(o==m)
% 			a=a+1;
% 				for p=1:sizePart(o),
% 				b(p)=norm(Particao{m}(n,:)-Particao{o}(p,:));
% 				end
% 				lk(a)=max(b);
% 			end
% 		end
% 		lj(n)=max(lk);
% 	end
% 	lh(m)=max(lj);
%  end
% down=max(lj);
% DI=up/down;