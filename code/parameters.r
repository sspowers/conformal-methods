# File: init.r
# sspowers@stanford.edu
#
# Define constants for the simulation study in here

parameters = list()

for (i in 1:20) {
    parameters[[i]] = list(
        alpha = (i-1)/20,
        m = 10000,
        n = 1000,
        p = 2,
        piTrain = c(0.5, 0.5, 0),
        piTest = c(0.4, 0.4, 0.2),
        sigmaX = 1,
        sigmaY = 2.5,
        name = paste('alpha = ', i-1, '/20', sep = '')
    )
}
