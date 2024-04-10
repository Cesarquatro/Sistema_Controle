clear
clc

d = daq("ni");

% Add Channels
ch1 = addinput(d,"Dev1","ai0","Voltage");
ch1.TerminalConfig = "SingleEnded";

ch2 = addinput(d,"Dev1","ai1","Voltage");
ch2.TerminalConfig = "SingleEnded";

addoutput(d,"Dev1","ao0","Voltage");
d.Rate = 1000;
Ts = 1/d.Rate;
t = 0.0:Ts:20.0;
rotacao = 3000*pi/30;
ref = rotacao*ones(1,length(t));

PIoutput = zeros(1,length(t));
RPM_medido = zeros(1,length(t));
corrente_medida = zeros(1,length(t));

erro = zeros(1,2);
u = zeros(1,2);

Dev1_1.Dev1_ai0 = 0.0;

kp = 0.001407025785043;
ki = 0.016885202156297;%0.0923;%

q0 = kp+(ki*Ts/2);
q1 = -kp+(ki*Ts/2);

for j = 1:length(t)
    Dev1_1 = read(d,seconds(Ts));
    corrente_medida(j) = Dev1_1.Dev1_ai1;

    RPM_medido(j) = Dev1_1.Dev1_ai0/2.5e-3;

    erro(2) = erro(1);
    erro(1) = ref(j) - (RPM_medido(j)*(pi/30));

    u(2) = u(1);
    u(1) = q0*erro(1) + q1*erro(2) + u(2);
    if u(1) > 10
        u(1) = 10;
    elseif u(1) < -10
        u(1) = -10;
    end
    PIoutput(j) = u(1);

    write(d,u(1));
end
pause(2) % Adjust the duration of signal generation.

% Reset DC Output
dcOutput = 0;
write(d,dcOutput);

% Clean Up
clear d

% tempo = 0:Ts:(Ts*(length(PIoutput)-1));
figure(1)
plot(t,PIoutput,t,corrente_medida);
figure(2)
plot(t,RPM_medido,t,(30/pi)*ref);