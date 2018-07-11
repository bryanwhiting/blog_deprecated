---
title: How to Fail Getting a Data Science Job
author: ~
date: '2018-07-11'
slug: how-to-fail-getting-a-data-science-job
categories: ['data science']
tags: ['recruiting', 'life lessons']
---

Last March, I wanted to break into the Data Science community but was struggling with confidence and starting to doubt I'd make it. I had been reading blog after blog about data science, practiced additional coding and learning new methods at night. And rejection after rejection, I wondered if I was on the right path. Now on the other side,  hindsight is 20/20.

I write this post to my past self, a person seeking for a job they couldn't seem to get.

## The Crucial Epiphony

It's a few years ago. I'm a college student with high hopes for the world. I anticipate, perhaps naively, that the world can't wait to hire me. I've got a good education, I'm smart, and I work hard. _Perhaps I should just start a 'waiting list' and have people apply to me?_ No, I'm not arrogant[^9], but I think as many college applicants do; I feel a degree of entitlement. After all, four years of hard work and success in college deserves the job, no? I have yet to learn that getting the what I want is _hard_.

[^9]: (If I do say so myself.)

I get to the final round of two top tech companies. One flies me out, suggests they'll offer me a job, but finds they don't have space. Another says that I have all the skills, though just lack 'confidence'. _What does that even mean?_, I wonder. I move on and I'm fortunate to land a good job in economics and data analytics and meet some great people. But after a time, I sense that I want to be applying the skills I worked hard for in school. 

I read [blog](https://medium.com/@datalab/how-to-break-into-the-data-science-market-f0e0b79b42f7), after [blog](http://brohrer.github.io/get_data_science_job.html), after [blog](https://tdhopper.com/blog/faq/) on how to get a job in the data science field. Past rejections are my foundation, but I'm a new person now. I get interviewed by more tech companies. I get more rejections. And I start thinking _perhaps I'm not getting the 'job title' I want because I'm not qualified. Perhaps I should pursue another discipline._ In time, I come to learn two key lessons. 

First, there are three sources of bias in the data science recruiting world:

1. Every company has a different perception of a data scientist.
2. Within each company, there are different definitions of a data scientist.
3. Recruiters have a different perception of a data scientist than the data scientist hiring managers.

These biases interact and create a hot mess, which leads to the second lesson, the crucial epiphony: 

> Find the data science job that **you** want to be interviewed for.

Though simple, this lesson is governed by a recruiting 'truth': the hiring process reveals what an employer is looking for. And if they're not testing you on what _you_ want to be tested on, take note. 

After 16 rejections (over the two application periods), I eventually land the job at a top tech company. I feel elated. Looking back, I see that some of the rejections were because I wasn't qualified. Others, because they were testing me for positions similar to, though not _quite_ reflective of, the skills I was proficient in. But the final round of interviews wiped that all away. I felt that this was the job interview I had been preparing for and was grateful to have found it. 

And once I'm in, I learn something new. It's not the _job title_ or the _company_ that matter to me. It's the (1) impact I'm having, (2) stuff I'm doing, (3) problems I'm solving, and (4) people I work with that bring daily satisfaction. No, no company is perfect, and no, no job is perfect. But I'm happy where I've landed and look forward to additional opportunities here.

I don't write this to boast. I also don't imply that a data science job is 'making it'. I write because I'm sensitive to the fact that you might not have found a job you're happy with. But you can. And I argue you _should_ pursue that job. You'll find it. And when you're on failure 16, perhaps you're feeling like Vitas Gerulaitis after losing that many times to Jimmy Connors. But remember [his victory statement](http://www.tennis.com/pro-game/2012/08/playing-ball-losing-them-all/37791/) after winning the 17th game:

> Nobody beats Vitas Gerulaitis 17 times in a row.

So let's dive in to some of the other lessons I learn along the way. Because getting a data science job has some unique quirks about it that need to be addressed.

## Discern what's being recruited

Every prospective data scientist (and job seeker) should be _extremely_ careful in their recruiting, to the point that they know exactly who's hiring them and why. 

The term Data Scientist is as general as saying 'Engineer'. If you're an engineer, are you a chemical, mechanical, civil, software, or a [maintence engineer](https://www.indeed.com/jobs?q=maintenance+engineer&l=90210)? Perhaps, you're a data engineer? And if you're a data engineer, are you just a data scientist at some other company? 

You've probably heard that there are a  [few](https://www.datasciencecentral.com/profiles/blogs/six-categories-of-data-scientists), [different](https://www.datasciencecentral.com/profiles/blogs/difference-between-machine-learning-data-science-ai-deep-learning), [types](https://www.dezyre.com/article/10-different-types-of-data-scientists/179) of a data scientist:

> statistician, economist (macroeconomic data), economist (microeconomic data), mathematician, data engineers, machine learning scientists, artificial intelligence (neural networks, reinforcement learning), actuarial scientist (risk), business analytic practitioners, software programming analysts, spatial data scientist (maps), interactive data visualization specialist, digital analytic consultant, quality analyst.

Though they all work with numbers and data, all of these job titles have completely different job duties and each require years of specialization. Yet, for now, all you'll see on job descriptions is 'data scientist'. And unfortunately, some companies think that if you're a data scientist you can do all of them!

Until the industry hype dies down and refines its definitions for data scientist, it's essential that (1) you define for yourself what your skillset is and (2) you clarify with the hiring managers that the skillset you have for is the skillset they value. To save time, do this upfront. Use the recruiting process to narrow the gap between what you want to be doing and what your employer wants you to do.

## Why I failed so many times

Each rejection brought valuable learnings. I'll share with you why I think I failed my previous interviews (with important takeaways in the footnotes):

1. In the coding portion of the interview, I didn't manipulate the data in the way they were expecting[^1]. 
2. I failed to maximize the efficiency of my for loop[^2]. 
3. It was decided that I would probably be better at a program manager position than a data scientist[^3].
4. I had no idea how to back out the efficient sample size necessary to detect a significant difference between A/B test populations[^4].
5. And after a final-round rejection, I followed up. I was told that I had all of the technical skills, but could work on my _confidence_.
6. A recruiter looked at my resume and told me I didn't have enough 'open-source' experience[^6]. (Check out the foonote.)

Recruiting is _very_ [hard to get right](https://steve-yegge.blogspot.com/2008/03/get-that-job-at-google.html). The important takeaway is not to take it personally if you get rejected. Sometimes rejection is a good thing. 

[^1]: I tried reshaping data rather than split-apply-combine. This may seem minor, but when you get stuck in an interiew there can be an awkward moment where you try to do it one way and the recruiter might not know your approach. If they can't guide you, you appear incompetant. This can often happen if I have an R background and my recruiter comes from a SQL background.
[^2]: Despite realizing 10 minutes after the interview my error and emailing the recruiter the true solution. This highlights a key point: are you looking for a software engineer, a data manipulator, or a statistician? 
[^3]: I feel like this happened because I was being quizzed by many computer scientists-turned-data scientists. I was asked a lot of machine learning questsions that I couldn't answer, yet I knew a ton of regression and statistical knowledge. So at the same time I made it to the final round of a separate tech company for knowing a ton of stats, I failed this interview for not knowing my machine learning well enough. The advice would be: own what you know. If you don't know machine learning, talk stats. But don't try talking machine learning just because you think that's what they want. _You_ can guide the interviewer to what you want to talk about.
[^4]: After the interview, I realized this was a simple t-test that I could have googled stack overflow for. But I'm sure they were looking for someone more immediately proficient in those techniques, which I was not. 
[^5]: You know how interviewers 'like to hear how you think' while trying to solve a problem. Although I arrived at the correct answers, perhaps I was a bit waffly in my attempts to explain my reasoning. I don't have any advice yet on this one. Try again?
[^6]: I reviewed my resume and I had five references to R, three to Python, and _one_ to SAS, a few to Stata, Matlab, etc. Of course, SAS stands out visually beause it has three capital letters over one: `R`. There are some lessons here: 1) your recruiter might think there's a difference between a forecast and a prediction, or a random forest and a decision tree. 2) Perhaps it's better to generalize your technique so recruiters can understand it, and the specify your technique so data scientists hiring managers can comprehend. E.g.: I specialize in decision tree methods (GBMs). 3) Only put on your resume things you want to do in your job.

## My type of data scientist

Among the many types of data scientist out there, here's how I might define the type of work I do at Capital One. On a high level, I do the following:

> Build a machine learning model that solves a strategic business initiative and impacts millions of customers.

More specifically, here's what my day-to-day looks like:

1. Build a data-processing pipeline. I write PySpark queries to query from an [RDBMS](https://en.wikipedia.org/wiki/Relational_database_management_system), clean, append and join, nine different data sources. (One of those data sources are 2 billion rows, others are less. After cleaning and compressing, it's around 600GB of data.)
1. Plot data, explore data. Work with real-time data.
1. Create AWS EMR/EC2 environments to pull data from Redshift/S3 into the data engineering pipeline.
1. Build models like logistic regressions and decision trees (Gradient Boosted Machines and AutoML using [H2O in python](http://docs.h2o.ai/h2o/latest-stable/h2o-docs/data-science/gbm.html)).
1. Build internal python packages and tools that do the above.
1. Build unit tests, sanity checks, and loggers to ensure the quality of the data pipeline.
1. Work directly with business partners to ensure the model satistfies the business intent.
1. Work side-by-side with tech teams (software engineers) to implement the solutions my team identifies.
1. Present to coworkers new innovations, methods, and processes my team develops.


It's a nice blend between data analytics, machine learning, statistics, and software engineering. And the colleagues around me are working on equally-challenging work. Whether they're doing supervised or unsupervised learning, doing matching algorithms, creating risk models, they're all working with data, building models, and solving strategic initiatives. But I wouldn't be surprised if they had their own definition for a data scientist. 

More importantly, here are my 'big three' for a happy job:

1. Work on challenging problems (put me on the moonshot)
2. Build data products (models, visualizations, dashboards, tools, etc.)
3. Work with collaborative, amiable colleages

Being able to satisfy (2) requires the company you work for have a strong 'data-driven' culture. They're out there. Find one!

## Get that Job!

What's your definition of a data scientist? What skills do you have to prove that? If you don't have the skills, work hard to get them. If you have them, be confident in what you have to offer and work hard to find the recruiters looking for you. They're out there.

So remember: discern the bias, know your skillset, and find the data science job that you want to be hired for. 

> Lastly, if you're a data scientist looking for new opportunities, please reach out to me! 
