#' Birthweight data in long format
#'
#' Reshapes \code{dobson::birthweight}, which has one column per sex for each
#' variable, into one row per baby: the data of the birthweight examples in
#' the linear models chapter (Dobson and Barnett, 4th edition, Example
#' 2.2.2).
#'
#' @returns A tibble with one row per baby and columns \code{id},
#'   \code{sex} (a factor with levels \code{"female"} and \code{"male"}),
#'   \code{age} (gestational age in weeks), \code{weight} (birthweight in
#'   grams), and the logical indicators \code{male} and \code{female}.
#' @export
#' @examplesIf requireNamespace("tidyr", quietly = TRUE)
#' birthweight_long()
birthweight_long <- function() {
  rlang::check_installed("tidyr")
  wide <- dobson::birthweight
  wide_cols <- names(wide)
  name_parts <- c("sex", ".value")
  long <- tidyr::pivot_longer(
    wide,
    cols = wide_cols,
    names_to = name_parts,
    names_sep = "s "
  )
  long |>
    dplyr::rename(age = "gestational age") |>
    dplyr::mutate(
      id = dplyr::row_number(),
      sex = dplyr::case_match(
        .data$sex,
        "boy" ~ "male",
        "girl" ~ "female"
      ),
      sex = factor(.data$sex, levels = c("female", "male")),
      male = .data$sex == "male",
      female = .data$sex == "female"
    ) |>
    dplyr::relocate("id")
}
