% Routines for opening face images and convert them to column vectors
% by stacking the columns of the face matrix one beneath the other.
%
% Last modification: 23/04/2018
% Author: Guilherme Barreto

clear; clc; close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fase 1 -- Carrega imagens disponiveis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
part1 = 'subject0';
part2 = 'subject';
part3 = {'.centerlight' '.glasses' '.happy' '.leftlight' '.noglasses' '.normal' '.rightlight' '.sad' '.sleepy' '.surprised' '.wink'};
part4 = strvcat(part3);

Nind=15;   % Quantidade de individuos (classes)
Nexp=length(part3);  % Quantidade de expressoes

X=[];  % Matriz que acumula imagens vetorizadas
d=[];  % Matriz que acumula o rotulo (identificador) do individuo
NAME=[];
for i=1:Nind,  % Indice para os individuos
    individuo=i,
    for j=1:Nexp,   % Indice para expressoes
        if i<10,
            nome = strcat(part1,int2str(i),part4(j,:));    % Monta o nome do arquivo de imagem
        else
            nome = strcat(part2,int2str(i),part4(j,:));
        end
        Img=imread(nome);  % le imagem
        % imshow(Img); pause;
        Ar = imresize(Img,[50 50]);   % Redimensionamento da imagem
        An=imnoise(Ar,'salt & pepper',0.05);  % imagem com ruido
        A=im2double(An);  % converte (im2double) para double precision

        A=A(:);  % Transforma matriz em vetor-coluna
        
        ROT=-ones(Nind,1); ROT(i)=1;  % Cria rotulo (label) da imagem
        X=[X A]; % Coloca cada imagem vetorizada como coluna da matriz X
        d=[d ROT]; % Coloca o rotulo de cada vetor como coluna da matriz d
    end 
end


