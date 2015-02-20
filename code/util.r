require('e1071')

evaluation = function(pred, yTest, y) {
    error12 = sum((pred != yTest)[y[, 3] == 0], na.rm = TRUE)/sum(y[, 3] == 0)
    reject12 = mean(is.na(pred)[y[, 3] == 0])
    error3 = sum((pred != yTest)[y[, 3] == 1], na.rm = TRUE)/sum(y[, 3] == 1)
    reject3 = mean(is.na(pred)[y[, 3] == 1])
    return(c(error12, reject12, error3, reject3))
}

simData = function(m = 100, n = 1000, p = 2,
	piTrain = c(0.5, 0.5, 0.0), piTest = c(0.4, 0.4, 0.2),
	sigmaX = 1, sigmaY = 1) {

    m = 100
    n = 1000
    p = 2
    piTrain = c(0.5, 0.5, 0.0)
    piTest = c(0.4, 0.4, 0.2)

    mu = sigmaY*matrix(rnorm(3*p), ncol = p)
#    sigma = sqrt(exp(matrix(rnorm(3*p), ncol = p)))

    y = t(rmultinom(n, 1, piTrain))
#    xTrain = y %*% mu + (y %*% sigma)*matrix(rnorm(n*p), ncol = p)
    xTrain = y %*% mu + sigmaX*matrix(rnorm(n*p), ncol = p)
    yTrain = apply(y == 1, 1, which)

    y = t(rmultinom(m, 1, piTest))
#    xTest = y %*% mu + (y %*% sigma)*matrix(rnorm(m*p), ncol = p)
    xTest = y %*% mu + sigmaX*matrix(rnorm(m*p), ncol = p)
    yTest = apply(y == 1, 1, which)
    yTest[yTest == 3] = sample(1:2, 1)
    
#    par(mfrow = c(1, 2))
#    plot(xTrain, col = yTrain + 1)
#    plot(xTest, col = yTest + 1)

    return(list(xTrain = xTrain, yTrain = yTrain,
        xTest = xTest, yTest = yTest, y = y))
}

simulation = function() {

    hash = sample(1000:9999, 1)
    set.seed(hash)
    data = simData()

    lasso = cv.glmnet(data$xTrain, as.factor(data$yTrain), family = 'binomial')
    lassoPred = predict(lasso, data$xTest, s = 'lambda.min', type = 'class') 

    naive = naiveBayes(data$xTrain, as.factor(data$yTrain))
    naivePred = predict(naive, data$xTest)

    custom = cv.customizeGlmnet(data$xTrain, data$yTrain, data$xTest,
        c(1, 2, 3, 5, 10), method = 'glmnet', family = 'binomial')
    customPred = custom$prediction

    noisePred = noise(data$xTrain, data$yTrain, data$xTest)

    distancePred = distance(data$xTrain, data$yTrain, data$xTest)

    conformalPred = conformal(data$xTrain, data$yTrain, data$xTest)

    return(list(hash = hash,
        lasso = evaluation(lassoPred, data$yTest, data$y),
        naive = evaluation(naivePred, data$yTest, data$y),
        custom = evaluation(customPred, data$yTest, data$y),
        noise = evaluation(noisePred, data$yTest, data$y),
        distance = evaluation(distancePred, data$yTest, data$y)),
        conformal = evaluation(conformalPred, data$yTest, data$y))
}
