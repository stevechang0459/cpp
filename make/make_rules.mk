# Project: cpp
# Makefile created by Steve Chang
# Date modified: 2025.06.01

OBJS = $(addprefix $(OBJDIR)/,$(SRCS:.cpp=.o))
ASMS = $(addprefix $(ASMDIR)/,$(SRCS:.cpp=.s))
DEPS = $(addprefix $(OBJDIR)/,$(SRCS:.cpp=.cpp.d))

# C_INCDIRS = $(foreach dir,$(MODULE_INCLUDES),$(PROJDIR)/$(dir))

CFLAGS = \
	$(OSFLAG) \
	$(addprefix -I,$(COMMON_INCLUDE)) \
	$(addprefix -I,$(EXTERN_INCLUDE)) \
	$(foreach include, . $(INCLUDE), -I$(SRCDIR)/$(include)) \
	-g -O2 -Wall -Werror
# -g -Os -Wall
# -g -Wall

DEFINES +=

# # Extra flags to give to compilers when they are supposed to invoke the linker,
# # ‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
# # instead.
# LDFLAGS = \
# 	-static \
# 	-static-libgcc

# # Library flags or names given to compilers when they are supposed to invoke
# # the linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
# # LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS variable.
# LDLIBS = \
# 	-lpthread

#
ARFLAGS = \
	rcs \
	# rcsv

###
.PHONY: all
all: $(LIBDIR)/$(LIBNAME)

$(LIBDIR)/$(LIBNAME): $(ASMS) $(OBJS)
	$(AR) $(ARFLAGS) $@ $(OBJS)

###
# all: $(BINDIR)/$(BINNAME)

# $(BINDIR)/$(BINNAME): $(OBJS)
# 	$(CC) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@

###
.PHONY: objall
objall: $(OBJS)

$(OBJS): | $(OBJDIR)

$(OBJDIR)/%.o : $(ASMDIR)/%.s
	$(CC) $(DEFINES) $(CFLAGS) -c $< -o $@

$(OBJDIR):
	mkdir $@

###
.PHONY: asmall
asmall: $(ASMS)

$(ASMS): | $(ASMDIR)

$(ASMDIR)/%.s : %.cpp
	$(CC) $(DEFINES) $(CFLAGS) -c $< -S -o $@

$(ASMDIR):
	mkdir $@

###
.PHONY: depall
depall: | $(OBJDIR)
	$(CC) $(DEFINES) $(CFLAGS) -M $(SRCS) > $(OBJDIR)/depend.d
	sed -i 's|\(.*\.o:\)|$(OBJDIR)/\1|g' $(OBJDIR)/depend.d

###
.PHONY: clean
clean:
	rm -rf $(OBJDIR)
	rm -rf $(ASMDIR)

.PHONY: objclean
objclean:
	rm -f $(OBJDIR)/*.o

.PHONY: asmclean
asmclean:
	rm -f $(ASMDIR)/*.s

.PHONY: depclean
depclean:
	rm -f $(OBJDIR)/*.d

ifeq ($(MAKECMDGOALS),all)
ifneq ($(wildcard $(OBJDIR)/depend.d),)
include $(OBJDIR)/depend.d
endif
endif
