#!/bin/bash

echo "Input from usr"

echo "Enter your name please:"
read name
echo "Your name is:" $name

read -p "Enter your age:" age
echo "Your age is:" $age

read -p "Username: " Username
read -sp "Password: " Password

echo ""

echo $Username $Password