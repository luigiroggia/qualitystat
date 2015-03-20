---
title       : Control Charts & Capability Analysis
subtitle    : Simulate your process
author      : Luigi Roggia - luigi.roggia@kiwidatascience.com
job         : Data Scientist
framework   : io2012       # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
url:
        lib: libraries
        assets: assets
logo: logo.png
---

## Introducing the subject

<p style="color:#669999">Well, suppose you have an industrial process</p>

<ul>
<li>What you need is your process being focused on some desired mean value</li>

<li>You do not want any special cause introducing variability other than the natural one</li>

<li>Also, your customers ask you to quantify how much capable you are to satify their specifications</li>
</ul>

<p style="color:#669999">
A simple example: you process is filling water bottles, you have a historical mean of 750 ml with a standard deviation of 2.5 ml 
</p>

<ul>
<li>
You want to detect any unusual deviation from these values, so that your process is under statistical control</li>

<li>
Your customer wants you to quantify your capability of filling bottles with a target value of 750, a lower specification limit of 745 and an upper specification limit of 755
</li>
</ul>


--- .class #id 

## How to face the problem

<p style="color:#669999">
In quality statistics you will find all the kinds of tools you need to control and quantify:
</p>

<ul>
<li><i>Control charts</i> help you detecting unusual deviation from natural variability</li>
<li><i>Capability analysis</i> let you quantify how much your process is capabale
</ul>



```r
# Example code
library(qcc)
Data<-rnorm(20,mean=3,sd=0.7)

# Create a control chart for single valued samplings
obj<-qcc(Data,type="xbar.one",title="Control Chart for Individual Values",plot="false")

# Create a control chart with subgroups
obj<-qcc(Data,type="xbar",title="Control Chart with Subgroups",sizes=5,plot="false")
```

--- .class #id


## About this project

<p style="color:#669999">
The application developed within the project, does the followings:
</p>

<ul>
<li>You can simulate a dataset from a normal distribution, giving the mean, the standard deviation, the number of samplings and the number of measurements for each sampling</li>

<li>You can give the lower and upper specication limits and a desidered target value for the capability analysis; if not specified, the app will use 3 standard deviations and their midpoint</li>

<li>The app automatically selects the correct control chart/s, based on the AIAG standards</li>

<li>The app runs a capability analysis</li>

<li>You can play around changing any of the above settings in real time and simulate what happens</li> 

--- .class #id

## Understanding samplings and measurements

<p style="color:#669999">
The app lets you specify both <i>number of samplings</i> and <i>measurements per sampling</i>. What does it mean?
<p>

<ul>
<li>Suppose that at 11:00 am and at 5:00 pm you go and get some random samples from your production line, to control them. Ok, these are the <i>samplings</i>; you are having two samplings per day. Suppose you collect data in this way for 20 days, then you will have 20 samplings </li>

<li>Suppose that any time you go for one of the above samplings, you collect 5 random items and then yoi check them; well, these are the measurements per sampling. In our example you will collect a total of 20*5 measures</li>

</ul>

<p style="color:#669999">
The number of measurements per sampling, also called subgroup size, is critical in order to select the correct control chart, according to the standards.
</p>
--- 


