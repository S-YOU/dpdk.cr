-include Makefile.local # for optional local options e.g. threads

# Recipes for this Makefile

## Build an example from examples/ directory and output in build/ directory
##   $ make hello
## Enable stats output of example
##   $ make l2fwd stats=1
## Build an example in non release mode
##   $ make hello release=
## Clean up built files then the library
##   $ make clean

release ?= 1   ## Compile in release mode [default]
stats ?= 1     ## Enable statistics output [default]
progress ?= 1  ## Enable progress output [default]
threads ?=     ## Maximum number of threads to use
debug ?=       ## Add symbolic debug info (not full)
verbose ?= 1   ## Run specs in verbose mode [default]
flags ?=       ## Additional build flags
link ?=        ## Additional link flags

ifeq ($(RTE_SDK),)
    $(error "Please define RTE_SDK environment variable")
endif
RTE_TARGET ?= x86_64-native-linuxapp-gcc
DPDK_PATH = $(RTE_SDK)/$(RTE_TARGET)

BIN := build
EXAMPLES := examples
SOURCES := $(shell find src -name '*.cr')
SPEC_SOURCES := $(shell find spec -name '*.cr')
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SPEC_FLAGS := $(if $(verbose),-v )

UNAME := $(shell uname)

ifeq ($(UNAME),Darwin)
C_EXT_SOURCES = $(shell find src/ext -name 'fixtures_*.c')
else
C_EXT_SOURCES = $(shell find src/ext -name '*.c')

LINK := $(link)
E1000 := $(shell lspci | grep 82540 2>&1 > /dev/null; echo $$?)
ifeq ($(E1000),0)
	LINK += -lrte_pmd_e1000
endif
endif


C_EXT_OBJS = $(subst .c,.o,$(C_EXT_SOURCES))
C_EXT_TARGET = $(ROOT_DIR)/src/ext/libdpdk.a
LDFLAGS += -std=c++14 -static-libgcc --param max-inline-insns-single=10000 -finline-functions -fPIE -pie -m64 -pthread -march=native -mssse3 -Wl,--whole-archive -Wl,--start-group $(LINK) -Wl,--end-group -Wl,--no-whole-archive -Wl,--no-as-needed -Wl,-export-dynamic -L$(DPDK_PATH)/lib -ldl $(if $(debug),-g -O0,$(if $(release),-O4 -Ofast ))
LDFLAGS_WITH_EXT = $(LDFLAGS) $(ROOT_DIR)/src/ext/libdpdk.a
FLAGS := $(flags) $(if $(debug),--error-trace ,$(if $(release),--release --no-debug -Dgc_none -Ddpdk_patch -Dfiber_none -Dexcept_none -Dhash_none -Dfile_none -Dtime_none --single-module ))$(if $(stats),--stats )$(if $(progress),--progress )$(if $(threads),--threads $(threads) )$(if $(LDFLAGS_WITH_EXT),--link-flags="$(LDFLAGS_WITH_EXT)" )
ifeq ($(UNAME),Linux)
DPDK_FLAGS := -I$(DPDK_PATH)/include -include $(DPDK_PATH)/include/rte_config.h -mssse3 -march=native -fPIE
endif

EXAMPLE_SOURCES = $(shell find examples -name '*.cr')
EXAMPLE_BIN = $(subst examples/,,$(subst .cr,,$(EXAMPLE_SOURCES)))
DEPS = $(C_EXT_TARGET)
CFLAGS += $(DPDK_FLAGS) $(if $(debug),-g -O0,$(if $(release),-O4 -Ofast ))
CXXFLAGS += $(DPDK_FLAGS) $(if $(debug),-g -O0,$(if $(release),-O4 -Ofast ))

.PHONY: all
all: dpdk ## Build all files (currently dpdk only) [default]

.PHONY: help
help: ## Show this help
	@echo
	@printf '\033[34mtargets:\033[0m\n'
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |\
		sort |\
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo
	@printf '\033[34moptional variables:\033[0m\n'
	@grep -hE '^[a-zA-Z_-]+ \?=.*?## .*$$' $(MAKEFILE_LIST) |\
		sort |\
		awk 'BEGIN {FS = " \\?=.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo
	@printf '\033[34mrecipes:\033[0m\n'
	@grep -hE '^##.*$$' $(MAKEFILE_LIST) |\
		awk 'BEGIN {FS = "## "}; /^## [a-zA-Z_-]/ {printf "  \033[36m%s\033[0m\n", $$2}; /^##  / {printf "  %s\n", $$2}'

.PHONY: dpdk
dpdk: $(DEPS) ## Build the library

.PHONY: spec
spec: clean_tests $(BIN)/all_spec ## Run all specs
	sudo $(BIN)/all_spec $(SPEC_FLAGS)

.PHONY: docs
docs: ## Generate standard library documentation
	@crystal docs src/docs.cr

.PHONY: $(EXAMPLE_BIN)
$(EXAMPLE_BIN): $(DEPS) # Build an example
	@if [ "$(release)" = "" ]; then printf "\nINFO: Use \033[36mmake $@ release=1\033[0m for performance\n\n"; fi;
	@mkdir -p $(BIN)
	crystal build $(FLAGS) $(EXAMPLES)/$@.cr -o $(BIN)/$@
	@grep -hE '^# ?#.*$$' $(EXAMPLES)/$@.cr | sed 's/^# #/##/g' | \
		awk 'BEGIN {FS = "## "}; /^## [A-Z]/ {printf "\033[36m%s\033[0m\n", $$2}; /^## [^A-Z]/ {printf "%s\n", $$2}'

$(C_EXT_TARGET): $(C_EXT_OBJS)
	@if [ "$(release)" = "" ]; then printf "\nINFO: Use \033[36mmake release=1\033[0m for performance\n\n"; fi;
	$(AR) rs $@ $^

$(BIN)/all_spec: $(DEPS)
	@mkdir -p $(BIN)
	@crystal build $(FLAGS) -o $@ spec/all_spec.cr

.PHONY: clean
clean: clean_examples clean_ext ## Clean up built directories and files

clean_examples:
	rm -rf $(BIN)
	rm -rf ./docs
	rm -rf ./bin # old bin

clean_ext:
	rm -rf $(C_EXT_OBJS) $(C_EXT_TARGET)

clean_tests:
	rm -f $(BIN)/all_spec
