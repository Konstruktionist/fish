function undopush -d 'Undo a `git push`'
  git push -f origin HEAD^:master
end