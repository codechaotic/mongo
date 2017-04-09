ifeq ($(BR2_PACKAGE_MONGO_3_0),y)
MONGO_VERSION_BASE = 3.0.14
endif

ifeq ($(BR2_PACKAGE_MONGO_3_2),y)
MONGO_VERSION_BASE = 3.2.12
endif

ifeq ($(BR2_PACKAGE_MONGO_3_4),y)
MONGO_VERSION_BASE = 3.4.3
endif

ifeq ($(BR2_PACKAGE_MONGO_3_5),y)
MONGO_VERSION_BASE = 3.5.5
endif

MONGO_VERSION = r$(MONGO_VERSION_BASE)
MONGO_SITE = $(call github,mongodb,mongo,$(MONGO_VERSION))
MONGO_SOURCE = mongo-$(MONGO_VERSION).tar.gz

MONGO_LICENSE = AGPLv3, Apache-2.0
MONGO_LICENSE_FILES = GNU-AGPL-3.0.txt APACHE-2.0.txt

MONGO_DEPENDENCIES += host-custom-scons host-python host-ncurses

ifeq ($(BR2_PACKAGE_MONGO_3_0),y)
MONGO_BUILD_OPTS += --64 --disable-warnings-as-errors
MONGO_BUILD_OPTS += --cc=$(TARGET_CC)
MONGO_BUILD_OPTS += --cxx=$(TARGET_CXX)
MONGO_BUILD_OPTS += --ld=$(TARGET_CXX)
MONGO_BUILD_OPTS += --libpath=$(STAGING_DIR)/lib64:$(STAGING_DIR)/usr/lib64
MONGO_BUILD_OPTS += --variant-dir=variant
MONGO_BUILD_VARS += MONGO_VERSION=$(MONGO_VERSION_BASE)
else
MONGO_BUILD_OPTS += --wiredtiger=on
MONGO_BUILD_VARS += CC=$(TARGET_CC)
MONGO_BUILD_VARS += CXX=$(TARGET_CXX)
MONGO_BUILD_VARS += LIBPATH=$(STAGING_DIR)/lib64:$(STAGING_DIR)/usr/lib64
MONGO_BUILD_VARS += MONGO_DISTNAME=$(MONGO_VERSION)
MONGO_BUILD_VARS += MONGO_VERSION=$(MONGO_VERSION_BASE)
MONGO_BUILD_VARS += VARIANT_DIR=$(MONGO_VERSION_BASE)
MONGO_BUILD_VARS += TARGET_ARCH=x86_64
MONGO_BUILD_VARS += TARGET_OS=linux
endif

ifeq ($(BR2_PACKAGE_MONGO_SSL),y)
MONGO_BUILD_OPTS += --ssl
MONGO_DEPENDENCIES += host-openssl openssl
endif

ifeq ($(BR2_PACKAGE_MONGO_MONGO),y)
MONGO_TARGETS += build/install/bin/mongo
endif

ifeq ($(BR2_PACKAGE_MONGO_MONGOD),y)
MONGO_TARGETS += build/install/bin/mongod
endif

ifeq ($(BR2_PACKAGE_MONGO_MONGOS),y)
MONGO_TARGETS += build/install/bin/mongos
endif

define MONGO_BUILD_CMDS
			 $(SCONS) $(MONGO_BUILD_OPTS) $(MONGO_TARGETS) -C $(@D) $(MONGO_BUILD_VARS)
endef

define MONGO_INSTALL_TARGET_CMDS
				mkdir -p $(TARGET_DIR)/usr/local/bin; \
				cd $(@D)/build/install; \
				cp -R bin/ $(TARGET_DIR)/usr/local
endef

$(eval $(generic-package))
