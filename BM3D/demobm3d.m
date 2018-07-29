function  demobm3d(  )
y = im2double(imread('barbara.png')); 
sigma=25;
 z = y + sigma/255*randn(size(y));%这里用噪声除以255的原因是将噪声限制在0到1内，由于信号也是在这个范围内的
 profile='lc';
 print_to_screen=1;
 %y = denoising_dwt(z);
 n=mad(z)%需要改进，只能估计这幅图像啊
 [PSNR, y_est] = BM3D(y, z, sigma, profile, print_to_screen);