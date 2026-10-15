RC ?= rc
TARGET ?= $(HOME)
PACKAGES ?=

.PHONY: check install uninstall
check install uninstall:
	$(RC) ./link.rc $@ "$(TARGET)" $(PACKAGES)
