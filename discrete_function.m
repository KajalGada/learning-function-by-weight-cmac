function [best_weight_matrix, best_err_value_training, test_error, ...
    iterations, test_out_plot] = discrete_function(r_x,r_y,x_range,g)

weight_matrix = zeros((x_range+g-1),1);

iterations = 0;
stopWhile = 1;
best_err_value_training = 10000;

while stopWhile == 1
    
    iterations = iterations + 1;
    
    for i = 1:1:size(r_x,1)

        if mod(i,3) ~= 0

            wt_id_start = r_x(i);
            current_wt = 0;
            
            if mod(g,2) ~= 0    %g is odd
                
                for current_wt_id = (wt_id_start-((g-1)/2)):1:...
                        (wt_id_start+((g-1)/2))
                    
                    current_wt = current_wt + ...
                        weight_matrix(current_wt_id);
                end
                
            else
                
                for current_wt_id = (wt_id_start-(g/2)-1):1:...
                        (wt_id_start+(g/2))
                    
                    current_wt = current_wt + ...
                        weight_matrix(current_wt_id);
                
                end
                
            end

            current_output = current_wt;
            error = r_y(i) - current_output;

            wt_update_value = error/g;
            
            if mod(g,2) ~= 0    %g is odd
                
                for wt_update_id = (wt_id_start-((g-1)/2)):1:...
                        (wt_id_start+((g-1)/2))
                    
                    weight_matrix(wt_update_id) = ...
                        weight_matrix(wt_update_id) + wt_update_value;
                    
                end
            else    %g is even
                
                for wt_update_id = (wt_id_start-(g/2)-1):1:...
                        (wt_id_start+(g/2))
                    
                    weight_matrix(wt_update_id) = ...
                        weight_matrix(wt_update_id) + wt_update_value;
                
                end
                
            end

        end

    end

    % ON THE TRAINING DATA
    out_plot = [];
    training_error = 0;
    
    for i = 1:1:size(r_x,1)
        
        if mod(i,3) ~= 0

            wt_id_start = r_x(i);
            current_wt = 0;

            if mod(g,2) ~= 0    %g is odd

                for current_wt_id = (wt_id_start-((g-1)/2)):1:...
                        (wt_id_start+((g-1)/2))
                    current_wt = current_wt + weight_matrix(current_wt_id);

                end

            else %g is even

                for current_wt_id = (wt_id_start-(g/2)-1):1:...
                        (wt_id_start+(g/2))

                    current_wt = current_wt + ...
                        weight_matrix(current_wt_id);

                end

            end

            current_output = current_wt;
            out_plot = [out_plot; r_x(i) current_output];

            error = abs(r_y(i) - current_output);
            training_error = training_error + error;

        end
        
    end

    if training_error < 0.1
        stopWhile = 0;
        %display('Training Error is:')
        %display(training_error)
    end

    if iterations > 500
        stopWhile = 0;
        display('Iterations exhausted')
    end

    if training_error < best_err_value_training
        best_err_value_training = training_error;
        best_weight_matrix = weight_matrix;
    end
        
end

% Test
test_out_plot = [];
test_error = 0;

for i = 3:3:size(r_x,1)

    wt_id_start = r_x(i);
    current_wt = 0;

    if mod(g,2) ~= 0    %g is odd

        for current_wt_id = (wt_id_start-((g-1)/2)):1:...
                (wt_id_start+((g-1)/2))
            current_wt = current_wt + weight_matrix(current_wt_id);

        end

    else %g is even

        for current_wt_id = (wt_id_start-(g/2)-1):1:...
                (wt_id_start+(g/2))

            current_wt = current_wt + ...
                weight_matrix(current_wt_id);

        end

    end

    current_output = current_wt;
    test_out_plot = [test_out_plot; r_x(i) current_output];

    error = abs(r_y(i) - current_output);
    test_error = test_error + error;

end

%display('Test error is:')
%display(test_error)

end