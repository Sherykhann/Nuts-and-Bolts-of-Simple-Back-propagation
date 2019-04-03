
 %-0.5574    0.3004
%   -0.4439    0.2693
 %BP PID;
clear all;
close all;


%xite=0.20;
alpha=1;
sum=0;

%S=1;%Signal type

IN=3;H=2;Out=2; %NN Structure
yd=[1000 0];



wj =[  0.1    0.6    0.8
    0.2    0.3    0.9];
    %wi=2*rand(H,IN)-ones(5,4);
 %wi_1=wi;wi_2=wi;wi_3=wi;
 
wo =[ 0.5    0.7
    0.6    0.5];
 % wo=2*rand(Out,H)-ones(3,5);
%wo_1=wo;wo_2=wo;wo_3=wo;






% x=[0,0,0];
% du_1=0;
% u_1=0;u_2=0;u_3=0;u_4=0;u_5=0;
% y_1=0;y_2=0;y_3=0;

Oh=zeros(H,1); %Output from NN middle layer
I=Oh;


ts=0.001;
for k=1:1:500
time(k)=k*ts;


    xi=[1  0  1];  %

%step 1 calculate outputs of hidden layer

I=wj*xi';
for n=1:1:H
    J(n)=(1)/(1+exp(-I(n)));%Middle Layer 
end
K=wo*J'; %These values will appear at the input of the output layer. 

%Step-2 calculate outputs 
for i=1:1:Out
    Y(i)=K(i); %Getting output 
end
O1(k)=Y(1);O2(k)=Y(2);

yout=[O1(k) O2(k)];
%Step 3 calculate error
for n=1:1:Out
error(n)=yd(n)-yout(n);
end 
sum(k)=sqrt((error(1))^2 + (error(2))^2 );
%sum(k)=norm(error)


%Update the weights between the output layer and hidden layer. 
% a1=1/(1+exp(-Y(1)));
% B1=a1*(1-a1);
for i=1:1:Out
  a(i)=1/(1+exp(-Y(i))); 
  b(i)=a(i)*(1-a(i));
end


  wo(1)= wo(1) +  alpha*error(1)*b(1)*J(1);
     wo(3)= wo(3) +  alpha*error(1)*b(2)*J(1);
      wo(2)= wo(2) +   alpha*error(2)*b(1)*J(2); 
       wo(4)= wo(4) +  alpha*error(2)*b(2)*J(2);
%     wo(1)= wo(1) +  alfa*error(1)*B1*J(1)  ;
    
%      wo(3)= wo(3) +  alpha*error(1)*(exp(-Y(1))/((1+exp(-Y(1))^2))*J(1) ;
%       wo(2)= wo(2) +  alpha*error(2)*(exp(-Y(2))/(1+exp(-Y(2)^2))*J(2) ;
%        wo(4)= wo(4) +  alpha*error(2)*(exp(-Y(2))/(1+exp(-Y(2)^2))*J(2) ;
%        
     
       
       %Update the weights between the input layer and hidden layer. 
       
      wj(1)= wj(1)+ (wo(1)*error(1)+ wo(2)*error(2));
      wj(3)= wj(3)+ (wo(1)*error(1)+ wo(2)*error(2));
      wj(5)= wj(5)+ (wo(1)*error(1)+ wo(2)*error(2));
      wj(2)= wj(2)+ (wo(3)*error(1)+ wo(4)*error(2));
      wj(4)= wj(4)+ (wo(3)*error(1)+ wo(4)*error(2));
      wj(6)= wj(6)+ (wo(3)*error(1)+ wo(4)*error(2));
      
      disp(k)
      disp(yout);
     


end
plot(sum);
% figure(1);
% plot(time,rin,'r',time,yout,'b');
% xlabel('time(s)');ylabel('rin,yout');
% figure(2);
% plot(time,error,'r');
% xlabel('time(s)');ylabel('error');
% figure(3);
% plot(time,u,'r');
% xlabel('time(s)');ylabel('u');
% figure(4);
% subplot(311);
% plot(time,kp,'r');
% xlabel('time(s)');ylabel('kp');
% subplot(312);
% plot(time,ki,'g');
% xlabel('time(s)');ylabel('ki');
% subplot(313);
% plot(time,kd,'b');
% xlabel('time(s)');ylabel('kd');
% wi
% wo
% sum(k)
