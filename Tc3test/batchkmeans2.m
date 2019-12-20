% Implementacao do algoritmo K-medias batch
%
% Autor: Guilherme Barreto
% Data: 21/11/2019
%
clear; clc; close all;


%K=4;
protDunn=[];
protCH=[];
rod=[];
for rodadas=1:100;
  rodadas,
%Dados=load('dataset1.dat'); % Leitura do conjunto de dados
Dados=load('datasetTC3.dat'); % Leitura do conjunto de dados
X=(Dados-mean(Dados))./std(Dados);
clear Dados;
[N p]=size(X);  
 
u=0;
l=[];
Dunn=[];
CH=[];

  for K=2:10;  % Numero de prototipos escolhido
  %K,
  % Posicao inicial dos prototipos
  I=randperm(N,K);
  W=X(I,:);   % Seleciona aleatoriamente K exemplos do conjunto de dados 

  Ne=10;   % Numero de epocas de treinamento

    for r=1:Ne,
    % Busca pelo prototipo mais proximo do vetor de atributos
      for t=1:N,
          for k=1:K,
            Dist2(k)=norm(X(t,:)-W(k,:));
          end
        [Dmin(t) Icluster(t)]=min(Dist2);   % Indice do prototipo mais proximo
      end  
  
    SSD(r)=sum(Dmin.^2);     % Soma das distancias quadraticas por iteracao
  
   % Particiona dados em K subconjuntos e atualiza prototipo correspondente
      for k=1:K,
       I=find(Icluster==k); % Indice de todos os exemplos mais proximos do prototipo W_k
       Particao{k}=X(I,:);  % Separa todos os exemplos da k-esima particao
          if(Particao{k}~=0)
           W(k,:) = mean(Particao{k});     % Atualiza posicoes dos prototipos
          end
      end

    % Calcula SSD 
      for t=1:N,
          for k=1:K,
           Dist2(k)=norm(X(t,:)-W(k,:));
          end
      [dummy Icluster(t)]=min(Dist2);   % Indice do prototipo mais proximo
      end 
  
    end


  #### Mostra posicao final dos prototipos
##  if(K==4)
##  figure;
##  %plot(X(:,1),X(:,2),'ro',W(:,1),W(:,2),'b*')
##  plot(Particao{1}(:,1),Particao{1}(:,2),'ro',Particao{2}(:,1),Particao{2}(:,2),'go',Particao{3}(:,1),Particao{3}(:,2),'mo',Particao{4}(:,1),Particao{4}(:,2),'co',W(:,1),W(:,2),'b*')
##  title (K); 
##  end
    l=[l K];

################################################################################
############################INDICE DUNN#########################################
    Np=[];
    for i=1:K,
      [aux Pp]=size(Particao{i});
      Np=[Np aux];
    end
    clear aux;

    D=0;
    b=0;
    for u=1:K,
      s=0;
      for i=1:Np(:,u),
        for j=1:Np(:,u),
          if(i~=j)
          s=s+1;
          b(s)=norm(Particao{u}(i,:)-Particao{u}(j,:));
          end 
        end 
      end
    D(u)=max(b);
    end
    clear b u i j s;
    D;

    z=0;
    for i=1:K,
      for j=1:K,
        if(i~=j)
        z=z+1;
        w(z)=norm(W(i,:)-W(j,:));
        end
      end
    end

    Dunn=[Dunn min(w)/max(D)];

    clear w z;

################################################################################
############################### INDICE CH ######################################
    B=zeros(p);
    for i=1:K,
      B=B + Np(:,K)*(W(i,:)-X)'*(W(i,:)-X);
    end

    auxW=zeros(p);
    Wk=zeros(p);
    for i=1:K,
      for j=1:Np(:,i),
        auxW = auxW + (Particao{i}(j,:)-W(i,:))'*(Particao{i}(j,:)-W(i,:));
      end
    Wk=Wk+auxW;
    end

    CH=[CH (trace(B)/(K-1))/(trace(Wk)/(N-K))];
    end     
################################################################################
################################## FIM #########################################
    clear W X K I SSD b Icluster Particao dummy indDunn Ne r N t Pp p i j k Dmin D Dist2 l Np;
    rod=[rod rodadas];

    [valorDunn indDunn]=max(Dunn);   
    protDunn=[protDunn  indDunn+1];
    
    [valorCH indCH]=max(CH);
    protCH=[protCH indCH+1];
end
modaDunn=mode(protDunn)
modaCH=mode(protCH)

figure;
plot(rod,protDunn);
ylabel('Numero K ótimo');
xlabel('Número de rodadas');
title('índice Dunn');

figure;
plot(rod,protCH);
ylabel('Numero K ótimo');
xlabel('Número de rodadas');
title('índice CH');
##
##figure; 
##plot(l,Dunn)
##title("indice Dunn");

##B=zeros(2);
##for i=1:K,
##B=B + Np(:,K)*(W(i,:)-X)'*(W(i,:)-X);
##end
##
##
##auxW=zeros(2);
##Wk=zeros(2);
##for i=1:K,
##  for j=1:Np(:,i),
##  auxW = auxW + (Particao{i}(j,:)-W(i,:))'*(Particao{i}(j,:)-W(i,:));
##  end
##Wk=Wk+auxW;
##end
##
##CH=[CH (trace(B)/(K-1))/(trace(Wk)/(N-K))];
##
##figure; 
##plot(l,CH)
##title("indice CH");