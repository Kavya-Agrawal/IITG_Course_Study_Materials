# Creating macros for required multiple executable file and paths to them
EXEC = shapes driver list-primes
LIBS = ../makedemo3 ../makedemo4 ../makedemo5
# Running all commands
all:
	@for dir in $(LIBS); do\
		$(MAKE) -C $$dir all ;\
	done
# Running all the makefile
clean:
	@for dir in $(LIBS); do\
		$(MAKE) -C $$dir clean ;\
	done
	
