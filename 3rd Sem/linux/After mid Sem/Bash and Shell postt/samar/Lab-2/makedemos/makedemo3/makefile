# Targets of makefile
TARGETS = shapes
# All sources files
SRCS = $(wildcard *.c)

#All object files
OBJS = $(SRCS:.c=.o)

# gcc Flags
CFLAGS = -Wall -g

#colors for printing
YELLOW = \033[33m
GREEN = \033[32m
RED = \033[31m
RESET = \033[0m

all : $(TARGETS)

$(TARGETS):$(OBJS)
	echo -e "$(YELLOW)Linking $@ from $^...$(RESET)"
	gcc -o $@ $^
	
%.o:%.c
	echo -e "$(GREEN)Compiling $< into $@...$(RESET)"
	gcc $(CFLAGS) -c $< -o $@

clean:
	@echo "$(RED)Cleaning up...$(RESET)"
	rm -rf $(OBJS) $(TARGETS)
vars:
	@echo "Variables in Makefile:"
	@echo "TARGET: $(TARGET)"
	@echo "SRCS: $(SRCS)"
	@echo "OBJS: $(OBJS)"
	@echo "CFLAGS: $(CFLAGS)"
