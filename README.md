# bootstrap_mean.R
function to compute mean values and confidence intervals based on bootstrap procedure (adapted from [Pillar, 1998](http://ecoqua.ecologia.ufrgs.br/arquivos/Reprints&Manuscripts/Pillar_1998_AbtractaBot.pdf))

#Arguments
inputs:

x= a matrix or vector object. If a matrix the function will compute the mean richness or mean abundance of all sampling units (rows). If a vector, each value must represent a sample unit.

sub.samples= Numeric vector. Each element represent the sequencial size of sub samples taken at each step of bootstrap procedure.

iterations= Numeric. Number of iterations taken at each sample size.

all_boot= Logical. if TRUE all the values computed at each step of bootstrap procedure will be show in the result. Default is FALSE.


outputs:
If all_boot argument is FALSE the output will be a list of length four containing the following elements:
Average_mean= a vector with means of the parameter calculated based on the all iterations in a given sample size.
Confidence_intervals= a matrix object with lower and upper limits of means at each sample size (based on the number of iterations).
Average_standard_deviation= a vector with means of the standard deviations of the means calculated at each iteration at each sample size.
differences_up_lower_limits= difference between upper and lower limits of confidence intervals.
If all_boot argument is TRUE the output will also contain:
Matrix_bootstrap_means= a matrix object with all values of means at each sample size at each iteration of bootstrap procedure.
Matrix_bootstrap_standard_deviation= a matrix object with all values of standard deviation computed from means at each sample size at each iteration of bootstrap procedure.


