%% Estimar a matriz de covariância local 
clc;
clear all;
%%
ionos=load('ionosphere');
ionos_in=ionos.X;
ionos_label=ionos.Y;
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
mtx1=mtx1';
mtx2=mtx2';

m1=sum(mtx1,2)/size(mtx1,2);
m2=sum(mtx2,2)/size(mtx2,2);
mmtx1=repmat(m1,1,size(mtx1,2));
mmtx2=repmat(m2,1,size(mtx2,2));
Cx1=((mtx1-mmtx1)*(mtx1-mmtx1)')/size(mtx1,2);
Cx2=((mtx2-mmtx2)*(mtx2-mmtx2)')/size(mtx2,2);
Cxcov1=cov(mtx1',1);
Cxcov2=cov(mtx2',1);
Cx1=round(Cx1,4);
Cx2=round(Cx2,4);
Cxcov1=round(Cxcov1,4);
Cxcov2=round(Cxcov2,4);

is_equal1=isequal(Cx1,Cxcov1);
is_equal2=isequal(Cx2,Cxcov2);


%Cx3=((ionos_in-mmtx)*(ionos_in-mmtx)')/size(ionos_in,2);
%Cx3=round(Cx3,4);
%is_equal3=isequal(Cx3,Cxcov);