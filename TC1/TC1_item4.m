ionos=load('ionosphere');
ionos_in=ionos.X;
ionos_label=ionos.Y;
%% Global
covglobal=cov(ionos_in);
%% Locais
labelchar=cell2mat(ionos_label);
for i= 1: size(labelchar,1)
    if(labelchar(i,1)=='g')
        ionos_out(i,1)=1;
    else
        ionos_out(i,1)=0;
    end
end
mtx1=[];
mtx2=[];
mtxresul=[ionos_in ionos_out];
for i= 1: size(mtxresul,1)
    if(mtxresul(i,35)==1)
    mtx1=vertcat(mtx1,mtxresul(i,1:34));
    else
     mtx2=vertcat(mtx2,mtxresul(i,1:34));
    end
end
covlocal1=cov(mtx1);
covlocal2=cov(mtx2);
%% Postos das Matrizes
rankg=rank(covglobal);
rankl1=rank(covlocal1);
rankl2=rank(covlocal2);
% Vemos que o posto das matrizes não é completo, através do comando rank (verifica o posto da matriz,
% em outras palavras as linas e colunas LI na matriz).
%% Condicionamento das Matrizes
condg=rcond(covglobal);
condl1=rcond(covlocal1);
condl2=rcond(covlocal2);
% O número de condicionamento de qualquer matriz inversível é maior ou
% igual a 1