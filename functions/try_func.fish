# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function try_func -d "Experiments in fish scripting"

# Building Gary Bernhardt's githelpers bash script in fish

# Define colors
set -l ycolor (set_color bryellow)
set -l ncolor (set_color normal)
set -l gcolor (set_color brgreen)
set -l bcolor (set_color blue)   # bold blue
set -l rcolor (set_color brred)

set log_hash "$ycolor%h"
set log_relative_time "$gcolor%ar"
set log_author "$bcolor%an$ncolor"
set log_refs "$rcolor%d$ncolor"
set log_subject "%s"

# Use a special character to separate our fields so strings with spaces in
# them (like names & subjects) will not split on them.
# Character used is U+222C (DOUBLE INTEGRAL). I'm guessing I will not use that
# in commit messages.

set log_format "$log_hash∬$log_relative_time∬$log_author∬$log_refs $log_subject"

set branch_prefix "%HEAD"
set branch_ref "$rcolor%refname:short$ncolor"
set branch_hash "$ycolor%objectname:short$ncolor"
set branch_date "$gcolor%committerdate:relative$ncolor"
set branch_author "$bcolor<%authorname>$ncolor"
set branch_contents "%contents:subject"

set branch_format "$branch_prefix∬$branch_ref∬$branch_hash∬$branch_date∬$branch_author∬$branch_contents"

set ANSI_RED '\033[31m'
set ANSI_RESET '\033[0m'


function gitl #   l = all commits, only current branch
  # first string replace: remove all ' ago' in date column
  # second string replace: replace (2 years, 5 months) with (2 years)
  git log --graph --pretty="tformat:$log_format" $argv | string replace ' ago' '' | string replace -r ',\s\d+?\s\w+\s?' '' | string replace -r '(Merge(\s\w+).+)' '$1' | column -t -s '∬' | less -FXRS
end

function gitla  #   la = all commits, all reachable refs
  gitl --all
end

function gitr #   r = recent commits, only current branch
  gitl -30
end

function gitra  #   ra = recent commits, all reachable refs
  gitr --all
end

function gith #   h = head
  gitl -1
  git show -p --pretty="tformat:"
end

# function gitl
#   pretty_git_log | pretty_git_format
# end

function show_git_head
  pretty_git_log -1
  git show -p --pretty="tformat:"
end

function pretty_git_log
  # git log --graph --pretty="tformat:$log_format" $argv | pretty_git_format
  git log --graph --pretty="tformat:$log_format" $argv | string replace ' ago' ''
end

# function pretty_git_branch
#   git branch -v --format=$branch_format $argv | pretty_git_format
# end
#
# function pretty_git_branch_sorted
#   git branch -v --format=$branch_format --sort=-committerdate $argv | pretty_git_format
# end


function remove_ago
  # Replace (2 years ago) with (2 years)
  # sed -Ee 's/(^[^<]*) ago\)/\1)/'
  string replace ' ago' ''
end

function remove_months_from_years
  # Replace (2 years, 5 months) with (2 years)
  string replace -r ',\s\d+?\s\w+\s?' ''
end

function columns
  # Line columns up based on ∬ delimiter
  column -s '∬' -t
end

# function color_merge -d 'Color merge commits specially'
#   sed -Ee "s/(Merge (branch|remote-tracking branch|pull request) .*$)/$(printf $ANSI_RED)\1$(printf $ANSI_RESET)/"
# end

function page_all
    # Page only if needed.
    less -FXRS
end

function pretty_git_format
  remove_ago | remove_months_from_years | columns | page_all
end

# function pretty_git_format
#   # Replace (2 years ago) with (2 years)
#   sed -Ee 's/(^[^<]*) ago\)/\1)/' |
#   # Replace (2 years, 5 months) with (2 years)
#   sed -Ee 's/(^[^<]*), [[:digit:]]+ .*months?\)/\1)/' |
#   # Line columns up based on ∬ delimiter
#   column -s '∬' -t |
#   # Color merge commits specially
#   sed -Ee "s/(Merge (branch|remote-tracking branch|pull request) .*$)/$(printf $ANSI_RED)\1$(printf $ANSI_RESET)/" |
#   # Page only if we're asked to.
#   if [ -n "$GIT_NO_PAGER" ]
#       cat
#   else
#       # Page only if needed.
#       less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS --chop-long-lines
#   end
# end

end
