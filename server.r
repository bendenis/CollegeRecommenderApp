library(shiny)
library(dplyr)



server <- function(input, output){
        
        output$institution_type_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(PublicPrivate, FourYear, TwoYear, UgradTotalPop)
        )
        
        output$location_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(State.x, City, Region, Longitude, Latitude, CampusType, LocationDescription)
        )

        output$ranking_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(rank_overall, rank_art, rank_business, 
                                                                          rank_cs, rank_medical, rank_engineer,
                                                                          rank_life_science, rank_physical_science,
                                                                          rank_social_science)
        )
        
        output$admissions_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(Acceptance.Rate, SATRangeUpper, SATRangeLower,
                                                                          ACTRangeUpper, ACTRangeLower,
                                                                          SATAverageComposite, ACTAverageComposite,
                                                                          SATAverageReading, SATAverageMath, SATAverageWriting,
                                                                          ACTAverageEnglish, ACTAverageMath, ACTAverageWriting,
                                                                          ApplicationFee, Requirements)
        )
        
        output$financial_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(InstateTuition, OutstateTuition, 
                                                                          SEOGScholarship, StateScholarship, CollegeScholarship,
                                                                          PellGrantScholarship, NeedBasedScholarship, UnitedNegroScholarship,
                                                                          NursingScholarship, PrivateScholarship, OtherScholarship,
                                                                          PLUSLoan, StateLoan, CollegeLoan, NursingLoan, PerkinsLoan,
                                                                          SubsudisedStaffordLoan, unSubsudisedStaffordLoan, OtherLoan)
        )
        
        output$academics_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(student_staff_ratio, subjects_offered) 
        )
        
        
        output$student_body_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(UgradTotalPop, UgradMalePop, UgradFemalePop,
                                                                          WhiteUgradPop, NativeUgradPop, ForeignUgradPop,
                                                                          LatinUgradPop, BlackUgradPop, AsianUgradPop,
                                                                          HawaiianUgradPop, MixraceUgradPop, NoRaceUgradPop,
                                                                          WhiteFreshmanPop, NativeFreshmanPop, ForeignFreshmanPop,
                                                                          LatinFreshmanPop, BlackFreshmanPop, AsianFreshmanPop,
                                                                          HawaiianFreshmanPop, MixraceFreshmanPop, NoRaceFreshmanPop,
                                                                          TotalUgradPop, TotalFreshmanPop)
        )
        
        
        output$campus_life_table = renderTable(
                DT %>% filter(SchoolName == input$school_name) %>% select(NumFrats, NumSororities, NumStudentOrg, IntramuralSports,
                                                                          SportsFacilities, SocailLifeComments, SocailOrganizations,
                                                                          ReligiousOrganizations, MinorotyStudentOrganizations,
                                                                          InternationalStudentOrganizations, OtherStudentOrganizations,
                                                                          PercentOutstate, PercentCOEDHousing, PercentCooperativeHousing,
                                                                          PercentDisabilityHousing, PercentWomenOnlyHousing,
                                                                          PercentMenOnlyHousing, PercentFratHousing,
                                                                          PercentSororityHousing, PercentSingleStudentAppartment,
                                                                          PercentMarriedStudentAppartment, PercentInternationalStudentHousing,
                                                                          PercentOtherHousing)
        )
        
        
        output$after_graduation_table = renderTable(
                
                DT %>% filter(SchoolName == input$school_name) %>% select(GradRate3Y, GradRate4Y, GradRate6Y,
                                                                          salary_10_year, maj_rel_job_6month, maj_rel_job_12month,
                                                                          GradSchoolList, FirmList, NotableAlumni,
                                                                          GradMBA, GradLaw, GradMedical, GradDental, GradEngineering,
                                                                          GradTheology, GradEducation, GradArtsSciences,
                                                                          GradVeterinary)
                
        )
        
}
