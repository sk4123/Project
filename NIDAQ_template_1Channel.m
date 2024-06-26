% MATLAB supports M-Series, E-Series, and USB hardware from 
% National Instruments with the Data Acquisition Toolbox.  This basic code 
% example shows you how to use MATLAB to acquire and analyze data from 
% National Instrument hardware in 10 commands.  Additional commands you 
% may find useful are included here but commented out.

% Modified: C Farny, ME310

% Use this command to determine Board IDs in system, if needed
hw = daq.getDevices

% Create an analog input object 'handle' using Board ID "Dev1".
ai = daq.createSession('ni');

% Data will be acquired from hardware (BNC) channel 1
ai.addAnalogInputChannel('Dev1','ai1','Voltage');

% Configure the analog input channel for single-ended or differential mode
ai.Channels.InputType='SingleEnded';
% set the full scale input range (note this range is variable and can be
% changed)
ai.Channels.Range = [-5 5]; % (V)

% --- set triggering ---
% Set the sample rate and samples per trigger
% Note: These are settable options and you might want to use different
% values!
ai.Rate = 200; % [Hz]
ai.DurationInSeconds = 5; % [s]

% Review the basic configuration of the acquisition by typing 
% the name of the 'handle' variable. Note that the handle is responsible
% for transferring information to and from the board and Matlab
ai
% Acquire data
data = startForeground(ai);

fs = ai.Rate;%sampling rate
SampleTime = ai.DurationInSeconds;
dt = 1/fs;%time step [s]

% Graphically plot the results
t = 0:dt:SampleTime-dt;
plot(t,data);

% Clean up
stop(ai);
