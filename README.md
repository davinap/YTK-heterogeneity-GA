Data from the growth arrest experiment in 'Promoter selection reduces phenotypic heterogeneity and improves bioproduction' (Patel et al.)

This folder contains the R script 'GA_pchange.R' used to generate Fig. 2. 

Abbreviations within the script:
AF = a-factor treated
exp = exponential phase

Cells were grown and then treated with a-factor or allowed to reach exponential phase. Following flow cytometry, data was cleaned up (see below), and the number of cells in each population (Pop1 and Pop2) were then noted in 'propchange_grouped_23032.csv'. This file was used to calculate significance of AF treatment in the 'GA_pchange.R' script, by performing Welch's t-test between treated and untreated groups. 


Comments within the scripts give further detail.

--------------------------------------------------------------------------------------------------------------
Cleanup in FlowJo to remove doublets and dead cells:

Controls:

- pi = propidium iodide, a dead cell stain
- GFP-/RFP+ = BP-HK = B10, Control strain, heat-killed, with pi
- GFP-/RFP- = BP- = B11, Control strain, no pi
- GFP+/RFP- = 897- = B12, GFP +ve strain, no pi


1) singlets from BP- (B11)
 - change axes to log
 - apply to all in group

2) comp from B10-B12
 - apply to all in group

3) Live/dead gating from BP-HK (B10) by comparing to BP (B9)
 - Live gate made as an offshoot of the singlets gate so 
   it is indented underneath it

4) Drag live gate of sample A1 and sample B9 (-ve control) into the layout
	and select comp bl1-h for the x-axis and histogram for y-axis

5) Set B9 (BY4741 w/PHLM) as control and batch report
	4 columns per row

6) Gate for low-expressing (Pop1) vs high-expressing population (Pop2) in macro-heterogeneous strains

7) Population sizes recorded in 'propchange_grouped_230323.csv'

