#' Count syllables in a text
#'
#' @description Returns a count of the number of syllables in texts. For English
#'   words, the syllable count is exact and looked up from the CMU pronunciation
#'   dictionary, from the default syllable dictionary `data_int_syllables`.
#'   For any word not in the dictionary, the syllable count is estimated by
#'   counting vowel clusters.
#'
#' @param x character vector whose
#'   syllables will be counted.  This will count all syllables in a character
#'   vector without regard to separating tokens, so it is recommended that x be
#'   individual terms.
#' @param syllable_dictionary optional named integer vector of syllable counts where
#'   the names are lower case tokens.  When set to `NULL` (default), then
#'   the function will use the data object `data_int_syllables`, an
#'   English pronunciation dictionary from CMU.
#' @param use.names logical; if `TRUE`, assign the tokens as the names of
#' the syllable count vector
#'
#' @return If `x` is a character vector, a named numeric vector of the
#'   counts of the syllables in each element.
#' @note `nsyllable()` only works reliably for English, as the only syllable
#'   count dictionary we could find is the freely available CMU pronunciation
#'   dictionary at `http://www.speech.cs.cmu.edu/cgi-bin/cmudict`.  If you have
#'   a dictionary for another language, please email the package maintainer as
#'   we would love to include it.
#' @name nsyllable
#' @export
#' @examples
#' # character
#' nsyllable(c("cat", "syllable", "supercalifragilisticexpialidocious",
#'             "Brexit", "Administration"), use.names = TRUE)
#'
nsyllable <- function(x, syllable_dictionary = nsyllable::data_int_syllables,
                      use.names = FALSE) {
    UseMethod("nsyllable")
}

#' @rdname nsyllable
#' @noRd
#' @export
nsyllable.character <- function(x, syllable_dictionary = nsyllable::data_int_syllables,
                                use.names = FALSE) {
    # look up syllables
    result <- syllable_dictionary[tolower(x)]

    # count vowels if the word did not match the syllable dictionary
    if (any(is.na(result))) {
        result[is.na(result)] <-
            sapply(gregexpr("[aeiouy]+", x[is.na(result)], ignore.case = TRUE),
                   function(y) {
                       temp <- attr(y, "match.length")
                       if (length(temp) == 1 && temp == -1) 
                           NA
                       else
                           length(attr(y, "match.length"))
                   })
    }

    # so we don't words with no vowels as having syllables
    result[which(result == 0)] <- NA

    # keep or discard names
    if (use.names) {
        names(result) <- x
    } else {
        result <- unname(result)
    }

    result
}
