# DockerSlim - MongoDB

This project builds slim docker images for running MongoDB using buildroot. As
with most docker images, there is little need to include a fully stocked OS like
debian or ubuntu along with your package. These images are based on customized
embedded systems and contain only the files they need to.

# Building the images

This project is based on [buildroot-submodule](https://github.com/Openwide-Ingenierie/buildroot-submodule)
so for details of its implementation please check out that project's `README.md`.
There are three steps to building any desired image.

* Build the project toolchain - `make -f Makefile.toolchain`
* Build the image filesystem - `make -f Makefile.<image-name>`
* Create the image - docker build -t <image-name> ./project-<image-name>

For example, to build the mongod image:
```
> make -f Makefile.mongod
> docker build -t mongod ./project-mongod
```

Building the filesystem can take upwards of 20 minutes depending on your machine
so it may be helpful to capture the output in a file. This can be done easily:
```
make -f Makefile.mongod 2>&1 | tee build.log
```

## Licence

dockerslim/mongodb is provided under the GPLv3 or later. The licence is provided in the _LICENCE_ file. Note that this licence only covers the files provided by dockerslim/mongodb. It does not cover mongo (which is a mix of APACHE-2.0 and AGPL) nor any software installed by buildroot nor the buildroot-submodule project (they have their own licences).
