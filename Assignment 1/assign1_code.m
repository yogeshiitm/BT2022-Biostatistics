alpha = 0.0180062

input_data = [
10.4258
2.61849
7.97376
13.5781
8.47175
4.30883
0.879769
4.20907
7.49608
16.3811
13.1448
11.9402
10.8532
3.20482
0.167763
2.01856
0.937986
0.140588
6.81876
4.19129
2.83444
0.343058
0.154489
1.06442
5.53522
8.09635
13.2817
2.45507
8.88373
6.39198
7.51622
0.486817
1.32259
16.1377
6.01965
9.77674
4.91633
0.371298
7.0286
7.02072
1.00949
7.3944
1.20993
3.0225
6.45975
4.48588
0.890043
23.5764
6.71841
0.0267806
5.89923
3.19728
0.847323
2.40868
9.73247
3.9982
5.27901
3.69988
4.84246
2.75601
1.206
6.32876
0.0855183
14.82
2.11289
5.97183
2.27173
6.05781
0.373814
4.58171
6.28353
2.72885
8.90695
2.38375
7.7351
4.55769
8.1131
0.935129
1.57427
3.64595
3.12529
0.754319
2.42106
3.9177
0.0960029
4.77497
5.03654
3.33613
1.03608
1.19016
6.11643
3.7686
1.53036
2.30537
0.984911
8.84518
0.130873
3.98009
11.7861
2.96555
3.13782
0.709317
3.10788
3.9117
2.65313
1.14116
1.43914
10.6414
2.70005
1.22303
4.90536
2.15079
0.669815
4.70613
1.33671
2.3041
7.86225
0.0331941
1.96936
2.06297
5.09693
1.00852
5.70275
0.637929
6.18662
4.29719
8.37016
2.00374
8.34422
3.01368
2.592
1.81732
1.12634
10.6227
1.68771
3.67046
3.80386
3.59685
0.336465
0.357448
3.38836
4.24711
9.94511
6.04456
3.91067
7.7535
19.0792
0.935526
2.52242
2.65166
];

random_z = [
84, 67, 20, 82, 65, 14, 28, 85, 12, 61
65, 89, 60, 125, 94, 66, 98, 40, 103, 132
142, 116, 68, 22, 79, 90, 105, 66, 84, 55
16, 143, 36, 49, 15, 94, 66, 107, 105, 133
19, 123, 56, 61, 9, 125, 87, 135, 2, 73
38, 130, 43, 24, 14, 31, 90, 9, 86, 33
2, 77, 105, 52, 68, 92, 84, 91, 29, 107
111, 1, 10, 64, 99, 72, 20, 108, 117, 149
66, 69, 53, 35, 91, 93, 113, 3, 131, 143
86, 145, 124, 31, 72, 1, 106, 136, 115, 83
46, 11, 142, 141, 103, 65, 70, 49, 117, 130
119, 5, 22, 65, 28, 44, 137, 98, 13, 138
136, 24, 53, 16, 92, 127, 23, 93, 139, 108
138, 53, 40, 68, 144, 66, 55, 84, 23, 117
70, 124, 78, 50, 73, 115, 145, 67, 51, 123
80, 9, 67, 81, 69, 88, 48, 101, 25, 27
130, 76, 89, 6, 135, 98, 94, 80, 3, 90
139, 41, 82, 104, 100, 140, 46, 35, 55, 133
143, 57, 74, 79, 107, 4, 52, 97, 34, 105
139, 137, 14, 51, 52, 19, 3, 68, 112, 90
74, 99, 60, 118, 19, 138, 14, 100, 143, 93
103, 57, 6, 20, 80, 4, 124, 32, 63, 54
2, 23, 116, 62, 122, 92, 148, 86, 99, 66
118, 95, 84, 126, 96, 91, 64, 129, 63, 43
96, 80, 72, 131, 122, 33, 8, 89, 74, 116
141, 17, 42, 8, 23, 101, 46, 39, 50, 31
64, 20, 8, 59, 78, 60, 67, 89, 143, 55
112, 27, 136, 101, 118, 72, 148, 122, 117, 143
36, 7, 143, 119, 62, 59, 73, 78, 142, 139
14, 135, 2, 38, 56, 109, 148, 4, 79, 24
108, 74, 16, 105, 64, 22, 21, 47, 40, 70
27, 111, 79, 148, 37, 26, 41, 126, 20, 144
76, 81, 36, 59, 126, 141, 1, 115, 62, 58
136, 40, 120, 101, 99, 75, 88, 133, 139, 8
134, 5, 116, 130, 1, 27, 73, 14, 38, 55
47, 84, 28, 48, 100, 149, 34, 127, 98, 113
116, 127, 42, 134, 26, 104, 108, 89, 107, 90
123, 124, 26, 83, 125, 48, 128, 11, 111, 131
133, 95, 124, 130, 3, 60, 39, 14, 135, 132
107, 91, 84, 106, 114, 35, 113, 55, 53, 132
42, 138, 124, 4, 33, 34, 23, 135, 142, 102
25, 106, 45, 78, 114, 7, 6, 87, 122, 14
36, 83, 100, 75, 125, 47, 20, 27, 123, 29
127, 131, 86, 29, 36, 52, 68, 84, 149, 16
141, 132, 28, 64, 13, 125, 84, 56, 30, 67
61, 46, 67, 62, 131, 58, 120, 65, 99, 89
11, 82, 42, 50, 41, 62, 55, 84, 16, 3
116, 96, 20, 128, 42, 107, 103, 9, 80, 90
104, 8, 29, 86, 65, 18, 91, 40, 21, 10
140, 4, 32, 79, 73, 143, 46, 120, 29, 118
126, 124, 95, 129, 10, 85, 12, 105, 58, 23
133, 74, 34, 90, 149, 20, 31, 72, 115, 77
50, 147, 48, 123, 89, 105, 54, 121, 17, 79
126, 40, 42, 32, 77, 91, 7, 69, 34, 35
100, 45, 73, 99, 55, 52, 74, 148, 139, 92
125, 101, 149, 28, 88, 2, 14, 21, 9, 131
3, 18, 72, 91, 79, 109, 43, 100, 94, 73
23, 12, 38, 2, 7, 49, 129, 61, 13, 121
81, 86, 42, 118, 59, 32, 149, 76, 84, 73
57, 9, 81, 32, 48, 53, 98, 142, 28, 14
14, 79, 49, 24, 59, 114, 124, 77, 34, 116
91, 117, 32, 70, 110, 56, 69, 111, 101, 67
123, 73, 14, 128, 23, 114, 45, 3, 53, 67
5, 101, 105, 138, 37, 54, 63, 127, 82, 4
85, 17, 5, 95, 86, 48, 112, 102, 72, 127
110, 59, 3, 141, 133, 95, 71, 143, 7, 91
35, 42, 142, 54, 96, 10, 80, 5, 84, 52
96, 147, 2, 11, 45, 138, 114, 10, 40, 79
93, 70, 15, 53, 118, 39, 119, 120, 100, 3
60, 65, 96, 132, 87, 73, 15, 42, 81, 59
143, 51, 17, 114, 50, 125, 82, 127, 70, 14
8, 120, 35, 67, 18, 48, 46, 16, 141, 142
34, 51, 33, 25, 128, 28, 11, 32, 13, 131
130, 9, 53, 6, 43, 146, 136, 123, 115, 74
4, 82, 38, 113, 145, 111, 89, 17, 126, 107
45, 44, 89, 59, 118, 20, 11, 141, 31, 55
73, 67, 90, 17, 81, 52, 130, 23, 68, 108
80, 70, 115, 25, 91, 37, 132, 67, 136, 16
22, 41, 64, 57, 114, 9, 94, 45, 145, 108
144, 34, 149, 72, 131, 29, 22, 70, 50, 76
89, 120, 19, 61, 3, 106, 121, 117, 5, 69
96, 106, 20, 61, 125, 104, 65, 50, 78, 136
131, 2, 105, 18, 62, 99, 101, 47, 110, 23
85, 90, 147, 145, 82, 15, 42, 91, 33, 88
6, 77, 43, 94, 42, 15, 145, 70, 125, 96
86, 51, 75, 42, 64, 107, 74, 141, 29, 79
21, 136, 103, 99, 90, 24, 138, 111, 13, 50
54, 1, 127, 37, 84, 65, 13, 96, 64, 63
140, 47, 45, 138, 106, 20, 67, 61, 117, 119
36, 86, 114, 22, 124, 30, 145, 29, 17, 25
88, 52, 75, 23, 38, 76, 114, 145, 18, 109
13, 56, 131, 118, 112, 29, 44, 75, 135, 61
115, 98, 116, 90, 129, 109, 52, 3, 99, 66
85, 127, 136, 46, 94, 74, 119, 70, 89, 12
129, 111, 90, 110, 89, 11, 76, 41, 47, 92
17, 33, 55, 43, 27, 58, 54, 41, 73, 76
145, 141, 97, 127, 42, 6, 4, 21, 101, 24
60, 1, 114, 36, 107, 20, 27, 34, 3, 142
70, 73, 64, 32, 95, 54, 104, 96, 117, 52
57, 81, 149, 50, 73, 87, 9, 95, 1, 127
25, 84, 70, 68, 122, 149, 139, 114, 36, 5
80, 129, 62, 37, 110, 65, 47, 145, 120, 117
127, 113, 56, 121, 95, 145, 102, 60, 23, 37
124, 119, 39, 83, 106, 55, 49, 144, 38, 37
72, 22, 50, 127, 53, 39, 75, 140, 132, 30
108, 131, 49, 5, 99, 33, 17, 26, 69, 30
148, 130, 142, 117, 52, 98, 32, 6, 11, 71
2, 16, 97, 122, 103, 35, 120, 17, 113, 45
144, 53, 51, 93, 2, 123, 131, 61, 133, 124
20, 123, 15, 96, 141, 52, 36, 149, 25, 140
58, 21, 72, 47, 73, 125, 70, 129, 56, 19
39, 125, 113, 75, 38, 143, 116, 2, 32, 31
111, 35, 78, 11, 96, 32, 83, 18, 107, 15
106, 48, 78, 71, 5, 18, 22, 132, 109, 97
110, 79, 99, 94, 14, 1, 73, 36, 75, 48
45, 126, 121, 18, 87, 139, 91, 108, 149, 16
131, 3, 5, 54, 110, 120, 109, 144, 147, 132
66, 129, 143, 109, 45, 117, 68, 85, 106, 61
102, 148, 96, 8, 71, 24, 65, 146, 125, 12
48, 41, 8, 136, 54, 37, 144, 65, 118, 62
]