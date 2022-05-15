apply_syllable_rules <- function(x, language) {
    pattern <- switch(
        language,
        pl = pl_syllable_pattern,
        default_syllable_pattern
    )
    
    vapply(
        gregexpr(pattern, x, ignore.case = TRUE),
        function(match) {
            if (length(match) == 1 && match == -1)
                NA_integer_
            else
                length(match)
        },
        integer(1)
    )
}

default_syllable_pattern <- "[aeiouy]+"
pl_syllable_pattern <- "i*([aeiouy])\\1*u*"
