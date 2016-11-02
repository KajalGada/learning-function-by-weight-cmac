%ENPM808F Homework 2

clear all; close all; clc;

x_range = 300;          %Input Range
x = [1:1:x_range];
y = 2*x;                %Function

r_x = generate_random_samples(x_range);
r_y = 2*r_x;

plot(x,y)               %Plot function and random samples (training)
hold on
for plot_train_id = 1:1:size(r_x,1)
    if mod(plot_train_id,3) ~= 0        
        plot(r_x(plot_train_id),r_y(plot_train_id),'r*')
    end
end
hold off

discrete_results = [];
test_error_best = 10000;

for g = 3:1:17 %[3,5,7,9,11,13,15,17]
    tic                     %Start timer
    [best_weight_matrix, best_err_value_training, test_error, ...
        iterations, out_plot] = discrete_function(r_x,r_y,x_range,g);
    t = toc;                %Stop timer
    if test_error < test_error_best
        out_plot_best = out_plot;
        g_best = g;
    end
    discrete_results = [discrete_results; ...
        g t iterations best_err_value_training test_error];
end

discrete_results

hold on                     %Plot test results
for best_plot_id = 1:size(out_plot_best,1)
    plot(out_plot_best(best_plot_id,1),out_plot_best(best_plot_id,2),'bo')
end
text(200,100,'Discrete Function')
text(200,60,'Best Window Size:')
text(200,20,num2str(g_best))
xlabel('Input')
ylabel('Output')
hold off

% PART TWO

continuous_results = [];
test_error_best = 10000;

for g = 3:1:17 %[5,7,9,11,13,15,17]
    tic                     %Start timer
    [best_weight_matrix, best_err_value_training, test_error, ...
        iterations, out_plot] = continuous_function(r_x,r_y,x_range,g);
    t = toc;                %Stop timer
    if test_error < test_error_best
        t_best_c = t;
        out_plot_best = out_plot;
        g_best = g;
    end
    continuous_results = [continuous_results;...
        g t iterations best_err_value_training test_error];
end

continuous_results

figure
plot(x,y)               %Plot function and random samples (training)
hold on
for plot_train_id = 1:1:size(r_x,1)
    if mod(plot_train_id,3) ~= 0        
        plot(r_x(plot_train_id),r_y(plot_train_id),'r*')
    end
end
hold off

hold on                     %Plot test results
for best_plot_id = 1:size(out_plot_best,1)
    plot(out_plot_best(best_plot_id,1),out_plot_best(best_plot_id,2),'go')
end
text(200,100,'Continuous Function')
text(200,60,'Best Window Size:')
text(200,20,num2str(g_best))
xlabel('Input')
ylabel('Output')
hold off


figure
% subplot(1,2,1)
plot(discrete_results(:,1), discrete_results(:,2),'b--o')
hold on
% subplot(1,2,2)
plot(continuous_results(:,1), continuous_results(:,2),'g--o')
xlabel('Generalization Factor')
ylabel('Time')
hold off