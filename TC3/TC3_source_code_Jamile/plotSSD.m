function plotSSD(SSD,R,K)
% SSD, valores da soma das dist�ncias quadr�ticas
% R, n�mero de repeti��o
% K, quantidade de clusters
figure;
plot(SSD); 
title(['SSD por itera��o (Rodada ',num2str(R),'), K = ',num2str(K)])
xlabel('Itera��o (k)')
ylabel('SSD(k)')
end

