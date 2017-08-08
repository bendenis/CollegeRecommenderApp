library(shiny)
library(dplyr)
library(shinydashboard)

DT = read.csv('Data/D10.csv')



shinyUI(
        dashboardPage(
                dashboardHeader(title = "CollegeRecommender"),
                dashboardSidebar(
                        sidebarMenu(
                                menuItem("College Profile", tabName = "profile"),
                                menuItem("College Chances", tabName = "chances"),
                                menuItem("College Similarity", tabName = "similarity")
                                )
                ),
                
                dashboardBody(
                        tabItems(
                                tabItem(tabName = "profile",
                                        h1("College Profile"),
                                        selectInput("school_name", label = "School Name", choices = unique(DT$SchoolName), 
                                                    selected = "Boston University"),
                                        
                                        h2("Institution Type"),
                                        tableOutput("institution_type_table"),
                                        
                                        h2("Location"),
                                        tableOutput("location_table"),
                                        
                                        h2("Rankings"),
                                        tableOutput("ranking_table"),
                                        
                                        h2("Admissions"),
                                        tableOutput("admissions_table"),
                                        
                                        h2("Financial"),
                                        tableOutput("financial_table"),
                                        
                                        h2("Academics"),
                                        tableOutput("academics_table"),
                                        
                                        h2("Student Body"),
                                        tableOutput("student_body_table"),
                                        
                                        h2("Campus Life"),
                                        tableOutput("campus_life_table"),
                                        
                                        h2("After Graduation"),
                                        tableOutput("after_graduation_table")
                                        
                                        ),
                                tabItem(tabName = "chances",
                                        h1("Recommended Based on Your Academics"),
                                        tableOutput("recommended_schools")
                                        ),
                                tabItem(tabName = "similarity",
                                        h1("Similar to the School you Like"),
                                        dataTableOutput("similar_school")
                                        )
                        )
                )
        )
)




