if [[ $# -lt 2 ]]; do
    echo "foff"
fi
book="phonebook.txt"
if [[ ! -f $book ]]; then
    touch $book
fi

display_contact() {
    echo "name: $1 surname: $2 email: $3 phone: $4"
}

search() {
    read -p "enter search query" name
    grep -i $name $book | display_contact
    if [[ $? -ne 0 ]]; then
        echo "$name not found"
    fi 
}

add(){
    read -p "Enter Name: " name
    read -p "Enter Surname: " surname
    read -p "Enter Email: " email
    read -p "Enter Phone: " phone

    duplicate=$(grep -i "$name,$surname,$email,$phone" $book)
    if [[ ! $duplicate == "" ]]; then
        echo "duplicate"
        read -p "do you wanna edit y/n" ar
        if [[ $ar == "y"]]; then
            edit_contact $name
        else 
            echo "done, not added"
        fi
    else
        echo "$name,$surname,$email,$phone" >> $book
        echo "Contact added."
    fi
}

remove_contact() {
    read -p "Enter Name: " name
    match=$(grep -i "$name" $book)
    if [[ $match == "" ]]; then
        echo "nothing to remove"
        return
    fi
    echo "found"
    echo $match
    read -p "really deelte?? y/n" choice
    if [[ choice == "y" ]]; then
        grep -i -v "$name" $book > temp && mv temp $book
        echo "done"
    else 
        echo "nothing done:"
    fi 

}

edit_contact(){
    read -p "Enter search name to edit: " name
    matched=$(grep -i "$name" $book)

    if [[ $matched == "" ]]; then
        echo "No matching contact found."
        return
    fi

    echo "Matching contacts:"
    echo "$matched"

     read -p "Enter new Name: " new_name
    read -p "Enter new Surname: " new_surname
    read -p "Enter new Email: " new_email
    read -p "Enter new Phone: " new_phone

    sed -i "/$name/d" $book
    echo "$new_name,$new_surname,$new_email,$new_phone" >> $book
    echo "Contact updated."
}

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

