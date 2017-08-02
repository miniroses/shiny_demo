library('shiny')
options(shiny.maxRequestSize = 20000*1024^2)

shinyServer(function(input, output,session) {
  
  output$mymap <- renderLeaflet({
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    leaflet(df) %>%addProviderTiles("OpenStreetMap.Mapnik")%>% addCircleMarkers(
      lng = ~longitude,
      lat = ~latitude,
      radius=3,
      weight=2
      
      
      
      )
  })
    
  observeEvent(input$mymap_marker_click, {
    leafletProxy("mymap", session) %>%
      removeMarker(input$map1_marker_click$id)
  })

})

