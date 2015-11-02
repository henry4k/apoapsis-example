include config.mk

NAME = example

ARCHIVE_CONTENTS += README.md
ARCHIVE_CONTENTS += LICENSE
ARCHIVE_CONTENTS += $(wildcard *.lua **/*.lua)
ARCHIVE_CONTENTS += $(wildcard *.vert **/*.vert)
ARCHIVE_CONTENTS += $(wildcard *.frag **/*.frag)

GENERATED_CONTENTS += $(patsubst %.xcf,%.png,$(wildcard *.xcf **/*.xcf))
GENERATED_CONTENTS += $(patsubst %.blend,%.json,$(wildcard *.blend **/*.blend))

GENERATED        += $(GENERATED_CONTENTS)
ARCHIVE_CONTENTS += $(GENERATED_CONTENTS)

include $(BUILD_TOOLS)/rules.mk
