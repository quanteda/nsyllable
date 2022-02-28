# Submission notes

Fix a test breaking on dev releases of R because of too exact a match to an error message.

## Test environments

* local macOS 12.2.1, R 4.1.2
* Ubuntu 20.04 LTS, R 4.1.2
* Windows release via devtools::check_win_release()
* Windows devel via devtools::check_win_devel()

## R CMD check results

100% clean.

## Downstream dependencies

None exist (yet).
