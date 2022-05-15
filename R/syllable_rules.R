apply_syllable_rules <- function(x, language) {
    switch(language,
           pl = apply_pl_rules(x),
           apply_default_rules(x)
    )
}

apply_default_rules <- function(x) {
    vapply(
        gregexpr("[aeiouy]+", x, ignore.case = TRUE),
        function(match) {
            if (length(match) == 1 && match == -1)
                NA_integer_
            else
                length(match)
        },
        integer(1)
    )
}

apply_pl_rules <- function(x) {
    vapply(
        gregexpr("i*([aeiouy])\\1*u*", x, ignore.case = TRUE),
        function(match) {
            if (length(match) == 1 && match == -1)
                NA_integer_
            else
                length(match)
        },
        integer(1)
    )
}
