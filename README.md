**Welcome to the DDG Tool wiki!**


## Motivation

Studying human design heuristics in a configuration occasionally are conducted through interactive digits tools [1], [2]. However, these tools are based on known problems to designers such as truss design and heat transfer design. In contrast, we present an interactive design tool based on a skewed design problem called Delta-Design Game (DDG). Delta-Design is a fictional design game developed by Bucciarelli [3], to teach students the social designing skills such as communications, trade-offs, and team-dynamics. 
This game consists of a well-defined configuration design problem, but on a skewed physics system. Due to this anomaly in world, this makes it challenging for designers to apply existing domain knowledge and design heuristics. However, the objectives in the design problem are identical to typical configuration design problems, therefore, making it a research tool suitable for studying designing for structurally similar novel problem.


## Delta Design Game Background

The delta design game (DDG) is situated on an imaginary planet called Delta P, which differs in several ways from Earth. Delta P is a planned flat world comprising a two-dimensional space (See Figure 1), in which we challenge the designers to build a residence for the inhabitants of Delta P using red and blue triangles called deltas. These different colored deltas have different properties: red deltas provide heat and blue deltas have a cooling effect. 

In Bucciarelli’s original conception of the DDG, four students, each with a different role, form a design team and are tasked to design a structure which meets the client requirements. Later, Grau and colleagues [6] modified the original game to be more time sensitive and provide a modified set of constraints: First, the design must be thermally stable (no more than two red triangles should be placed close to each other) and aesthetically optimized (where the total number of blue deltas cannot be more than 60% of total deltas and no more than three blue triangles should be placed together). In addition to aesthetics and thermal constraints, there are other geometrical constraints which are also applied in DDG such as minimum door length, minimum internal area, and ratio of inner and outer perimeter. Grau’s modified DDG also operationalized the challenge for students in a structural mechanics class, in which the time to complete the challenge was shortened to an hour.  


![Figure 1: Example of Successful Design on DDG Tool](https://github.com/mmalviyar/Delta-Design-Tool/blob/master/Files/Picture1.png)

***Figure 1: Example of Successful Design on DDG Tool***

## Software Introduction
To facilitate design and data collection, we developed a graphical user interface (GUI) using MATLAB’s App designer [5], as shown in Figure 1. Besides facilitating the virtual design, we also focused on providing a more authentic design environment by embedding client feedback as a feature in the tool. The back end of the GUI tests the design score and satisfaction of constraints in real-time. The GUI also does not allow for impossible design features (for example, overlapping delta triangles). There are nine design actions that can be performed to complete the challenge. We place these actions on three different panels based on their roles. Table 2 explains the specific function of each of the actions in the Compose and Revise sub-panels. All actions performed in the GUI are recorded for later analysis to study design heuristics. There are three message boxes in GUI: Delta World Status, Design Feedback, and Participant Information. The “Delta Status” message box displays the success or an error message corresponding to a designer’s actions. The “Participant Information” box displays the participant number, time left for the study and number of deltas. The “Design Score” message box is an essential feature for making this GUI a real-life experience, providing real-time insight as to the constraints when designs do not meet requirements. 
We also designed a control panel to provide a way to mitigate accidental mistakes. For example, if a designer accidentally deletes a triangle, they can use the UNDO function to return to the previous state. We added a panel at bottom for an overview of design constraints and objective function details. List of available actions are as follows:

* **Add UP Delta**	Adding a red or blue upward delta	
* **Add DOWN Delta** 	Adding a red or blue downward delta	
* **Add Anchor** 	Defining a delta as anchor delta	
* **Move** 	        Move a delta from one location to another	
* **Fine Control** 	Move a delta nearby locations for fine location tuning purposes
* **Color** 	        Change the color of existing delta	
* **Flip** 	        Change the orientation of existing delta	
* **Delete** 	        Delete existing delta or anchors	
* **End Study**	        Ending the study	

## Objective Function Description
As a researcher, you can define you own objective function to evaluate the performance of a designer. As an example we developed a default objective function for evaluating the individual designer's performance as they played the game. The constraints related to the properties of the red and blue deltas and the overarching storyboard of the game remained the same as in []; however, individuals can also complete the challenge in 45 minutes. One of the main objectives for the designer is to achieve a low-cost design with optimum factor of safety (FOS). We defined the maximum cost of residence to be $1500 as per original game rules. We defined the target FOS to be 1.3, which strikes an optimum balance between over-designing and under-designing [6]. A summary of the objectives is presented below:

**Main Objective**

* Cost: Cost of the design should be less than 500
* Strength: Minimum factor of safety of the design should be greater than 1

**Constraints**	
* Thermal: No more than two adjacent red deltas 
* Aesthetics: 
1. No more than three adjacent blue deltas
1. Smoother Exterior and an Angular Interior
1. Total number of blue deltas may not exceed 60% of the total number of deltas
* Spatial	: 
1. Doorway length must be between 5 and 10m
1. Minimum Interior Area of 100 quarter-deltas

To judge and compare the designs of residence by participants analytically, we developed a normalized design score based on FOS and cost, calculated in Equations 1-3. The design score varies from 0 (lowest score) to 1 (highest score), such that if the design does not meet the requirement, the client satisfaction score is zero. The normalized design score is given by

![](http://chart.apis.google.com/chart?cht=tx&chl=g(x)=1-0.5*(F(x)+C(x)))

where the Factor of Safety, F(x), and cost  C(x)  of the design are governed by
 	
![](http://chart.apis.google.com/chart?cht=tx&chl=F(x)=\frac{|f(x)-1.3|}{0.7})

![](http://chart.apis.google.com/chart?cht=tx&chl=F(x)=\frac{|c(x)-700|}{800})

In these equations, x represents the design generated by designer, c(x) is the cost of the design and f(x) is factor of safety. Factor of safety represents the strength of residence and is mainly depended on topology of structure and position of anchors, whereas cost of the residence is depended on number of red and blue deltas and adjacent connections between deltas. We also suggest to explore other objective functions such as cost to strength ratio and number of triangles to strength.

## Installation
DDG tool can be accessed directly without installing but will need access to MATLAB 2019 or higher.

## Usage
**DDG Tool GUI**
We mainly programmed the DDG tool using MATLAB App designer and supporting modules with object oriented programming. DDG tool works with MATLAB 2019 or higher with App designer functionality and can be accessed via Opener.mlapp in the package. This would open up a prompt window asking for participant number (Figure 2a). After entering the participant number, designer can access to the program and sketch their design with real-time performance evaluation (Figure 2b).





**DDG Tool data collection**
The sequential data is stored as series of object files after each events. This files are named as per convention:- XState_A.mat, where X is the participant number and A is the action number at given point of design. In addition, the DDG tool store the time and action log as table (Xactiondata.mat). Using collected data, a researcher can use a variety of sequential learning algorithms and statistics to extract design heuristics.



## Examples
A successful demonstration of the DDG tool in a research is presented in [7]. Additionally successfully designs are also provided in Examples folder (To access, copy all the files into main folder and run the program with participant number 51).

## Community Guidelines


## References
[1]	C. McComb, J. Cagan, and K. Kotovsky, “Mining Process Heuristics from Designer Action Data Via Hidden Markov Models,” J. Mech. Des. Trans. ASME, vol. 139, no. 11, pp. 1–12, 2017, doi: 10.1115/1.4037308.

[2]	C. McComb, J. Cagan, and K. Kotovsky, “Rolling with the punches: An examination of team performance in a design task subject to drastic changes,” Des. Stud., vol. 36, no. C, pp. 99–121, 2015, doi: 10.1016/j.destud.2014.10.001.

[3]	L. L. Bucciarelli, “Delta Design Game,” 1991. [Online]. Available: http://ocw.mirror.ac.za/NR/rdonlyres/Aeronautics-and-Astronautics/16-00 Introduction-to-Aerospace-Engineering-and-DesignSpring2003/405313D0-C7F9-4AB4-896C-11DD7339F372/0/intro.pdf.

[4]	S. Oberoi, S. Finger, and E. Rosé, “Online Implementation of the Delta Design Game for Analyzing Collaborative Team Practices,” 2013, doi: 10.1115/detc2013-13319.

[5]	Mathworks, “MATLAB APP DESIGNER.” Mathworks, 2019, [Online]. Available: https://www.mathworks.com/products/matlab/app-designer.html.

[6]	G. Michelle, S. Sheppard, and S. R. Brunhaver, “Revamping Delta Design for Introductory Mechanics,” 2012.

[7]    M. Malviya, “Characterizing Implicit Cognitive Process across Engineering Design contexts using Machine Learning,” The Pennsylvania State University, 2020.



