require(glmnet)

noise = function(xTrain, yTrain, xTest) {
    newx = apply(xTrain, 2, function(x) {
        runif(500, min(x) - diff(range(x))/2)}) 
    mult = cv.glmnet(rbind(xTrain, newx), c(yTrain, rep(3, 500)),
        family = 'multinomial')
    pred = predict(mult, xTest, type = 'class')
    pred[pred == 3] = NA
    return(pred)
}

distance = function(xTrain, yTrain, xTest) {
    centroids = aggregate(xTrain, by = list(yTrain), mean)[, 2:3]
    centroid1 = unlist(centroids[1, ])
    centroid2 = unlist(centroids[2, ])
    max1 = max(rowSums(t(t(xTrain[yTrain == 1, ]) - centroid1)^2))
    max2 = max(rowSums(t(t(xTrain[yTrain == 2, ]) - centroid2)^2))
    max = max(max1, max2)
    dist1 = rowSums(t(t(xTest) - centroid1)^2)
    dist2 = rowSums(t(t(xTest) - centroid2)^2)
    dist = apply(cbind(dist1, dist2), 1, min)
    fit = cv.glmnet(xTrain, as.factor(yTrain), family = 'binomial')
    pred = predict(fit, xTest, s = 'lambda.min', type = 'class')
    pred[dist > max] = NA
    return(pred)
}

conformal = function(xTrain, yTrain, xTest, alpha = 0.01, beta = 0.5) {

    py = table(yTrain)/length(yTrain)

    lpx1 = rowSums(log(dnorm(scale(xTrain[yTrain == 1, ])))) + log(py[1])
    lpx2 = rowSums(log(dnorm(scale(xTrain[yTrain == 2, ])))) + log(py[2])
    Rtrain = array(NA, nrow(xTrain))
    Rtrain[yTrain == 1] = exp(-lpx1)
    Rtrain[yTrain == 2] = exp(-lpx2)
    Rcdf = ecdf(Rtrain)

    lpx1test = rowSums(log(dnorm(scale(xTest,
        center = colMeans(xTrain[yTrain == 1, ]),
        scale = apply(xTrain[yTrain == 1, ], 2, sd))))) + log(py[1])
    lpx2test = rowSums(log(dnorm(scale(xTest,
        center = colMeans(xTrain[yTrain == 2, ]),
        scale = apply(xTrain[yTrain == 2, ], 2, sd))))) + log(py[2])
    Rtest = exp(-cbind(lpx1test, lpx2test))

    rxy = 1 - apply(Rtest, 2, Rcdf)
    pred = apply(rxy, 1, which.max)
    rxyMax = apply(rxy, 1, max)
    rxyMin = apply(rxy, 1, min)
    pred[rxyMax < alpha] = NA
    pred[rxyMin >= beta] = NA
    pred
}

conformalNew = function(xTrain, yTrain, xTest, alpha = 0.01, beta = 0.4) {
    py = table(yTrain)/length(yTrain)
    px1 = dnorm(xTrain[, 1], mean = mean(xTrain[yTrain == 1, 1]),
        sd = sd(xTrain[yTrain == 1, 1]))*dnorm(xTrain[, 2],
        mean = mean(xTrain[yTrain == 1, 2]), sd = sd(xTrain[yTrain == 1, 2]))
    px2 = dnorm(xTrain[, 1], mean = mean(xTrain[yTrain == 2, 1]),
        sd = sd(xTrain[yTrain == 2, 1]))*dnorm(xTrain[, 2],
        mean = mean(xTrain[yTrain == 2, 2]), sd = sd(xTrain[yTrain == 2, 2]))
    pxy = t(rbind(px1, px2) * as.vector(py))
    Rtrain = 1/rowSums(model.matrix(~ as.factor(yTrain) - 1)*pxy)
    Rcdf = ecdf(Rtrain)

    px1test = dnorm(xTest[, 1], mean = mean(xTrain[yTrain == 1, 1]),
        sd = sd(xTrain[yTrain == 1, 1]))*dnorm(xTest[, 2],
        mean = mean(xTrain[yTrain == 1, 2]), sd = sd(xTrain[yTrain == 1, 2]))
    px2test = dnorm(xTest[, 1], mean = mean(xTrain[yTrain == 2, 1]),
        sd = sd(xTrain[yTrain == 2, 1]))*dnorm(xTest[, 2],
        mean = mean(xTrain[yTrain == 2, 2]), sd = sd(xTrain[yTrain == 2, 2]))
    pxyTest = t(rbind(px1test, px2test) * as.vector(py))
    Rtest = 1/pxyTest
    rxy = 1 - apply(Rtest, 2, Rcdf)

    pred = apply(rxy, 1, which.max)
    rxyMax = apply(rxy, 1, max)
    pred[rxyMax < alpha] = NA
    pred[apply(pxyTest/rowSums(pxyTest), 1, min) > beta] = NA
    pred
}

