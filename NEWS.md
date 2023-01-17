## conjurer 1.7.0 (2023-01-15)
* Updated internal functions related to buildModelData to ensure that argument modelObj is used to source the intercept as well as the range of the independent variables from the model instead of generating randomly.
* Added a new function buildId
* Updated vignettes to include the various types of data distributions along with the industry example.

## conjurer 1.6.0 (2023-01-08)
* Updated buildModelData to include a new argument modelObj that sources the model object.

## conjurer 1.5.0 (2022-04-25)
* Added new functions namely buildModelData and extractDf to access uncovr API.
* Made a change to an internal function namely nextAlphaProb in response to note from R devel build server.
* The above two changes resulted in dependencies on other packages namely jsonlite, httr and methods.

## conjurer 1.4.0 (2021-10-31)
* Added new function buildPattern

## conjurer 1.3.0 (2021-10-17)
* Added new function buildHierarchy

## conjurer 1.2.0 (2020-09-06)
* Added new function buildNum

## conjurer 1.1.1 (2020-03-21)
### Bug fixes
* Bug: Generating names based on custom training data doesn’t work #22

## conjurer 1.1.0 (2020-03-13)

* Added new function buildNames.
