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
