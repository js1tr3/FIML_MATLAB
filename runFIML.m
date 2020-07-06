NN = FIML(100, 1e-3, [7; 7], @solver);
            % number of iter, max step size (NN weight), number of nodes in
            % the hidden layer, two layers with 7 each, solver handle
NN.save();

figure(1)
%plot(

function [obj, sens, features, beta] = solver(NN)

    T_inf = 5;

    data = dlmread(strcat("True/solution_", string(T_inf), ".txt"));
    [obj, sens, features, beta] = RHT(T_inf, 129, 1e-2, 1000, 1e-8, 0, NN, data);
% could evaluate.    
end