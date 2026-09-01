

#!/bin/bash

PHONEBOOK="phonebook.txt"

# Create phonebook file if it doesn't exist
if [ ! -f "$PHONEBOOK" ]; then
    touch "$PHONEBOOK"
fi

# Function to display a contact
display_contact() {
    echo "Name: $1, Surname: $2, Email: $3, Phone: $4"
}

# Function to search contacts
search_contact() {
    read -p "Enter search query: " query
    grep -i "$query" "$PHONEBOOK"
    if [ $? -ne 0 ]; then
        echo "No contacts found."
    fi
}

# Function to add contact
add_contact() {
    read -p "Enter Name: " name
    read -p "Enter Surname: " surname
    read -p "Enter Email: " email
    read -p "Enter Phone: " phone

    # Check for duplicate contacts
    duplicate=$(grep -i "$name,$surname,$email,$phone" "$PHONEBOOK")
    if [ "$duplicate" != "" ]; then
        echo "Duplicate contact found!"
        read -p "Do you want to edit this contact? (y/n): " choice
        if [ "$choice" = "y" ]; then
            edit_contact "$name" "$surname"
        else
            echo "Contact not added."
            return
        fi
    else
        echo "$name,$surname,$email,$phone" >> "$PHONEBOOK"
        echo "Contact added."
    fi
}

# Function to remove a contact
remove_contact() {
    read -p "Enter search query to remove: " query
    matched=$(grep -i "$query" "$PHONEBOOK")

    if [ "$matched" == "" ]; then
        echo "No matching contact found."
        return
    fi

    echo "Matching contacts:"
    echo "$matched"
    read -p "Are you sure you want to remove these contacts? (y/n): " choice
    if [ "$choice" = "y" ]; then
        grep -i -v "$query" "$PHONEBOOK" > temp && mv temp "$PHONEBOOK"
        echo "Contact(s) removed."
    else
        echo "Operation cancelled."
    fi
}

# Function to edit a contact
edit_contact() {
    read -p "Enter search query to edit: " query
    matched=$(grep -i "$query" "$PHONEBOOK")

    if [ "$matched" == "" ]; then
        echo "No matching contact found."
        return
    fi

    echo "Matching contacts:"
    echo "$matched"
    
    read -p "Enter the contact's current phone number to edit: " phone
    contact=$(grep -i "$phone" "$PHONEBOOK")

    if [ "$contact" == "" ]; then
        echo "No contact with that phone number found."
        return
    fi

    # Read new details
    read -p "Enter new Name: " new_name
    read -p "Enter new Surname: " new_surname
    read -p "Enter new Email: " new_email
    read -p "Enter new Phone: " new_phone

    # Replace the old contact with the new one
    sed -i "/$phone/d" "$PHONEBOOK"
    echo "$new_name,$new_surname,$new_email,$new_phone" >> "$PHONEBOOK"
    echo "Contact updated."
}

# Main menu
while true; do
    echo "Phonebook Options:"
    echo "1. Search Contact"
    echo "2. Add Contact"
    echo "3. Remove Contact"
    echo "4. Edit Contact"
    echo "5. Exit"
    read -p "Choose an option: " option

    case $option in
        1)
            search_contact
            ;;
        2)
            add_contact
            ;;
        3)
            remove_contact
            ;;
        4)
            edit_contact
            ;;
        5)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done

chmod +x phonebook.sh


./phonebook.sh


2)

#!/bin/bash

# Function to check if a word is a palindrome
is_palindrome() {
    local word=$1
    local reverse_word=$(echo "$word" | rev)

    if [ "$word" = "$reverse_word" ]; then
        echo "$word"
    fi
}

# File containing dictionary (one word per line)
DICTIONARY="words.txt"

# Loop through each word in the dictionary
while read -r word; do
    is_palindrome "$word"
done < "$DICTIONARY"

chmod +x find_palindromes.sh

./find_palindromes.sh


3)

awk -F ',' '{print $3}' ./student-dataset.csv |sort | uniq -c | sort -nr
or
#!/bin/bash
# Find the country with the maximum number of students

awk -F ',' '{print $3}' ./student-dataset.csv | tail -n +2 | sort | uniq -c | sort -nr | head -n 1


#!/bin/bash
# Calculate the country-wise average math score

awk -F ',' 'NR>1 {sum[$3]+=$11; count[$3]++} END {for (country in sum) print country, sum[country]/count[country]}' ./student-dataset.csv


#!/bin/bash
# Replace "United States of America" with "USA" and "United Kingdom" with "UK"

sed -i 's/United States of America/USA/g; s/United Kingdom/UK/g' ./student-dataset.csv


#!/bin/bash
# Find the city-wise distribution of students from the USA

awk -F ',' '$3 == "USA" {print $4}' ./student-dataset.csv | sort | uniq -c | sort -nr












