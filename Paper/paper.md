---
title: 'Delta Design Game (DDG): An interactive MATLAB tool to collect configuration-design data'
tags:
  - MATLAB
  - Delta Design Game
  - Design Thinking
  - Graphical User Interface
  - Design Cognition
authors:
  - name: Manoj Malviya
    orcid: 0000-0003-0872-7098
    affiliation: 1
  - name: Dr Christopher McComb
    affiliation: 2
  - name: Dr Catherine Berdanier^
    affiliation: 3
affiliations:
 - name: Graduate Research Assistant, Department of Mechanical Engineering, The Pennsylvania State University, University Park, PA, USA
   index: 1
 - name: Assistant Professor, Engineering Design, The Pennsylvania State University, University Park, PA, USA
   index: 2
 - name: Assistant Professor, Department of Mechanical Engineering, The Pennsylvania State University, University Park, PA, USA
   index: 3
date: 13 October 2020
bibliography: paper.bib

---
# Summary

Studying human design heuristics in a configuration occasionally are conducted through interactive digits tools [@McComb:2017], [@McComb:2015]. However, these tools are based on known problems to designers such as truss design and heat transfer design. In contrast, we present an interactive design tool based on a skewed design problem called Delta-Design Game (DDG). Delta-Design is a fictional design game developed by Bucciarelli [@Bucciarelli:1991], to teach students the social designing skills such as communications, trade-offs, and team-dynamics. 

This game consists of a well-defined configuration design problem, but on a skewed physics system. Due to this anomaly in world, this makes it challenging for designers to apply existing domain knowledge and design heuristics. However, the objectives in the design problem are identical to typical configuration design problems, therefore, making it a research tool suitable for studying designing for structurally similar novel problem. More information on the problem statement can be found in the software documentation and [@Michelle:2012]. 

Previously, Oberio [@Oberoi:2013] has implemented an online version of the game focused on studying the social aspect of design by recording the communication between team members. In contrast, we focused on providing authentic individual design experience with real-time feedback to designers, and thus, differing from the online version presented in [5]. This GUI tool is programmed using MATLAB App Designer [@Mathworks:2020], and can be used using latest version of MATLAB. 

The digitization of the DDG tool offers the design thinking research community a new way to investigate novel problem-solving skillsets in engineering design and offers a host of new methods by which to analyze behavioral data over the course of a design challenge [@Mehta:2020] [@Malviya:2020]. Being written in such a high-level language that is MATLAB allows an easier understanding of the DDG tool while also giving an opportunity to tweak as per the application. Additionally, this tool can also be used in teaching designing for novel structural mechanics problems in undergraduate and graduate classes.

In the presented design tool, we provide adequate features for designers to produce a design within a given time-period. More information about design features are presented in documentation. On the back end, we collect design states as object files, and temporal data of actions as csv file. These data files are stored locally in the main folder, and therefore, protecting the data privacy. DDG tools comes with several examples of designs, found under Examples/, to illustrate the mechanics of data storing and successful designs. An example of such design with DDG interface is presented in Figure 1.

![Figure 1: Example of Successful Design on DDG Tool](https://github.com/mmalviyar/Delta-Design-Tool/blob/master/Files/Picture1.png)

***Figure 1: Example of Successful Design on DDG Tool***


# References





