#!/bin/sh

git submodule init
git submodule update --recursive

DLDT_C_WRAPPER_REPO=https://github.com/linxie47/dldt/commit/fbacc7d7e0a9664ebe19ae50c9846433a6b2f85b.patch

cd inference-engine; \
    wget -O - ${DLDT_C_WRAPPER_REPO} | patch -p2; \
    mkdir build; \
    cd build; \
    cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr -DLIB_INSTALL_PATH=/usr/lib/x86_64-linux-gnu -DENABLE_MKL_DNN=ON -DENABLE_CLDNN=OFF -DENABLE_SAMPLE_CORE=OFF  ..; \
    make -j16; \
    rm -rf ../bin/intel64/Release/lib/libgtest*; \
    rm -rf ../bin/intel64/Release/lib/libgmock*; \
    rm -rf ../bin/intel64/Release/lib/libmock*; \
    rm -rf ../bin/intel64/Release/lib/libtest*; \
    for p in /usr ; do \
        mkdir -p $p/include/dldt; \
        cp -r ../include/* $p/include/dldt; \
        libdir="$p/lib/x86_64-linux-gnu"; \
        cp -r ../bin/intel64/Release/lib/* "$libdir"; \
        cp -r ../temp/omp/lib/* "$libdir"; \
        mkdir -p "$libdir/pkgconfig"; \
        pc="$libdir/pkgconfig/dldt.pc"; \
        echo "prefix=/usr" > "$pc"; \
        echo "libdir=/usr/lib/x86_64-linux-gnu" >> "$pc"; \
        echo "includedir=/usr/include/dldt" >> "$pc"; \
        echo "" >> "$pc"; \
        echo "Name: DLDT" >> "$pc"; \
        echo "Description: Intel Deep Learning Deployment Toolkit" >> "$pc"; \
        echo "Version: 5.0" >> "$pc"; \
        echo "" >> "$pc"; \
        echo "Libs: -L\${libdir} -linference_engine -linference_engine_c_wrapper" >> "$pc"; \
        echo "Cflags: -I\${includedir}" >> "$pc"; \
    done;
