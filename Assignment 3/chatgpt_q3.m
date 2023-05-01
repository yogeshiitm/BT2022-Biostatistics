% given data
data = [...]; % enter your data here

% alpha value
alpha = 0.0116117;

% number of treatments and replications
num_treatments = 15;
num_replications = 10;

% compute the grand mean
grand_mean = mean(data(:));

% compute the treatment sum of squares (SST), replication sum of squares (SSR), and total sum of squares (SSTO)
ssr = sum(sum((mean(data,2)-grand_mean).^2))/num_treatments;
sst = sum(sum((data-mean(data(:))).^2)) - ssr;
ssto = sst + ssr;

% calculate degrees of freedom
df_treatment = num_treatments - 1;
df_replication = num_replications - 1;
df_total = num_treatments*num_replications - 1;
df_error = df_total - df_treatment - df_replication;

% calculate the final error sum of squares and error degrees of freedom
ss_error = ssto - sst - ssr;
df_error_final = df_total - df_treatment;


% calculate the mean square error and final error mean square
ms_error = ss_error / df_error;
ms_error_final = ss_error / df_error_final;

% calculate mean square (MS) for treatment and replication
ms_treatment = sst / df_treatment;
ms_replication = ssr / df_replication;

% calculate the F-statistic and p-value for the replication variance component
f_replication = ms_replication / ms_error;
p_replication = 1 - fcdf(f_replication, df_replication, df_error);

% perform the F-test on the treatment variance component and find its p-value and F-test status
f_treatment = ms_treatment / ms_error_final;
p_treatment = 1 - fcdf(f_treatment, df_treatment, df_error_final);
f_test_status = double(p_treatment < alpha);

% sort the treatment level sample means in descending order
treatment_means = mean(data,2);
[treatment_means_sorted, index] = sort(treatment_means, 'descend');

% perform post ANOVA t-tests on the given pairs of sorted list and find their p-values
t_test_p_value_1 = 2*(1-tcdf(abs(treatment_means_sorted(1)-treatment_means_sorted(4))/(sqrt(ms_error_final/num_replications)),df_error_final));
t_test_p_value_2 = 2*(1-tcdf(abs(treatment_means_sorted(9)-treatment_means_sorted(13))/(sqrt(ms_error_final/num_replications)),df_error_final));
