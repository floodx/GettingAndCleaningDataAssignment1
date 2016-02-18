= Getting and Cleaning Data Assignment #1 =

== Overview == 

This assignment extracted data from a number of different files and combined then into single, tidy dataset. This README describes how this was accomplished.

== Methodology ==

* Relevant data was read in using read.table
* Data from ./train and ./test were combined into a single data-frame
* Combined ./train and ./test data was subsetted to only included "mean" and "std" measurements
* Column names were tidied up
* Integer values for "activity" were replaced with their associated string values
* All data were merged into a tidy dataset
* Tidy dataset was written to a file
* Averages from tidy dataset were taken to create a second dataset
* Second dataset was written to a file