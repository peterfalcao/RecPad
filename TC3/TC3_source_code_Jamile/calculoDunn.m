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

