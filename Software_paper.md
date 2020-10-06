# Delta Design Game (DDG): An interactive MATLAB tool to collect configuration-design data


## Summary

Studying human design heuristics in a configuration occasionally are conducted through interactive digits tools [1], [2]. However, these tools are based on known problems to designers such as truss design and heat transfer design. In contrast, we present an interactive design tool based on a skewed design problem called Delta-Design Game (DDG). Delta-Design is a fictional design game developed by Bucciarelli [3], to teach students the social designing skills such as communications, trade-offs, and team-dynamics. 

This game consists of a well-defined configuration design problem, but on a skewed physics system. Due to this anomaly in world, this makes it challenging for designers to apply existing domain knowledge and design heuristics. However, the objectives in the design problem are identical to typical configuration design problems, therefore, making it a research tool suitable for studying designing for structurally similar novel problem. More information on the problem statement can be found in the software documentation and [4]. 

Previously, Oberio [5] has implemented an online version of the game focused on studying the social aspect of design by recording the communication between team members. In contrast, we focused on providing authentic individual design experience with real-time feedback to designers, and thus, differing from the online version presented in [5]. This GUI tool is programmed using MATLAB App Designer [6], and can be used using latest version of MATLAB. 

The digitization of the DDG tool offers the design thinking research community a new way to investigate novel problem-solving skillsets in engineering design and offers a host of new methods by which to analyze behavioral data over the course of a design challenge. Being written in such a high-level language that is MATLAB allows an easier understanding of the DDG tool while also giving an opportunity to tweak as per the application. Additionally, this tool can also be used in teaching designing for novel structural mechanics problems in undergraduate and graduate classes.

In the presented design tool, we provide adequate features for designers to produce a design within a given time-period. More information about design features are presented in documentation. On the back end, we collect design states as object files, and temporal data of actions as csv file. These data files are stored locally in the main folder, and therefore, protecting the data privacy. DDG tools comes with several examples of designs, found under Examples/, to illustrate the mechanics of data storing and successful designs. An example of such design with DDG interface is presented in Figure 1.

![Figure 1: Example of Successful Design on DDG Tool](https://github.com/mmalviyar/Delta-Design-Tool/blob/master/Files/Picture1.png)

***Figure 1: Example of Successful Design on DDG Tool***


***References***


[1]	C. McComb, J. Cagan, and K. Kotovsky, “Mining Process Heuristics from Designer Action Data Via Hidden Markov Models,” J. Mech. Des. Trans. ASME, vol. 139, no. 11, pp. 1–12, 2017, doi: 10.1115/1.4037308.

[2]	C. McComb, J. Cagan, and K. Kotovsky, “Rolling with the punches: An examination of team performance in a design task subject to drastic changes,” Des. Stud., vol. 36, no. C, pp. 99–121, 2015, doi: 10.1016/j.destud.2014.10.001.

[3]	L. L. Bucciarelli, “Delta Design Game,” 1991. [Online]. Available: http://ocw.mirror.ac.za/NR/rdonlyres/Aeronautics-and-Astronautics/16-00Introduction-to-Aerospace-Engineering-and-DesignSpring2003/405313D0-C7F9-4AB4-896C-11DD7339F372/0/intro.pdf.

[4]	M. Michelle, M. Grau, S. Univeristy, S. D. Sheppard, M. Samantha, and R. Brunhaver, “Revamping Delta Design for Introductory Me-,” ASEE Annu. Conf. Expo. Conf. Proc. 2012, 2012.

[5]	S. Oberoi, S. Finger, and E. Rosé, “Online Implementation of the Delta Design Game for Analyzing Collaborative Team Practices,” 2013, doi: 10.1115/detc2013-13319.

[6]	Mathworks, “MATLAB APP DESIGNER.” Mathworks, 2020, [Online]. Available: https://www.mathworks.com/products/matlab/app-designer.html.




