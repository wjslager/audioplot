CFLAGS = -I /usr/local/include -I include -Wall -std=c++1z
LDFLAGS = -lpthread

# Name of executable
PG = audioplot

# Search these folders for source and header files
vpath %.cpp src
vpath %.h include

# Files to compile and link
OBJ = main.o  

# MAKE INSTRUCTIONS

all: $(PG)

$(PG): $(OBJ)
	$(CXX) -o $@ $(CFLAGS) $(OBJ) $(LDFLAGS)

.cpp.o:
	$(CXX) -c $< $(CFLAGS)

clean:
	rm -f *.o
	rm -f $(PG)
