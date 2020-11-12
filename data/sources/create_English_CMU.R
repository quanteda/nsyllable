library("nsyllable")
library("quanteda")

rl <- readLines("https://raw.githubusercontent.com/Alexir/CMUdict/master/cmudict-0.7b")

# remove comments and entries starting with punctuation
rl <- rl[!stringi::stri_detect_regex(rl, "^[\\p{P}\\p{S}]")]

# fix one entry for "déjà"
rl[35609] <- "DÉJÀ  D EY2 JH AA1"

# make each row a list element
rls <- strsplit(rl, " ")
# name the element with its first element
names(rls) <- stringi::stri_trans_tolower(sapply(rls, function(x) x[1]))
# remove first element and spaces
rls <- lapply(rls, function(x) x[-1])
# remove variants
rls <- rls[!stringi::stri_detect_fixed(names(rls), "(")]

# sort
rls <- rls[sort(names(rls))]

# convert to tokens
toks <- as.tokens(rls)
# select the phonemes with stresses
toks <- tokens_select(toks, "\\p{N}$", valuetype = "regex")

data_syllables_en <- ntoken(toks)

usethis::use_data(data_syllables_en, overwrite = TRUE)
