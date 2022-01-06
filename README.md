# Some Useful Shell Scripts
## Back Up and Source Difference
### Back Up
This script will take an individual file or directory, and back it up into a tar file. Specifically, this script will take two inputs:

1. the directory where the tar file should be saved;

2. an individual file or directory to backup.

Furthermore, the name of the tar file created will need to contain the name of the directory or file (without the extension) and the date the backup was created in YYYYMMDD format. Finally, the script will need to return with error code 0 upon success and the appropriate error code otherwise (see below). For example, let’s imagine that the following is executed on September 28, 2020:

![image](https://user-images.githubusercontent.com/68981504/148325966-84ec577f-af5c-4872-835d-2e60cbcf67e6.png)

where backups and asgn1 are directories. This would produce a file called asgn1.20200928.tar in ∼/backups containing directory asgn1 and all files therein.

### Source Difference
This script will take two directories as input parameters, iterate over the lists of files, and report files which are either present in one directory but missing in the other, or present in both directories but differ in content

## Weblogs
### Webmetrics
Created a script, webmetrics.sh, which will parse webserver logs and produce three metrics:

1. Number of requests coming from the browsers Safari, Firefox, and Chrome. 

2. Number of distinct users (distinct IP addresses) per day.

3. Top 20 popular requests by product ID.


## Scientific Calculator
Built-in data types of programming languages (including C) have limitations in terms of size and range of data (example integers) that they can work with. This is often an impediment for many calculations (such as scientific computations) which can involve numbers beyond the range that is supported by built-in data types.

Understanding the ASCII table, and the fact that characters are internally represented by their ASCII values which makes basic arithmetic operators over them possible, can help significantly here.

This calculator accepts three arguments as input, x, op, y, where x and y are integers and op is an arithmetic operator.

## C program File IO
Online platforms can track users easily and study and analyze user behaviour. Such data analytics are also relevant with remote delivery of exams. In this program, I analyzed an user event file (data.csv) for such an exam generated from mycourses (anonymised) to look for students who could have possibly collaborated.

## C program Dynamic Memory
Word clouds are often used to visualize the context of an article or someone’s academic research. This is because they are a good visual representation of the main research categories on which one or more articles focus. This is accomplished by constructing an image where words are organized in the shape of a cloud with words which occur at a higher frequency getting more emphasis (i.e., larger fonts). The first task in building a word cloud is to scan the relevant articles and compute the frequency of different words in it.
