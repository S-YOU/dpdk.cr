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
stats ?=       ## Enable statistics output
progress ?= 1  ## Enable progress output [default]
threads ?=     ## Maximum number of threads to use
debug ?=       ## Add symbolic debug info (not full)
verbose ?= 1   ## Run specs in verbose mode
flags ?=       ## Additional build flags

ifeq ($(RTE_SDK),)
    $(error "Please define RTE_SDK environment variable")
endif
RTE_TARGET ?= x86_64-native-linuxapp-gcc
DPDK_PATH = $(RTE_SDK)/$(RTE_TARGET)

BIN := build
EXAMPLES := examples
SOURCES := $(shell find src -name '*.cr')
SPEC_SOURCES := $(shell find spec -name '*.cr')
ROOT_DIR :=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SPEC_FLAGS := $(if $(verbose),-v )

C_EXT_SOURCES = $(shell find src/ext -name '*.c')
C_EXT_OBJS = $(subst .c,.o,$(C_EXT_SOURCES))
C_EXT_TARGET = $(ROOT_DIR)/src/ext/libdpdk.a
LDFLAGS += -std=c++14 -static-libgcc --param max-inline-insns-single=10000 -finline-functions -fPIE -pie -m64 -pthread -march=native -mssse3 -Wl,--no-as-needed -Wl,-export-dynamic -L$(DPDK_PATH)/lib -lc -lnuma -lpthread -ldl -lrt -lm -lgc -levent -lpcre $(if $(release),-O3 -Ofast )
LDFLAGS_WITH_EXT = $(LDFLAGS) $(ROOT_DIR)/src/ext/libdpdk.a
FLAGS := $(flags) $(if $(release),--release )$(if $(stats),--stats )$(if $(progress),--progress )$(if $(threads),--threads $(threads) )$(if $(debug),--error-trace ,--no-debug )$(if $(LDFLAGS_WITH_EXT),--link-flags="$(LDFLAGS_WITH_EXT)" )
DPDK_FLAGS := -I$(DPDK_PATH)/include -include $(DPDK_PATH)/include/rte_config.h -mssse3 -march=native -fPIE

EXAMPLE_SOURCES = $(shell find examples -name '*.cr')
EXAMPLE_BIN = $(subst examples/,,$(subst .cr,,$(EXAMPLE_SOURCES)))
DEPS = $(C_EXT_TARGET)
CFLAGS += $(DPDK_FLAGS) $(if $(debug),-g -O0,$(if $(release),-O3 -Ofast ))
CXXFLAGS += $(DPDK_FLAGS) $(if $(debug),-g -O0,$(if $(release),-O3 -Ofast ))

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
	@crystal build $(FLAGS) $(EXAMPLES)/$@.cr -o $(BIN)/$@
	@grep -hE '^# ?#.*$$' $(EXAMPLES)/$@.cr | sed 's/^# #/##/g' | \
		awk 'BEGIN {FS = "## "}; /^## [A-Z]/ {printf "\033[36m%s\033[0m\n", $$2}; /^## [^A-Z]/ {printf "%s\n", $$2}'

$(C_EXT_TARGET): $(C_EXT_OBJS)
	@if [ "$(release)" = "" ]; then printf "\nINFO: Use \033[36mmake release=1\033[0m for performance\n\n"; fi;
	$(AR) rs $@ $^

$(BIN)/all_spec: $(DEPS)
	@mkdir -p $(BIN)
	@crystal build $(FLAGS) -o $@ spec/all_spec.cr

.PHONY: clean
clean: clean_examples ## Clean up built directories and files
	rm -rf $(C_EXT_OBJS) $(C_EXT_TARGET)

.PHONY: clean_examples
clean_examples: ## Clean up examples
	rm -rf $(BIN)
	rm -rf ./docs
	rm -rf ./bin # old bin

clean_tests:
	rm -f $(BIN)/all_spec
