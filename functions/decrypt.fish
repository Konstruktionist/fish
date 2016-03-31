function decrypt -d 'Decrypt a file'
   set -l result (echo $argv | sed 's/.enc//g')
   openssl enc -d -aes-256-cbc -in $argv > $result
end

