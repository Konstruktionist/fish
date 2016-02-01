function cleands -d 'Recursively delete ".DS_Store" files'
  find . -name '*.DS_Store' -type f -delete
end
