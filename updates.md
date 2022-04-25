## March 21

I decided on my project and searched through github to try and find data sets on Olympic swimming results throughout the years.

## March 23 Beginning of Class

I spent a lot of time trying to find a data set that will work. Once I found this data set I was able to load it into R. I then worked through trying to make the variables how I want them in the data set. For example the competition name is not the same throughout all the variables and I would like to be able to group together all Olympic Games, but the city is listed in the name. So, it is difficult to find a way to fix this. I also brainstormed just how in general I want my app to look, so I knew what I needed my variables to look like.

## March 23 End of Class

I began putting information into my R app. I worked on attempting to get the tabs up and running and am working through connecting clicking on tabs to filtering particular data, however I am not sure if this is possible so I am still working through that.

## March 28 Beginning of Class

In between the last two classes I worked on the best way to show my data visualizations and decided on a sort of template to follow. I created the majority of the inputs that will be used in this app. I also messed around with the templates and decided where it would be best to put the tabs and what exactly I wanted the tabs to represent. I also played around with the data to start being able to visualize the data in the app.

## March 28 End of Class

During this class I fixed a few of the inputs so that they make more sense when choosing the variables. I also began looking at creating visualizations to put into the tabs. I made a base visualization that I am just trying to connect to the data in the shiny app. I have been working through how to fix my app so that I could possibly only have certain year input options when a particular series is selected. I am not sure if this is possible however.

## March 30 Beginning of Class

In between the last two classes I focused mostly on the format I want my app to be in. I was having a lot of issues with the different series inputs because I wanted to be able to change the year depending on the series (and I wanted the series to all have separate tabs). So, I figured out how to do this by making a separate data set for each series. I also worked on creating a new visualization in the app. I chose not to add every single series yet (because it is all copy and paste once I do anyways), so that I can do it when the visualization is actually ready how I want it to be.

## March 30 End of Class

During class today I focused on figuring out how to get a plotly graph into the shiny app and reviewed how to make a shiny app in general. I was able to change the plot already in my app into a plotly graph so the user can read the graph more clearly. I also began to work on creating a map for a tab in my app, however I haven't figured out how to combine the data sets for it because the labeling is off so I am working on that as well. 

## April 4 Beginning of Class

In between the last two classes I began adding the last of the tabs, however after adding some I decided to keep two of the types of series out because they only had data from one year. I then continued to work on creating a map for my app. I figured out how to combine the data sets, but they still won't combine because it says they are too large to combine, so I am still working through this. I may opt out of adding a map or possibly make smaller data sets, so it will be easier to combine. 

## April 4 End of Class

During this class I was mainly working through issues with the data visualizations I would like to make. I am working through changing NA values so that I can make a graphic that shows the time_behind. I am also working through combining the map data sets still (but it still doesn't work even with a smaller data set). I edited the tabs so they are now all set and just need to add more visualizations to each tab. This means the base of my project is done and now it's just adding good visualizations to the app.

## April 11 Beginning of Class

In between the last two classes I worked on creating new visualizations for the data set. I decided to work on making a graph that shows the top 8 finishers for each event and shows the amount of time they were behind the first place finisher. I figured out how to get the na values changed to 0 for the first place finishers, however I am still debating other additions to the graph like how to show the country before I put it in the project. I also began working on a table that shows the amount of medals for each country by year depending on the series. I am also still working on this because it did not work well when I placed it into the project, so I am not sure why it worked with the data and not now. 

## April 13 Beginning of Class

In between the last two classes I was able to add one of my new visualizations into the project. I worked on making it more visually pleasing and am still working on that part, so I have only added it in the world cup section of the project. I put some more work into figuring out how to put my other visualization into shiny, but I am still struggling with this and have not quite figured it out. 

## April 20 Beginning of Class

In between the last two classes I have been working still on the two visualizations. I have been able to get them both into the Olympics portion of the app, but I am still have a lot of trouble with the medal visualization. I want to be able to label my tables but I only know how to do that with one of the table functions, which shiny isn't letting me use (or I'm not using it correctly in shiny). I was able to get this graph into the app, but it shows NA values where I want it to show 0 or that added values for the total. I decided to add a different input right above that chart so it is more specifically know that only the year is used. I am debating doing this as well for the other main parts of my app, but I have not quite figured out the best way to do it because the graphs all use different inputs and all have different set values. Before I move on I want to be able to figure out how to get the NA values out of this graph. I think I may end up putting each graph on a different tab and have different inputs from there. 

## April 20 End of Class

During class today I fixed the olympic medal visualization, so now it works. I then began working on fixing the layout of my app because the way it was was not working for me. I decided I'm going to do separate inputs for each graph, which seems like a lot, but all the graphs use different inputs, so if this isn't done this way the graphs could become more confusing for the user. They may be confused why they are able to choose a year for a graph that looks at the times across all years, so this is just to fix that issue. I had a lot of parentheses issues with this, but I figured it out by the end. This part is only updated in the Olympic Games part of the project. So, now I feel pretty comfortable with all my graphics and the layout, I just have to update the rest of the project.

## April 25 Beginning of Class

In between the last two classes I finished getting the rest of the graphics into the app. I also fixed the organization of the app, or attempted to so that the inputs make more sense with the graphs. Before it was hard to tell what graphics needed what inputs, so now they have been fixed. I now need to fix the tables and graphs, so they look more visually pleasing and possibly add some more visualizations. When I put the last few graphics in, some of them are not working correctly, so I'm not entirely sure what I did wrong there, but I also have been working on fixing those. 

## April 25 End of Class

Fixed the graphics that weren't working due to misspellings for inputs and outputs. I then worked on adding a theme and organizing the app so it looks nicer. I'm doing this to make sure it can get done before I add more visualizations. I have also begun checking out headers, so the user understands what the app is doing. I took out the title for the top 8 graph, so I need to decide whether to put the title as a header in the graph or the app (I think app will look better). Mostly just tidying up the app to make it look nicer, just testing out different themes and versions of things that will go best with my app.


