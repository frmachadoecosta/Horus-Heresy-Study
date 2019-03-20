# Horus Heresy Study

This small script serves to help me choose what books I should read from the Horus Heresy Series of Wahammer 40k

Using Python and the *goodreads_api_client* API, data was collected from Goodreads website on all books belonging to this series, repective authors, publishing year and average user reviews to create a usable dataset with Pandas, this can be seen in **goodreads.py** file. 

The analysis itself was caried out in R and is fairly straight foward, 

1. Strightly based on average ratings after analysing its distribution on an histogram (visual representation of the selection was made with *ggplot* and is available on [data_analysis_R/Rplot01.png](https://github.com/frmachadoecosta/Horus-Heresy-Study/blob/master/data_analysis_R/Rplot01.png))

2. Adding an extra filter to not consider books that were reviewd under 150 times so as to give a slight edge to more popular books and minimizer outliers in user reviews.

3. Colleting Dan Abbet's work in the series


Second and Third filters were added together and cleaned with *dplyr* and book titles from the final result was exported to .csv to **data_analysis_R/final_list.csv** and can be seen here.

| ------------- |
|"Horus Rising (Horus Heresy #1)"|
|"Legion"|
|"A Thousand Sons"|
|"The First Heretic"|
|"Prospero Burns"|
|"Know No Fear"|
|"Betrayer"|
|"Prince of Crows"|
|"The Unremembered Empire"|
|"The Master of Mankind"|
|"Wolfsbane"|
| ------------- |