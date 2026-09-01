%A	Full weekday name	   Monday
%a	Abbreviated weekday name	   Mon
%B	Full month name	   October
%b	Abbreviated month name	   Oct
%d	Day of the month (01-31)	   21
%m	Month number (01-12)	         10
%Y	Full year	                  2024
%y	Last two digits of the year	24
%H	Hour (00-23)	                  15
%I	Hour (01-12, 12-hour format)	03
%M	Minute (00-59)	               32
%S	Second (00-59)	            45
%p	AM or PM	                  PM
%Z	Timezone	                     IST

DATE COMMAND
      Find the Day of the Week for a Specific Date:
      date -d "2024-12-25" +%A

      To display the current UTC (Coordinated Universal Time), use the -u option.
      date -u

      Set the Date and Time Manually:
      sudo date --set "2024-12-25 12:00:00"

      Summary of Important Options
      Option	Description
      -u	Display time in UTC
      -d "STRING"	Display date/time based on a given string
      --set "STRING"	Set the system date/time (needs sudo)
      +FORMAT	Customize the output with format specifiers

Summary of Positional Arguments
      Symbol	Description
      $0	The name of the script
      $1, $2, ...	The first, second, etc., arguments
      $@	All arguments as separate strings
      $#	Total number of arguments
      shift	Moves positional arguments to the left


1️⃣ Arithmetic Operators
   These operators are used to perform basic mathematical operations.

      Operator	Description	Example
      +	Addition	expr 5 + 3 (results in 8)
      -	Subtraction	expr 5 - 3 (results in 2)
      *	Multiplication	expr 5 \* 3 (results in 15)
      /	Division	expr 5 / 2 (results in 2)
      %	Modulus (remainder)	expr 5 % 2 (results in 1)

2️⃣ Relational Operators
   Relational operators are used to compare two values.

      Operator	Description	Example
      -eq	Equal to	[[ $a -eq $b ]]
      -ne	Not equal to	[[ $a -ne $b ]]
      -gt	Greater than	[[ $a -gt $b ]]
      -lt	Less than	[[ $a -lt $b ]]
      -ge	Greater than or equal to	[[ $a -ge $b ]]
      -le	Less than or equal to	[[ $a -le $b ]]

3️⃣ Logical Operators
   Logical operators are used to combine multiple conditions.

      Operator	Description	Example
      &&	Logical AND	[[ condition1 && condition2 ]]
      `		`
      !	Logical NOT (negation)	[[ ! condition ]]

4️⃣ Assignment Operators
   Assignment operators are used to assign values to variables.

      Operator	Description	Example
      =	Assign value	x=5
      +=	Add and assign	x+=5 (equivalent to x=x+5)
      -=	Subtract and assign	x-=5 (equivalent to x=x-5)
      *=	Multiply and assign	x*=5 (equivalent to x=x*5)
      /=	Divide and assign	x/=5 (equivalent to x=x/5)
      %=	Modulus and assign	x%=5 (equivalent to x=x%5)


If-Else Statements in Shell Scripting
   Basic Structure
      if [ condition ]; then
         # Code to execute if the condition is true
      elif [ another_condition ]; then
         # Code to execute if the second condition is true
      else
         # Code to execute if none of the conditions are true
      fi
                        OR
      if [[ condition ]]; then
         # Code to execute if the condition is true
      elif [[ another_condition ]]; then
         # Code to execute if the second condition is true
      else
         # Code to execute if none of the conditions are true
      fi

7️⃣ Switch Statements in Shell Scripting
      case variable in
         pattern1)
            # Code to execute if variable matches pattern1
            ;;
         pattern2)
            # Code to execute if variable matches pattern2
            ;;
         *)
            # Code to execute if variable doesn't match any pattern
            ;;
      esac  

8️⃣ Arrays in Shell Scripting
   Types of Arrays
   Indexed Arrays: These are arrays with numerical indices.
   Associative Arrays: These arrays use string keys as indices (available in Bash version 4.0 and above).

   1️⃣ Indexed Arrays
      Declaring Indexed Arrays
         array_name=(value1 value2 value3)

         ${array_name[index]}

   2️⃣ Associative Arrays
      Declaring Associative Arrays

         declare -A associative_array
         associative_array[key1]="value1"
         associative_array[key2]="value2"

         ${associative_array[key]}


9️⃣ Loops in Shell Scripting
Types of Loops
For Loop
While Loop
Until Loop

   1️⃣ For Loop

      for variable in list; do
         # Commands to execute
      done

      for ((i=1; i<=5; i++)); do
         echo "Number: $i"
      done

   2️⃣ While Loop

      while [ condition ]; do
         # Commands to execute
      done

   3️⃣ Until Loop
      The until loop is the opposite of the while loop. It continues to execute as long as the specified condition is false.

      until [ condition ]; do
         # Commands to execute
      done

🔟 Functions in Shell Scripting
      function_name() {
         # Commands to execute
      }
   You can also define a function using the function keyword:
      function function_name {
         # Commands to execute
      }

//////////////////////////////////////////////////////////////////////////////////////////////////////

1️⃣ Debugging Scripts
   1.1 Using set Command
      set -x: Enables a mode of the shell where all executed commands are printed to the terminal. This is useful for tracing the flow of execution.
      set -e: Causes the script to exit immediately if any command returns a non-zero status (indicating an error). #exexution_            failure
      set -u: Treats unset variables as an error and exits immediately. #unset failures

2️⃣ Error Handling in Shell Scripting
   2.1 Checking Exit Status
      $?


Memory updated
Great! Let’s dive into regular expressions, sed, awk, and file operations in shell scripting. We’ll start with regular expressions.

3️⃣ Regular Expressions in Shell Scripting
      3.1 What are Regular Expressions?
      Regular expressions (regex) are sequences of characters that define a search pattern. They are often used for string matching and manipulation.

      Basic Regex Syntax
      .: Matches any single character.
      *: Matches zero or more occurrences of the preceding character.
      +: Matches one or more occurrences of the preceding character.
      ?: Matches zero or one occurrence of the preceding character.
      ^: Matches the start of a line.
      $: Matches the end of a line.
      [abc]: Matches any one of the characters inside the brackets.
      [^abc]: Matches any character not inside the brackets.
      (abc|def): Matches either abc or def.

4️⃣ sed (Stream Editor)
      sed is a powerful text processing tool used for parsing and transforming text in files or streams.

      Basic sed Syntax
      Substitution: s/pattern/replacement/
      Delete lines: d
      Print lines: p
      Range: You can specify line ranges to operate on.

5️⃣ awk
      awk is a powerful programming language designed for text processing. It excels at handling structured data.
      awk 'pattern { action }' file

6️⃣ File Operations
      6.1 Reading from a File
      You can read a file line by line using a while loop with read.

      while IFS= read -r line; do
         # Process line
      done < filename

CALLLLLLLLL
   1️⃣ Basic Syntax1️
      cal [options] [month] [year]


1️⃣ Basic Syntax

cut [options] [file]

















Parameter Expansion
   Parameter expansion allows you to manipulate the values of shell variables. Here are some of the most commonly used operators:
   
   Basic Expansion:
   
      Syntax: ${parameter}

   Default Values:
      Syntax :                                                                       ${parameter:-default}
      Description: If parameter is unset or null, it expands to default.
      unset var
      echo "${var:-default_value}"  # Output: default_value

   Default Assignment:
   
      Syntax :                                                                       ${parameter:=default}
      Description: If parameter is unset or null, it assigns default to parameter and then expands to the value of parameter.
      echo "${var:=default_value}"  # var is set to default_value and echoed.
      echo "$var"                   # Output: default_value
   Remove Prefix:
   
      Syntax :                                                                       ${parameter#pattern}
      Description: Removes the shortest match of pattern from the beginning of parameter.
      filename="example.txt"
      echo "${filename#*.}"  # Output: txt
   Remove Suffix:
   
      Syntax :                                                                       ${parameter%pattern}
      Description: Removes the shortest match of pattern from the end of parameter.
      filename="example.txt"
      echo "${filename%.txt}"  # Output: example
   Remove Longest Prefix:
   
      Syntax :                                                                       ${parameter##pattern}
      Description: Removes the longest match of pattern from the beginning.
      path="/usr/local/bin/example"
      echo "${path##*/}"  # Output: example
   Remove Longest Suffix:
   
      Syntax :                                                                       ${parameter%%pattern}
      Description: Removes the longest match of pattern from the end.
      path="/usr/local/bin/example.txt"
      echo "${path%%.*}"  # Output: /usr/local/bin/example
   String Length:
   
      Syntax :                                                                       ${#parameter}
      Description: Returns the length of parameter.
      str="Hello"
      echo "${#str}"  # Output: 5
   Substring Extraction:
   
      Syntax :                                                                       ${parameter:offset:length}
      Description: Extracts a substring starting at offset with a specified length.
      str="Hello, World!"
      echo "${str:7:5}"  # Output: World

String Manipulation

   String manipulation in shell scripting allows you to modify and handle strings easily. Here are some common operations:
   
   Concatenation:
   
      You can simply place strings next to each other.
      str1="Hello"
      str2="World"
      result="${str1}, ${str2}!"  # Output: Hello, World!
      echo "$result"
   Uppercase and Lowercase Conversion:
   
      Using ^^ for uppercase and ,, for lowercase (Bash 4+).
      str="hello"
      echo "${str^^}"  # Output: HELLO
      echo "${str,,}"  # Output: hello
   Replacing Substrings:
   
      Syntax :                                                                       ${parameter//pattern/replacement}
      Description: Replaces all occurrences of pattern with replacement.
      str="Hello, World!"
      echo "${str//World/Bash}"  # Output: Hello, Bash!
   Splitting a String:
   
      You can use IFS (Internal Field Separator) to split strings.
      str="one:two:three"
      IFS=':' read -ra parts <<< "$str"
      echo "${parts[1]}"  # Output: two
   Trimming Whitespace:
   
      To trim whitespace from the beginning and end.
      str="   Hello, World!   "
      trimmed="${str#"${str%%[![:space:]]*}"}"  # Leading
      trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"  # Trailing
      echo "$trimmed"  # Output: Hello, World!


CHANGING FILE NAMESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
      # Get the base name without extension
      base_name=$(basename "$original_file" .txt)  
      
      # Create a backup filename
      backup_file="${base_name}.bak"
      
      # Copy the original file to the backup
      cp "$original_file" "$backup_file"
      
      echo "Backup created: $backup_file"

Using AWK TO SOLVE QUIZ 1 FIRST QUESTION  

#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 [-l | -w | -c] file"
    exit 1
fi

file="$2"
if [ "$1" == "-l" ]; then
    awk 'END {print NR, FILENAME}' "$file"
elif [ "$1" == "-w" ]; then
    awk '{word_count += NF} END {print word_count, FILENAME}' "$file"
elif [ "$1" == "-c" ]; then
    awk '{char_count += length($0) + 1} END {print char_count, FILENAME}' "$file"
else
    lines=$(awk 'END {print NR}' "$1")
    words=$(awk '{word_count += NF} END {print word_count}' "$1")
    chars=$(awk '{char_count += length($0) + 1} END {print char_count}' "$1")
    echo "$lines $words $chars $1"
fi

































Regular expressions (regex) are powerful tools used to search, match, and manipulate strings. They include a variety of characters and constructs, each with specific functionality. Here’s a complete breakdown of regex components, grouped by type:

1. Basic Symbols and Literals
   .: Matches any single character except newline.
   [abc]: Matches any character within the square brackets (a, b, or c).
   [^abc]: Matches any character NOT within the square brackets.
   [a-z]: Matches any lowercase letter from a to z.
   [A-Z]: Matches any uppercase letter from A to Z.
   [0-9]: Matches any digit from 0 to 9.
   \: Escapes a special character, treating it as a literal (e.g., \. matches a literal dot).
2. Anchors
   ^: Asserts the position at the start of a line or string.
   $: Asserts the position at the end of a line or string.
   \b: Asserts a word boundary (between \w and \W).
   \B: Asserts a non-word boundary.
3. Quantifiers
   *: Matches 0 or more of the preceding element.
   +: Matches 1 or more of the preceding element.
   ?: Matches 0 or 1 of the preceding element.
   {n}: Matches exactly n occurrences of the preceding element.
   {n,}: Matches n or more occurrences of the preceding element.
   {,m}: Matches 0 to m occurrences of the preceding element.
   {n,m}: Matches between n and m occurrences of the preceding element.
   *?, +?, ??, {n}?, {n,}?, {,m}?, {n,m}?: Non-greedy (lazy) versions of the quantifiers above.
4. Character Classes
   \d: Matches any digit (same as [0-9]).
   \D: Matches any non-digit character.
   \w: Matches any word character (alphanumeric or underscore).
   \W: Matches any non-word character.
   \s: Matches any whitespace character (spaces, tabs, line breaks).
   \S: Matches any non-whitespace character.
5. Groups and Capturing
   (abc): Capturing group, matches the exact sequence abc.
   (?:abc): Non-capturing group, matches the sequence abc but does not capture it.
   (a|b|c): Alternation, matches either a, b, or c.
   (?<name>abc): Named capturing group, captures abc with the name name.
   (?<=abc): Positive lookbehind, matches if preceded by abc.
   (?<!abc): Negative lookbehind, matches if not preceded by abc.
   (?=abc): Positive lookahead, matches if followed by abc.
   (?!abc): Negative lookahead, matches if not followed by abc.
6. Special Sequences
   \A: Matches the start of the string (regardless of line breaks).
   \Z: Matches the end of the string, or just before a newline at the end.
   \b: Matches a word boundary position (between a word character and a non-word character).
   \B: Matches a position that is not a word boundary.
   \G: Matches the end of the previous match.
7. POSIX Character Classes
   [[:alnum:]]: Alphanumeric characters (a-z, A-Z, 0-9).
   [[:alpha:]]: Alphabetic characters (a-z, A-Z).
   [[:ascii:]]: ASCII characters.
   [[:blank:]]: Space and tab.
   [[:cntrl:]]: Control characters.
   [[:digit:]]: Digits (0-9).
   [[:graph:]]: Visible characters (non-space).
   [[:lower:]]: Lowercase letters (a-z).
   [[:print:]]: Visible and whitespace.
   [[:punct:]]: Punctuation.
   [[:space:]]: Whitespace (spaces, tabs, line breaks).
   [[:upper:]]: Uppercase letters (A-Z).
   [[:word:]]: Word characters (alphanumeric + underscore).
   [[:xdigit:]]: Hexadecimal characters (0-9, a-f, A-F).
8. Escape Sequences (Specific to Some Regex Engines)
   \t: Tab.
   \n: Newline.
   \r: Carriage return.
   \f: Form feed.
   \v: Vertical tab.
   \e: Escape character (for certain regex engines).
9. Pattern Modifiers (for Specific Regex Implementations)
   (?i): Case-insensitive mode.
   (?m): Multiline mode (anchors ^ and $ match the start and end of each line).
   (?s): Dot-all mode (allows . to match newlines).
   (?x): Ignore whitespace and allow comments in the regex.
   (?U): Ungreedy mode (switches all quantifiers to lazy by default).
10. Assertions and Atomic Groups
   (?>...): Atomic group; the regex engine does not backtrack within this group.
   (?(condition)yes-pattern|no-pattern): Conditional pattern, matches yes-pattern if condition is met, otherwise no-pattern.
11. Backreferences
   \1, \2, etc.: Matches the same text as most recently matched by capturing group #1, #2, etc.



*****************************IMPPPPPPPPPPPPP******************************************************ITERATION

#!/bin/bash

# Define the file to read
file="yourfile.txt"

# Iterate over each line in the file
while IFS= read -r line; do
    echo "Line: $line"

    # Iterate over each word in the line
    for word in $line; do
        echo "  Word: $word"

        # Iterate over each character in the word
        for (( i=0; i<${#word}; i++ )); do
            char="${word:i:1}"
            echo "    Character: $char"
        done
    done
done < "$file"


******************************************************************************************************

1. File Test Operators
   Operator	Description
   -e file	True if the file exists.
   -f file	True if the file exists and is a regular file.
   -d file	True if the file exists and is a directory.
   -h file or -L file	True if the file exists and is a symbolic link.
   -r file	True if the file exists and is readable.
   -w file	True if the file exists and is writable.
   -x file	True if the file exists and is executable.
   -s file	True if the file exists and has a non-zero size.
   -t fd	True if file descriptor fd is open and refers to a terminal.
   -c file	True if the file exists and is a character special file.
   -b file	True if the file exists and is a block special file.
   -p file	True if the file exists and is a named pipe (FIFO).
   -S file	True if the file exists and is a socket.
   -k file	True if the file exists and has the sticky bit set.
   -u file	True if the file exists and has the set-user-ID bit set.
   -g file	True if the file exists and has the set-group-ID bit set.
2. String Test Operators
   Operator	Description
   -z string	True if the string is empty (zero length).
   -n string	True if the string is not empty.
   string1 = string2	True if the strings are equal.
   string1 != string2	True if the strings are not equal.
   string1 < string2	True if string1 is lexicographically less than string2.
   string1 > string2	True if string1 is lexicographically greater than string2.
   [[ string =~ regex ]]	True if the string matches the regular expression regex.
3. Integer Comparison Operators
   Operator	Description
   -eq	True if two integers are equal.
   -ne	True if two integers are not equal.
   -lt	True if the first integer is less than the second.
   -le	True if the first integer is less than or equal to the second.
   -gt	True if the first integer is greater than the second.
   -ge	True if the first integer is greater than or equal to the second.
4. Logical Operators
   These are used to combine multiple test expressions.

   Operator	Description
   ! expr	Negates the expression (expr).
   expr1 -a expr2	Logical AND; True if both expr1 and expr2 are true.
   expr1 -o expr2	Logical OR; True if either expr1 or expr2 is true.
   &&	Logical AND in [[ ... ]] or with if statements.
   `	
5. Extended Test Syntax with [[ ... ]]
   The [[ ... ]] syntax in bash and ksh extends test capabilities with additional operators.

   Pattern Matching: [[ string == pattern ]] matches string against a shell pattern (e.g., *.txt).
   Regex Matching: [[ string =~ regex ]] allows regex matching within [[ ... ]].

//////////////////////////////////////////////////parameter expansion

parameter expansions in shell scripting.

Syntax	                              Description	                                               Example	               Output
${variable}	               Basic expansion. Expands to the value of variable.	                  name="Alice"; echo ${name}	Alice
${variable:-default}	      Expands to default if variable is unset or null.	                  echo ${username:-guest}	guest (if username is unset)
${variable:=default}	 Sets variable to default if unset or null, then expands to variable.	   echo ${username:=guest}	guest (sets username if unset)
${#variable}	      Expands to the length of variable.	                                       str="Hello"; echo ${#str}	5
${variable:offset:length}	Extracts substring from variable, starting at offset, length length.	text="world"; echo ${text:1:3}	orl
${variable/pattern/repl}	Replaces the first occurrence of pattern with repl in variable.	   path="file.txt"; echo ${path/txt/pdf}	file.pdf
${variable//pattern/repl}	Replaces all occurrences of pattern with repl in variable.	         str="aaab"; echo ${str//a/x}	xxxb
${variable/#pattern/replacement}: Replaces pattern with replacement if it occurs at the beginning of variable.
${variable/%pattern/replacement}: Replaces pattern with replacement if it occurs at the end of variable.
${variable#pattern}	     Removes the shortest match of pattern from the beginning of variable.	path="/usr/bin"; echo ${path#*/}	usr/bin
${variable##pattern} removes the longest match of pattern from the beginning of variable.
${variable%pattern}	   Removes the shortest match of pattern from the end of variable.	      file="report.txt"; echo ${file%.txt}	report
${variable^}	   Converts the first character of variable to uppercase (Bash 4.0+).	         word="hello"; echo ${word^}	Hello
${variable,}	   Converts the first character of variable to lowercase (Bash 4.0+).	         word="HELLO"; echo ${word,}	hELLO
${variable:?message}	Displays message and exits if variable is unset or null.	e                 echo ${name:?Name required}	Error: Name required if name unset

