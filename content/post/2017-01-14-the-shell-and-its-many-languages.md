---
title: "The Shell and its Many Languages"
author: "Bryan Whiting"
date: 2017-01-14
categories: ['tutorials']
tags: ['coding', 'r', 'stata', 'python', 'bash']
---

If you don't know how to use the shell/terminal/command line, you should. Why? Here's a sampling of I've done in the last month:

* I used R to generate 30,000 plots using *ggplot()*. I used the shell and [ffmpeg](https://ffmpeg.org/) to animate those plots as a movie.
* I've used the shell from VBA to send an Excel column of data into Stata, execute a summary statistic command, and then import the results back into Excel. I did this because Excel can't quickly get the percentiles of a dataset, but Stata can. 
* I've used the shell in Stata to execute a Python script to concatenate 10,000 text files, something that is harder in Stata. 
* You can use the shell command in Matlab, Stata, VBA, R, etc. to send an email from a Python script. Although the other languages are mostly capable of sending emails, sometimes it's easier to figure it out in just one language. 

Last week, I had scripts open from R, Matlab, Python, Stata, VBA and EViews, because as great as your default language is, sometimes other languages have irreplaceable functionality.

You don't need to know too much about a program in order to be able to use its comparative advantage. EViews is good at time series, for example, and it has statistical tests that are harder in R, Stata, or Matlab to perform. And so, I learned just enough EViews to read in the data, do the test, and save out the results.

# Here's how you get your programs to talk using the shell:

* Pick a language (let's choose R)
* Pick a second language that can do something that language A can't (let's choose Stata)
* In R, learn how to write lines of text to a text file
* In R, write Stata code to a ".do" file
* Once your Stata script is created, use the shell command in R to execute the Stata script (most statistical programming languages have a shell command)
* If necessary, you can then read the Stata output into R

# A 'Hello World' example:

For example, let's say I want to make Stata print "hello world". I can use R to write a script and then execute it using the shell.

```{r}
# Create the Stata file
fileID <- file("stata_file.do")
writeLines('display "hello world"', fileID)
close(fileID)
```

In R, run the `system()` command to call the shell. Use the `"Stata.exe" do` command to execute the `.do` file.
```{r}
# Execute the Stata file
system("C:\Program Files\...\Stata.exe do stata_file.do")
```

Taking it one step further, have Stata save the results to an output file.
```{r}
# Create the Stata file
fileID <- file("stata_file.do")
writeLines('log using file.log', fileID)
writeLines('display "hello world"', fileID)
writeLines('log close', fileID)
close(fileID)
# Execute the stata script
system("C:\Program Files\...\Stata.exe do stata_file.do")
```

Now, you've written an R script that writes a Stata script and executes it. As an output, you'll have a ".log" file. 

# Takeaways

If you have most of your analysis done in one language, but another has some comparative advantages, perhaps it's time to use the shell. This is like using the ```Rcpp``` package, but for any language you need.




