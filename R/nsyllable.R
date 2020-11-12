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
#' @param language specify the language for syllable counts by [ISO
#'   639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) code. The
#'   default is English, using the data object [`data_syllables_en`], an English
#'   pronunciation dictionary from CMU.
#' @param syllable_dictionary optional named integer vector of syllable counts
#'   where the names are lower case tokens.  This can be used to override the
#'   language setting, when set to `NULL` (the default).  If a syllable
#'   dictionary is supplied, this will override the `language` argument.
#' @param use.names logical; if `TRUE`, assign the tokens as the names of the
#'   syllable count vector
#' @return an integer vector of the counts of the syllables in each element,
#'   named with the element if `use.names = TRUE`
#' @name nsyllable
#' @export
#' @examples
#' # character
#' nsyllable(c("cat", "syllable", "supercalifragilisticexpialidocious",
#'             "Brexit", "Administration"), use.names = TRUE)
#'
nsyllable <- function(x, language = "en", syllable_dictionary = NULL,
                      use.names = FALSE) {
    UseMethod("nsyllable")
}

#' @rdname nsyllable
#' @noRd
#' @export
nsyllable.character <- function(x, language = "en", syllable_dictionary = NULL,
                                use.names = FALSE) {

    language <- match.arg(language)

    if (is.null(syllable_dictionary)) {
        syllable_dictionary <- switch(language, en = nsyllable::data_syllables_en)
    } else {
        check_syllable_dictionary(syllable_dictionary)
    }

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

check_syllable_dictionary <- function(x) {
    if (is.null(x) || !length(x) || !is.integer(x) ||
        is.null(names(x)) || any(is.na(names(x))) || any(names(x) == ""))
        stop("syllable_dictionary must be a named integer vector", call. = FALSE)
}
