# Statistical Computing in R

Code

Published

Last modified: 2026-11-12: 7:37:46 (UTC)

# 1 Online R learning resources

There are an overwhelming number of great resources for learning R; here are some recommendations:

- [*The RStudio Education website*](https://education.rstudio.com), especially:
  - [*Finding your way to R*](https://education.rstudio.com/learn/)
- [*UCD-SERG Lab Manual*](https://ucd-serg.github.io/lab-manual/)
- *R for Epidemiology* (Cannell and Livingston [\[1\]](#ref-r4epi))
- *The Epidemiologist R Handbook* (Batra [\[2\]](#ref-epirhb))
- *Practical R for Epidemiologists* (Myatt [\[3\]](#ref-practicalr4epi))
- *R for Data Science* (Wickham et al. [\[4\]](#ref-r4ds))
- *Advanced R* (Wickham [\[5\]](#ref-wickham2019advanced))
- *R Graphics Cookbook* (Chang [\[6\]](#ref-changRgraphicscookbook))
- *R Packages* (Wickham and Bryan [\[7\]](#ref-rpkgs))
- Nahhas [\[8\]](#ref-NahhasIntroR) (same author as Nahhas [\[9\]](#ref-NahhasIRMPHR))
- Myatt [\[3\]](#ref-practicalr4epi)
- Aragon [\[10\]](#ref-phdswR) (previously Aragon [\[11\]](#ref-appliedepiusingR)): Author is State Public Health Officer and Director, California Department of Public Health, <https://drtomasaragon.github.io/>)
- *SAS and R* (Kleinman and Horton [\[12\]](#ref-kleinman2009sas))
- The [“sassy system”](https://r-sassy.org/) is “an integrated set of packages designed to make programmers more productive in R, particularly those with a background in SAS® software. The system leverages useful concepts and thought patterns to create a more efficient and satisfactory R programming experience.”
  - In particular, the [procs](https://cran.r-project.org/web/packages/procs/) package in R provides versions of common SAS procedures, such as ‘proc freq’, ‘proc means’, ‘proc ttest’, ‘proc reg’, ‘proc transpose’, ‘proc sort’, and ‘proc print’
- *R for SAS and SPSS users* (Muenchen [\[13\]](#ref-muenchen2011r))
- *Building reproducible analytical pipelines with R* (Rodrigues [\[14\]](#ref-rapR))
- *Posit Recipes: Some tasty R code snippets*: <https://posit.cloud/learn/recipes>
- *R for Reproducible Scientific Analysis* (Software Carpentry): <https://swcarpentry.github.io/r-novice-gapminder/>

# 2 UC Davis R programming courses

There are several dedicated UC Davis courses on R programming:

- [BIS 015L](https://catalog.ucdavis.edu/search/?q=BIS+015L): Introduction to Data Science for Biologists
  - see course materials at <https://jmledford3115.github.io/datascibiol/>
- [ENV 224](https://catalog.ucdavis.edu/search/?q=ENV+224)/ [ECL 224](https://catalog.ucdavis.edu/search/?q=ECL+224): Data Management & Visualization in R
  - see lecture videos and course materials at <https://ucd-rdavis.github.io/R-DAVIS/index.html>
- [ESP 106](https://catalog.ucdavis.edu/search/?q=ESP+106): Environmental Data Science
- [STA 015B](https://statistics.ucdavis.edu/expanded-descriptions/15b): Introduction to Statistical Data Science II
- [STA 032](https://statistics.ucdavis.edu/expanded-descriptions/32): Gateway to Statistical Data Science
- [STA 035A](https://statistics.ucdavis.edu/expanded-descriptions/35A): Statistical Data Science
- [STA 035B](https://statistics.ucdavis.edu/expanded-descriptions/35B): Statistical Data Science II
- [STA 141A](https://statistics.ucdavis.edu/expanded-descriptions/141A): Fundamentals of Statistical Data Science
- [STA 242](https://statistics.ucdavis.edu/expanded-descriptions/242): Introduction to Statistical Programming
- [ABG 250](https://catalog.ucdavis.edu/search/?q=ABG+250): Mathematical Modeling in Biological Systems
- [PSC 120](https://catalog.ucdavis.edu/search/?q=PSC+120): Agent-Based Modeling
- [PSC 203A](https://catalog.ucdavis.edu/search/?q=PSC+203A): Data Cleaning & Management in the Social Sciences
- [PSC 203B](https://catalog.ucdavis.edu/search/?q=PSC+203B): Data Visualization in the Social Sciences

[DataLab](https://datalab.ucdavis.edu/) maintains another list of courses: <https://datalab.ucdavis.edu/courses/>

DataLab also provides short-form workshops on R programming and data science: <https://datalab.ucdavis.edu/workshops/>

# 3 Demographics tables

Demographics tables are important first steps in many data analyses and papers.

The `gtsummary` package is flexible and can probably provide whatever table options you’re looking for, and if not, the developers are usually very welcoming of feature requests.

If `gtsummary` is really not doing what you want, other packages I’ve used for demographics tables include:

- <https://cran.r-project.org/web/packages/procs/> (replicates common SAS commands)
- <https://cran.r-project.org/web/packages/arsenal/index.html> (from the Mayo Clinics)
- <https://cran.r-project.org/web/packages/table1/index.html>

# 4 Writing functions

- Read this ASAP: <https://r4ds.hadley.nz/functions.html>
- Use this as a reference: <https://adv-r.hadley.nz/functions.html>

## 4.1 Methods versus functions

See <https://adv-r.hadley.nz/oo.html#oop-systems>

## 4.2 Debugging code

- <https://adv-r.hadley.nz/debugging.html>

- <https://webhomes.maths.ed.ac.uk/~swood34/RCdebug/RCdebug.html>

# 5 `data.frame`s and `tibble`s

## 5.1 Displaying `tibble`s

See [`vignette("digits", package = "tibble")`](https://tibble.tidyverse.org/articles/digits.html)

# 6 The `tidyverse`

> The tidyverse is an opinionated collection of R packages designed for data science. All packages share an underlying design philosophy, grammar, and data structures.

- https://www.tidyverse.org/

These packages are being actively developed by [Hadley Wickham](https://hadley.nz/) and his colleagues at [posit](https://posit.co/)[^1].

Details:

- Wickham et al. [\[15\]](#ref-welcometidyverse)
- Wickham et al. [\[4\]](#ref-r4ds)
- Kuhn and Silge [\[16\]](#ref-kuhn2022tidy)

# 7 Piping

See [Wickham et al. \[4\]](https://r4ds.hadley.nz/data-transform.html#sec-the-pipe) for details.

There are currently (2026) two commonly-used pipe operators in R:

- `%>%`: the “`magrittr` pipe”, from the [`magrittr`](https://cran.r-project.org/web/packages/magrittr/index.html) package (Bache and Wickham [\[17\]](#ref-magrittr); [re-exported](https://r-pkgs.org/dependencies-in-practice.html#re-exporting) by [`dplyr`](https://cran.r-project.org/web/packages/dplyr/index.html) and others) .

- `|>`: the “native pipe”, from base R ($\geq$ 4.1.0)

See <https://www.tidyverse.org/blog/2023/04/base-vs-magrittr-pipe> for a comparison of their behavior.

## 7.1 Which pipe should I use?

Wickham et al. [\[4\]](#ref-r4ds) [recommends the native pipe](https://r4ds.hadley.nz/data-transform.html#sec-the-pipe:~:text=So%20why%20do%20we%20recommend%20the%20base%20pipe%3F):

> For simple cases, \|\> and %\>% behave identically. So why do we recommend the base pipe? Firstly, because it’s part of base R, it’s always available for you to use, even when you’re not using the tidyverse. Secondly, \|\> is quite a bit simpler than %\>%: in the time between the invention of %\>% in 2014 and the inclusion of \|\> in R 4.1.0 in 2021, we gained a better understanding of the pipe. This allowed the base implementation to jettison infrequently used and less important features.

## 7.2 Why doesn’t `ggplot2` use piping?

Here’s `tidyverse` creator Hadley Wickham’s answer (from 2018):

> I think it’s worth unpacking this question into a few smaller pieces:
>
> - Should ggplot2 use the pipe? IMO, yes.
> - Could ggplot2 support both the pipe and plus? No
> - Would it be worth it to create a ggplot3 that uses the pipe? No.

<https://forum.posit.co/t/why-cant-ggplot2-use/4372/7>

# 8 Grouping operations in `dplyr`

The `dplyr` package provides two approaches for grouping data:

- **Persistent grouping** with `group_by()`: Creates a grouped data frame that remains grouped for subsequent operations until explicitly ungrouped
- **Per-operation grouping** with the `.by` argument: Applies grouping for a single operation only, without modifying the data frame structure

**Recommendation**: Default to using per-operation grouping with the `.by` argument, as it is more explicit, reduces the risk of accidentally operating on grouped data, and eliminates the need to remember to `ungroup()`.

For a detailed comparison of these approaches, see [`?dplyr_by`](https://dplyr.tidyverse.org/reference/dplyr_by.html).

# 9 Quarto

Quarto is a system for writing documents with embedded R code and/or results:

- Read this ASAP: <https://r4ds.hadley.nz/communicate>
- Then use this for reference: <https://quarto.org/docs/reference/>
- Learn LaTeX in 30 minutes (not everything in here is relevant to Quarto): <https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes>
- LaTeX symbol reference guide: <https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols>
- LaTeX commands: <https://www.overleaf.com/learn/latex/Commands>
- LaTeX cheat sheet: <https://wch.github.io/latexsheet/latexsheet.pdf>

## 9.1 Building PDF documents

To compile Quarto documents to PDF, you need a LaTeX installation. [TinyTeX](https://yihui.org/tinytex/) is a lightweight, portable LaTeX distribution recommended for use with Quarto.

**Recommended method** (run from the terminal/command line):

``` sh
quarto install tinytex
```

**Alternative method** (run from the R console):

``` downlit
install.packages("tinytex")
tinytex::install_tinytex()
```

For more details, see:

- Quarto PDF engine documentation: <https://quarto.org/docs/output-formats/pdf-engine.html>
- TinyTeX documentation: <https://yihui.org/tinytex/>
- Video tutorial: [Preparing RStudio to Generate PDF Files with Quarto and TinyTeX](https://www.youtube.com/watch?v=OUWOx80eJqk)

See Knuth [\[18\]](#ref-knuth84) for additional discussion of literate programming.

# 10 One source file, multiple outputs

One of quarto’s excellent features is the ability to convert the same source file into multiple output formats; in particular, I am using the same set of source files to generate an html website, a pdf document, and a set of revealjs slide decks.

I use `::: notes` divs to mark text chunks to omit from the revealjs format but include in the website and pdf format.

# 11 Packages

> This book espouses our philosophy of package development: anything that can be automated, should be automated. Do as little as possible by hand. Do as much as possible with functions. The goal is to spend your time thinking about what you want your package to do rather than thinking about the minutiae of package structure.

- https://r-pkgs.org/introduction.html#:~:text=This%20book%20espouses,of%20package%20structure.

- Read this ASAP: <https://r-pkgs.org/whole-game.html>

- Use the rest of Wickham and Bryan [\[7\]](#ref-rpkgs) as a reference

# 12 Submitting packages to CRAN

- Read this first: <https://r-pkgs.org/release.html>
- A problems-and-solutions book is under construction: <https://contributor.r-project.org/cran-cookbook/>

# 13 Git

94% of respondents to a [2022 Stack Overflow survey](https://survey.stackoverflow.co/2022/#section-version-control-version-control-systems) reported using git for version control.

[More details](https://r-pkgs.org/software-development-practices.html#sec-sw-dev-practices-git-github)

- *Happy Git with R* <https://happygitwithr.com/>

- <https://usethis.r-lib.org/articles/pr-functions.html>

- *Git Magic* <http://www-cs-students.stanford.edu/~blynn/gitmagic/>

- <https://ohshitgit.com/>

- <https://maelle.github.io/saperlipopette/>

# 14 Spatial data science

- Pebesma and Bivand [\[19\]](#ref-spatialds)

# 15 Shiny apps

- Read Wickham [\[20\]](#ref-masteringshiny) first
- Use Fay et al. [\[21\]](#ref-golembook) as a reference

# 16 Making the most of RStudio

Over time, explore all the tabs and menus; there are a lot of great quality-of-life features.

- use the `History` tab to view past commands; you can rerun them or copy them into a source code file in one click! (up-arrow in the Console also enables this process, but less easily).

# 17 Contributing to R

Many modern R packages are developed on Github, and welcome bug reports and pull requests (suggested edits to source code) through the Github interface.

To contribute to “base R” (the core systems), see <https://contributor.r-project.org/>

# References

\[1\]

B. Cannell and M. Livingston, *R for epidemiology*. Online, 2024. Available: <https://www.r4epi.com/>

\[2\]

N. Batra, Ed., *The epidemiologist R handbook*. Online, 2024. Available: <https://www.epirhandbook.com/>

\[3\]

M. Myatt, *Practical R for epidemiologists*. Online, 2022. Available: <https://practical-r.org/index.html>

\[4\]

H. Wickham, M. Çetinkaya-Rundel, and G. Grolemund, *R for data science*. " O’Reilly Media, Inc.", 2023. Available: <https://r4ds.hadley.nz/>

\[5\]

H. Wickham, *Advanced r*. Chapman; Hall/CRC, 2019. Available: <https://adv-r.hadley.nz/index.html>

\[6\]

W. Chang, *R graphics cookbook: Practical recipes for visualizing data*. O’Reilly Media, 2024. Available: <https://r-graphics.org/>

\[7\]

H. Wickham and J. Bryan, *R packages*. O’Reilly Media, Inc., 2023. Available: <https://r-pkgs.org/>

\[8\]

R. W. Nahhas, *An introduction to r for research*. 2023. Available: <https://bookdown.org/rwnahhas/IntroToR/>

\[9\]

R. W. Nahhas, *Introduction to regression methods for public health using R*. CRC Press, 2024. Available: <https://www.bookdown.org/rwnahhas/RMPH/>

\[10\]

T. J. Aragon, *Population health data science with R: Transforming data into actionable knowledge*. Online, 2017. Available: <https://bookdown.org/medepi/phds/>

\[11\]

T. J. Aragon, *Applied epidemiology using R*. Online, 2013. Available: <https://tbrieder.org/epidata/course_reading/e_aragon.pdf>

\[12\]

K. Kleinman and N. J. Horton, *SAS and R: Data management, statistical analysis, and graphics*. Chapman; Hall/CRC, 2009. Available: <https://www.routledge.com/SAS-and-R-Data-Management-Statistical-Analysis-and-Graphics-Second-Edition/Kleinman-Horton/p/book/9781466584495>

\[13\]

R. A. Muenchen, *R for SAS and SPSS users*. Springer Science & Business Media, 2011. Available: <https://link.springer.com/book/10.1007/978-1-4614-0685-3>

\[14\]

B. Rodrigues, *Building reproducible analytical pipelines with r*. Online, 2023. Available: <https://raps-with-r.dev/>

\[15\]

H. Wickham *et al.*, “Welcome to the tidyverse,” *Journal of Open Source Software*, vol. 4, no. 43, p. 1686, 2019, doi: [10.21105/joss.01686](https://doi.org/10.21105/joss.01686).

\[16\]

M. Kuhn and J. Silge, *Tidy modeling with r*. " O’Reilly Media, Inc.", 2022. Available: <https://www.tmwr.org/>

\[17\]

S. M. Bache and H. Wickham, *Magrittr: A forward-pipe operator for r*. 2022. Available: <https://CRAN.R-project.org/package=magrittr>

\[18\]

D. E. Knuth, “Literate programming,” *Comput. J.*, vol. 27, no. 2, pp. 97–111, May 1984, doi: [10.1093/comjnl/27.2.97](https://doi.org/10.1093/comjnl/27.2.97).

\[19\]

E. Pebesma and R. Bivand, *Spatial data science: With applications in R*. Boca Raton: Chapman; Hall/CRC, 2023. doi: [10.1201/9780429459016](https://doi.org/10.1201/9780429459016).

\[20\]

H. Wickham, *Mastering shiny*. " O’Reilly Media, Inc.", 2021. Available: <https://mastering-shiny.org/>

\[21\]

C. Fay, S. Rochette, V. Guyader, and C. Girard, *Engineering production-grade shiny apps*. Chapman; Hall/CRC, 2021. Available: <https://engineering-shiny.org/>

Back to top

## Footnotes

[^1]: [the company formerly known as RStudio](https://posit.co/blog/rstudio-is-becoming-posit/)
