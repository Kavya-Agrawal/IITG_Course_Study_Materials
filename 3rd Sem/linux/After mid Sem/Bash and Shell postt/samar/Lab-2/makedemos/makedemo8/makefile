# macro for libraries path and executable file
LIB = /usr/include/GL
EXEC = intertroboarm

# macro for falgs to include libraries
CPPFLAGS = -I$(LIB)
LDFLAGS = -lGL -lGLU -lglut -lm

# rules to make executable files
$(EXEC): intertroboarm.cpp
	g++ -o $(EXEC) intertroboarm.cpp $(CPPFLAGS) $(LDFLAGS)

# cleaning 
clean:
	rm -f $(EXEC)
