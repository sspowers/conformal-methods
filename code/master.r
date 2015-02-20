# File: master.r
# sspowers@stanford.edu
#
# Main entry point to simulation. Manages mappers and then reduces output.

# parameters.r has constants that are useful for master
source("code/parameters.r")

#
# Create and initialize a mini-cluster
#

# Here, I use snow. It may also be worth looking at "foreach" for R.
# Useful reference: http://www.sfu.ca/~sblay/R/snow.html
library(snow);

# Create a 16-node mini-cluster
cl <- makeSOCKcluster(rep("localhost", 16))

# Load the mapper script to the cluster
clusterEvalQ(cl, source("code/simulation.r"))

# Run the simulation
# Note: What is function(x)run.simu(x)??
# It's a hack for avoiding scoping issues. "run.simu" is only defined in mapper scope,
# but not in master scope. This is why we cannot directly reference run.simu here.
results.raw = clusterApply(cl, parameters, function(x)run.simu(x))

stopCluster(cl);

# Turn an ugly list into an easy-to-manipulate matrix
results = Reduce(rbind, results.raw)

# Grab the name entries from the params list
results.names = sapply(parameters, function(parameters)parameters$name)

rownames(results) = results.names
results = data.frame(results)

# Reproducible research involves remembering what you did!
hash = sample(1000:9999, 1)
save.image(paste('results/simulation', hash, '.RData', sep = ''))

#
# Make a tex table
#

#library(xtable)
#xtab = xtable(results, label="tab:rf")

#fileConn<-file("results/output_table.tex")
#writeLines(print(xtab), fileConn)
#close(fileConn)
