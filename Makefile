SWITCH_FLAGS := --show-trace --verbose
SWITCH_PROFILE := --flake ~/.config/system

OS := $(shell uname -s)
ifeq ($(OS),Darwin)
	SWITCH_CMD := sudo -i darwin-rebuild switch
else
	SWITCH_CMD := sudo nixos-rebuild switch
endif

switch: 
	$(SWITCH_CMD) $(SWITCH_FLAGS) $(SWITCH_PROFILE)

.PHONY: switch

