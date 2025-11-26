
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Block2.RamdomForest

[![R-CMD-check](https://github.com/ChenzhiNi315/Block2.RamdomForest/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ChenzhiNi315/Block2.RamdomForest/actions/workflows/R-CMD-check.yaml)

<!-- badges: start -->

<!-- badges: end -->

## Overview

The goal of **Block2.RamdomForest** is to provide functions for running Random Forest simulation experiments for Assignment 1. It facilitates testing classification performance across different task conditions and tree configurations.

## Installation

You can install the development version of Block2.RamdomForest from [GitHub](https://github.com/) with:

```r
# install.packages("devtools")
devtools::install_github("YOUR_GITHUB_USERNAME/Block2.RamdomForest")
```

# Usage
This is a basic example which shows how to run a simulation task:
```r
library(Block2.RamdomForest)

# Run the simulation for Task 1 (Linear: x1 < x2)
task1_results <- run_task1()

# View the first few rows of the results
head(task1_results)
```

For a full walkthrough of the assignment tasks and analysis, please see the included vignette:
```r
vignette("Assignment1", package = "Block2.RamdomForest")
```
