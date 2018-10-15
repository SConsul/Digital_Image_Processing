%% ORL Dataset
X = zeros(92*112,192);
for i = 1:32 %Loading images
    for j = 1:6
    X(:,6*(i-1)+j) = reshape(im2double((imread(strcat('../Data/Dataset/s',num2str(i),'/',num2str(j),'.pgm')))),[92*112,1]);
    end
end
mean_face = (sum(X,2)/192);%Mean face of the dataset
Xbar = X - mean_face;
L = Xbar'*Xbar;
[V,D] = eig(L);
[d,ind] = sort(diag(D),'descend');%Sorting eigen values in descending order
D = D(ind,ind);
V = V(:,ind);
V= X*V;
V_2 = V.*V;
V_data=V./sqrt(sum(V_2));%Normalized eigen faces


k_vec = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
rate_rec = zeros(size(k_vec));%Vector that stores recognition rate for each k
for z = 1:13
    Vk=V_data(:,1:k_vec(1,z));
    coeff = Vk'*Xbar;%Coefficients of the training set
    rate= 0;
    for i = 1:32
        for j = 7:10
            z_i =  reshape(im2double((imread(strcat('../Data/Dataset/s',num2str(i),'/',num2str(j),'.pgm')))),[92*112,1]);
            z_bar = z_i - mean_face;
            coeff_z = Vk'*z_bar;%Coefficient of the probe image
            error_image = coeff - coeff_z;
            error_image = error_image.*error_image;
            error_sum = sum(error_image);
            [M,I] = min(error_sum);
            if(i == floor((I-1)/6)+1)%Checking for correct recognition
                rate=rate+1;
            end
    
        end
    end
    rate_rec(1,z) = rate/128*100;
    disp(['No. of Images correctly identified for k = ',num2str(k_vec(1,z)), 'is: ' ,num2str(rate)]);
    
end   
figure;
plot(k_vec,rate_rec);
title('Recognition Rate vs k');
xlabel('k');
ylabel('Recognition Rate');
axis on



%% Yale Dataset
X_yale = zeros(192*168,1520);
yaleF_person = dir([ '../Data/Dataset/yaleB*']);

for i = 1:38%Loading training dataset 
    yaleFiles = dir(['../Data/Dataset/' yaleF_person(i).name '/*.pgm']);
    for j = 1:40
        imgPath = strcat(['../Data/Dataset/' yaleF_person(i).name '/' yaleFiles(j).name]);
        X_yale(:,40*(i-1)+j) =  reshape(im2double((imread(imgPath))),[192*168,1]);
    end
end

mean_face_yale = (sum(X_yale,2)/1520);%Mean face of the dataset
Xbar_yale = X_yale - mean_face_yale;
%Calculating eigen faces using SVD
[U,S,V] = svds(Xbar_yale,1000);
[d,ind] = sort(diag(S),'descend');
S = S(ind,ind);
S= sqrt(S);
U = U(:,ind);
U_2 = U.*U;
U_data=U./sqrt(sum(U_2));%Normalized eigen faces

k_vec1=[1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
rate_rec = zeros(size(k_vec1));
rate_rec1 = zeros(size(k_vec1));
for z = 1:17%Testing dataset
    Vk=U_data(:,1:k_vec1(1,z));
    coeff = Vk'*Xbar_yale;
    rate= 0;
    rate1=0;
    length=0;
    for i = 1:38
        yaleFiles = dir(['../Data/Dataset/' yaleF_person(i).name '/*.pgm']);
        for j = 41:size(yaleFiles,1)
%             disp(i);
            imgPath = strcat(['../Data/Dataset/' yaleF_person(i).name '/' yaleFiles(j).name]);
            z_i =   reshape(im2double((imread(imgPath))),[192*168,1]);
            z_bar = z_i - mean_face_yale;
            coeff_z = Vk'*z_bar;
            error_image = coeff - coeff_z;
            error_image = error_image.*error_image;
            error_sum = sum(error_image);
            [M,I] = min(error_sum);
            error_sum1 = sum(error_image(4:k_vec1(1,z),:));
            [M,I1] = min(error_sum1);
            if(i == floor((I-1)/40)+1)
                rate=rate+1;
            end
            if(i == floor((I1-1)/40)+1)
                rate1=rate1+1;
            end
            length=length+1;
    
        end
    end
    rate_rec(1,z) = rate/length*100;
    rate_rec1(1,z) = rate1/length*100;
    disp(['No. of Images correctly identified for k = ',num2str(k_vec1(1,z)) ,'is: ', num2str(rate)]);
    disp(['No. of Images correctly identified for k (without top 3 eigen coefficients) = ',num2str(k_vec1(1,z)), 'is: ' ,num2str(rate1)]);
end   
figure;
plot(k_vec1,rate_rec);
title('Recognition Rate vs k');
xlabel('k');
ylabel('Recognition Rate');
axis on
axis([0 1000 0 100]);

figure;
plot(k_vec1,rate_rec1);
title('Recognition Rate vs k');
xlabel('k (Without considering top 3 eigen coefficients)');
ylabel('Recognition Rate');
axis on
axis([0 1000 0 100]);

    