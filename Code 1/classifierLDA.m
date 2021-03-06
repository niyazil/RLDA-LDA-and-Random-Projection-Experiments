%This function applies the LDA classifier to given data provided the labeled
%data statistics. It returns the error rate e, i.e. the number of
%classification errors over the total number of samples classified.
%'X0' is a matrix of samples to be classified whose true class is class 0.
%Similarly, 'X1' is a matrix of samples to be classified whose true class is
%class 1. The total number of samples is denoted by 'n'.

%NOTE:C needs to be invertible!

function e=classifierLDA(xBar0,xBar1,C,X0,X1,n0,n1,n,c)
    if(det(C)==0)
        disp('C is singular.')
        e=Inf;
    else
        discriminant=@(x)(x-(xBar0+xBar1)/2)'*inv(C)*(xBar0-xBar1);%define the LDA discriminant (which operates on a single sample)
        %apply discriminant to each column of each sample matrix and count the number
        %of errors
        noErrors=0;
        for i=1:n0
            if(discriminant(X0(i))<=c)%if class 0 sample classifies to class 1 increment noErrors
                noErrors=noErrors+1;
            end
        end
        for j=1:n1
            if(discriminant(X1(j))>c)%if class 1 sample classifies to class 0 increment noErrors
                noErrors=noErrors+1;
            end
        end

        %compute the error rate
        e=noErrors/n;
    end
end