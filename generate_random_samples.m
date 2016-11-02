function r_x = generate_random_samples(x_range)
r = x_range*rand((x_range/2),1);
% r = x_range*rand(x_range,1);
r = uint32(r);
r = sort(r);
r = unique(r);
r = r(r>(10));
r_x = double(r);
end