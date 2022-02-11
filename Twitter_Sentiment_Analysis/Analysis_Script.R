# To implement this project, we will need to first install certain packages required to perform the NLP processes 
# on the dataset. Below mentioned are the packages to be installed

install.packages("tm")            # used for text mining
install.packages("Rtools")        # used for building R applications in Windows
install.packages("SnowballC")     # used for stemming (breaking down words into their root forms) of words 
install.packages("wordcloud")     # used to generate a word cloud of images
install.packages("RColorBrewer")  # used to provide a variety of color palettes to the generated plots
install.packages("syuzhet")       # used to perform sentiment analysis on text
install.packages("ggplot2")       # used to create data visualization plots 

# loading the above mentioned libraries will allow us to perform further tasks...

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(syuzhet)
library(ggplot2)

# reading the csv file and storing it into a variable for further use

df <- read.csv("sentiment_data.csv")
View(df)

# We can also dynamically access the csv file for analysis using the readLines() command below.

text <- readLines(file.choose())

# Converting the csv file data into a Corpus format. A Corpus is basically a collection text documents 
# on which certain NLP functions and text mining processes can be performed upon.

TextDoc <- Corpus(VectorSource(text))

# Now to perform the text mining operations, we start by replacing special characters such as '/', '@', etc. with 
# blank spaces. Further, we will also remove numbers, capital letters, punctuation marks, trailing white spaces,
# and finally perform stemming on the entire document.

toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
TextDoc <- tm_map(TextDoc, toSpace, "/")
TextDoc <- tm_map(TextDoc, toSpace, "@")
TextDoc <- tm_map(TextDoc, toSpace, "\\|")
TextDoc <- tm_map(TextDoc, content_transformer(tolower))
TextDoc <- tm_map(TextDoc, removeNumbers)
TextDoc <- tm_map(TextDoc, removeWords, stopwords("english"))
TextDoc <- tm_map(TextDoc, removePunctuation)
TextDoc <- tm_map(TextDoc, stripWhitespace)
TextDoc <- tm_map(TextDoc, stemDocument)
View(TextDoc)

# Once the text has been processed, we will have stripped the data down to basic root words as a result of stemming.

# To initiate sentiment analysis on the words so obtained, we may convert the entire document into a document
# matrix. Using a document matrix will allow us to arrange our data in a columnar format. For example,
# we can retrieve the most common words and their frequency count. The demonstration is shown below.

TextDoc_dtm <- TermDocumentMatrix(TextDoc)
dtm_m <- as.matrix(TextDoc_dtm)

dtm_v <- sort(rowSums(dtm_m), decreasing = TRUE)
dtm_d <- data.frame(word = names(dtm_v), freq = dtm_v)
head(dtm_d, 5)

# The above function will have generated the top 5 most frequently occurring words in descending order. 

# Now, we can choose to build a word cloud of the most commonly occurring words.  The size of words in the word cloud
# will be directly proportional to their frequency count.

set.seed(1234)
wordcloud(words = dtm_d$word, freq = dtm_d$freq, min.freq = 5, max.words = 100, random.order = FALSE, rot.per = 0.30, colors = brewer.pal(8, "Dark2"))

# Plotting a bar graph to visualize the most frequently occurring words.

barplot(dtm_d[1:10,]$freq, las = 2, names.arg = dtm_d[1:10,]$word, col = "orange", main = "Top 10 Word Occurrences By Frequency Count", ylab = "Count of Words")

# Trying to find the association of each word with another, the numerical result so obtained will tell us about
# how closely the defined words are related to the most commonly occurring words, concerning sentiment value.
# Note: 'corlimit' specifies the threshold value of the extent to which the words shall find similarities. 

findAssocs(TextDoc_dtm, terms = c("get", "just", "day", "love", "good"), corlimit = 0.25)

# We can categorize the texts as particular emotions instead of giving them a numerical value. A list of emotions
# may be displayed in a tabular format and words matching the sentiment will be counted accordingly. 
# It will also return the count of positive and negative sentiments in the texts.

d <- get_nrc_sentiment(text)
View(d)
head(d, 10)

# Converting the above data into a data frame, we can now plot a graph depicting the count of the most frequently associated 
# emotions with the texts so analyzed.

td <- data.frame(t(d))
td_new <- data.frame(rowSums(td[2:253]))
names(td_new)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) <- NULL
td_new2 <- td_new[1:8,]
quickplot(sentiment, data = td_new2, weight = count, geom = "bar", fill = sentiment, ylab = "count") + ggtitle("Sentiment Frequency")

# Representing the data with respect to total percentage, we plot the following graph.

barplot(sort(colSums(prop.table(d[, 1:8]))), horiz = TRUE, cex.names = 0.7, las = 1, main = "Emotions in Text", xlab = "Percentage")

# Hence, we have finally concluded our results from the visualizations obtained. It has been observed that 
# 'anticipation' and 'trust' are the two most frequently occurring emotions in the tweets data set.

# Similarly, 'day', 'just' and 'get' have emerged as the most frequently occurring words in the data set.
# Further such analysis can be performed on other data sets containing textual data. 