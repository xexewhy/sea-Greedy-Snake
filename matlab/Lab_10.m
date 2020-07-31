clear
clc
%Read picture
picture=imread('./body.png');
Num=size(picture);
%Extract RGB components
R=picture(:,:,1);G=picture(:,:,2);B=picture(:,:,3);
%Convert RGB component vectors to 1D vectors
R=reshape(R,[1,Num(1)*Num(2)]);G=reshape(G,[1,Num(1)*Num(2)]);
B=reshape(B,[1,Num(1)*Num(2)]);
%Create a new SEU_Picture_R_Rom.coe file to save the image R value
fid = fopen('./body_R.coe','wt');
fprintf(fid,'memory_initialization_radix = 10;\nmemory_initialization_vector = ');
for i = 1 : 1024
    if mod(i-1,32) == 0 
        fprintf(fid,'\n');
    end
    fprintf(fid,'%4d,',R(i));
end
%Create a new SEU_Picture_G_Rom.coe file to save the image G value
fid = fopen('./body_G.coe','wt');
fprintf(fid,'memory_initialization_radix = 10;\nmemory_initialization_vector = ');
for i = 1 : 1024
    if mod(i-1,32) == 0 
        fprintf(fid,'\n');
    end
    fprintf(fid,'%4d,',G(i));
end
%Create a new SEU_Picture_B_Rom.coe file to save the image B value
fid = fopen('./body_B.coe','wt');
fprintf(fid,'memory_initialization_radix = 10;\nmemory_initialization_vector = ');
for i = 1 : 1024
    if mod(i-1,32) == 0 
        fprintf(fid,'\n');
    end
    fprintf(fid,'%4d,',B(i));
end