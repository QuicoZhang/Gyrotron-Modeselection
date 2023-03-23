clc
clear all
freL1=[140.176,140.177,140.176,140.176,140.176,140.176];
QL1=[833.39,856.26,867.69,864.48,860.44,858.75];
L1={'0.5L','0.7L','0.9L','1.1L','1.3L','1.5L'};
x=[1,2,3,4,5,6];
y=[1,2,3,4,5,6,7];

yyaxis('left')
P1=plot(x,freL1,'-*');
ylim([140.15,140.2]);
ylabel('Resonant Frequency/GHz');
legend(P1,'Resonant Frequency');
legend('off'); legend('show');
hold on

yyaxis('right')
P2=plot(x,QL1,'-o');
ylim([800,900]);
ylabel('Q Value');
legend(P2,'Q Value');
set(gca,'xticklabel',L1)
legend('off'); legend('show');  

xlabel('Length of L1');