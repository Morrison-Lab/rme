# Syllabus

Code

Published

Last modified: 2026-11-11: 19:41:22 (UTC)

> **NOTE:**
>
> This document is the syllabus for the **Spring 2026** offering of Epi 204. All details are subject to change during the quarter; the authoritative, continuously-updated version is posted on [Canvas](https://canvas.ucdavis.edu/courses/1077308).

[TABLE]

# 1 Course Overview

[TABLE]

# 2 Details

## 2.1 Course Content

This course is an introduction to advanced regression methods for epidemiological research. The first part of the course will focus on generalizations of linear regression to binary data (logistic regression) and count data (Poisson regression). The second part of the course will focus on time-to-event data (survival analysis). We will look at the theoretical underpinnings of the models, but the main emphasis will be on formulating models, fitting models to data, and interpreting results. If time permits, we will also briefly discuss ordinal regression.

The [schedule of class sessions and a tentative list of specific topics](https://canvas.ucdavis.edu/courses/1077308/files/folder/Logistics) is available on Canvas (and reproduced on the [Schedule](../chapters/schedule.llms.md) page). It will be updated regularly as the course progresses.

### 2.1.1 Learning Objectives/Topics Overview

Upon completing the class, students are expected to be able to:

- Perform regression analysis procedures for modeling covariate‐outcome relationships, including:

  - Maximum likelihood inference for one homogenous sample (weeks 1-2)

  - Linear regression for continuous outcomes (weeks 2-3)

  - Logistic regression for binary outcomes (weeks 4-5)

  - Poisson regression for count outcomes (week 7)

  - Survival analysis for time‐to‐event outcomes (week 7-9)

- Appropriately apply these statistical methods to real-world data.

- Interpret the results of applying these statistical methods to data.

- Produce clearly written data analysis reports detailing:

  - Introduction

    - scientific questions

    - scientific hypotheses

  - Methods

    - study design

    - data structure

    - analytic assumptions

    - statistical methods

  - Results

    - statistical results

  - Discussion

    - interpretation of results

    - limitations of analyses

    - scientific conclusions

### 2.1.2 Prerequisites

The required prerequisites for this class are all of the following:

- EPI 203 (Mathematical statistical inference)

- EPI 205 (Principles of epidemiology)

- STA 108 (Linear regression models)

- Instructor’s consent.

Additional recommended prior coursework:

- Introduction to Statistical Programming in R: STA 015B, STA 032, STA 035A-B, STA 141A, ENV/ECL 224, or BIS 015L

## 2.2 Class Format

This course will be taught entirely in-person. The class sessions will not be digitally streamed or recorded. Class sessions will include a mix of lectures and interactive data analysis exercises.

### 2.2.1 Participation

Active participation in class is strongly encouraged. Please feel welcome to interrupt class frequently to ask questions or to ask us to slow down or repeat details that you missed.

The class scratch notebook is shared with course participants on Canvas (the link is restricted to enrolled students).

### 2.2.2 Schedule

This class will meet Tuesdays and Thursdays, 2:10pm–4:00pm, in Gladys Valley Hall (<https://campusmap.ucdavis.edu/?b=178>) room 1010, starting March 31, 2026, and concluding June 4, 2026. The preliminary schedule of class session topics is on the [Schedule](../chapters/schedule.llms.md) page and on [Canvas](https://canvas.ucdavis.edu/courses/1077308/files/folder/Logistics).

### 2.2.3 Attendance

Attendance is not tracked or graded but is strongly recommended. However, **do not attend class if you think you might be infectious**. If you miss class, please review the lecture materials posted online, confer with your classmates, and feel free to contact the instructor to schedule a meeting if helpful.

### 2.2.4 Equipment

You will need to bring a laptop (Mac, Windows, or Linux) to class every day in order to participate in the data analysis exercises. Laptops can be borrowed from the library: <https://lsit.ucdavis.edu/request-loaner-equipment>

### 2.2.5 Software

The applied data analysis exercises in class will use the R programming language, which is free to download at <https://cran.r-project.org/>. R is a very popular option for data analysis; you can find jobs for R users here: <https://www.r-users.com/>. We will also use the RStudio integrated development environment, which is free to download at <https://posit.co/download/rstudio-desktop/>. Please try to install both of these programs prior to the second day of class (Thursday, April 4).

As an alternative to installing software, you may choose to use the cloud computing service [Posit Cloud](https://posit.cloud/); you can sign up for the Free plan and join the workspace for this course (join link available on Canvas), which will provide access to additional compute hours for the duration of this course. We can help you with any installation or sign-up issues during the first week of class or during office hours.

For homework, you are strongly encouraged to use the R programming skills taught in class. If you would prefer to use another programming language, you may do so, but the instructor and TA may not be able to guide you as effectively.

## 2.3 Homework

There will be five graded homework assignments, as well as additional ungraded exercises and readings. Each homework assignment is worth 5% of your final grade (25% cumulative). The homework assignments are always due at 5pm Pacific (see [schedule](https://canvas.ucdavis.edu/courses/1077308/files/folder/Logistics)); see the Late Work policy in [Section 2.3.2](#sec-late-work).

### 2.3.1 Homework Submission Format

Homework submissions **must** be **typed** and **submitted digitally** as a **PDF** [on Canvas](https://canvas.ucdavis.edu/courses/1077308/assignments). Regardless of whether you compose your submission in Quarto, RMarkdown, MS Word, Google Docs, or any other system, you must convert it to PDF before submitting. Doing so minimizes the chance that your submission will look different to us than it does to you.

Homework solutions should use a journal article or technical report format. Tables and figures should have numbers and captions, and their source and interpretation should be explained in the main text of your homework solution. Raw, uninterpreted software output is not acceptable; please see in-class exercise solutions for examples.

Reports must have sufficient documentation to meet “reproducible research” standards. We will introduce these standards in class. We encourage using the Quarto system (<https://quarto.org/docs/get-started/hello/rstudio.html>) to generate reports; this system will be taught in class.

### 2.3.2 Late Work

Requests for extensions due to foreseeable issues should be submitted at least 24 hours prior to the due date (i.e., by 5pm Pacific time, one day before the due date).

Unless otherwise noted, every assignment has an automatic **24-hour, no-questions-asked extension, which will be programmed into Canvas by allowing submissions without penalty for 24 hours after the due date.** However, this course moves very quickly, and you should aim to submit assignments on time.

If you have not submitted your homework by the extended deadline, you are still encouraged to complete the assignments in order to learn the material.

### 2.3.3 Collaboration

We strongly encourage you to study together and discuss homework problems. You are also encouraged to share questions and answers on [Canvas Discussions](https://canvas.ucdavis.edu/courses/1077308/discussion_topics). However, you must list your collaborators at the top of your submissions, and you must write up your final homework answers individually to make sure you are learning the material. Do not turn in work that is identical to any other student’s work.

### 2.3.4 Artificial Intelligence

You may use AI assistance if helpful (e.g., ChatGPT), but you are ultimately responsible for the quality of your submitted work. Please keep in mind that you will not have computer access during the exams!

### 2.3.5 Homework Grading

After each homework submission deadline, solutions will be posted. **You are encouraged to self-grade your homework assignments** **using the posted solutions.** Accurately self-grading each homework is 1% of your grade (5% cumulative).

The instructor and TA will spot-check your self-grading, and you are encouraged to ask for help with self-grading during office hours.

Your self-graded homework solutions are due on Canvas at 5pm, 1 week after the solutions are provided. **Self-grading should include specific, detailed annotations on each sub-problem marking where you made mistakes, what your mistake was, and what a correct answer would have been. In other words, give yourself the feedback that you think an ideal TA would give.** Handwritten self-grading annotations are acceptable.

Self-grading serves multiple purposes:

- It enables the TA and instructor to spend more time on office hours and course preparation.

- It motivates the students to learn from their mistakes.

You are also welcome to opt out of self-grading, in whole or in part. If you do not complete your self-grading for an assignment by the corresponding deadline, we will assume that you want us to grade it for you, but we would be grateful for explicit notification when you decide not to self-grade, which might enable us to provide feedback sooner.

**All questions and objections to grading by the instructor and TA must be submitted in writing on Canvas.**

### 2.3.6 Expected Study Workload

See <https://academicsenate.ucdavis.edu/committees/courses-of-instruction/policies-procedures#Credit>:

> “At UC Davis, units of credit are assigned to courses based on the "Carnegie rule" which specifies **one unit of credit for three hours of work** by the student **per week**. Usually this involves one hour of lecture or discussion led by the instructor and two hours of outside preparation by the student.”

Epi 204 is a four-unit course, so you should plan to **spend up to eight hours per week studying outside of class time**. Please actively manage and track your time.

**If you find yourself spending more than eight hours per week on this course**, please contact the instructor and TA to discuss how we can help you become more efficient and effective in the course.

**Please track the time you spend on this course.** Accurately tracking your time is an important habit to build for your career. If you have concerns about the workload for this course, we are glad to discuss them with you, and our first question will be, “how much time have you spent on this course per week, and how much time are you spending on each task (reading, problem-solving, typesetting homeworks, etc)?” Ezra uses <https://toggl.com/> to track his time; you should use whatever system works best for you.

## 2.4 Exams

This course is part of the core curriculum for the Epidemiology MS and PhD programs, and the Epidemiology doctoral pre-qualifying written exam (PQE) will cover this course’s content. In order to prepare the PhD students for the PQE, this course will include two in-class midterm exams and an in-person final exam (Tuesday, June 9, 10:30 a.m. – 12:30 p.m.), each containing questions similar to those on the PQE.

**Note sheets are not allowed for these exams.**

**Any calculator allowed for the SAT is allowed for the exams.**

Each midterm is worth 35% of the course grade.

**The final exam is entirely optional**. If your grade on the final is higher than the average of your two midterm grades, your final grade will be used to replace both of your midterm grades. The final exam is intended as an extra chance to demonstrate your mastery of the course material, and it can only improve your grade. **If you are satisfied with your grade prior to the final, you are welcome to skip it entirely; doing so will not affect your course grade.**

Epi 204 is a graduate-level course, and we expect you to be **self-motivated** to learn this material, as you will need to use it for qualifying exams, your dissertations, and the rest of your careers.

## 2.5 Instructor Feedback

I encourage you to send us anonymous feedback and requests about changes to the class at any time through [Google Forms](https://forms.gle/uHczdp4aSkRKpnCC6). Feel free to be blunt!

Non-anonymous feedback is also always welcome through [Canvas](https://canvas.ucdavis.edu/conversations) or in person, and I'm planning to do a formal mid-quarter evaluation with some specific questions.

## 2.6 End-Quarter Course Evaluations

Please complete the end-of-quarter [course evaluations](https://eval.ucdavis.edu/) for both the Instructor and TA. Teaching Evaluations are an important part of our portfolios for [job applications](https://epiresearch.org/membership/ser-careers/) and [promotions](https://caes.ucdavis.edu/node/4776). The **deadline** for these evaluations is **before** **finals week**; please don’t miss it!

## 2.7 Instructor E-mail Policy

- **Course-related questions sent via e-mail will be ignored without warning.**

&nbsp;

- Please use [Canvas Discussions](https://canvas.ucdavis.edu/courses/1077308/discussion_topics) for course questions. We will monitor this discussion board during business hours M-F and respond within one business day in most cases.

- Please use [Canvas Inbox](https://canvas.ucdavis.edu/conversations) for questions with sensitive personal content.

## 2.8 Texts

The listed course textbooks are **optional**; we will **not** follow them closely, and the primary content will be the lectures and corresponding notes (<https://morrison-lab.github.io/rme/> with additional files on Canvas).

- The material in the first half of the course relies heavily on *An Introduction to Generalized Linear Models*, 4th ed. (2018), by Dobson, Annette J, and Adrian G Barnett (CRC press: <https://doi.org/10.1201/9781315182780>). Dobson and Barnett’s text is a classic textbook for GLMs; you’ll see its datasets used as examples in the R documentation for \`glm()\` and \`lm()\`, and the book itself provides R code for many of its examples. The UCLA biostatistics MS core course on GLMs (Biostat 200C) used this book when I was there.\
  \
  Book self-description: “The original purpose of the book was to present a unified theoretical and conceptual framework for statistical modelling in a way that was accessible to undergraduate students and researchers in other fields.”

- Another classic textbook is Vittinghoff, Eric, David V Glidden, Stephen C Shiboski, and Charles E McCulloch. 2012. *Regression Methods in Biostatistics: Linear, Logistic, Survival, and Repeated Measures Models*. 2nd ed. Springer. <https://doi.org/10.1007/978-1-4614-1353-0>. The UCSF Epidemiology PhD program uses this book; its authors are/were on faculty there. The book provides Stata code instead of R, but I think you can find R code online.

- A more modern textbook for linear, logistic, and Poisson regression is Dunn, Peter K, Gordon K Smyth, et al. 2018. *Generalized Linear Models with Examples in R*. Vol. 53. Springer. <https://doi.org/10.1007/978-1-4419-0118-7>. I’m just getting started on this book, and it looks good so far.

- A more modern textbook for survival analysis models is Moore, Dirk F. 2016. *Applied Survival Analysis Using R*. Vol. 473. Springer. <https://doi.org/10.1007/978-3-319-31245-3>.

- A textbook on generalized linear [mixed models](../chapters/intro-multilevel-models.llms.md#def-mixed-model) is Stroup, Walter W. *Generalized Linear Mixed Models: Modern Concepts, Methods and Applications* (Routledge): <https://www.routledge.com/Generalized-Linear-Mixed-Models-Modern-Concepts-Methods-and-Applications/Stroup/p/book/9781439815120>

The “self-learning” books by Kleinbaum and Klein are less mathematical than this course, but provide lots of helpful practice problems:

- Logistic Regression: A Self-Learning Text (3rd ed.), Kleinbaum & Klein, Springer, 2010: <https://link.springer.com/book/10.1007/978-1-4419-1742-3>

- Survival Analysis: A Self-Learning Text (3rd ed.), Kleinbaum & Klein, Springer, 2012: <https://link.springer.com/book/10.1007/978-1-4419-6646-9>

The textbooks provide additional information and alternative explanations of some of the course content.

See the [Canvas Reading List](https://canvas.ucdavis.edu/courses/1077308/external_tools/10944) page for the full up-to-date list.

Several of the texts can also be downloaded **for free** while on the UC Davis network (or [VPN](https://library.ucdavis.edu/vpn/)), for example using the following links:

- Logistic Regression: A Self-Learning Text (3rd ed.), Kleinbaum & Klein, Springer, 2010: <https://link.springer.com/book/10.1007/978-1-4419-1742-3>

- Survival Analysis: A Self-Learning Text (3rd ed.), Kleinbaum & Klein, Springer, 2012: <https://link.springer.com/book/10.1007/978-1-4419-6646-9>

**Soft-cover copies of Springer texts are also available for \$40** (**cheaper than Amazon**) from the same links through Springer’s MyCopy print-on-demand service; however it may take a few weeks to ship. This service is available for many of Springer’s texts; take advantage of it while you have an academic affiliation.

### 2.8.1 Example Data Sets

The data sets used in the Kleinbaum & Klein textbooks are available on the Canvas page:

- <https://canvas.ucdavis.edu/courses/1077308/files/folder/Data> (let us know if any are missing)

## 2.9 Other Learning Resources

Videos and materials from the 2021 version of this class: <https://dmrocke.ucdavis.edu/Class/EPI204-Spring-2021/EPI204-Spring-2021.html>

Guides to learning R:

- <https://education.rstudio.com/learn/>

- <https://education.rstudio.com/learn/beginner/>

- <https://posit.cloud/learn/primers> Tutorials for basic operations in RStudio

- If you are coming to R from a traditional point-and-click statistics package such as SPSS or SAS, RStudio’s [Thomas Mock](https://twitter.com/thomas_mock) has created a free video webinar titled [A Gentle Introduction to Tidy Statistics In R](https://resources.rstudio.com/webinars/a-gentle-introduction-to-tidy-statistics-in-r). 

- “What They Forgot to Teach You About R”: <https://rstats.wtf/>

- <https://r4ds.had.co.nz/>

- <https://epirhandbook.com/en/>

- <https://www.r4epi.com/>

- <https://data-science-methods.github.io/book/>

- UC Davis DataLab

  - “R Basics: Introduction to Programming for Researchers” videos by Nick Ulle:\
    <https://video.ucdavis.edu/media/R+BasicsA++Introduction+to+Programming+for+Researchers+%284-part+series%29+Part+1+of+4+-+2021-05-18/1_we50mwf1>

  - Intermediate R workshop reader:\
    <https://ucdavisdatalab.github.io/workshop_intermediate_r/>

  - Check out all their workshops here: <https://datalab.ucdavis.edu/workshops/>

Guides to using Quarto:

- “Quarto for Reproducible Medical Manuscripts”, talk by Mine Cetinkaya-Rundel, Professor of the Practice of Statistical Science at Duke University: <https://www.youtube.com/watch?v=NK1onTLcgY4>

A Coursera course on Survival Analysis in R:\
<https://www.coursera.org/learn/survival-analysis-r-public-health>

Another open-source textbook: “**Introduction to Regression Methods for Public Health Using R”:** <https://www.bookdown.org/rwnahhas/RMPH/>

An open-access intro stats textbook with sections on linear and logistic regression:\
<https://openintro-ims.netlify.app/index.html>

[StatQuest with Josh Starmer](https://statquest.org/):\
Step-by-step video tutorials on core statistical and machine learning concepts, including linear models and logistic regression.

[AmstatVideos (American Statistical Association)](https://www.youtube.com/@AmstatVideos):\
Lectures, webinars, and historical interviews with prominent statisticians, including the [Distinguished Statistician series](https://www.youtube.com/watch?v=rSg5e0w8uTE&list=PLKO-pS4OmDhE) featuring Jerzy Neyman.

[Tips for Biostatisticians Collaborating with Non-Biostatistician Medical Researchers](https://hbiostat.org/talks/collab.html#1):\
Frank Harrell’s slide deck on statistical collaboration and consulting (“Your job is not to give the investigator what she wants; Your job is to give her what she needs”).

Carstensen, Bendix, Epidemiology with R (Oxford, 2020; online edn, Oxford Academic, 21 Jan. 2021), <https://doi.org/10.1093/oso/9780198841326.001.0001>

An introduction to machine learning with the Tidymodels package:\
<https://tmv.netlify.app/site/>

An open-access textbook on R programming fundamentals:\
<https://rstudio-education.github.io/hopr/>

An open-access textbook on data wrangling, exploration, and analysis with R:\
<https://stat545.com/>

A UC Davis Ecology Dept. course on data management: <https://gge-ucd.github.io/R-DAVIS/index.html>

Tutorial for RMarkdown: <https://rmarkdown.rstudio.com/lesson-1.html>

How to use Git: <http://www-cs-students.stanford.edu/~blynn/gitmagic/ch01.html>

## 2.10 Self-Care as Students

You deserve respect, and are encouraged to practice self-care so that you can remain focused and engaged; that might mean getting a drink of water, leaving to use the restroom, taking a moment to stretch, or doing something else you need to do to take care of yourself. Please be respectful of others by minimizing distractions when practicing self-care.

College life can be overwhelming at times, but you are not alone if you’re feeling stressed. For many of us, systems of oppression such as racism, sexism, heterosexism or cissexism may cause additional stress. Please remember to practice self-care and reach out for support when you need it.

You can visit the [Aggie Compass Basic Needs Center](https://aggiecompass.ucdavis.edu/) to find resources related to return to campus, health and well-being, academics, basic needs (food and housing) and more.

We also encourage you to explore some of the resources available for graduate students on campus:

- The **GradPathways Institute for Professional Development**: <https://grad.ucdavis.edu/professional-development>

## 2.11 Special Accommodations

If you have a learning disability, sensory or physical disability or if English is not your first language and you need special assistance in lecture, reading assignments, or written assignments, please contact the instructor at the beginning of the quarter. While students are welcome to work with us on accommodations without involving UCD’s Student Disability Center (SDC), we also recommend that you contact the SDC for additional resources and support. The SDC office at the University of California, Davis is located at 54 Cowell Building, or the SDC can be reached by phone at (530) 752-3184. For more information, please see: <https://sdc.ucdavis.edu/>.

There is a graduate student support specialist who can meet with you one-on-one to customize accommodations to your specific needs.

## 2.12 Academic Verification

Students are now required to provide active confirmation that they are enrolled and participating in classes. You can do this through the online website: <https://participate.ucdavis.edu/>. Please do so promptly, as failure to confirm may result in reduction of financial aid or other administrative hassles! 

## 2.13 Academic Conduct

Academic honesty is an important part of the integrity of the University's education. All students are responsible for the academic integrity of the UC Davis campus according to the UC Davis Code of Academic Conduct. This code covers conduct during exams, plagiarism, unauthorized collaboration, misuse of materials, fraud, lying, intimidation or disruption. The full statement can be found [here](https://studentconduct.ucdavis.edu/conduct/policies/student-conduct-and-discipline-interim#102.01.1). See also: [“Suggestions for Avoiding Academic Misconduct”](https://ossja.ucdavis.edu/suggestions-avoiding-academic-misconduct).

You are expected to come to class ready to learn and participate. You are expected to treat your fellow students and the instructors with professional respect, courtesy, sensitivity, and inclusion, in accordance with the UC Davis Principles of Community (<https://excellence.ucdavis.edu/principles-community/>). You should likewise expect and require that the instructors treat you all with professional respect, courtesy, sensitivity, and inclusion.

### 2.13.1 Academic Conduct Specific to Epi 204

Cell phones must be silenced and put away during class. Do not photograph or record instructors or TAs without explicit consent. Do not take pictures of the board or screen; instead, please feel free to ask for more time to handwrite or type up your notes. Taking notes is a crucial practice and skill both for learning and for professional work.

## 2.14 Territory Acknowledgement

Acknowledging territory shows recognition of and respect for Native Americans. It is recognition of their presence both in the past and the present. Recognition and respect are essential elements of establishing healthy, reciprocal relations. These relationships are key to reconciliation, a process to which we are committed.

We would like to respectfully acknowledge that the land on which we gather is traditional unceded Patwin territory. We recognize and respect our role as guests here.

This territory acknowledgement is an adaptation of one written by the Canadian Association of University Teachers. For more information, please see their website:

<https://www.caut.ca/content/guide-acknowledging-first-peoples-traditional-territory>

## 2.15 Changes to this syllabus

All details in this syllabus are subject to change throughout the quarter; any major changes will be announced via Canvas.

The authoritative, continuously-updated version of this syllabus is on [Canvas](https://canvas.ucdavis.edu/courses/1077308); feel free to leave questions and comments there at any time during the quarter.

# 3 Finding Employment on Campus

Many GGE students have mentioned that it is difficult to find TA and GSR positions. If you are trying to find a research project, please talk to me; I don’t always have opportunities to offer in my own work, but I will try to connect you with someone whose interests match yours.

I am also going to compile some resources here:

- [A list of TA job portals in several departments](https://basc.ucdavis.edu/graduate/funding/ta#:~:text=TA%20Jobs%20by%20Department)

- [TA jobs in the Math department](https://www.math.ucdavis.edu/about/student_employment)

- [TA jobs in the Statistics department](https://statistics.ucdavis.edu/resources/employment/teaching-assistants#:~:text=We%20do%20welcome%20TA%20Applications%20from%20graduate%20students%20in%20other%20programs%2C%20if%20positions%20are%20available.%20If%20you%20would%20like%20to%20apply%20for%20a%20TA%20position%20within%20the%20department%2C%20please%20contact%20the%20graduate%20coordinator%20Andi%20Carr%20(MSB%204118E%2C%20abcarr%40ucdavis.edu).)

- [TA jobs in the Electrical and Computer Engineering department](https://ece.ucdavis.edu/teaching-assistants)

- [Resources from Grad Studies](https://grad.ucdavis.edu/student-employment)

# 4 Finding Employment After Graduating

- [UC Davis jobs: keyword “epidemiological”](https://hr.ucdavis.edu/careers/apply?format=json&keywords=epidemiological&Category%5Bcategory_id%5D=&MCampus%5B%5D=DV&MCampus%5B%5D=DVMC)

- [UC Davis jobs: keyword “statistical”](https://hr.ucdavis.edu/careers/apply?format=json&keywords=statistical&Category%5Bcategory_id%5D=&MCampus%5B%5D=DV&MCampus%5B%5D=DVMC)

Back to top
