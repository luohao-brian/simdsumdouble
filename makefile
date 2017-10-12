# flags
CC = g++
CFS = -Wall -msse2 -mavx

# args
RELEASE =0
BITS =
CFLAGS =

# [args] 生成模式. 0代表debug模式, 1代表release模式. make RELEASE=1.
ifeq ($(RELEASE),0)
	# debug
	CFS += -g
else
	# release
	CFS += -O3 -DNDEBUG
	//CFS += -O3 -g -DNDEBUG
endif

# [args] 程序位数. 32代表32位程序, 64代表64位程序, 其他默认. make BITS=32.
ifeq ($(BITS),32)
	CFS += -m32
else
	ifeq ($(BITS),64)
		CFS += -m64
	else
	endif
endif

# [args] 使用 CFLAGS 添加新的参数. make CFLAGS="-mavx".
CFS += $(CFLAGS)


.PHONY : all clean

# files
TARGETS = simdsumdouble
OBJS = simdsumdouble.o

all : $(TARGETS)

simdsumdouble : $(OBJS)
	$(CC) $(CFS) -o $@ $^


simdsumdouble.o : simdsumdouble.c zintrin.h ccpuid.h
	$(CC) $(CFS) -c $<


clean :
	rm -f $(OBJS) $(TARGETS) $(addsuffix .exe,$(TARGETS))
