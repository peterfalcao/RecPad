%%%***********************************************************
% Reconhecimento de Padroes
% Questão:Cálculo de distância entre matrizes
% Patrícia Jamile
% Data: 06/12/2014
%%***********************************************************

function D = distn_euclidian( A,B )
%distn_euclidian: Cálculo do vetor mais próximo de v na matriz X, utilizando distância 
% euclidiana através do comando 'norm' 
%  @param A matriz de amostras
%  @param B vetor de origem
%  @param D quantidade de amostra na matriz X
%

[Al,Ac] = size(A);
[Bl,Bc] = size(B);

if Ac~=Bc
    disp('Dimensões erradas, deve ter mesmo n´mero de coluns');
    exit;
end

D = zeros(Al,Bl);
for i = 1:Al
    for j = 1:Bl
        D(i,j)= norm(A(i,:)-B(j,:),2);
    end
end

end

