# all:
# 	gcc -c foo/src/foo.c -o foo/obj/foo.o -Ifoo/include
# 	ar rcs foo/lib/libfoo.a foo/obj/foo.o #it create libfoo.a
# 	gcc -c bar/src/bar.c -o bar/obj/bar.o -Ibar/include
# 	ar rcs bar/lib/libbar.a bar/obj/bar.o #it create libbar.a
# 	gcc driver.c -Ifoo/include -Ibar/include -L./foo/lib -L./bar/lib -lfoo -lbar
# 	 ./a.out


# CC = gcc
# CFLAGS = $(INCLUDES) -Wall -Wextra -O2
# LDFLAGS = $(LIBS)

# # Define the target executable name
# TARGET = driver

# # Define the source file
# SRC = driver.c

# # Rule to build the executable
# $(TARGET): $(SRC)
# 	@echo "Compiling $< into $@"
# 	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

# # Clean rule to remove the executable


LIBS = -Lfoo/lib -lfoo -Lbar/lib -lbar
INCLUDES = -Ifoo/include -Ibar/include

driver : driver.c foo/lib/libfoo.a bar/lib/libbar.a
	gcc driver.c $(LIBS) -o driver

foo/lib/libfoo.a : foo/obj/foo.o
	ar rcs foo/lib/libfoo.a foo/obj/foo.o

bar/lib/libbar.a : bar/obj/bar.o
	ar rcs bar/lib/libbar.a bar/obj/bar.o

foo/obj/foo.o : foo/src/foo.c
	gcc -c $(INCLUDES) foo/src/foo.c -o foo/obj/foo.o

bar/obj/bar.o : bar/src/bar.c
	gcc -c $(INCLUDES) bar/src/bar.c -o bar/obj/bar.o

clean:
	rm -f libdriver foo/obj/foo.o bar/obj/bar.o foo/lib/libfoo.a bar/lib/libbar.a
	@echo "Cleanup completed"

