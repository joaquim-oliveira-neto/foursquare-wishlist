## Foursquare wishlist
###Objective
This Ruby on Rails app brings the last checkins of your friends on foursquare an enables you to add these venues to your wishlist.

###Observations
1. This app works only on develpment mode and you should use localhost:3000 to run it
2. In order for this app to work add to `config/application.yml`the following:
> 
development:
  FOURSQUARE_ID: "your foursquare ID"
  FOURSQUARE_SECRET: "your foursquare secret"

###Third party gems used to communicate with Foursquare API
1. `omniauth-foursquare` to authenticate
2. `foursquare2` to facilitate downloading data from the API

###Improvements to be done
1. Use ajax to render adding and deleting venues from the wishlist without having to reload the page everytime
2. Use cashing to reduce the number of APIs calls


