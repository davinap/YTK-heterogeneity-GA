This folder contains the FlowJo workspace (.wsp file), the method of analysis in FlowJo to determine the number of cells in Pop1 and Pop2 ('230323_flow_analysis'), and the resulting plots (.svg files).
It also contains the script used to run Welch's t-tests between the treated and untreated groups - 'GA_pchange.R'

The GA_flow_files folder contains the .fcs files used in the FlowJo workspace. 
rep1 = Rows A and B, Row A was AF treated
rep2 = Rows C and D, Row C was AF treated
rep3 = Rows E and F, Row E was AF treated
pop1 = low-expressing population
pop2 = high-expressing population

The layout of strains can be found in the layout file under GA_growth_curves>230323_layout.csv

GA_all_plots = An overlay of all samples' sfGFP expression levels. 
GA_gating = Gating strategy before determining sfGFP expression levels and population gating
GA_pops = Plots representing how gates were drawn for Pop1 and Pop2. The number of cells in each populations were then noted in 'propchange_grouped_23032.csv'. This file was used to calculate significance of AF treatment in the 'GA_pchange.R' script. 

