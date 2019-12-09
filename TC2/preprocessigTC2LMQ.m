clear; clc; close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fase 1 -- Carrega imagens disponiveis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
part1_people = {'an2i' 'at33' 'boland' 'bpm' 'ch4f' 'cheyer' 'choon' 'danieln' 'glickman' 'karyadi' 'kawamura' 'kk49' 'megak' 'mitchell' 'night' 'phoebe' 'saavik' 'steffi' 'sz24' 'tammo'};
part1_people_vector = strvcat(part1_people);
part2_pose = {'_straight' '_left' '_right' '_up'};
part2_pose_vector = strvcat(part2_pose);
part3_expression = {'_neutral' '_happy' '_sad' '_angry'};
part3_expression_vector = strvcat(part3_expression);
part4_eyes = {'_sunglasses' '_open'};
part4_eyes_vector = strvcat(part4_eyes);
part5_size = {'_2','_4'};
part5_size_vector = strvcat(part5_size);
part_6 ='.PGM';
part_7 ={'.PGM','.bad'};
part7_vector=strvcat(part_7);

Nind = length(part1_people); % Quantidade de individuos
Npose = length(part2_pose); % Quantidade de poses
Nexpression = length(part3_expression);
Neyes = length(part4_eyes);
Nsize = length(part5_size);
Ntype=length(part_7);
qtd_noexists = 0;
qtd_exists = 0;

X=[];  % Matriz que acumula imagens vetorizadas
d=[];  % Matriz que acumula o rotulo (identificador) do individuo
% Mtxtrain=[]; % Matriz que acumula as imagens de treino
% MtxDtrain=[];
% Mtxtest=[]; % Matriz que acumula as imagens de teste
% MtxDtest=[];% Matriz de rotulos de teste
folder = 'C:\Users\pedro\Desktop\RecPad\TC2\faces\';
 count=0;
 resize=50;
 dMLQ=[];
%     Mtxtrain=[];
%     MtxDtrain=[];
%     Mtxtest=[];
%     MtxDtest=[];
for i=1:Nind
    counter(i)=0;
    folder_name = strcat(part1_people_vector(i,:),'\');
    ind_name = part1_people_vector(i,:);
    for j=1:Npose
       pose_name = part2_pose_vector(j,:);
       for k=1:Nexpression
           expression_name = part3_expression_vector(k,:);
           for l=1:Neyes
               eyes_name = part4_eyes_vector(l,:);
               for m=1:(Nsize + 1)
                   size = m;
                   if size==3
                        for n=1:Ntype
                        type=part7_vector(n,:);
                        name = strcat(ind_name,pose_name,expression_name,eyes_name,type);
                        fullFileName = fullfile(folder, folder_name, name);
                        if exist(fullFileName, 'file')
                           Img=imread(fullFileName);  % le imagem
                           Ar = imresize(Img,[resize resize]);   % Redimensionamento da imagem
                           An=imnoise(Ar,'salt & pepper',0.05);  % imagem com ruido
                           A=im2double(An);  % converte (im2double) para double precision
                           A=A(:);  % Transforma matriz em vetor-coluna                           
                           ROT=-ones(Nind,1); ROT(i)=1;  % Cria rotulo (label) da imagem
                           X=[X A]; % Coloca cada imagem vetorizada como coluna da matriz X
                           d=[d ROT]; % Coloca o rotulo de cada vetor como coluna da matriz d
                           qtd_exists = qtd_exists+1; % quantidade de imagens existentes
                           counter(i)=counter(i)+1; % quantidade de imagens por indivíduo
                       else
                           qtd_noexists = qtd_noexists + 1; %quantidade de imagens não existentes 
                       end
                       end
                       else
                           size_name= part5_size_vector(m,:);
                           name = strcat(ind_name,pose_name,expression_name,eyes_name,size_name,part_6);
                           fullFileName = fullfile(folder, folder_name, name);
                           if exist(fullFileName, 'file')
                                Img=imread(fullFileName);  % le imagem
                                 Ar = imresize(Img,[resize resize]);   % Redimensionamento da imagem
                                 An=imnoise(Ar,'salt & pepper',0.05);  % imagem com ruido
                                 A=im2double(An);  % converte (im2double) para double precision
                                 A=A(:);  % Transforma matriz em vetor-coluna

                                 ROT=-ones(Nind,1); ROT(i)=1;  % Cria rotulo (label) da imagem
                                 X=[X A]; % Coloca cada imagem vetorizada como coluna da matriz X
                                 d=[d ROT]; % Coloca o rotulo de cada vetor como coluna da matriz d                           
                                 qtd_exists = qtd_exists + 1; % quantidade de imagens existentes
                                 counter(i)=counter(i)+1; % quantidade de imagens por indivíduo
                           else
                                 qtd_noexists = qtd_noexists + 1; %quantidade de imagens não existentes 
                           end
                   end
               end                     
           end
       end
    end 
end
%tp=toc;
for z=1:100
countcorr=0;
countincorr=0;
Mtxtrain=[];
MtxDtrain=[];
Mtxtest=[];
MtxDtest=[];
    for i=1:Nind
        if(i==1)
            %treino   
            trainingcount(i)=round(0.8*counter(i));
            ran1=randperm(counter(i));
            Xind=X(:,1:counter(i));
            dind=d(:,1:counter(i));
            Xtrainran=Xind(:,ran1');
            dtrainran=dind(:,ran1');
            Xtrain=Xtrainran(:,1:trainingcount(i));
            dtrain=dtrainran(:,1:trainingcount(i));
            Mtxtrain=[Mtxtrain Xtrain];
            MtxDtrain=[MtxDtrain dtrain];
             
           %teste
           %testcount(i)=counter(i)-trainingcount(i);
            Xtest=X(:,trainingcount(i)+1:counter(i));
            dtest=d(:,trainingcount(i)+1:counter(i));
           
            Mtxtest=[Mtxtest Xtest];
            MtxDtest=[MtxDtest dtest];          
        else
            trainingcount(i)=round(0.8*counter(i));
            ran1=randperm(counter(i));
            Xind=X(:,((sum(counter(1:i-1)))+1):sum(counter(1:i)));
            dind=d(:,((sum(counter(1:i-1)))+1):sum(counter(1:i)));
            Xtrainran=Xind(:,ran1');
            dtrainran=dind(:,ran1');
            Xtrain=Xtrainran(:,1:trainingcount(i));
            dtrain=dtrainran(:,1:trainingcount(i));
            Mtxtrain=[Mtxtrain Xtrain];
            MtxDtrain=[MtxDtrain dtrain];
            
            Xtest=Xtrainran(:,trainingcount(i)+1:counter(i));
            dtest=dtrainran(:,trainingcount(i)+1:counter(i));
            Mtxtest=[Mtxtest Xtest];
            MtxDtest=[MtxDtest dtest];        
        end
    end
    W=MtxDtrain*pinv(Mtxtrain);
    for v=1:length(MtxDtest) 
        ROTLMQ=-ones(Nind,1);
        LMQ=W*Mtxtest(:,v);
        [m,ind]=max(LMQ);
        ROTLMQ(ind)=1;
        dMLQ(:,v)=ROTLMQ;
        if (isequal(dMLQ(:,v),MtxDtest(:,v)))
            countcorr=countcorr+1;
        else
            countincorr=countincorr+1;
        end
    end
    countcorrl(z)=countcorr;
    countincorrl(z)=countincorr;
end
accuracy=(countcorrl/length(MtxDtest))*100;
meanLMQ=mean(accuracy);
medianLMQ=median(accuracy);
minLMQ=min(accuracy);
maxLMQ=max(accuracy);
stdLMQ=std(accuracy);
 time=toc;
