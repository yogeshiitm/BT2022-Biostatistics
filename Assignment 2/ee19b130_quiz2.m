% Lowest p-value for the original dataset
% Lowest p-value for the shuffled dataset
% FDR (%) of the standard method at the given alpha
% FDR (%) of the Bonferroni method at the given FWER


% ERROR IN ANSWER
% EE19B130, 1.39931,0.00202699,30.6666,4.06e-05,16

% |x - 0.000024|/x * 100 = 1.39931        => x = 0.0000236688 (ans)  &  0.00002434
% |x - 0.008880|/x * 100 = 0.00202699     => x = 0.008879            &  0.00888018
% |x - 93.333333|/x * 100 = 30.6666       => x = 71.42858 (ans)      &  134.6152 (not possible since answer must be <= 100)
% |x - 71.428571|/x * 100 = 4.06e-05      => x = 71.428542 (ans)     &  71.4286

alpha = 0.0500733;
FWER = 0.399667;
alphastar = FWER/15;

% % % % % % % % % % % % % % % % % % % % % % % % %
% Sample-1
control_data{1} = [4.50035	3.70734	13.1023	3.90432	12.1985];
treatment_data{1} = [33.9949	50.6854	34.8225	46.4013	40.1867];

% Sample-2
control_data{2} = [8.75539	12.7643	13.7751	12.9383	7.71177];
treatment_data{2} = [31.4571	44.6222	27.5239	51.7762	39.8227];

% Sample-3
control_data{3} = [15.115	11.0494	8.36675	3.57559	12.3055];
treatment_data{3} = [43.2444	34.5018	30.0862	46.0936	33.9571];

% Sample-4
control_data{4} = [9.93761	10.6703	7.69344	14.7055	16.0685];
treatment_data{4} = [36.0223	43.9132	26.2473	45.5969	35.236];

% Sample-5
control_data{5} = [12.1978	14.518	11.3845	8.35617	9.72258];
treatment_data{5} = [30.44	38.0764	16.094	45.6036	32.1054];

% Sample-6
control_data{6} = [13.971	10.2732	7.90805	6.25476	9.72575];
treatment_data{6} = [28.8716	51.474	30.4357	48.9844	35.2753];

% Sample-7
control_data{7} = [9.34218	9.16222	8.30871	9.10363	-0.790682];
treatment_data{7} = [32.5502	44.8921	23.347	45.3814	34.7662];

% Sample-8
control_data{8} = [9.66028	12.0909	10.4136	7.94163	1.00936];
treatment_data{8} = [36.8466	43.2816	17.3072	46.0636	29.5882];

% Sample-9
control_data{9} = [9.98733	15.1622	11.8264	8.64447	5.17257];
treatment_data{9} = [38.4742	54.207	25.5579	55.4439	36.5692];

% Sample-10
control_data{10} = [14.6854	10.9954	9.55915	11.6333	7.09235];
treatment_data{10} = [39.4213	40.2481	26.891	52.9748	43.0605];

% Sample-11
control_data{11} = [10.035	9.48788	6.80514	15.8965	6.87184];
treatment_data{11} = [41.4381	40.6197	20.4686	46.2214	27.5397];

% Sample-12
control_data{12} = [7.82341	12.8193	11.5428	12.5342	11.2657];
treatment_data{12} = [35.9369	35.0359	7.70217	51.336	38.325];

% Sample-13
control_data{13} = [11.6294	9.1706	8.7572	12.4265	14.1393];
treatment_data{13} = [41.3325	49.87	27.403	48.8024	35.0175];

% Sample-14
control_data{14} = [11.614	15.9296	8.84184	13.0735	13.7196];
treatment_data{14} = [37.5617	36.3026	26.9027	47.8919	34.7443];

% Sample-15
control_data{15} = [5.51439	5.27678	11.2681	8.04106	6.33196];
treatment_data{15} = [43.9064	33.298	20.5109	44.6188	36.0547];
% % % % % % % % % % % % % % % % % % % % % % % % %


% clc;
p_values_original = zeros(15,1);
%% 
for i = 1:15
    % disp(control_data{i})
    % disp(treatment_data{i})
    [h1, p1] = ttest2(control_data{i}, treatment_data{i}, 'Alpha', alpha, 'Vartype', 'equal');
    [h2, p2] = ttest2(control_data{i}, treatment_data{i}, 'Alpha', alpha, 'Vartype', 'unequal');
    p = ttestclass(control_data{i}, treatment_data{i}, alpha).tp_value;
    % fprintf('p ttest2 equal: %f\n', p1);
    % fprintf('p ttest2 unequal: %f\n', p2);
    % fprintf('p ttestclass: %f\n\n', p);
    p_values_original(i) = p;
    %disp(ttestclass(control_data{i}, treatment_data{i}, alpha))
end
lowest_p_value_original = min(p_values_original);
fprintf('Lowest p-value original: %f\n', lowest_p_value_original);


% Two-sample t-test for shuffled datasets
p_values_shuffled = zeros(15, 1);
control_data_shuffled = cell(15, 5);
treatment_data_shuffled = cell(15, 5);
for i = 1:15
    control_data_shuffled{i} = control_data{i};
    control_data_shuffled{i}(1) = treatment_data{i}(3);
    treatment_data_shuffled{i} = treatment_data{i};
    treatment_data_shuffled{i}(3) = control_data{i}(1);
    % disp(control_data_shuffled{i})
    % disp(treatment_data_shuffled{i})
    [h1, p1] = ttest2(control_data_shuffled{i}, treatment_data_shuffled{i}, 'Alpha', alpha, 'Vartype', 'equal');
    [h2, p2] = ttest2(control_data_shuffled{i}, treatment_data_shuffled{i}, 'Alpha', alpha, 'Vartype', 'unequal');
    p = ttestclass(control_data_shuffled{i}, treatment_data_shuffled{i}, alpha).tp_value;
    % fprintf('p ttest2 equal: %f\n', p1);
    % fprintf('p ttest2 unequal: %f\n', p2);
    % fprintf('p ttestclass: %f\n\n', p);
    p_values_shuffled(i) = p;
end
lowest_p_value_shuffled = min(p_values_shuffled);
fprintf('Lowest p-value shuffled: %f\n', lowest_p_value_shuffled);

%% 


% To calculate the FDR in the standard t-test at the given alpha, we can use the Benjamini-Hochberg procedure:
% Standard FDR using Benjamini-Hochberg procedure
rej1 = sum(p_values_original <= alpha);
rej2 = sum(p_values_shuffled <= alpha);
FDR_est = rej2/rej1*100;
fprintf('FDR using Benjamini-Hochberg method at given Alpha: %f %%\n', FDR_est);


% To calculate the number of significant tests in the Bonferroni method at the given FWER, we can use the following code:
% Bonferroni method at the given FWER
n = length(p_values_original);
alpha_bonf = FWER/n;
rej_bonf1 = sum(p_values_original <= alpha_bonf);
rej_bonf2 = sum(p_values_shuffled <= alpha_bonf);
FDR_est_bonf = rej_bonf2/rej_bonf1 *100;
fprintf('FDR using Bonferroni method at given FWER: %f %%\n', FDR_est_bonf);
%% 



% Perform the t-test on the simulated data and calculate the FDR
num_rejections = 0;
num_rejections_shuffled = 0;
for i = 1:15
    sim_out1 = ttestclass(control_data{i}, treatment_data{i}, alpha);
    sim_out2 = ttestclass(control_data_shuffled{i}, treatment_data_shuffled{i}, alpha);
    if sim_out1.ttest_result == 1  %% i.e. null hypothesis is rejected, and there is enough evidence to support the alternative hypothesis
        num_rejections = num_rejections + 1;
    end
    if sim_out2.ttest_result == 1
        num_rejections_shuffled = num_rejections_shuffled + 1;
    end
end
fdr_percent1 = num_rejections_shuffled / num_rejections * 100;
fprintf('FDR using ttestclass at alpha: %f %%\n', fdr_percent1);


% Perform the t-test on the simulated data and calculate the FDR
alphastar = FWER/15;
num_rejections_bonf = 0;
num_rejections_shuffled_bonf = 0;
for i = 1:15
    sim_out1 = ttestclass(control_data{i}, treatment_data{i}, alphastar);
    sim_out2 = ttestclass(control_data_shuffled{i}, treatment_data_shuffled{i}, alphastar);
    if sim_out1.ttest_result == 1
        num_rejections_bonf = num_rejections_bonf + 1;
    end
    if sim_out2.ttest_result == 1
        num_rejections_shuffled_bonf = num_rejections_shuffled_bonf + 1;
    end
end
fdr_percent2 = num_rejections_shuffled_bonf / num_rejections_bonf * 100;
fprintf('FDR using ttestclass at fwer: %f %%\n', fdr_percent2);