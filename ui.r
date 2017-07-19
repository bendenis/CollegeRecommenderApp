library(shiny)
library(dplyr)

DT = read.csv('/Users/bendenisshaffer/Dropbox/myKlovr/CollegeRecommender/Data/Intrim/D8.csv')
cols = c('ACTRangeUpper','SATRangeUpper','AverageAdmittedGPA','tuition_fee','rank_overall','location','scid','SchoolName')
reco = DT[,cols]


reco[which(reco$SATRangeUpper < 0),'SATRangeUpper'] = NA
reco[which(reco$ACTRangeUpper == 0),'ACTRangeUpper'] = NA

# add 4 columns to 'reco': volunteer_hour, award, ap_score, writing

reco$volunteer_hour = 1:1878
reco$award = 1:1878
reco$writing = 1:1878
reco$ap_score = 1:1878

# manually set values
for (i in 1:dim(reco)[1]){ 
        if (is.na(reco$rank_overall[i])) reco[i,c('volunteer_hour','award','ap_score','writing')] = c(50,1,1,1)
        else if (reco$rank_overall[i] <= 50)  reco[i,c('volunteer_hour','award','ap_score','writing')] = c(200,5,5,8)
        else if (reco$rank_overall[i] <= 100)  reco[i,c('volunteer_hour','award','ap_score','writing')] = c(150,3,3,5)
        else if (reco$rank_overall[i] <= 200)  reco[i,c('volunteer_hour','award','ap_score','writing')] = c(100,1,1,3)
        else reco[i,c('volunteer_hour','award','ap_score','writing')] = c(50,1,1,1)
}


shinyUI(
        fluidPage(
                
                numericInput("ACTscore", "Your ACT Score:", value = 30, min = 1, max = 36),
                numericInput("SATscore", "Your SAT Score:", value = 1200, min = 400, max = 1600),
                numericInput("GPA", "Your GPA:", value = 3.5, min = 2, max = 4),
                numericInput("volunteer", "Hours of Volunteer Work:", value = 20, min = 0, max = 200),
                numericInput("awards", "Number of Awards:", value = 2, min = 0, max = 40),
                numericInput("APscore", "Your AP Score:", value = 3, min = 1, max = 4),
                numericInput("writing", "Writing Skills:", value = 4, min = 1, max = 10),
                
                dataTableOutput("recommended_schools")
        )
)