%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Histogram and data descriptors
%}

%Beginning of code
clear
close
clc

%Part a: Five historgrams of different bin widths
data= [413, 236, 372, 628, 300, 417, 205, 404, 464, 605, 198, 123, 389, 439, 497, 500, 535, 643, 569, 231, 675, 126, 347, 217, 577, 441, 865, 725, 378, 196];
bw=[25,50,75,100,200]; %Different bin widths
figure;
%Creating all 5 histograms
for i=1:width(bw)
    subplot(width(bw),1,i);
    histogram(data, 'BinWidth', bw(i));
    title(strcat('Bin Width: ',num2str(bw(i)), ' lb.'));
end

%Part b: Mean and standard deviation
mean = mean(data)
std = std(data)

%Part c: Normal distribution 10th and 90th percentiles
N=10000;
sample=sort(normrnd(mean, std,1,N)); %Sorting the data
P10=sample(.10*N) %Sample 10th percentile
P90=sample(.90*N) %Sample 90th percentile

%{
%This is extra code I wrote (not part of the assignment). Feel free to uncomment and run the code.
%Creates histogram of randomly generated normal distribution "sample" of 10000 points.
figure;
histogram(sample);
%Calculates 10th and 90th percentile, without using N=10000 points or the randomly generated normal distribution "sample".
%Here, I used z-scores.
z10=-1.282;
z90=1.282;
zP10 = mean+z10*std
zP90 = mean+z90*std
%}

%Part d: Empirical 10th and 90th percentiles
sortedData=sort(data); %Sorting the data
dP10 =sortedData(.10*width(data)) %Empirical 10th percentile
dP90=sortedData(.90*width(data)) %Empirical 90th percentile