# Defining some Macros
CC = gcc
CFLAGS = -Wall
SRC = main.c
OBJ = $(SRC:.c=.o)
EXEC = myprogram

# condition flag
DEBUG = 0

# target to build programme
all : $(EXEC)

# rules for building EXEC
$(EXEC) : $(OBJ)
# if-else conditioning which here mean if DEBUG = 1 then link with -g flag
ifeq ($(DEBUG),1)
	$(CC) $(CFLAGS) -g -o $@ $^
else
	$(CC) $(CFLAGS) -o $@ $^
endif

# compiling into object file
%.o : %.c
	$(CC) -o $@ -c $<
clean:
	rm -rf $(EXEC)

