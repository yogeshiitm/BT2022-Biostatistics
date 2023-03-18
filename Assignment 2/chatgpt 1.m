% Sure, here is the MATLAB code to perform the two-sample t-test for the given 15 pairs of datasets and to generate the shuffled datasets by swapping the first datapoint of control and the third datapoint of treatment for each pair of datasets and perform the two-sample t-test on them:
% Two-sample t-test for original datasets
alpha = 0.05;
p_values_original = zeros(15, 1);
for i = 1:15
    [h, p] = ttest2(control_data, treatment_data, 'Alpha', alpha, 'Vartype', 'unequal');
    p_values_original(i) = p;
    control_data = treatment_data;
end
lowest_p_value_original = min(p_values_original);

% Two-sample t-test for shuffled datasets
p_values_shuffled = zeros(15, 1);
for i = 1:15
    control_data_shuffled = control_data;
    control_data_shuffled(1) = treatment_data(3);
    treatment_data_shuffled = treatment_data;
    treatment_data_shuffled(3) = control_data(1);
    [h, p] = ttest2(control_data_shuffled, treatment_data_shuffled, 'Alpha', alpha, 'Vartype', 'unequal');
    p_values_shuffled(i) = p;
    control_data = treatment_data;
end
lowest_p_value_shuffled = min(p_values_shuffled);


% To calculate the FDR in the standard t-test at the given alpha, we can use the Benjamini-Hochberg procedure:
% FDR in the standard t-test
sorted_p_values = sort(p_values_original);
n = length(sorted_p_values);
fdr = alpha * (1:n) ./ n;
reject = sorted_p_values < fdr;
fdr_rate = sum(reject) / n * 100;

To calculate the number of significant tests in the Bonferroni method at the given FWER, we can use the following code:

% Number of significant tests in the Bonferroni method
bonferroni_alpha = FWER / 15;
significant_tests = sum(p_values_original < bonferroni_alpha);