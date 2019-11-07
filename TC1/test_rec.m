clc;
clear all;
ionos=load('ionosphere');
ionos_in=ionos.X';
ionos_label=ionos.Y;
%amostra=ionos_in(:,1:3);
%amostra = [1 2 3; 0 1 2; 4 5 6]
for n = 1:size(ionos_in,2) 
alfa=(n-1)/n;
    if(n==1)
       m=alfa*mean(V0)+(1-alfa)*ionos_in(:,n);
    else
       m=alfa*m+(1-alfa)*ionos_in(:,n);
    end        
end