#' Plot the birthweight data with chosen regression lines
#'
#' Graphs birthweight against gestational age, colored by sex, and draws one
#' line per sex from the chosen coefficients of the model in
#' \code{\link{birthweight_loglik}}.
#'
#' @inheritParams birthweight_loglik
#'
#' @returns A \code{ggplot} object.
#' @export
#' @examplesIf rlang::is_installed(c("ggplot2", "tidyr"))
#' birthweight_plot(
#'   male_int = 2651,
#'   male_slope = 112,
#'   female_int = 2422,
#'   female_slope = 130
#' )
birthweight_plot <- function(
  male_int,
  male_slope,
  female_int,
  female_slope,
  data = birthweight_long()
) {
  rlang::check_installed("ggplot2")
  check_birthweight_coefs(male_int, male_slope, female_int, female_slope)
  sexes <- c("female", "male")
  sex_levels <- levels(data$sex)
  slopes <- c(female_slope, male_slope)
  centered_intercepts <- c(female_int, male_int)
  # The model centers age at 35 weeks; the plot's axis is uncentered.
  raw_intercepts <- centered_intercepts - slopes * 35
  line_sex <- factor(sexes, levels = sex_levels)
  lines <- tibble::tibble(
    sex = line_sex,
    slope = slopes,
    intercept = raw_intercepts
  )
  points_aes <- ggplot2::aes(
    x = .data$age,
    y = .data$weight,
    col = .data$sex,
    shape = .data$sex
  )
  lines_aes <- ggplot2::aes(
    intercept = .data$intercept,
    slope = .data$slope,
    col = .data$sex
  )
  ggplot2::ggplot(data, points_aes) +
    ggplot2::geom_point(alpha = 0.7) +
    ggplot2::geom_abline(data = lines, mapping = lines_aes) +
    ggplot2::xlab("Gestational age (weeks)") +
    ggplot2::ylab("Birthweight (grams)") +
    ggplot2::labs(col = "Sex", shape = "Sex") +
    ggplot2::theme_bw()
}
