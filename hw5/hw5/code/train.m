function [model, loss] = train(model,input,label,params,numIters)

% Initialize training parameters
% This code sets default values in case the parameters are not passed in.

% Learning rate
if isfield(params,'learning_rate') lr = params.learning_rate;
else lr = .01; end
% Weight decay
if isfield(params,'weight_decay') wd = params.weight_decay;
else wd = .0005; end
% Batch size
if isfield(params,'batch_size') batch_size = params.batch_size;
else batch_size = 128; end

% There is a good chance you will want to save your network model during/after
% training. It is up to you where you save and how often you choose to back up
% your model. By default the code saves the model in 'model.mat'
% To save the model use: save(save_file,'model');
if isfield(params,'save_file') save_file = params.save_file;
else save_file = 'model.mat'; end

% update_params will be passed to your update_weights function.
% This allows flexibility in case you want to implement extra features like momentum.
update_params = struct('learning_rate',lr,'weight_decay',wd);

updated_model = model;
for i = 1:numIters
	% TODO: Training code  
    selectid = randperm(size(input,4),batch_size);
    new_input = input(:,:,:,selectid);
    new_label = label(selectid,1);
    [output,activations] = inference_(updated_model,new_input);
    [loss, dv_input] = loss_crossentropy_(output, labels, hyper_params, false);
    [grad] = calc_gradient_(updated_model, new_input, activations, dv_output);
    updated_model = update_weights_(updated_model,grad,update_params);    
end
model = updated_model;
