# File: init.r
# sspowers@stanford.edu
#
# Define constants for the simulation study in here

parameters = list()

for (i in 1:16) {
    parameters[[i]] = list(
        alpha = 0.05,
        m = 10000,
        n = 1000,
        p = 2^i,
        piTrain = c(0.5, 0.5, 0),
        piTest = c(0.4, 0.4, 0.2),
        sigmaX = 1,
        sigmaY = 2.5,
        name = paste('p =', 2^i)
    )
}
