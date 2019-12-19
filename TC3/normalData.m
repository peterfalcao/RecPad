function [dataNormal,L,C] = normalData(data)
[L,C] = size(data);
Ymin = repmat(min(data),L,1);
Ymax = repmat(max(data),L,1);
dataNormal = (data - Ymin)./(Ymax - Ymin);
end

