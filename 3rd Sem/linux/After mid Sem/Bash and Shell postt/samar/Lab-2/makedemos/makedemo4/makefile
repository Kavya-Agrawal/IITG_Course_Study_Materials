# macro for library and header file paths
LIBS = -Ifoo/include -Ibar/include -L./foo/lib -L./bar/lib
LIBRARIES = -lfoo -lbar

# Defining Targets and sources
TARGETS = driver
SRC = driver.c 

all : $(TARGETS)
$(TARGETS) : $(SRC)
	gcc -o $@ $^ $(LIBS) $(LIBRARIES)
# cleaning
clean:
	rm -rf $(TARGETS)
