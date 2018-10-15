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

k_vec = [62];

 % We calculate mean and variance of coefficients of each person in the 
   %training set. During testing, we calculate the distance of probe 
   %image in coefficient space with mean of every person in the training data. 
   %The person is identified on the basis of closest distance to mean. If 
   %the closest distance is more than 1.5*variance of this predicted identity 
   %then we reject the image as not belonging to training dataset

%% Calculating false positives for people not a part of the training set
people_identified = zeros(size(k_vec));
for z = 1:1
    Vk=V_data(:,1:k_vec(1,z));
    coeff = Vk'*Xbar;%Coefficients of the training set
    false_positives = 0;
    mean_coeff = zeros(k_vec(z),32);
    var_coeff = zeros(1,32);
    for i=1:32
        mean_coeff(:,i) = sum(coeff(:,6*(i-1)+1:6*i),2)/6;
        temp = zeros(k_vec(1,z),6);
        temp = coeff(:,6*(i-1)+1:6*i) - mean_coeff(:,i);
        var_coeff(i) = sum(sum(temp.*temp))/6;
        
    end
    for i=33:40
        for j =7:10
            z_i =  reshape(im2double((imread(strcat('../Data/Dataset/s',num2str(i),'/',num2str(j),'.pgm')))),[92*112,1]);
            z_bar = z_i - mean_face;
            coeff_z = Vk'*z_bar;%Coefficient of the probe image
            identified = 0;
            distance = sum((coeff_z-mean_coeff).*(coeff_z-mean_coeff));
            [M,I]= min(distance);
            
                if M < 1.5*var_coeff(I)
                    identified=1;
                end
            
            false_positives = false_positives+identified;
        end
    end
    people_identified(1,z) = false_positives/32*100;
    disp(['The false positives for k = ',num2str(k_vec(z)),' is ',num2str(false_positives),'(',num2str(people_identified(1,z)),'%) out of 32 person'])
end
%% Calculating false negatives for people present on the training set  
people_notidentified = zeros(size(k_vec));
for z = 1:1
    Vk=V_data(:,1:k_vec(1,z));
    coeff = Vk'*Xbar;%Coefficients of the training set
    false_negatives = 0;
    mean_coeff = zeros(k_vec(z),32);
    var_coeff = zeros(1,32);
    for i=1:32
        mean_coeff(:,i) = sum(coeff(:,6*(i-1)+1:6*i),2)/6;
        temp = zeros(k_vec(1,z),6);
        temp = coeff(:,6*(i-1)+1:6*i) - mean_coeff(:,i);
        var_coeff(i) = sum(sum(temp.*temp))/6;
        
    end
    for i=1:32
        for j =7:10
            z_i =  reshape(im2double((imread(strcat('../Data/Dataset/s',num2str(i),'/',num2str(j),'.pgm')))),[92*112,1]);
            z_bar = z_i - mean_face;
            coeff_z = Vk'*z_bar;%Coefficient of the probe image
            not_identified = 0;
            
%             for k=1:32
            distance = sum((coeff_z-mean_coeff).*(coeff_z-mean_coeff));
            [M,I]= min(distance);
            
                if M > 1.5*var_coeff(I)
                    not_identified=1;
                end
            
            false_negatives = false_negatives+not_identified;
        end
    end
    people_notidentified(1,z) = false_negatives/128*100;
    disp(['The false negatives for k = ',num2str(k_vec(z)),' is ',num2str(false_negatives),'(',num2str(people_notidentified(1,z)),'%) out of 128 person' ])
end

  