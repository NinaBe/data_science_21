




library(e1071)
library(shiny)


titanic.svm <- readRDS("titanic.svm.rds")


ui <- fluidPage(
  
  titlePanel("Wer überlebt auf der Titanic?"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      numericInput("age", "Alter:", value = ""),
      
      selectInput("sex", selected = NULL, "Geschlecht:", c("weiblich" = 1, "männlich" = 0)),
      
      sliderInput("pclass", "Klasse:", min = 1, max = 3, value = 1),
      
      helpText("Geben Sie Alter, Geschlecht und Klasse an und erfahren Sie, ob die Person auf der Titanic überlebt hätte."),
      
      actionButton("action", label = "Überlebt die Person?")),
    
    mainPanel(
      
      tableOutput("value1")
    )
  )
)



server <- function(input, output, session) {
  
  observeEvent(input$action, {
    
    age <- input$age
    
    sex <- as.numeric(input$sex)
    
    pclass <- as.numeric(input$pclass)
    
    data <- data.frame(age, sex, pclass)
    
    result <- predict(titanic.svm, data, probability = TRUE)
    
    my_result <- data.frame(attr(result, "probabilities"))
    
    output$value1 <- renderTable(my_result)
    
    }
  )
}

shinyApp(ui, server)


