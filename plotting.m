data = readtable('train.txt');
one = 1;
two = 4;
figure;
x = data{1:40,one};
y = data{1:40,two};

plot(x,y,'*')
hold on
x = data{41:80,one};
y = data{41:80,two};

plot(x,y, 'o')

x = data{81:120,one};
y = data{81:120,two};

plot(x,y, '.')