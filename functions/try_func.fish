# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function try_func -d "Experiments in fish scripting"

  echo ''
  echo "## Remote URLs:"\n
  git remote -v
  echo ''

  echo "## Remote Branches:"\n
  git branch -r --color=never
  echo ''

  echo "## Local Branches:"\n
  git branch --color=never
  echo ''

  echo "## Most recent commit:"\n
  git log --max-count=1 --pretty=short --color=never
  echo ''

  echo "Type 'git log' for more commits, or 'git show <commit id>' for full commit details"
end
