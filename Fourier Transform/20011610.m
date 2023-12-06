clc; clear;
f1 = 'char';
f2 = 'first';
f3 = 'second';

DTMF_table(1) = struct(f1, '1', f2, 697, f3, 1209);
DTMF_table(2) = struct(f1, '2', f2, 697, f3, 1336);
DTMF_table(3) = struct(f1, '3', f2, 697, f3, 1477);
DTMF_table(4) = struct(f1, '4', f2, 770, f3, 1209);
DTMF_table(5) = struct(f1, '5', f2, 770, f3, 1336);
DTMF_table(6) = struct(f1, '6', f2, 770, f3, 1477);
DTMF_table(7) = struct(f1, '7', f2, 852, f3, 1209);
DTMF_table(8) = struct(f1, '8', f2, 852, f3, 1336);
DTMF_table(9) = struct(f1, '9', f2, 852, f3, 1477);
DTMF_table(10) = struct(f1, '0', f2, 941, f3, 1336);
DTMF_table(11) = struct(f1, 'A', f2, 697, f3, 1633);
DTMF_table(12) = struct(f1, 'B', f2, 770, f3, 1633);
DTMF_table(13) = struct(f1, 'C', f2, 852, f3, 1633);
DTMF_table(14) = struct(f1, 'D', f2, 941, f3, 1633);
DTMF_table(15) = struct(f1, '*', f2, 941, f3, 1209);
DTMF_table(16) = struct(f1, '#', f2, 941, f3, 1477);

save("DTMF_keypad_f", "DTMF_table");

%%
clc; clear;

x  = [697, 770, 852, 941];
y = [1209, 1336, 1477, 1633];

mat = [['1', '2', '3', 'A'];
       ['4', '5', '6', 'B'];
       ['7', '8', '9', 'C'];
       ['*', '0', '#', 'D']];
   
save("decode")

%%
clc; clear; close;

audioName = input("Kök dizindeki dosya adini girin: ", 's');
% audioName = 'tel.wav';
[tone, Fs] = audioread(audioName);
info = audioinfo(audioName);

load("decode.mat")
% bütün sesi tinlama uzunluguna bölme
env = envelope(tone,80,'rms');
[w, s, e] = pulsewidth(env,Fs);
s = [[.001]; s];
e = [s(2); e];
s = round(s * Fs);
e = round(e * Fs);

f = [x , y];
tones = cell(size(s));
for i = 1:size(s)
    tones(i,:) = {tone(s(i):e(i))};
end

for i=1:size(s)
    freq_indices = round(f./Fs*size(tones{i}, 1)) + 1;   
    dft_data = abs(goertzel(tones{i},freq_indices));
    [val, ind] = maxk(dft_data, 2);
    if (ind(1) > ind(2))
       disp(mat(ind(2),ind(1)-4))
    else
       disp(mat(ind(1),ind(2)-4))
    end
    disp("-----------------------")
    
    stem(f,abs(dft_data))
    ax = gca;
    ax.XTick = f;
    xlabel('Frekans (Hz)')
    title('DFT Büyüklüğü')
    
    pause(3);
end

%%
[tel,fs] = audioread('tel.wav')
sound(tel); %plays the data in the vector tel as an audio signal.
d = floor(length(tel)/7); %the length of each interval
tel1 = tel(1:d); %extracting the first of n intervals of length d from the tel vector..
tel2 = tel(2:d);
tel3 = tel(3:d);
tel4 = tel(4:d);
tel5 = tel(5:d);
tel6 = tel(6:d);
tel7 = tel(7:d);

n = length(tel);
p = abs(fft(tel));
f = (fs/n)*(0:n-1);

plot(f,p)
xlabel('f(Hz)')
title('Güç')

%%
