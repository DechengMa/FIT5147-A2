m <- leaflet() %>% 
  setView(lng = 147.898, lat = -14.8773, zoom = 6) %>% 
  addTiles()
m %>% addProviderTiles("Stamen.Toner")
m

data <- read.csv('./assignment-02-data-formated.csv')
head(data)

leaflet(data) %>% addTiles() %>%
  addMarkers(~longitude, ~latitude, popup = ~as.character(location))
