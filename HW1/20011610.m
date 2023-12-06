%% Yazarak Konvolusyon Kullanma

close all
clearvars
x=input('Gir x[n]:')
 
y=input('Gir y[m]:')

% konvolusyon
m=length(x);
n=length(y);
X=[x,zeros(1,n)];
Y=[y,zeros(1,m)];
for i=1:n+m-1
    myConv(i)=0;
    for j=1:m
        if(i-j+1>0)
            myConv(i)=myConv(i)+X(j)*Y(i-j+1);
        else
        end
    end
end
% sonuclarin grafiksel gosterimi
figure;
subplot(3,1,1); stem(x, '-b^'); xlabel('n');
ylabel('x[n]'); grid on;
subplot(3,1,2); stem(y, '-ms');
xlabel('n'); ylabel('y[n]'); grid on;
subplot(3,1,3); stem(myConv, '-ro');
ylabel('myConv[n]'); xlabel('----->n'); grid on;
title('2 Sinyalin Konvolusyonu');

%% Hazir Konvolusyon Formulu

close all
clearvars
x=input('Gir x[n]:');
 
y=input('Gir y[m]:');

myConv = conv(x,y);

msg = ['Result of conv is'];
disp(msg)
disp(myConv)

figure;
subplot(3,1,1); stem(x, '-b^'); xlabel('n');
ylabel('x[n]'); grid on;
subplot(3,1,2); stem(y, '-ms');
xlabel('n'); ylabel('y[n]'); grid on;
subplot(3,1,3); stem(myConv, '-ro');
ylabel('myConv[n]'); xlabel('----->n'); grid on;
title('2 Sinyalin Konvolusyonu');

%% 5 Saniye Ses Kaydetme
recObj = audiorecorder; %% kayıt başlatma nesnesi
disp('Start speaking.') %% ekrana mesaj
recordblocking(recObj, 5); %% kayıt işlemi
disp('End of Recording.'); %% ekrana mesaj
X1 = getaudiodata(recObj); %% kaydedilen sesi x1 değişkeninde saklama

%% 10 Saniye Ses Kaydetme
recObj = audiorecorder; %% kayıt başlatma nesnesi
disp('Start speaking.') %% ekrana mesaj
recordblocking(recObj, 10); %% kayıt işlemi
disp('End of Recording.'); %% ekrana mesaj
X2 = getaudiodata(recObj); %% kaydedilen sesi x2 değişkeninde saklama

%% Sisteme Girdi Olarak Verme

n=X1;
y(n) = x(n) + 0.4 * x(n-400) + 0.4 * x(n-800);
y(n) = deneme5;
Y1 = conv(X1,deneme5);

n=X2;
y(n) = x(n) + 0.4 * x(n-400) + 0.4 * x(n-800);
y(n) = deneme10;
Y2 = conv(X2,deneme10);

x=X1;
y=deneme5;
m=length(x);
n=length(y);
X=[x,zeros(1,n)];
Y=[y,zeros(1,m)];
for i=1:n+m-1
    myConv(i)=0;
    for j=1:m
        if(i-j+1>0)
            myConv(i)=myConv(i)+X(j)*Y(i-j+1);
        else
        end
    end
end

My_Y1 = myConv;

x=X2;
y=deneme10;
m=length(x);
n=length(y);
X=[x,zeros(1,n)];
Y=[y,zeros(1,m)];
for i=1:n+m-1
    myConv(i)=0;
    for j=1:m
        if(i-j+1>0)
            myConv(i)=myConv(i)+X(j)*Y(i-j+1);
        else
        end
    end
end

My_Y2 = myConv;


%% Giriş Verilerini Seslendirme

sound(X1)
sound(X2)
sound(Y1)
sound(Y2)
sound(My_Y1)
sound(My_Y2)