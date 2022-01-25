function [ylwR2 ylwR]=fLWLS(xTr,yTr,xTs,arg)
% [ylwR2 ylwR]=fLWLS(xTr,yTr,xTs,arg)
%  default: arg.sgm=1;
if exist('arg')==1 && isfield(arg,'sgm'),sgm=arg.sgm;else,sgm=8e1;end;
if exist('arg')==1 && isfield(arg,'ep'),ep=arg.ep;else,ep=1e-8;end;
%% Local Weight LS
fDist=@(x,y) sum(bsxfun(@minus,x,y).^2,2);% º∆À„æ‡¿Î
fExp=@(x) exp(-x/sgm)+ep;
ylwR=zeros(size(xTs,1),1);ylwR2=ylwR;
for i=1:size(xTs,1)
    dstMat=fDist(xTr,xTs(i,:));
    dstEMat=fExp(dstMat);
    W=diag(dstEMat);
    w=inv(xTr'*W*xTr)*xTr'*W*yTr;
    ylwR(i)=xTs(i,:)*w;
    ylwR2(i)=-(dstMat)'*yTr;%Õ∂∆±
end