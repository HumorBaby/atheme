# Additional extensions for building single-file modules.

.SUFFIXES: $(PLUGIN_SUFFIX)

plugindir = ${MODDIR}/modules/$(MODULE)
PLUGIN=${SRCS:.c=$(PLUGIN_SUFFIX)}

install: $(PLUGIN)

.c$(PLUGIN_SUFFIX):
	COMPILER=${CC}; \
	COMPILER_FLAGS="-MMD -MP ${CFLAGS} ${PLUGIN_CFLAGS} ${CPPFLAGS} ${PLUGIN_LDFLAGS} ${LDFLAGS} -o $@ $< ${LIBS}"; \
	${COMPILE_STATUS}; \
	if $${COMPILER} $${COMPILER_FLAGS}; then \
		${COMPILE_OK}; \
	else \
		${COMPILE_FAILED}; \
	fi

ifndef V

COMPILE_STATUS = printf "CompileModule: $@\n"
COMPILE_OK = true

else

COMPILE_STATUS = printf "CompileModule: $$COMPILER $$COMPILER_FLAGS\n"
COMPILE_OK = true

endif

-include *.d
