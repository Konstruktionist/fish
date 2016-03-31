function encrypt -d 'encrypt a file'
   openssl enc -aes-256-cbc -salt -in $argv -out $argv.enc
   rm $argv
end

