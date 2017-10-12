#.libPaths()
#setwd("C:/Program Files/R/R-3.4.1/library")
#install.packages("RTools")
#install.packages('ROracle',type="source")
#library(ROracle)
require(shiny)
require(shinydashboard)
require(devtools)
require(rCharts)
require(dplyr)
require(tidyr)
require(googleVis)
#require(DBI)
#require(RJDBC)
require(ggplot2)
require(colorRamps)
require(RColorBrewer)
require(grDevices)
require(shinyjs)
require(extrafont)


#drv <- odbcConnect("DATABASE",uid="projectshiny",pwd="project")
#drv <- dbDriver("Oracle")
#drv <- JDBC("oracle.jdbc.driver.OracleDriver","ojdbc6.jar")
#conn <- dbConnect(drv,"jdbc:oracle:thin:@localhost:1521:xe","projectshiny","project")

#summermedalist <- dbGetQuery(conn,"select s.year as holdyear, c.cityname as city, s.SPORT as sport, s.DISCIPLINE as discipline
#                                    , s.EVENT as event,  s.ATHLETE as athlete, s.GENDER as gender, s.MEDAL as medal , n.NATION as nation, n.ALPHA3 as code, n.ALPHA2 as code2
#                                  ,concat(s.year,concat(' ',c.cityname)) as hold
#                                  from summer s left outer join code2 n on s.country = n.ALPHA3
#                                  join cityname c on s.city = c.CITYNAME")

#wintermedalist <- dbGetQuery(conn,"select w.year as holdyear,  c.cityname as city, w.SPORT as sport, w.DISCIPLINE as discipline
#                                , w.EVENT as event, w.ATHLETE as athlete, w.GENDER as gender, w.MEDAL as medal, n.nation as nation, n.ALPHA3 as code, n.ALPHA2 as code2
#                             ,concat(w.year,concat(' ',c.cityname)) as hold
#                             from winter w left outer join code2 n on w.country = n.ALPHA3
#                             left outer join cityname c on w.CITY = c.CITYNAME")
#read.csv("data/summer.csv",fileEncoding="UTF-16", stringsAsFactors =F)
#write.csv(wintermedalist,"winter.csv")
#dbDisconnect(conn)

#summercost <- dbGetQuery(conn, "select cn.KOREANNAME, cn.NATION, c.YEAR, c.COST
#                         from cost c join cityname cn on c.GAMES = cn.CITYNAME
#                         where c.TYPE = 'Summer' and c.COST <>0
#                         order by c.COST ASC")
#summercost
#write.csv(summercost,"summercost.csv")
#wintercost <- dbGetQuery(conn, "select cn.KOREANNAME, cn.NATION, c.YEAR, c.COST
#                         from cost c join cityname cn on c.GAMES = cn.CITYNAME
#                         where c.TYPE = 'Winter' and c.COST <> 0
#                         order by c.COST ASC")
#wintercost
#write.csv(wintercost,"wintercost.csv")

#-------------------------------------------------------------------------------------------------------------


summermedalist <- read.csv("data/summer.csv",fileEncoding="UTF-16", stringsAsFactors =F)
#summermedalist



wintermedalist <- read.csv("data/winter.csv",fileEncoding = "UTF-16",stringsAsFactors =F)
#wintermedalist  

summercost <- read.csv("data/summercost.csv",fileEncoding = "UTF-16", stringsAsFactors =F)
wintercost <- read.csv("data/wintercost.csv", fileEncoding = "UTF-16", stringsAsFactors = F)


wintercost
medalist <- rbind(summermedalist,wintermedalist)

#dataset
v1 <- c("06 APR - 15 APR","14 MAY - 28 OCT","01 JUL - 23 NOV"
        ,"27 APR - 31 OCT","05 MAY - 27 JUL","20 APR - 12 SEP"
        ,"25 JAN - 05 FEB","04 MAY - 27 JUL","11 FEB - 19 FEB"
        ,"17 MAY - 12 AUG","04 FEB - 15 FEB","30 JUL - 14 AUG"
        ,"06 FEB - 16 FEB","01 AUG - 16 AUG","30 JAN - 08 FEB"
        ,"29 JUL - 14 AUG","14 FEB - 25 FEB","19 JUL - 03 AUG"
        ,"26 JAN - 05 FEB","22 NOV - 08 DEC","18 FEB - 28 FEB"
        ,"25 AUG - 11 SEP","29 JAN - 09 FEB","10 OCT - 24 OCT"
        ,"06 FEB - 18 FEB","12 OCT - 27 OCT","13 FEB - 24 FEB",
        "26 AUG - 11 SEP","04 FEB - 15 FEB","17 JUL - 01 AUG",
        "13 FEB - 24 FEB","19 JUL - 03 AUG"
        ,"08 FEB - 19 FEB","28 JUL - 12 AUG","13 FEB - 28 FEB"
        ,"17 SEP - 02 OCT","08 FEB - 23 FEB","25 JUL - 09 AUG"
        ,"12 FEB - 27 FEB","19 JUL - 04 AUG","07 FEB - 22 FEB"
        ,"15 SEP - 01 OCT","08 FEB - 24 FEB","13 AUG - 29 AUG"
        ,"10 FEB - 26 FEB","08 AUG - 24 AUG","12 FEB - 28 FEB"
        ,"27 JUL - 12 AUG","07 FEB - 23 FEB","05 AUG - 21 AUG"
        ,"09 FEB - 25 FEB","24 JUL - 09 AUG","04 FEB - 20 FEB"
        ,"","")
v2 <- c(241,997,651,2008,2407,2622,258,3088,464,2883,252,1334,646,
        3963,669,4104,694,4955,821,3314,665,5338,1091,5152,1158,5516,1006,7134,1123,6084,1072,
        5179,1272,6829,1423,8397,1801,9356,1737,10318,2176,10651,
        NA,10625,2508,10942,2566,10568,2780,11238,NA,NA,NA,NA,NA)

v3 <- c("Greece","France","USA","Great Britain","Sweden","Belgium"
        ,"France","France","Switzerland","Netherlands","USA","USA"
        ,"Germany","Germany","Switzerland","Great Britain","Norway"
        ,"Finland","Italy","Australia / Sweden","USA","Italy","Austria"
        ,"Japan","France","Mexico","Japan","Germany","Austria","Canada","USA","Russia","Bosnia and Herzegovina"
        ,"USA","Canada","Republic Of Korea","France","Spain","Norway"
        ,"USA","Japan","","USA","Greece","Italy","China","Canada",
        "Great Britain","Russia","Brazil","Republic Of Korea","Japan"
        ,"China","France","USA")

v4 <- c(14,24,12,22,28,29,16,44,25,46,17,37,28,49,28,59,30,69,32,72,
        30,83,36,93,37,112,35,121,37,92,37,80,49,140,57,159,64,169,67,197,72,199,77
        ,201,80,204,82,204,88,207,NA,NA,NA,NA,NA)

v5 <- c(43,95,95,110,102,156,16,126,14,109,14,117,17,129,22,136,22,
        149,24,151,27,150,34,163,35,172,35,195,37,198,38,203,39,221,46,237,57,257,61,
        271,68,300,80,301,84,302,86,302,98,306,NA,NA,NA,NA,NA)

v6 <- c("summer","summer","summer","summer","summer","summer",
        "winter","summer","winter","summer","winter","summer",
        "winter","summer","winter","summer","winter","summer",
        "winter","summer","winter","summer","winter","summer",
        "winter","summer","winter","summer","winter","summer","winter",
        "summer","winter","summer","winter","summer","winter",
        "summer","winter","summer","winter","summer","winter",
        "summer","winter","summer","winter","summer","winter",
        "summer","winter","summer","winter","summer","summer")
v7 <- c(1896,1900,1904,1908,1912,1920,1924,1924,1928,1928,1932,
        1932,1936,1936,1948,1948,1952,1952,1956,1956,1960,1960,
        1964,1964,1968,1968,1972,1972,1976,1976,1980,1980,1984,
        1984,1988,1988,1992,1992,1994,1996,1998,2000,2002,2004,
        2006,2008,2010,2012,2014,2016,2018,2020,2022,2024,2028)
v8 <- c("1896 Athens","1900 Paris","1904 St Louis","1908 London","1912 Stockholm",             
        "1920 Antwerp","1924 Chamonix","1924 Paris","1928 St.Moritz","1928 Amsterdam",
        "1932 Lake Placid","1932 Los Angeles","1936 Garmisch Partenkirchen","1936 Berlin",
        "1948 St.Moritz","1948 London","1952 Oslo","1952 Helsinki","1956 Cortina d'Ampezzo",
        "1956 Melbourne / Stockholm","1960 Squaw Valley","1960 Rome","1964 Innsbruck",
        "1964 Tokyo","1968 Grenoble","1968 Mexico","1972 Sapporo","1972 Munich",
        "1976 Innsbruck","1976 Montreal","1980 Lake Placid","1980 Moscow","1984 Sarajevo",
        "1984 Los Angeles","1988 Calgary","1988 Seoul","1992 Albertville","1992 Barcelona",
        "1994 Lillehammer","1996 Atlanta","1998 Nagano","2000 Sydney","2002 Salt Lake City",
        "2004 Athens","2006 Turin","2008 Beijing","2010 Vancouver","2012 London","2014 Sochi",
        "","","","","","")

dataset <- as.data.frame(cbind(v1,v2,v3,v4,v5,v6,v7,v8))
dataset <- data.frame(v1,v2,v3,v4,v5,v6,v7,HOLD=v8)

goldset <- data.frame(v1 = c("Gold","Gold","Gold","Gold","Gold"))
silverset <- data.frame(v1=c("Silver","Silver","Silver","Silver","Silver"))
bronzeset <- data.frame(v1=c("Bronze","Bronze","Bronze","Bronze","Bronze"))

periodset <- data.frame(v1=c())


pal <- c(grDevices::colors()[652],grDevices::colors()[418],grDevices::colors()[90])
#-----------------------------------------------------------------------------------------------------------------------------------------#

#my own js code


#--------------------------------------------------------------------------------------------
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(
    title = "Olympic Statistics",
    titleWidth = "300px"
  ),
  dashboardSidebar(
    sidebarUserPanel(
      "",
      subtitle = div(style="font-family:Times New Roman",img(src="torch.png"),"OLYMPIC DATA",img(src="torch.png"))
    ),
    width = "300px",
    disable= "False",
    sidebarMenu(
      id="tabs",
      menuItem(tags$b(tags$p("Grouped By Year")),tabName="yeardata",icon= icon('calendar')),
      menuItem(tags$b(tags$p("Summer/Winter")),tabName="seasondata",icon= icon('globe', lib='glyphicon')),
      menuItem(tags$b(tags$p("Upcoming...")),tabName="upcoming",icon=icon('fire',lib='glyphicon'))
    ),
    actionButton('switchtab',"Tab Switching Button")
  ),
  dashboardBody(
    tags$head(tags$style(HTML('
                              .main-header .logo {
                              font-family: "Georgia", Times, "Times New Roman", serif;
                              font-weight: bold;
                              font-size: 24px;
                              }
                              '))),
    tabItems(
      tabItem(tabName = "yeardata",
              fluidRow(
                column(4,selectInput("selectyear",label="Choose Year",width="1000",
                                     choices= dplyr::select(medalist,HOLDYEAR,CITY) %>% dplyr::distinct()
                                     %>% tidyr::unite(HOLD,HOLDYEAR,CITY,sep=" ") %>% dplyr::arrange(HOLD))),
                column(6,div("")),
                column(2,useShinyjs(),actionButton("previous","Go Previous Page"))
              ),
              
              fluidRow(
                column(12,tags$b(tags$h1(style="font-style:italic",textOutput("nth"))))),
              fixedRow(
                infoBoxOutput("holdyear",width=4),
                infoBoxOutput("period",width=4),
                infoBoxOutput("athletes",width=4),
                infoBoxOutput("holdcountry",width=4),
                infoBoxOutput("countries",width=4),
                infoBoxOutput("events",width=4)
              ),
              fixedRow(
                column(4,uiOutput("olympicposter"))
                ,column(8,tags$b(tags$p("Number of Events per Sports")),htmlOutput("eventnum"))
              ),
              fluidRow(
                column(8,selectInput("medalselect",label="select dataset",
                                     choices=c("All","Gold","Silver","Bronze")),
                       htmlOutput("medalpiechart")),
                column(4,tags$b(tags$p(style="font-size:20px; margin-top:360px","Top 5 of The Olympic")))
                
              ),
              fluidRow(
                showOutput("top5","nvd3")
              ),
              fluidRow(
                column(4,selectInput("selectyear2",label="Choose Year",width="1000",
                                     choices= dplyr::select(medalist,HOLDYEAR,CITY) %>% dplyr::distinct()
                                     %>% tidyr::unite(HOLD,HOLDYEAR,CITY,sep=" ") %>% dplyr::arrange(HOLD)))
              ),
              fluidRow(
                tags$b(tags$p(style="font-style:italic;margin-left:20px","Map Chart Of Medal")),
                column(12,htmlOutput("mapchart"))
              )
      ),     
      
      tabItem(tabName = "seasondata",
              fluidRow(
                column(6,tags$h1(style="font-family:Times New Roman","Olympic Hold Cost"))
              ),
              fluidRow(
                column(12,plotOutput("costgraphic"))
              ),
              fluidRow(
                column(12,plotOutput("costgraphic2"))
              ),
              
              fluidRow(
                column(12,tags$h1(style="font-family:Times New Roman","Multiple Summer Data of Olympic"),htmlOutput("bubble"))
              ),
              fluidRow(
                column(12,tags$h1(style="font-family:Times New Roman","Multiple Winter Data of Olympic"),htmlOutput("bubble2"))
              )
      ),
      tabItem(tabName = "upcoming",
              fluidRow(
                column(12,h1("Upcoming Olympic Event List"),
                       p("You can directly go to official site by clicking poster")
                )
              ),
              fluidRow(
                column(4,uiOutput("olympic2018")),
                column(4,uiOutput("olympic2020")),
                column(4,uiOutput("olympic2022"))
              ),  
              
              fluidRow(
                column(2,div("")),
                column(4,uiOutput("olympic2024")),
                column(4,uiOutput("olympic2028"))
              )
      )
    )
    ),
  title = "olympic data"
    )

#---------------------------------------------------------------------------------------------------------------------------------------#

server <- function(input,output,session){
  #tab switching code
  observeEvent(input$switchtab,{
    newtab <- switch(input$tabs,
                     "yeardata"="seasondata",
                     "seasondata"="upcoming",
                     "upcoming"="yeardata")
    updateTabItems(session, "tabs", newtab)
  })
  
  #reactive data set
  All <- reactive({
    input$selectyear
    dplyr::filter(medalist,HOLD==input$selectyear) %>%
      dplyr::select(MEDAL,NATION) %>%
      dplyr::count(NATION) %>% dplyr::arrange(desc(n))
  })
  Gold <- reactive({
    input$selectyear
    dplyr::filter(medalist,HOLD==input$selectyear) %>%
      dplyr::filter(MEDAL=="Gold") %>%
      dplyr::select(MEDAL,NATION) %>%
      dplyr::count(NATION) %>% dplyr::arrange(desc(n))
  })
  
  Silver <- reactive({
    input$selectyear
    dplyr::filter(medalist,HOLD==input$selectyear) %>%
      dplyr::filter(MEDAL=="Silver") %>%
      dplyr::select(MEDAL,NATION) %>%
      dplyr::count(NATION) %>% dplyr::arrange(desc(n))
  })
  
  Bronze <- reactive({
    input$selectyear
    dplyr::filter(medalist,HOLD==input$selectyear) %>%
      dplyr::filter(MEDAL=="Bronze") %>%
      dplyr::select(MEDAL,NATION) %>%
      dplyr::count(NATION) %>% dplyr::arrange(desc(n))
  })
  
  goldtop <- reactive({
    input$selectyear
    head(dplyr::arrange(All(),desc(n)),5) %>%
      dplyr::left_join(Gold(),by="NATION") %>% cbind(goldset) %>%
      dplyr::select(NATION,n.y,v1)
  })
  
  silvertop <- reactive({
    input$selectyear
    head(dplyr::arrange(All(),desc(n)),5) %>%
      dplyr::left_join(Silver(),by="NATION") %>% cbind(silverset) %>%
      dplyr::select(NATION,n.y,v1)
  })
  bronzetop <- reactive({
    input$selectyear
    head(dplyr::arrange(All(),desc(n)),5) %>%
      dplyr::left_join(Bronze(),by="NATION") %>% cbind(bronzeset) %>%
      dplyr::select(NATION,n.y,v1)
  })
  top5 <- reactive({
    input$selectyear
    rbind(goldtop(), silvertop(), bronzetop())
  })
  
  imagename <- reactive({
    input$selectyear
    gsub('/','',input$selectyear)
    gsub(' ','',input$selectyear)
  })
  
  code <- reactive({
    input$selectyear
    na.omit(medalist)
  })
  
  #show title
  output$nth <- renderText({
    title = dplyr::select(medalist,CITY) %>% dplyr::distinct()
    paste(input$selectyear,' ','Olympic')
  })
  #button click -> go back to previous page
  observeEvent(input$previous,{
    runjs(
      if(document.referrer){
        history.back();
      } else {
        location.href="www.naver.com"
      }
      
    )
  })
  #reuse input code!
  Selected <- reactiveValues(Chosen=NULL)
  observeEvent(
    input$selectyear,Selected$chosen <- (input$selectyear)
  )
  observeEvent(
    input$selectyear2,Selected$chosen <- (input$selectyear2)
  )
  observeEvent(
    Selected$chosen, updateSelectInput(session,"selectyear",selected = Selected$chosen)
  )
  observeEvent(
    Selected$chosen, updateSelectInput(session,"selectyear2",selected= Selected$chosen)
  )
  #show infobox
  output$holdyear <- renderInfoBox({
    infoBox(
      tags$b(style="font-size:20px;","Hold Year")
      ,tags$span(style="font-style:italic",substr(input$selectyear,0,4))
      ,color="yellow"
      ,icon=icon("calendar",lib="glyphicon")
    )
  })
  output$period <- renderInfoBox({
    infoBox(
      tags$b(style="font-size:20px;","Period")
      ,tags$span(style="font-style:italic",as.array(dataset$v1)[which(grepl(input$selectyear,dataset$HOLD))])
      ,icon=icon("calendar-o")
    )
  })
  output$athletes <- renderInfoBox({
    infoBox(
      tags$b(style="font-size:20px;","Athletes")
      ,tags$span(style="font-style:italic",as.array(dataset$v2)[which(grepl(input$selectyear,dataset$HOLD))])
      ,icon=icon("user-circle-o")
      ,color="olive"
    )
  })
  output$holdcountry <- renderInfoBox({
    infoBox(
      tags$b(style="font-size:20px;","Hold country")
      ,tags$span(style="font-style:italic",as.array(dataset$v3)[which(grepl(input$selectyear,dataset$HOLD))])
      ,icon=icon("globe")
      ,color="blue"
    )
  })
  output$countries <- renderInfoBox({
    infoBox(
      tags$b(style="font-size:20px;","Countries")
      ,tags$span(style="font-style:italic",as.array(dataset$v4)[which(grepl(input$selectyear,dataset$HOLD))])
      ,icon=icon("plane",lib="glyphicon")
      ,color="teal"
    )
  })
  output$events <- renderInfoBox({
    infoBox(
      tags$b(style="font-size:20px;","Events")
      ,tags$span(style="font-style:italic",as.array(dataset$v5)[which(grepl(input$selectyear,dataset$HOLD))])
      ,icon=icon("grain",lib="glyphicon")
      ,color="purple"
    )
  })
  
  
  #show poster
  output$olympicposter <- renderUI({
    
    tags$img(weight="300", height="300",style="margin-bottom:20px",src=paste0(imagename(),".png"))
  })
  output$olympic2018 <- renderUI({
    tags$a(href="https://www.pyeongchang2018.com/ko/index",tags$img(weight="300", height="300",style="margin-top:30px",src="2018PyengChang.png"))
  })
  output$olympic2020 <- renderUI({
    tags$a(href="https://tokyo2020.jp/en/",tags$img(weight="300", height="300",style="margin-top:30px",src="2020Tokyo.png"))
    
  })
  output$olympic2022 <- renderUI({
    tags$a(href="http://www.beijing2022.cn/en/",tags$img(weight="300", height="300",style="margin-top:30px",src="2022Beijing.jpg"))
    
  })
  output$olympic2024 <- renderUI({
    tags$a(href="https://www.olympic.org/paris-2024",tags$img(weight="300", height="300",style="margin-top:30px",src="2024Paris.png"))
  })
  output$olympic2028 <- renderUI({
    tags$a(href="https://www.olympic.org/la-2028",tags$img(weight="300", height="300",style="margin-top:30px",src="2028LA.png"))
  })
  
  #show graphics
  medal <- reactive({
    switch(input$medalselect,
           "All"=All(),
           "Gold" = Gold(),
           "Silver" = Silver(),
           "Bronze" = Bronze())
  })
  output$medalpiechart <- renderGvis({
    gvisPieChart(medal(),options=list(width="500px", height="300px",
                                      pieSliceText='label',pieHole=0.5,
                                      title="Medal rank"))
  })
  output$eventnum <- renderGvis({
    gvisBarChart(dplyr::filter(medalist,HOLD==input$selectyear) %>% dplyr::select(SPORT,EVENT)%>%
                   dplyr::distinct(EVENT,SPORT) %>% dplyr::count(SPORT) %>% dplyr::rename(count=n) %>%
                   dplyr::arrange(desc(count)), xvar="SPORT", 
                 yvar="count",
                 options=list(width="600px", height="250px"))
  })
  output$top5 <- renderChart2({
    n1 <- nPlot(n.y~NATION, group="v1", data=top5(), type="multiBarChart")
    n1$chart(color=pal)
    return(n1)
  })
  output$mapchart <- renderGvis({
    gvisGeoChart(
      dplyr::filter(code(),HOLD==input$selectyear) %>% dplyr::select(CODE2,MEDAL,NATION) %>% dplyr::count(CODE2,NATION) %>% dplyr::rename(Medals=n),
      locationvar = "CODE2", colorvar = "Medals" , hovervar="NATION",options=list(width=1000, height=600)
    )
  })
  summercost
  #show the graphic of tab - summer/winter ---- need fixing

  if(!is.null(output$costgraphic())){
    output$costgraphic <- renderGvis(NULL)
    output$costgraphic2 <- renderGvis(NULL)
    output$costgraphic2 <- renderPlot({
      ggplot(data=wintercost)+
        geom_col(mapping=aes(x=paste(YEAR,KOREANNAME),y=COST), fill=colorRamps::blue2green(12))+labs(x="Holded City",y="Cost(billion)")+
        theme(axis.text.x=element_text(angle=45,hjust=1,size=16))+
        theme(axis.title.y=element_text(angle=0,hjust=10))+
        scale_y_continuous(limits=c(0,25))+
        ggtitle("Winter Cost")+
        theme(plot.title = element_text(family=extrafont::choose_font("ttf"),face="bold", size=25, hjust=0.5, vjust=2, color="red"))+
        geom_text(aes(x=paste("Winter",YEAR),y=COST+0.3,label=COST),size=5,vjust=0)
    })
  } else {
    output$costgraphic <- renderPlot({
      ggplot(data=summercost)+
        geom_col(mapping=aes(x=paste(YEAR,KOREANNAME),y=COST), fill=grDevices::heat.colors(11))+labs(x="Holded City",y="Cost(billion)")+
        theme(axis.text.x=element_text(angle=45,hjust=1,size=16))+
        theme(axis.title.y=element_text(angle=0,hjust=10))+
        ggtitle("Summer Cost")+
        scale_y_continuous(limits=c(0,20))+
        theme(plot.title = element_text(family=extrafont::choose_font("ttf"),face="bold", size=25, hjust=0.5, vjust=2, color="red"))+
        geom_text(aes(x=paste("Summer",YEAR),y=COST+0.3,label=COST),size=5,vjust=0)
    })
    output$costgraphic2 <- renderPlot({
      ggplot(data=wintercost)+
        geom_col(mapping=aes(x=paste(YEAR,KOREANNAME),y=COST), fill=colorRamps::blue2green(12))+labs(x="Holded City",y="Cost(billion)")+
        theme(axis.text.x=element_text(angle=45,hjust=1,size=16))+
        theme(axis.title.y=element_text(angle=0,hjust=10))+
        scale_y_continuous(limits=c(0,25))+
        ggtitle("Winter Cost")+
        theme(plot.title = element_text(family=extrafont::choose_font("ttf"),face="bold", size=25, hjust=0.5, vjust=2, color="red"))+
        geom_text(aes(x=paste("Winter",YEAR),y=COST+0.3,label=COST),size=5,vjust=0)
    })
  }
  
 
  

  output$bubble <- renderGvis({
    gvisBubbleChart(dplyr::rename(dataset,Athletes=v2,Hold=v3,Countries=v4,Events=v5,Year=v7) %>% 
                      dplyr::filter(v6=="summer"),idvar="Year",xvar="Countries",yvar="Athletes",colorvar="Year",
                    options=list(width="1000px", height="500px"))
  })
  output$bubble2 <- renderGvis({
    gvisBubbleChart(dplyr::rename(dataset,Athletes=v2,Hold=v3,Countries=v4,Events=v5,Year=v7) %>% 
                      dplyr::filter(v6=="winter"),idvar="Year",xvar="Countries",yvar="Athletes",colorvar="Year",
                    options=list(width="1000px", height="500px"))
  })
}

shinyApp(ui=ui, server=server)

#test

