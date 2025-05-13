fid = fopen("zi.txt", "r");
a = fscanf(fid, "%s");
length(a)
fclose(fid);
num = hex2dec('66FF');
fid = fopen("mif.txt", "a");
for i = 1 : length(a)
    num = num + 1;
    if (a(i) == '0')
        data = 'FFFFFF';
    else
        data = '000000';
    end
    fprintf(fid, "	%s	: %s;\n", dec2hex(num), data);
end
fclose(fid);