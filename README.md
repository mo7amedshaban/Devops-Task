1. How your script handles arguments and options:

I used getopts to handle flags like -n and -v. The script processes the flags, checks for at least two arguments (search string and filename), and ensures the file exists. If anything is missing, it shows an error.

2. How would the structure change to support regex or -i/-c/-l options?

To support options like -e for regex or -c for count, I would expand getopts to include these flags. I'd modify the grep command to handle these options and adjust the output accordingly, either showing a count or file names.

3. What part of the script was hardest to implement and why?

The hardest part was handling combined options like -vn or -nv. I had to ensure the script could process them in any order and show the correct output or error when needed.
