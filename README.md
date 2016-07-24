## Note

Hello!


* My code assumes that you have already downloaded and unzipped
the household power consumption data, and placed in the same directory
as the R script files. 
* Please feel free to update the value of the "value" parameter 
in the dbWriteTable function call (line 18) to the corresponding 
file directory of the data.
* The R scripts used RSQLite package to parse data.
* Additionally, for plot 4, I deliberately did not include x labels 
for all the plots to maintain consistency across the plot, different from 
the original plot from the instructor (which had "datetime" as the x label
for the plots on the right)