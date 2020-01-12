
---
title: 'A Parametric Method for Generating Synthetic Data'
tags:
  - R
  - synthetic data generator
  - dummy data generator
  - fake data generator

authors:
  - name: Sidharth Macherla
    orcid: 0000-0002-4825-2026    

date: 12 January 2020

bibliography: paper.bib
---

# Summary
Data science applications need data to prototype and demonstrate to potential clients. For such purposes, using production data is a possibility. However, it is not always feasible due to legal and/or ethical considerations[@SynDataNeed]. This resulted in a need for generating synthetic data. This need is the key motivator for the package **conjurer**.

Data across multiple industry domains such as Commerce [@10.2307/1884282],  Food industry[@doi:10.1177/1847979018808673] are known to exhibit some form of seasonality, cyclicality and trend. Although there are synthetic data generation packages such as synthpop[@synthpop] in R and sklearn.datasets [@scikit-learn] in Python, they focus on synthetic versions of microdata containing confidential information or for machine learning purposes. There is a need for a more generic synthetic data generation package that helps for multiple purposes such as forecasting, customer segmentation, insight generation etc. This package **conjurer** helps in generating such synthetic data.
# Methodology
The core component of this package is generation of a data distribution.
(1) Let $t$ be a transaction and $d$ be transaction data such that,
$$d = \{t_1,t_2,...,t_n\}$$

(2) Let months of an year be encoded as numerics in the following way.
$$ m = \{ January, February, ..., December\}$$
$$ y = \{x \in R \mid 0< x <12\} $$
$$y \mapsto m$$



 for all transactions, there exists seasonality, cyclicality and trend

# References