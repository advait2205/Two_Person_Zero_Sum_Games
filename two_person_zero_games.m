function [prob_A, prob_B, value_of_the_game]=two_person_zero_sum(A)

% Minimax-Maximin Principle
temp1=max(A,[],2);  
temp2=min(A,[],1);
t1=min(temp1);
t2=max(temp2);

% Saddle Point
if(t1==t2)  
    %Pure Strategy
    display("Saddle point exists");
    display(t1)
else
    %Mixed Strategy

   [m,n]=size(A);
   temp=(min(A));
 %  temp=temp+1;
 min_value=(min(temp));
 if (min_value<0)       %Make all the coefficients positive
        min_value=abs(min_value)+1;
        A=A+min_value;       
        display(A);
 else
     min_value=0;
 end

    %   Player A Strategy (linear_programming)
    optimization_function_coeff=ones(1,n);
    RHS_values=-1*ones(1,n);
    equality_constraints=zeros(n,1);
    strategies=-A';
    strategy_A=linprog(optimization_function_coeff,strategies,RHS_values,[],[],equality_constraints);
    display(strategy_A);

    % Player B strategy  (linear programming)
    optimization_function_coeff=-1*ones(1,n);
    RHS_values=ones(1,n);
    equality_constraints=zeros(n,1);
    strategies=A;
    strategy_B=linprog(optimization_function_coeff,strategies,RHS_values,[],[],equality_constraints);
    display(strategy_B);

    Z1=sum(strategy_A);
    Z2=sum(strategy_B);
    V1=1/Z1;
    V2=1/Z2;
    prob_A=strategy_A*V1;
    prob_B=strategy_B*V2;
    value_of_the_game=V1-min_value;
    display(prob_A);
    display(prob_B);
    display(value_of_the_game);
end