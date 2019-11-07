clear; clc; close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fase 1 -- Carrega imagens disponiveis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
part1_people = {'an2i' 'at33' 'boland' 'bpm' 'ch4f' 'cheyer' 'choon' 'danieln' 'glickman' 'karyadi' 'kawamura' 'kk49' 'megak' 'mitchell' 'night' 'phoebe' 'saavik' 'steffi' 'sz24' 'tammo'};
part1_people_vector = strvcat(part1_people);
part2_pose = {'_straight' '_left' '_right' '_up'};
part2_pose_vector = strvcat(part2_pose);
part3_expression = {'_neutral' '_happy' '_sad' '_angry'};
part3_expression_vector = strvcat(part3_expression);
part4_eyes = {'_sunglasses' '_open'};
part4_eyes_vector = strvcat(part4_eyes);
part5_size = {'_2', '_4'};
part5_size_vector = strvcat(part5_size);
part_6 = '.PGM';

Nind = length(part1_people); % Quantidade de individuos
Npose = length(part2_pose); % Quantidade de poses
Nexpression = length(part3_expression);
Neyes = length(part4_eyes);
Nsize = length(part5_size);

qtd_noexists = 0;
qtd_exists = 0;

X=[];  % Matriz que acumula imagens vetorizadas
d=[];  % Matriz que acumula o rotulo (identificador) do individuo


folder = 'C:\Users\pedro\Desktop\TC2\faces\';

for i=1:Nind
    folder_name = strcat(part1_people_vector(i,:),'\');
    ind_name = part1_people_vector(i,:)
    for j=1:Npose
       pose_name = part2_pose_vector(j,:);
       for k=1:Nexpression
           expression_name = part3_expression_vector(k,:);
           for l=1:Neyes
               eyes_name = part4_eyes_vector(l,:);
               for m=1:(Nsize + 1)
                   size = m;
                   if size==3
                       name = strcat(ind_name,pose_name,expression_name,eyes_name,part_6);
                       fullFileName = fullfile(folder, folder_name, name);
                       if exist(fullFileName, 'file')
                           Img=imread(fullFileName);  % le imagem
                           Ar = imresize(Img,[50 50]);   % Redimensionamento da imagem
                           An=imnoise(Ar,'salt & pepper',0.05);  % imagem com ruido
                           A=im2double(An);  % converte (im2double) para double precision
                           
                           A=A(:);  % Transforma matriz em vetor-coluna
                           
                           
                           ROT=-ones(Nind,1); ROT(i)=1;  % Cria rotulo (label) da imagem
                           X=[X A]; % Coloca cada imagem vetorizada como coluna da matriz X
                           d=[d ROT]; % Coloca o rotulo de cada vetor como coluna da matriz d
                           qtd_exists = qtd_exists + 1;
                       else
                           qtd_noexists = qtd_noexists + 1;
                       end
                       else
                           size_name= part5_size_vector(m,:);
                           name = strcat(ind_name,pose_name,expression_name,eyes_name,size_name,part_6);
                           fullFileName = fullfile(folder, folder_name, name);
                           if exist(fullFileName, 'file')
                                Img=imread(fullFileName);  % le imagem
                                 Ar = imresize(Img,[50 50]);   % Redimensionamento da imagem
                                 An=imnoise(Ar,'salt & pepper',0.05);  % imagem com ruido
                                 A=im2double(An);  % converte (im2double) para double precision

                                 A=A(:);  % Transforma matriz em vetor-coluna

                                 ROT=-ones(Nind,1); ROT(i)=1;  % Cria rotulo (label) da imagem
                                 X=[X A]; % Coloca cada imagem vetorizada como coluna da matriz X
                                 d=[d ROT]; % Coloca o rotulo de cada vetor como coluna da matriz d                           
                                 qtd_exists = qtd_exists + 1;
                           else
                            qtd_noexists = qtd_noexists + 1;
                           end
                   end
               end                     
           end
       end
    end
end
% Embaralhar imagens
ran = randperm(qtd_exists);
Xran=X(:,ran');
dran=d(:,ran');
% Separa em treino e teste.
trainIds=floor(qtd_exists*0.8);
%testIds=(qtd_exists-trainIds);

Xtrain=Xran(:,1:trainIds);
dtrain=dran(:,1:trainIds);

Xtest=Xran(:,trainIds+1:qtd_exists);
dtest=dran(:,trainIds+1:qtd_exists);

for i=1:dtrain

    
end




