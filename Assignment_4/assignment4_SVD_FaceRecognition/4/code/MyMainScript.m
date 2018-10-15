%Cross checking MySVD with different variants of input matrix
square = magic(9);
[u s v] = MySVD(square);
err_sq = square - u*s*v';
err_sq = sum(sum(err_sq.*err_sq))/numel(square);
disp(['Reconstruction Error for a square matrix = ', num2str(err_sq)]);

tall = rand(12,9);
[u s v] = MySVD(tall);
err_tall = tall - u*s*v';
err_tall = sum(sum(err_tall.*err_tall))/numel(tall);
disp(['Reconstruction Error for a tall matrix = ', num2str(err_tall)]);

fat = rand(6,13);
[u s v] = MySVD(fat);
err_fat = fat - u*s*v';
err_fat = sum(sum(err_fat.*err_fat))/numel(fat);
disp(['Reconstruction Error for a fat matrix = ', num2str(err_fat)]);

%as seen, all variants of input matrix A result in small errors average squared error ( = Frobenius norm of difference/numel) between original and recontructied image