# Dimensional Search code example

This code needs some refactoring, but it's working in production at the moment.

This is a search feature for a website that I have developed for a company that sells
springs and suspensions for trucks.

It's a dimensional search for springs, that enables customers to initiate
the search by selecting the number of leaves and then narrow down the search by
several parameters.

If only one parameter is present in the min/max fields, the search is performed 
for the exact value. 

If two values are present, the search is performed on the range of
values from min to max.

The results table is displayed with an Ajax call and items can be sorted and
kept sorted through pagination.

The controller delegates the search to an action object called
`DimensionalSearch` that performs the actual search and passes the results to
the controller to be displayed.

You can see a screenshot of the web page here:
https://github.com/cesareferrari/dimensional-search/blob/master/screenshot/dimensional_search.png

