function plotSSD(SSD,R,K)
% SSD, valores da soma das distâncias quadráticas
% R, número de repetição
% K, quantidade de clusters
figure;
plot(SSD); 
title(['SSD por iteração (Rodada ',num2str(R),'), K = ',num2str(K)])
xlabel('Iteração (k)')
ylabel('SSD(k)')
end

