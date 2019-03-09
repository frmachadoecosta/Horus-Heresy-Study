#goodreads_dataset analysis
library(ggplot2)

hhn <- read.csv('Warhammer_Books.csv')
str(hhn)

#it's reading title and author as factor, should be character
hhn$title <- as.character(hhn$title)
hhn$author <- as.character(hhn$author)

summary(hhn$average_rating)


#First Analysis
#---------------------------------------------------------------------

hist(hhn$average_rating,
     breaks = 5,
     main = 'Average Ratings of Horus Heresy Books',
     xlab = 'Average Rating'
     )

ggplot(hhn, aes(x=average_rating)) + 
  geom_histogram(binwidth=0.1,color="darkblue", fill="lightblue") +
  ggtitle("Average Ratings of Horus Heresy Books")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(y="Nº of Books", x = "Average Rating")+
  geom_vline(data=hhn, aes(xintercept=mean(average_rating)),linetype="dashed")+
  geom_text(aes(x=mean(hhn$average_rating), label="Mean of Ratings", y=15),angle=90,vjust=-0.5,size=4) +
  annotate("rect",xmin=quantile(hhn$average_rating, probs = 0.9),
           xmax =4.45,ymin=0, 
           ymax=18, alpha=.2, fill="red") +
  geom_text(aes(x=quantile(hhn$average_rating, probs = 0.9), label="What I'll read", y=15), hjust= -0.3,size=5) 
  

firstselected <- hhn[which(hhn$average_rating>=quantile(hhn$average_rating, probs = 0.9)),]
firstselected$title




#Second Analysis - being picky 
#---------------------------------------------------------------------
# Deciding what I'm reading just based of user reviews is bad enough, 
# I shouldn't consider books with ratings_count under 150
hhn.high <- hhn[hhn$ratings_count > 150 ,]

ggplot(hhn.high, aes(x=average_rating)) + 
  geom_histogram(binwidth=0.1,color="darkblue", fill="lightblue") +
  ggtitle("Average Ratings of Horus Heresy Books")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(y="Nº of Books", x = "Average Rating")+
  geom_vline(data=hhn.high, aes(xintercept=mean(average_rating)),linetype="dashed")+
  geom_text(aes(x=mean(hhn.high$average_rating), label="Mean of Ratings", y=15),angle=90,vjust=-0.5,size=4) +
  annotate("rect",xmin=quantile(hhn.high$average_rating, probs = 0.9),
           xmax =4.45,ymin=0, 
           ymax=18, alpha=.2, fill="red") +
  geom_text(aes(x=quantile(hhn.high$average_rating, probs = 0.9), label="What I'll read", y=15), hjust= -0.3,size=5) 

secondselected <- hhn.high[which(hhn.high$average_rating>=quantile(hhn.high$average_rating, probs = 0.9)),]
secondselected$title


#Third Analysis - fanboying
#---------------------------------------------------------------------
#Collect all Dan Abbet's writing with over 4.0 rating and ratings_count over 150
hhn.dan <- hhn[hhn$ratings_count > 150 & hhn$author == 'Dan Abnett' & hhn$average_rating>4.0,]
hhn.dan$title


#---------------------------------------------------------------------
best <- rbind(secondselected,hhn.dan)
best.clean <- dplyr::distinct(best)
best.clean$title
toread <- best.clean[order(best.clean$publication_year),'title']
write.table(toread, "final_list.csv", sep = ",", row.names = FALSE, col.names = FALSE)
