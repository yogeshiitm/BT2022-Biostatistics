% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Name: Aman Kumar
% Roll Number: EE19B066
% Course: EE3005
% Assignment: 3
% This the MATLAB code for the 7th question in HW3
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% Initializing the symbol time and the sample time respectively
% Reciprocal of these would be the Symbol rate, and the Sample rate
Tsymb = 2e-7; % Symbol rate = 1 / Tsymb
Tsam = 2.5e-8; % Sampling rate = 1 / Tsamp

% Initializing a1 and a2 for the time limit [a1, a2T]
a1 = -10;
a2 = 40;

% Since most of the energy of sinc(t / T) is contained in [-T, T]
% Thus, we can choose M = 1
M = 1;
time = a1 * Tsymb : Tsam : a2 * Tsymb; % Vector to store the time axis

% Length of message is (a2 - a1 + 1)
len = a2 - a1 + 1;
bx = zeros(1, len);
by = zeros(1, len);

step = Tsymb / Tsam;

% Generating random signal
for i = 1 : 1 : len
    Rx = randi(2); % A random integer in {1, 2}

    if(Rx == 1)
        bx(i) = -1/sqrt(2);
    else
        bx(i) = 1/sqrt(2);
    end

    Ry = randi(2); % A random integer in {1, 2}

    if(Ry == 1)
        by(i) = -1/sqrt(2);
    else
        by(i) = 1/sqrt(2);
    end
end

% Finding the modulated signal u(t)
% Modulated signal, u(t) =  Σb[n]p(t - n*Tsymb)
% p(t) --> Pulse
% b[n] --> symbol

u_t = zeros(1, length(time)); % Vector to store the modulated signal u(t)

for m = 1 : 1 : length(time) % Not using 'i' as it is used in the complex number
    for n = a1 + 1 : 1 : a2
        b = bx(n - a1) + 1i * by(n - a1);
        if(((time(m) - n * Tsymb) >= (-M * Tsymb)) && ((time(m) - n * Tsymb) <= (M * Tsymb)))
            p = sinc((time(m) - n * Tsymb) / Tsymb);
            u_t(m) = u_t(m) + b * p;
        end
    end
end

% Calculating the power of u(t)
Len = length(u_t);
Pow = (norm(u_t)^2) / Len;

disp("Power of u(t): ");
disp(Pow);

% FIGURE: 1
% Plotting: Power Spectum of u(t)
figure(1);
pspectrum(u_t, time);

% FIGURE: 2
% Plotting: Re{u(t)} vs time
figure(2);
plot(time, real(u_t));
title('$Re\{u(t)\}$ v $t$', 'Interpreter','latex');
xlabel('$t$', 'Interpreter','latex');
ylabel('$Re\{u(t)\}$', 'Interpreter','latex');

% FIGURE: 3
% Plotting: Im{u(t)} vs time
figure(3);
plot(time, imag(u_t));
title('$Im\{u(t)\}$ v $t$', 'Interpreter','latex');
xlabel('$t$', 'Interpreter','latex');
ylabel('$Im\{u(t)\}$', 'Interpreter','latex');