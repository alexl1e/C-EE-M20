%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Green-Screen graphics
%}

%Beginning of code
clear
close
clc

%Part a: Read and show images
img1=imread('Object.png'); %Dinosaur image
img2=imread('Background.jpg'); %Scenic background image
figure;
imshow(img1);
figure;
imshow(img2);

%Part b: Histograms for red, green, and blue channels
colors = ["Red", "Green", "Blue"]; %Colors in "RGB"
figure;
%Creating all 3 histograms for each color
for i=1:3
    subplot(3,1,i);
    histogram(img1(:,:,i));
    title(strcat('Object Image: ',colors(i), ' Channel'));
end

%Part c: Replace green screen
%Iterating through every pixel on the object image
for x=1:height(img1)
    for y=1:width(img1)
        if ~(img1(x,y,1) < 100 && img1(x,y,2) > 100 && img1(x,y,3)<100) %If it is not a green screen pixel
            img2(x,y,1)=img1(x,y,1); %Set red pixel value in background image to correpsonding one from object image
            img2(x,y,2)=img1(x,y,2); %Set green pixel value in background image to correpsonding one from object image
            img2(x,y,3)=img1(x,y,3); %Set green pixel value in background image to correpsonding one from object image
        end
    end
end
%Display the result of the green-screen effect
figure;
imshow(img2);

%{ 
Copyright Acknowledgement:
The images of Task 2 are downloaded from:
• https://www.pngfind.com/
• https://www.geeksforgeeks.org/
%}