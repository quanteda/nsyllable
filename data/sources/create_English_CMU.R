library("nsyllable")
library("quanteda")

rl <- readLines("https://raw.githubusercontent.com/Alexir/CMUdict/master/cmudict-0.7b")

# remove comments and entries starting with punctuation
rl <- rl[!stringi::stri_detect_regex(rl, "^[\\p{P}\\p{S}]")]

# make each row a list element
rls <- strsplit(rl, " ")
# name the element with its first element
names(rls) <- stri_trans_tolower(sapply(rls, function(x) x[1]))
# remove first element and spaces
rls <- lapply(rls, function(x) x[-1])
# remove variants
rls <- rls[!stri_detect_fixed(names(rls), "(")]

# convert to tokens
toks <- as.tokens(rls)
# select the phonemes with stresses
toks <- tokens_select(toks, "\\p{N}$", valuetype = "regex")

data_int_syllables <- ntoken(toks)

usethis::use_data(data_int_syllables, overwrite = TRUE)
