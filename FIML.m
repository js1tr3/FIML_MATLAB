function NN = FIML(nFIMLIters, stepSize, nHiddenLayerNodes, solver)

    % SOLVE FOR BASELINE AND TRAIN THE NEURAL NETWORK FOR BASELINE STATES ::::::::::::::::::::::::::::::::::::::::::::::
    
    fprintf("Beginning FIML\n");
    [~, ~, features, beta] = solver([]);
    NN = NeuralNetwork(size(features,2), nHiddenLayerNodes);
    
    fprintf("Training NN for baseline...\n");
    NN.train(features, beta, 100, 20, 0.8, 0);
    
    [obj, dJdbeta, ~, ~] = solver(NN);
    sens = NN.getSens(features, dJdbeta);
    % For Finite diference, evaluate sensitivity to the weights and bias directly.
    % loop oVer NN.vars
    % perturb NN.vars (1 at a time)
    % Evaluate perturbed objective
    % [pertobj, ~, ~, ~] = solver(NN);, use perturbed ojective and nominal
    % to determine .. write a small function here.
    % dont need sens=NN.getsens(); comemnt out for now when using FD.
    % call this loop after each time you call Solver(NN);
    
    
    fprintf("FIML Iteration 000000   Objective %+.10e", obj);
    fprintf('\n');
    objectives = zeros(nFIMLIters, 1);
    
    
    for iter=1:nFIMLIters
        
        NN.vars = NN.vars - stepSize * sens / max(abs(sens));
        [objectives(iter), dJdbeta, ~, ~] = solver(NN); % here again after for FD.
        sens = NN.getSens(features, dJdbeta);
        
        fprintf("FIML Iteration %06d   Objective %+.10e", iter, objectives(iter));
        fprintf('\n');
        
    end

end