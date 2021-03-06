library(shiny)
library(affy)
library(GEOquery)
library(som)
shinyUI(fluidPage(
	titlePanel("My GEO shiny App"),
	mainPanel(pageWithSidebar(
	headerPanel("Dataset Selection"),
        sidebarPanel(
		tabsetPanel(
			tabPanel("Dounload dataset from GEO",value=1),
			tabPanel("Upload your own dataset", value=2),
			id="conditionedPanels"
		),
		conditionalPanel(condition="input.conditionedPanels=='1'",
				textInput("number","Enter a dataset name e.g. GSE136 : ",value=""),
				actionButton("Gobutton","Download"),
				radioButtons("checkGroup",label = h3("Select type of dataset file"),
				choices = list('Raw data CEL files', 'Series matrix file'), selected =NULL), htmlOutput('pdfviewer')
				),
		conditionalPanel(condition="input.conditionedPanels=='2'",
			fileInput('file1', 'Choose CSV File',
					accept = c('text/csv',
			   		'text/comma-separated-values,text/plain','.csv')
				  ),
				tags$hr(),
				checkboxInput(inputId = 'header', label = 'Header', value = FALSE),
				radioButtons('sep','Separator',
		     				c(Comma=',',
		       				Semicolon=';',Tab='\t',
                      				',')
					)
				)
		),
	mainPanel(
		tabsetPanel(
		tabPanel("dataset",
			fluidRow(
			      column(8,plotOutput("dataBoxplot"),
				tableOutput("contents"),tags$style(type='text/css','#view{background-color:rgba(11,56,49,0.2);color:balck;font-family:verdana;}'),
	       			downloadButton("downloadData","Download")
				    )
				)
			)#,
		#actionButton("NormalizeButton","Normalize"),
		#actionButton("LogTransformButton","Log2 Transform")
			  )
		))
	)))
