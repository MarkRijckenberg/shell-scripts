# .R script showing capabilities of sparklyr R package
# Prerequisites before running this R script: 
# Ubuntu 16.04 LTS 64-bit, r-base (version 3.3.3 or newer), RStudio 64-bit version
#install.packages("sparklyr")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("tidyr")
library(sparklyr)
library(dplyr)
library(ggplot2)
library(tidyr)
set.seed(100)
# sparklyr cheat sheet: https://github.com/rstudio/cheatsheets/raw/master/source/pdfs/sparklyr.pdf
# dplyr+tidyr: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
# sparklyr currently (2017-04-22) only supports Spark version: 2.0.1 or 2.0.2 (not 2.1.0!!)
# Install Spark locally:
# spark_install("2.0.2")
config <- spark_config()
# number of CPU cores to use:
config$spark.executor.cores <- 6
config$spark.executor.memory <- "4G"
# Connect to local version:
sc <- spark_connect (master = "local",
                     config = config, version = "2.0.2")
# Copy data to Spark memory:
import_iris <- copy_to(sc, iris, "spark_iris", overwrite = TRUE) 
# partition data:
partition_iris <- sdf_partition(import_iris,training=0.5, testing=0.5) 
# Create a hive metadata for each partition:
sdf_register(partition_iris,c("spark_iris_training","spark_iris_test")) 
# Create reference to training data in Spark table
tidy_iris <- tbl(sc,"spark_iris_training") %>% select(Species, Petal_Length, Petal_Width) 
# Spark ML Decision Tree Model
model_iris <- tidy_iris %>% ml_decision_tree(response="Species", features=c("Petal_Length","Petal_Width")) 
# Create reference to test data in Spark table
test_iris <- tbl(sc,"spark_iris_test") 
# Bring predictions data back into R memory for plotting:
pred_iris <- sdf_predict(model_iris, test_iris) %>% collect
pred_iris %>%
inner_join(data.frame(prediction=0:2,
lab=model_iris$model.parameters$labels)) %>%
ggplot(aes(Petal_Length, Petal_Width, col=lab)) +
geom_point() 
spark_disconnect(sc)
