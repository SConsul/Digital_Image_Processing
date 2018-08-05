% Contrast-limited Adaptive Histogram Equalisation`
tic;
my_imshow(barbara, "Original Barbara");
barbara_thresh = 0.05;
barbara_clahe_51 = myCLAHE(barbara,51,barbara_thresh);
my_imshow(barbara_clahe_51, 'CL-Adaptive Histogram Equalised Barbara');
barbara_clahe_half = myCLAHE(barbara,51,barbara_thresh/2);
my_imshow(barbara_clahe_half, 'CL-Adaptive Histogram Equalised Barbara - half');

my_imshow(TEM, 'Original TEM');
TEM_thresh = 0.05;
TEM_clahe_51 = myCLAHE(TEM,51,TEM_thresh);
my_imshow(TEM_clahe_51, 'CL-Adaptive Histogram Equalised TEM');
TEM_clahe_half = myCLAHE(TEM,51,TEM_thresh/2);
my_imshow(TEM_clahe_half, 'CL-Adaptive Histogram Equalised TEM - half');

my_imshow(canyon, 'Original Canyon');
canyon_thresh = 0.05;
canyon_clahe_51 = myCLAHE(canyon,51,canyon_thresh);
my_imshow((canyon_clahe_51)/255, 'Independent channel CL-Adaptive Histogram Equalised Canyon');
canyon_clahe_half = myCLAHE(canyon,51,canyon_thresh/2);
my_imshow((canyon_clahe_half)/255, 'Independent channel CL-Adaptive Histogram Equalised Canyon - half');
toc;