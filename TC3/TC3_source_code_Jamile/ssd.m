function ssd_out = ssd(dados, C)
[NL, NC] = size(dados);
[NT, NC] = size(C);
ssd_out = 0;
for j = 1:NT
    for f = 1:NL
        ssd_out = ssd_out + norm(dados(f,:)- C(j,:))^2;
    end
end

end

