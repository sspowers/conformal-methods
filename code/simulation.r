# File: simulation.r
# sspowers@stanford.edu
#
# Code to be run on individual mapper nodes

# remember to import packages inside the mapper
source('code/rejectionMethods.r')
source('code/util.r')

# inner loop of simulation
run.simu.inner = function(parameters) {
	
	attach(parameters)

	data = simData(m, n, p, piTrain, piTest, sigmaX, sigmaY)

#	lasso = cv.glmnet(data$xTrain, as.factor(data$yTrain), family = 'binomial')
#	lassoPred = predict(lasso, data$xTest, s = 'lambda.min', type = 'class')

#	naive = naiveBayes(data$xTrain, as.factor(data$yTrain))
#	naivePred = predict(naive, data$xTest)

#	custom = cv.customizeGlmnet(data$xTrain, data$yTrain, data$xTest,
#		c(1, 2, 3, 5, 10), method = 'glmnet', family = 'binomial')
#	customPred = custom$prediction

#	noisePred = noise(data$xTrain, data$yTrain, data$xTest)

#	distancePred = distance(data$xTrain, data$yTrain, data$xTest)

#    conformalPred = conformal(data$xTrain, data$yTrain, data$xTest)

#	c(evaluation(lassoPred, data$yTest, data$y),
#		evaluation(naivePred, data$yTest, data$y),
#		evaluation(customPred, data$yTest, data$y),
#		evaluation(noisePred, data$yTest, data$y),
#		evaluation(distancePred, data$yTest, data$y),
#        evaluation(conformalPred, data$yTest, data$y))

    pred1 = conformal(data$xTrain, data$yTrain, data$xTest,
        alpha = alpha, beta = alpha)
    pred2 = conformalNew(data$xTrain, data$yTrain, data$xTest,
        alpha = alpha, beta = (1-alpha)^2/2)
    pred3 = conformalNew(data$xTrain, data$yTrain, data$xTest,
        alpha = alpha, beta = (1-alpha)^3/2)
    pred4 = conformalNew(data$xTrain, data$yTrain, data$xTest,
        alpha = alpha, beta = 0.5)
    pred5 = conformalNew(data$xTrain, data$yTrain, data$xTest,
        alpha = alpha, beta = 0.4)

    c(evaluation(pred1, data$yTest, data$y),
        evaluation(pred2, data$yTest, data$y),
        evaluation(pred3, data$yTest, data$y),
        evaluation(pred4, data$yTest, data$y),
        evaluation(pred5, data$yTest, data$y))
}

# wrapper
run.simu = function(parameters, nrep = 100) {
	
	results = replicate(nrep, run.simu.inner(parameters))
	
	rowMeans(results)
}
