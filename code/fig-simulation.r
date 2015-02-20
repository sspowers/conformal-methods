# zeroth simulation

range = 0:8
resultsTotal = array(NA, dim = c(16, 20, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-0.pdf')
par(mfrow = c(2, 2))
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 3], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'Original classes')
    legend('topright',c('lasso', 'nb', 'ct', 'noise', 'dist'),
        lty = 1:5, col = 1:5)
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 2], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'Original classes')
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 1], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'New class')
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 0], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'New class')
dev.off()


# first simulation

range = 10:24
resultsTotal = array(NA, dim = c(16, 24, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i-9] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-1.pdf')
par(mfrow = c(2, 2))
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 3], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'Original classes')
    legend('topright',c('lasso', 'nb', 'ct', 'noise', 'dist', 'cnfrml'),
        lty = c(1:5, 1), col = 1:6)
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 2], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'Original classes')
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 1], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'New class')
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 0], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'New class')
dev.off()




# second simulation

range = 30:39
resultsTotal = array(NA, dim = c(16, 20, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-2.pdf')
par(mfrow = c(2, 2))
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 3], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'Original classes')
    legend('topleft', paste('a =', 1:5/10),
        lty = c(1:5), col = 1:5)
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 2], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'Original classes')
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 1], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'New class')
matplot(resultsMean[, 1:(ncol(results)/4)*4 - 0], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'New class')
dev.off()


# third simulation
numMethods = 7
range = 40:49
resultsTotal = array(NA, dim = c(16, 4*numMethods, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-3.pdf')
par(mfrow = c(2, 2))
matplot(resultsMean[, 1:numMethods*4 - 3], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'Original classes', lty = 1:numMethods, col = 1:numMethods)

legend('topright',
    paste('a =', c(1:5/10, .01, .01), ', b =', c(1:5/10, .5, .6)),
    lty = 1:numMethods, col = 1:numMethods)

matplot(resultsMean[, 1:numMethods*4 - 2], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'Original classes', lty = 1:numMethods, col = 1:numMethods)
matplot(resultsMean[, 1:numMethods*4 - 1], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'New class', lty = 1:numMethods, col = 1:numMethods)
matplot(resultsMean[, 1:numMethods*4 - 0], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'New class', lty = 1:numMethods, col = 1:numMethods)
dev.off()


# fourth simulation
numMethods = 7
range = 50:59
resultsTotal = array(NA, dim = c(16, 4*numMethods, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-4.pdf')
par(mfrow = c(2, 2))
matplot(resultsMean[, 1:numMethods*4 - 3], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'Original classes', lty = 1:numMethods, col = 1:numMethods)

legend('topright',
    paste('a =', c(.2, .1, .05, .01, .005, .01, .01),
    ' b =', c(.2, .1, .05, .01, .005, .5, .4)),
    lty = 1:numMethods, col = 1:numMethods)

matplot(resultsMean[, 1:numMethods*4 - 2], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'Original classes', lty = 1:numMethods, col = 1:numMethods)
matplot(resultsMean[, 1:numMethods*4 - 1], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Misclassification rate',
    main = 'New class', lty = 1:numMethods, col = 1:numMethods)
matplot(resultsMean[, 1:numMethods*4 - 0], type = 'l',
    xlab = expression(sigma[C]), ylab = 'Rejection rate',
    main = 'New class', lty = 1:numMethods, col = 1:numMethods)
dev.off()



# fifth simulation
numMethods = 4
range = 60:69
resultsTotal = array(NA, dim = c(11, 4*numMethods, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-5.pdf')

plot(resultsMean[, 2], resultsMean[, 4], type = 'l', lty = 1, col = 1,
 xlim = c(0, 1), ylim = c(0, 1))
lines(resultsMean[, 6], resultsMean[, 8], type = 'l', lty = 2, col = 2)
lines(resultsMean[, 10], resultsMean[, 12], type = 'l', lty = 3, col = 3)
lines(resultsMean[, 14], resultsMean[, 16], type = 'l', lty = 4, col = 4)

dev.off()

# sixth simulation
numMethods = 4
range = 70:79
resultsTotal = array(NA, dim = c(20, 4*numMethods, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-6.pdf')

plot(resultsMean[, 2], resultsMean[, 4], type = 'l', lty = 1, col = 1,
 xlim = c(0, 1), ylim = c(0, 1))
lines(resultsMean[, 6], resultsMean[, 8], type = 'l', lty = 2, col = 2)
lines(resultsMean[, 10], resultsMean[, 12], type = 'l', lty = 3, col = 3)
lines(resultsMean[, 14], resultsMean[, 16], type = 'l', lty = 4, col = 4)

dev.off()


# seventh simulation
numMethods = 4
range = 80:89
resultsTotal = array(NA, dim = c(21, 4*numMethods, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-7.pdf')

plot(resultsMean[, 2], resultsMean[, 4], type = 'l', lty = 1, col = 1,
 xlim = c(0, 1), ylim = c(0, 1))
lines(resultsMean[, 6], resultsMean[, 8], type = 'l', lty = 2, col = 2)
lines(resultsMean[, 10], resultsMean[, 12], type = 'l', lty = 3, col = 3)
lines(resultsMean[, 14], resultsMean[, 16], type = 'l', lty = 4, col = 4)

dev.off()


# eighth simulation
numMethods = 5
range = 90:99
resultsTotal = array(NA, dim = c(21, 4*numMethods, length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-8.pdf')

plot(resultsMean[, 2], resultsMean[, 4], type = 'l', lty = 1, col = 1,
 xlim = c(0, 1), ylim = c(0, 1))
lines(resultsMean[, 6], resultsMean[, 8], type = 'l', lty = 2, col = 2)
lines(resultsMean[, 10], resultsMean[, 12], type = 'l', lty = 3, col = 3)
lines(resultsMean[, 14], resultsMean[, 16], type = 'l', lty = 4, col = 4)
lines(resultsMean[, 18], resultsMean[, 20], type = 'l', lty = 5, col = 5)

dev.off()



# ninth simulation
range = 100:109
load(paste('data/solomon/simulation', range[1], '.RData', sep = ''))
resultsTotal = array(NA, dim = c(nrow(results), ncol(results), length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-9.pdf', width = 14)
par(mfrow = c(1, 2))
matplot(log(2^(1:12)), resultsMean[, 1:5*4-3], type = 'l', xlab = 'Dimension',
    ylab = 'Rejection rate', main = 'Rejection rate on old classes', axes = F)
axis(1, log(2^(1:12)), 2^(1:12))
axis(2)
legend('topleft', legend =
    c('a=.05', 'a=.05,b=.45', 'a=.05,b=.43', 'a=.05,b=.5', 'a=.05,b=.4'),
    col = 1:5, lty = 1:5)
matplot(log(2^(1:12)), resultsMean[, 1:5*4-2], type = 'l', xlab = 'Dimension',
    ylab = 'Rejection rate', main = 'Rejection rate on new class', axes = F)
axis(1, log(2^(1:12)), 2^(1:12))
axis(2)
dev.off()

pdf('figs/simulation-9-coverage.pdf')
matplot(log(2^(1:12)), resultsMean[, 1:5*4-1], type = 'l', xlab = 'Dimension',
    ylab = 'Coverage rate', main = 'Coverage rate on original classes',
    axes = FALSE)
legend('bottomleft', legend =
    c('a=.05', 'a=.05,b=.45', 'a=.05,b=.43', 'a=.05,b=.5', 'a=.05,b=.4'),
    col = 1:5, lty = 1:5)
axis(1, log(2^(1:12)), 2^(1:12))
axis(2, c(.8, .95), c(.8, .95))
dev.off()


# tenth simulation
range = 110:119
load(paste('data/solomon/simulation', range[1], '.RData', sep = ''))
resultsTotal = array(NA, dim = c(nrow(results), ncol(results), length(range)))
for (i in range) {
    load(paste('data/solomon/simulation', i , '.RData', sep = ''))
    resultsTotal[, , i + 1 - min(range)] = as.matrix(results)
}
resultsMean = apply(resultsTotal, 1:2, mean)

pdf('figs/simulation-10.pdf', width = 14)
plot(resultsMean[, 1], resultsMean[, 2], type = 'l',
    xlim = c(0, 1), xlab = 'Rejection rate on original classes',
    ylim = c(0, 1), ylab = 'Rejection rate on new class')
legend('bottomright', legend = 1:5, col = 1:5, lty = 1:5)
for (i in 1:4) {
    lines(resultsMean[, 4*i+1], resultsMean[, 4*i+2], col = i, lty = i)
}
dev.off()

pdf('figs/simulation-10-coverage.pdf')
matplot(0:20/20, resultsMean[, 1:5*4-1], type = 'l', xlab = 'alpha',
    ylab = 'Coverage rate', main = 'Original classes')
legend('topleft', legend = 1:5, col = 1:5, lty = 1:5)
dev.off()


