 ### Stock market prediction using Numarical and Text anaylsis ###

#installing package quantmod
install.packages("quantmod")
library(quantmod)


# stock price analyis of SENS 
getSymbols("SENS", src="yahoo")
chartSeries(SENS) 
addMACD() # adds moving average convergence divergence signals
addBBands() # Adds Bollinger bands to the stock
addCCI() # Add Commodity channel index. 
addADX() #Add Directional Movement Indicator 
addCMF() #Add Money Flow chart

Returns_by_yaer_SENS<-yearlyReturn(SENS)
head(Returns_by_yaer_SENS)

Returns_by_month_SENS=monthlyReturn(SENS)
head(Returns_by_month_SENS)






getSymbols("^BSESN", src="yahoo") 
chartSeries(BSESN)

addMACD() # adds moving average convergence divergence signals 
addBBands() # Adds Bollinger bands to the stock price. 
addCCI() # Add Commodity channel index. 
addADX() #Add Directional Movement Indicator 
addCMF() #Add Money Flow chart



###   Text analysis   ###

df=read.csv(file.choose())
head(df)
str(df)
View(df)

#build corpus
library(tm)
Corpus=iconv(df$headline_text)
Corpus=Corpus(VectorSource(Corpus))
inspect(Corpus[1:5])

#cleaning the text

Corpus=tm_map(Corpus,tolower)
inspect(Corpus[1:5])

Corpus=tm_map(Corpus,removeNumbers)
Corpus=tm_map(Corpus,removePunctuation)
inspect(Corpus[1:15])

stopwords('english')
clean.set=tm_map(Corpus,removeWords,stopwords("english"))
inspect(Corpus[1:15])

clean.set=tm_map(Corpus,stripWhitespace)
inspect(Corpus[1:15])

#term doc matrix
tdm=TermDocumentMatrix(clean.set)
tdm

tdm=as.matrix(tdm)
tdm[1:10,1:20]
w=rowSums(tdm)
w
w=subset(w,w>10)
barplot(w,las=2,col = rainbow(20))

#wordcloud
library(wordcloud)
w=sort(rowSums(tdm),decreasing = T)
set.seed(222)
wordcloud(words = names(w),
          freq = w,
          max.words = 300,
          random.order = F,
          min.freq = 5)
