## Sentiment Analysis of Twitter Tweets

#### Overview

I'd taken a course on the basics of **R programming**, a statistical computing language, and learned about how it can be used in the field of data analysis. Towards the end, 
I thought of gaining some hands-on experience in how R can be used in real-life scenarios. This led me to create a simple project titled, '**Twitter Sentiment 
Analysis in R**' which performs **simple data mining and natural language processing techniques** on the tweet text. 

Basically, sentiment analysis is about **identifying and analyzing textual content** with respect to the **emotion it projects**; generally categorized into **positive**, **negative** or **neutral**. It is important especially when businesses need to analyze customer reviews and understand customer needs. Looking at it from a programmer's perspective, R can be a good place to start due to the availability of **many packages** that support sentiment analysis.


R supports packages such as

* **tm**
* **SnowballC**
* **wordcloud**
* **ggplot2**

which we will be using in this project. 


We may analyze the text according to the most frequently occuring words, most common emotions observed, 
word association percentages, and also plot graphs for the results so obtained. R also supports **worldcloud**, a package used to graphically represent the frequency 
of words; the size of the word in the graph being directly proportional to it's frequency count. 

A **step-wise explanation** of the code has been provided in the '**Analysis_Script.R**' file, via comments. All graphs and charts have been added to this repository containing
appropriate names for easier understanding. The data set used, has been imported from **Kaggle.com**.


You may also check out the reference I've used below:

**References:** https://www.red-gate.com/simple-talk/databases/sql-server/bi-sql-server/text-mining-and-sentiment-analysis-with-r/
