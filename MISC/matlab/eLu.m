%%
A= rand(4);
[L,U,P] =lu(A);
zr = norm(L*U-P*A);
%% 
x = rand(4,1);
b = A*x;
% 原理：高斯消元法
% PA = LU
% Ax = b
% <==> PAx = Pb, LUx = Pb
% <==>  Ly = Pb, y=Ux
%   
%% eLu
n = length(A);
A2= A;A2(2:n,1) = A2(2:n,1)/A2(1,1);
for t=2:n-1
    A2(t,t:n) = A2(t,t:n) -A2(t,1:t-1)*A2(1:t-1,t:n);
    A2(t+1:n,t) =(A2(t+1:n,t)-A2(t+1:n,1:t-1)*A2(1:t-1,t))/A2(t,t);
end
A2(n,n)=A2(n,n)-A2(n,1:n-1)*A2(1:n-1,n);
L2=tril(A2,-1)+eye(n);U2=triu(A2);
zr2 = norm(L2*U2-A);
%% lu solve
b2 = b;
for t=2:n
    b2(t)=b2(t)-L2(t,1:t-1)*b2(1:t-1);
end
b2(n)=b2(n)/U2(n,n);
for t=1:n-1
    k=n-t;
    b2(k)=(b2(k)-U2(k,k+1:n)*b2(k+1:n))/U2(k,k);
end
x2=b2;
zr3 = norm(x2-x);
%%
zr4=norm( inv(U2)*inv(L2)-inv(A))