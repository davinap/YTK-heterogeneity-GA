setwd("C:/Users/davin/Documents/PhD/Writing/Heterogeneity/Supp_Data/YTK_growth_arrest/GA_flow/")

library(tidyverse)
library(gtools)
library(reshape2)
library(diptest)
library(diveRsity)
library(gridExtra)
library(openxlsx)
library(readxl)
library(fitdistrplus)
library(flexmix)
library(tictoc)
library(plotrix)
library(extrafont)
library(grafify)
library(directlabels)




gt <- read.csv("propchange_grouped_230323.csv", header = TRUE) #read in pop1 and pop2 replicate data
gt2 <- gt %>% group_by(Promoter, Group) %>% summarise_all(mean) #good, summary of mean for all replicates, treated and untreated
gt3 <- melt(gt2)
gt4 <- melt(gt)

#calculate mean and standard error for pop1 and pop2 for all promoters in treated and untreated groups
df_summary <- gt4 %>% group_by(Promoter, Group, variable) %>% summarise(mean=mean(value),
                                                          se = sd(value)/sqrt(n()))

proms <- c("HHF2","HHF1","HTB2","RNR1") #heterogeneous promoters tested
treatment <- c("exp","AF") #treatment groups: exponential phase and a-factor treated
df_summary$Promoter<-factor(df_summary$Promoter, levels=proms) #reorder promoters to order in 'proms'
df_summary$Group <- factor(df_summary$Group, treatment) #reorder group column to order in 'treatment'
df_summary$Group <- relevel(df_summary$Group, "Untreated") #reorder Group to have 'untreated' first


#aesthetics for ggplot
tbar<-theme(axis.text.x = element_text(family="Calibri Light", size=12, vjust=6),
            axis.title.y = element_text(family="Calibri Light", size=12, vjust=2),
            axis.title.x = element_text(family="Calibri Light", size=12, vjust=2),
            axis.text.y = element_text(family="Calibri Light", size=11),
            legend.text = element_text(family="Calibri Light", size=10.5),
            legend.title = element_text(family="Calibri Light", size=10.5),
            panel.grid.minor.y = element_blank(),
            panel.grid.minor.x=element_blank(),
            panel.grid.major.x=element_blank())



#this one - turquoise brown
ggplot(df_summary, aes(x = Promoter, y = mean, fill = variable, group = interaction(Group, variable), colour=variable)) +
  geom_bar(position = position_dodge(0.8), width = 0.8, stat = "identity", alpha=0.5, size=0.72) +
  ## scale_fill_manual(values = c("Pop1" = "red", "Pop2" = "blue")) +
  geom_text(aes(label = Group), position = position_dodge(width = 0.8), vjust=-1.9, family="Calibri", size=3.7, fontface="bold") +
  geom_errorbar(aes(ymin = mean-se, ymax = mean+se), 
                position = position_dodge(width = 0.8), 
                width = 0.2) +
  labs(x = "Promoter", y = "Proportion of cells in population", fill = "Population")+
  theme_minimal() +
  scale_y_continuous(limits = c(0,100), breaks = seq(0,100,10)) +
  scale_fill_manual(values=c("#1B9E77","#A6761D")) +
  scale_colour_manual(values=c("#1B9E77","#A6761D")) +
  guides(colour=FALSE) + #gets rid of legend which has colour of each bar chart
  tbar




####Welch's t-test####
#t-tests between treated (AF) and untreated (exp) groups#
#https://www.datanovia.com/en/lessons/types-of-t-test/unpaired-t-test/welch-t-test/
library(rstatix)

View(gt4)

#for pop1 - filter out pop1 from variable column
p1 <- gt4 %>% filter(str_detect(variable, "Pop1")) #good
p2 <- gt4 %>% filter(str_detect(variable, "Pop2")) #for Pop2


View(p1) #Population 1 in all replicates
View(p2) #Population 2 in all replicates


#visualise
bxp1 <- ggboxplot(
  p1, x = "Group", y = "value", 
  ylab = "value", xlab = "Group", add = "jitter", title = "pop1")

bxp1 #good


bxp2 <- ggboxplot(
  p2, x = "Group", y = "value", 
  ylab = "value", xlab = "Group", add = "jitter", title = "pop2")

bxp2 #good


#t-test population 1, untreated vs AF treated
head(gt4)
test1 <- p1 %>% t_test(value ~ Group) %>% add_significance()
test1 #p = 0.000000382 ****  

test2 <- p2 %>% t_test(value ~ Group) %>% add_significance()
test2 #p=0.000000382 ****


