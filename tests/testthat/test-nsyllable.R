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

test_that("nsyllable works for unknown words", {
  expect_identical(
    nsyllable(c("notword", "NOTWORD")),
    c(2L, 2L)
  )
})

test_that("nsyllable works for different use.names arguments", {
  expect_identical(
    nsyllable(c("testing", "Reagan", "WHOA"), use.names = TRUE),
    c(testing = 2L, Reagan = 2L, WHOA = 1L)
  )
  expect_identical(
    nsyllable(c("testing", "Reagan", "WHOA"), use.names = FALSE),
    c(2L, 2L, 1L)
  )
})

test_that("nsyllable works for words that include punctuation", {
  expect_identical(
    nsyllable(c("#rstats", "@justinbieber")),
    c(1L, 4L)
  )
  expect_identical(
    nsyllable(c("#rstats", "@justinbieber"), use.names = TRUE),
    c("#rstats" = 1L, "@justinbieber" = 4L)
  )
  expect_identical(
    nsyllable(c("!!!", "\U0001F600", "Hooray!!\U0001F600")),
    c(NA, NA, 2L)
  )
})
