test_that("nsyllable for English works for words in dictionary", {
  expect_identical(
      nsyllable(c("super", "syllable", "test")),
      c(2L, 3L, 1L)
  )
  expect_identical(
      nsyllable(c("super", "syllable", "test"), use.names = TRUE),
      c(super = 2L, syllable = 3L, test = 1L)
  )
})

test_that("nsyllable for English works for words NOT in dictionary", {
  expect_identical(
      nsyllable(c("super", "syllable", "testthat"), use.names = FALSE),
      c(2L, 3L, 2L)
  )
  expect_identical(
      nsyllable(c("super", "syllable", "testthat"), use.names = TRUE),
      c(super = 2L, syllable = 3L, testthat = 2L)
  )
})

test_that("dipthong estimation works for non-dictionary words", {
  expect_identical(
      nsyllable(c("aaaargh", "oooookaaaay"), use.names = FALSE),
      c(1L, 2L)
  )
})
