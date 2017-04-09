################################################################################
#
# scons
#
################################################################################

CUSTOM_SCONS_VERSION = 2.5.1
CUSTOM_SCONS_SITE = http://downloads.sourceforge.net/project/scons/scons/$(CUSTOM_SCONS_VERSION)
CUSTOM_SCONS_SOURCE = scons-$(CUSTOM_SCONS_VERSION).tar.gz
CUSTOM_SCONS_LICENSE = MIT
CUSTOM_SCONS_LICENSE_FILES = LICENSE.txt
CUSTOM_SCONS_SETUP_TYPE = distutils

HOST_CUSTOM_SCONS_NEEDS_HOST_PYTHON = python2

HOST_CUSTOM_SCONS_INSTALL_OPTS = \
	--install-lib=$(HOST_DIR)/usr/lib/scons-$(CUSTOM_SCONS_VERSION)

$(eval $(host-python-package))

# variables used by other packages
SCONS = $(HOST_DIR)/usr/bin/python2 $(HOST_DIR)/usr/bin/scons $(if $(QUIET),-s)
