# Schedule

Code

Published

Last modified: 2026-11-13: 18:56:42 (UTC)

> **NOTE:**
>
> This table is the **tentative** schedule for the Spring 2026 offering of Epi 204. It is generated directly from the course schedule spreadsheet (`inst/extdata/epi-204-schedule-2026.xlsx`) and will be updated as the quarter progresses. The authoritative, continuously-updated version is on [Canvas](https://canvas.ucdavis.edu/courses/1077308/files/folder/Logistics).

## 1 Class sessions

> **NOTE:**
>
> Show R code
>
> ``` downlit
> library(dplyr)
>
> schedule_path <- here::here("inst/extdata/epi-204-schedule-2026.xlsx")
>
> # Combine the per-textbook reading-reference columns into a single labeled
> # string, dropping any that are blank for a given session.
> combine_readings <- function(...) {
>   values <- c(...)
>   labels <- c("Dunn & Smyth", "Dobson", "Vittinghoff", "Notes")
>   parts <- mapply(
>     function(label, value) {
>       if (is.na(value) || trimws(value) == "") {
>         return(NA_character_)
>       }
>       paste0(label, " ", trimws(value))
>     },
>     labels, values,
>     USE.NAMES = FALSE
>   )
>   parts <- parts[!is.na(parts)]
>   if (length(parts) == 0) {
>     return(NA_character_)
>   }
>   paste(parts, collapse = "; ")
> }
>
> class_schedule <-
>   readxl::read_excel(schedule_path, sheet = "Schedule") |>
>   # Drop footnote rows and the tentative "Skipped?" row (no real session date).
>   filter(!is.na(Date)) |>
>   mutate(Date = format(as.Date(Date), "%b %d")) |>
>   rowwise() |>
>   mutate(
>     Readings = combine_readings(
>       `Dunn & Smyth sections`, `Dobson sections`,
>       `Vittinghoff sections`, `Lecture notes **`
>     )
>   ) |>
>   ungroup() |>
>   transmute(
>     Week, Date, Day,
>     Topic = Topics,
>     Subtopics,
>     Deadlines = `Deadlines*`,
>     `New work` = `New Assignments`,
>     Lecturer,
>     Readings
>   )
>
> class_schedule |>
>   gt::gt() |>
>   gt::sub_missing(missing_text = "") |>
>   gt::opt_row_striping() |>
>   gt::tab_options(table.font.size = gt::pct(80)) |>
>   gt::tab_footnote(
>     footnote = paste(
>       "Homework assignments have an automatic 24-hour grace period",
>       "unless otherwise announced."
>     ),
>     locations = gt::cells_column_labels(columns = Deadlines)
>   )
> ```
>
> [TABLE]
>
> Table 1: Tentative schedule of class sessions (Spring 2026).

## 2 Assignments and exams

> **NOTE:**
>
> Show R code
>
> ``` downlit
> readxl::read_excel(schedule_path, sheet = "Homework and Exams") |>
>   filter(!is.na(Assignments)) |>
>   mutate(
>     Topics = gsub("[\r\n]+", " ", Topics),
>     across(
>       c(`Date Assigned`, `Date Due*`, `Date Returned (approx.)`),
>       ~ format(as.Date(.x), "%b %d")
>     )
>   ) |>
>   rename(
>     `Date due` = `Date Due*`,
>     `Date returned (approx.)` = `Date Returned (approx.)`
>   ) |>
>   gt::gt() |>
>   gt::sub_missing(missing_text = "") |>
>   gt::opt_row_striping() |>
>   gt::tab_options(table.font.size = gt::pct(85))
> ```
>
> [TABLE]
>
> Table 2: Homework assignments and exams (Spring 2026).

Back to top
