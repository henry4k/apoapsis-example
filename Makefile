include config.mk
include $(BUILD_TOOLS)/tools.mk

NAME = example

ARCHIVE_CONTENTS += README.md
ARCHIVE_CONTENTS += LICENSE
ARCHIVE_CONTENTS += meta.json
ARCHIVE_CONTENTS += $(call rwildcard,'*.lua')
ARCHIVE_CONTENTS += $(call rwildcard,'*.vert')
ARCHIVE_CONTENTS += $(call rwildcard,'*.frag')

XCF_FILES = $(call rwildcard,'*.xcf')
GENERATED_CONTENTS += $(patsubst %.xcf,%.png,$(XCF_FILES))

BLEND_FILES = $(call rwildcard,'*.blend')
GENERATED_CONTENTS += $(patsubst %.blend,%.json,$(BLEND_FILES))

GENERATED        += $(GENERATED_CONTENTS)
ARCHIVE_CONTENTS += $(GENERATED_CONTENTS)

include $(BUILD_TOOLS)/rules.mk
