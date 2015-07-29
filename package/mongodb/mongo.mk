MONGO_VERSION = r3.0.4
MONGO_SITE = git://github.com/mongodb/mongo
MONGO_SITE_METHOD = git

MONGO_DEPENDENCIES = host-scons host-python
MONGO_BUILD_OPTS = --disable-warnings-as-errors
MONGO_INSTALL_OPTS = --prefix=$(TARGET_DIR)/usr/local

ifeq ($(BR2_PACKAGE_OPENSSL),y)
MONGO_BUILD_OPTS += --ssl
MONGO_DEPENDENCIES += openssl
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGO),y)
MONGO_BUILD_TARGETS += mongo
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGOD),y)
MONGO_BUILD_TARGETS += mongod
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGOS),y)
MONGO_BUILD_TARGETS += mongos
endif

ifeq ($(BR2_PACKAGE_MONGODB_MONGOPERF),y)
MONGO_BUILD_TARGETS += mongoperf
endif

define MONGO_BUILD_CMDS
			 $(SCONS) -C $(@D) $(MONGO_BUILD_OPTS) $(MONGO_BUILD_TARGETS)
endef

define MONGO_INSTALL_TARGET_CMDS
			 $(SCONS) -C $(@D) $(MONGO_INSTALL_OPTS) install
endef

$(eval $(generic-package))
