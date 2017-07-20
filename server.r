library(shiny)
library(dplyr)

academicData = DT[,c("AverageAdmittedGPA","SATAverageComposite","SATAverageMath",
                     "SATAverageReading","SATAverageWriting","SATRangeLower",
                     "SATRangeUpper","ACTAverageEnglish","ACTAverageMath",
                     "ACTAverageWriting","ACTAverageComposite",
                     "ACTRangeLower","ACTRangeUpper",
                     "GradLaw","GradMedical","GradDental","GradEngineering","GradTheology",
                     "GradEducation","GradArtsSciences","GradVeterinary","GradMBA",
                     "Specialized","SelectivityRank","SchoolName")]

academicData = na.omit(academicData)

academicDataMat = scale(academicData[,-25], center = TRUE, scale = TRUE)

academicDistMat = as.matrix(dist(academicDataMat, method = "minkowski", p = 1))

colnames(academicDistMat) = academicData$SchoolName
row.names(academicDistMat) = academicData$SchoolName

college_recommend <- function (user_data,weights){
        for (i in 1:nrow(reco)) { 
                cols = c('ACTRangeUpper','SATRangeUpper','AverageAdmittedGPA','volunteer_hour','award','ap_score','writing')
                vec = user_data[1,cols]/reco[i,cols]
                vec[1,is.na(vec[1,])] = 1
                vec[1,(vec[1,4:7] > 1)] = 1
                reco$admit_chance[i] = round(sum(vec*weights),3)
        }
        output = reco[,c('rank_overall','SchoolName','tuition_fee','location','admit_chance')]
        # risk college
        df = output %>%
                filter(admit_chance<0.99) %>%
                top_n(5,-rank_overall)
        # fit college
        df1 = output %>%
                filter(admit_chance<=1.01 & admit_chance>=0.99) %>%
                top_n(10,-rank_overall)
        # safe college
        df2 = output %>%
                filter(admit_chance > 1.02 ) %>%
                top_n(5,-rank_overall)
        #df as final output for this user
        df = rbind(df,df1,df2) %>%
                arrange(admit_chance)
        
        return (df)
}



server <- function(input, output){
        
        output$recommended_schools = renderDataTable({
                
              user_data = reco[192,]
              user_data[1] = input$ACTscore
              user_data[2] = input$SATscore
              user_data[3] = input$GPA
              user_data[9] = input$volunteer
              user_data[10] = input$awards
              user_data[11] = input$writing
              user_data[12] = input$APscore
              weights = c(0.25,0.25,0.1,0.1,0.1,0.1,0.1)
              college_recommend(user_data, weights)
                
        })
        
        output$similar_school = renderDataTable({
                lst = sort(academicDistMat[which(academicData$SchoolName == input$school_name),])[-1]
                tb = data.frame(Name = names(lst))
                tb
        })
        
}
