MONGODB_VERSION = r3.0.4
MONGODB_SITE = git://github.com/mongodb/mongo
MONGODB_SITE_METHOD = git

MONGODB_DEPENDENCIES += host-scons host-python
MONGODB_BUILD_OPTS += --disable-warnings-as-errors

# Currently builds with SSL enabled are broken
ifeq ($(BR2_PACKAGE_MONGODB_SSL),y)
MONGODB_BUILD_OPTS += --ssl
MONGODB_DEPENDENCIES += host-openssl openssl
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGO),y)
MONGODB_TARGETS += build/install/bin/mongo
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGOD),y)
MONGODB_TARGETS += build/install/bin/mongod
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGOS),y)
MONGODB_TARGETS += build/install/bin/mongos
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGOPERF),y)
MONGODB_TARGETS += build/install/bin/mongoperf
endif

define MONGODB_BUILD_CMDS
			 $(SCONS) $(MONGODB_TARGETS) $(MONGODB_BUILD_OPTS) -C $(@D)
endef

# $(info $$MONGODB_BUILD_CMDS is [$(MONGODB_BUILD_CMDS)])
# $(error Aborting!)

define MONGODB_INSTALL_TARGET_CMDS
				mkdir -p $(TARGET_DIR)/usr/local; \
				cd $(@D)/build/install; \
				cp -R bin/ $(TARGET_DIR)/usr/local
endef

$(eval $(generic-package))
