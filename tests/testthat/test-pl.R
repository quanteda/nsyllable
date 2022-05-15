test_that("in simple cases syllable count is equal to vowel count", {
    expect_identical(
        nsyllable(c("krowa", "samolot", "chytry", "szpak"), language = "pl"),
        c(2L, 3L, 2L, 1L)
    )
})

test_that("'i' before a vowel is not counted", {
    expect_identical(
        nsyllable(c("ziemia", "niebo", "gniot", "wzium"), language = "pl"),
        c(2L, 2L, 1L, 1L)
    )
})

test_that("'i' before consonant and at the end is counted", {
    expect_identical(
        nsyllable(c("zima", "pani", "widzialny"), language = "pl"),
        c(2L, 2L, 3L)
    )
})

test_that("'au' and 'eu' groups are considered a single syllable by default", {
    expect_identical(
        nsyllable(c("euro", "automobil", "miau", "neurologia"), language = "pl"),
        c(2L, 4L, 1L, 4L)
    )
})

test_that("'au' and 'eu' are considered separate when at the border of a prefix", {
    skip("hard to implement")
    expect_identical(
        nsyllable(c("nieuk", "nausznik", "zauroczenie"), language = "pl"),
        c(2L, 3L, 5L)
    )
})

test_that("'au' and 'eu' are considered separate when at the border of a suffix", {
    skip("hard to implement")
    expect_identical(
        nsyllable(c("faryzeusz", "liceum"), language = "pl"),
        c(4L, 3L)
    )
})

test_that("'au' and 'eu' are considered separate in a few exceptions", {
    skip("the exceptions will have to be listed out (including non-lemma forms)")
    expect_identical(
        nsyllable(c("nauka", "naukowy", "laurka", "Zeus", "neutralne", "neutron"), language = "pl"),
        c(3L, 4L, 3L, 2L, 4L, 3L)
    )
})

test_that("other vowel groups are counted as multiple syllables", {
    expect_identical(
        nsyllable(c("gargantuiczny", "Maorys", "meandry", "szyici"), language = "pl"),
        c(5L, 3L, 3L, 3L)
    )
})

test_that("multiple repetitions of vowels are treated as a single syllable", {
    expect_identical(
        nsyllable(c("czeeeemuuuu", "wieeeeem", "miaaauuuuu", "ziiiiimno"), language = "pl"),
        c(2L, 1L, 1L, 2L)
    )
})
