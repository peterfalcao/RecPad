% TC1
%% Estimar a matriz de covariância GLOBAL 
clc;
clear all;
%%
%%Forma vetorial
ionos=load('ionosphere');
ionos_in=ionos.X';
ionos_label=ionos.Y;
% Calculo do vetor médio
m=sum(ionos_in,2)/size(ionos_in,2);

%%%%%%%%%%%%%%%%% Equação 68 %%%%%%%%%%%%%%%%%%

%mmtx=repmat(m,34,1);% para realizar subtração de observação por vetor médio linha a linha;
% Calculo pela equação 68 - Cx=1/n sum[x(n)-m]*[x(n)-m]'
tic;
somacx=0;
for i = 1:size(ionos_in,2) 
       somacx=somacx+(ionos_in(:,i)-m)*(ionos_in(:,i)-m)';
end
Cx1=somacx/size(ionos_in,2);
t1=toc;
tic;
Cxcov=cov(ionos.X,1);
t2=toc;
% Colocando em 4 casas decimais para comparar com a função cov(para N)
Cx1=round(Cx1,4);
Cxcov=round(Cxcov,4);
% Comparando as matrizes de covariância
is_equal1=isequal(Cx1,Cxcov);
somarx=0;

%%%%%%%%%%%%%%%%% Equação 69 %%%%%%%%%%%%%%%%%%
tic
for i = 1:size(ionos_in,2) 
       somarx=somarx+(ionos_in(:,i))*(ionos_in(:,i))';
end
Rx=somarx/size(ionos_in,2);
Cx2=Rx-(m*m');
t3=toc;
Cx2=round(Cx2,4);
is_equal2=isequal(Cx2,Cxcov);

%%%%%%%%%%%%%%%%% Equação 70 %%%%%%%%%%%%%%%%%%
tic
mmtx=repmat(m,1,351);
Cx3=((ionos_in-mmtx)*(ionos_in-mmtx)')/size(ionos_in,2);
t4=toc;
Cx3=round(Cx3,4);
is_equal3=isequal(Cx3,Cxcov);

%%%%%%%%%%%%%%%%% Equação 73 %%%%%%%%%%%%%%%%%%

% Calculo do vetor médio da equação 73 
tic;
for n = 1:size(ionos_in,2) 
alfa=(n-1)/n;
v0=zeros(34,1);
mtxI=eye(34);
    if(n==1)
       mrec=alfa*mean(v0)+(1-alfa)*ionos_in(:,n);
       Rxrec=alfa*mtxI+(1-alfa)*(ionos_in(:,n)*ionos_in(:,n)');
    else
       mrec=alfa*mrec+(1-alfa)*ionos_in(:,n);
       Rxrec=alfa*Rxrec+(1-alfa)*(ionos_in(:,n)*ionos_in(:,n)');
    end
       Cxrec=Rxrec-(mrec*mrec');
end
t5=toc;
Cxrec=round(Cxrec,4);
Cxreccov=cov(ionos.X,1);
Cxreccov=round(Cxreccov,4);
% Comparando as matrizes de covariância
is_equal4=isequal(Cxrec,Cxreccov);




