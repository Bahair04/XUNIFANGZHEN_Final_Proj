% ��ȡ�ı��ļ��е�ǰ24964������
filename = "D:\XUNIFANGZHEN\FPGA\sim\sobel_res_out.txt";
fid = fopen(filename, 'r');
dat = fscanf(fid, "%d");
for i = 1 : length(dat)
    if (i >= 160 && mod(i - 160, 159) == 0)
        dat(i) = -1;
    end
end
fclose(fid);
fid = fopen("fix_data.txt", "w");
for i = 1 : length(dat)
    if (dat(i) == -1)
        continue;
    end
    fprintf(fid, "%d\n", dat(i));
end
fclose(fid);
data = textread("D:\XUNIFANGZHEN\FPGA\fix_data.txt", '%d', 24964);

% ��������������Ϊ158*158�ľ���
imageData = reshape(data, 158, 158);

% ��ʾͼ��
imshow(imageData, []);

