FROM golang

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  automake build-essential curl \
  cdbs debhelper dh-autoreconf flex bison \
  libjpeg-dev libtiff-dev libpng-dev libgif-dev librsvg2-dev libpoppler-glib-dev zlib1g-dev fftw3-dev liblcms2-dev \
  liblcms2-dev libmagickwand-dev libfreetype6-dev libpango1.0-dev libfontconfig1-dev libglib2.0-dev libice-dev \
  gettext pkg-config libxml-parser-perl libexif-gtk-dev liborc-0.4-dev libopenexr-dev libmatio-dev libxml2-dev \
  libcfitsio-dev libopenslide-dev libwebp-dev libgsf-1-dev libgirepository1.0-dev gtk-doc-tools

ENV LIBVIPS_VERSION 8.7.0

RUN \
  # Build libvips
  cd /tmp && \
  curl -OL https://github.com/libvips/libvips/releases/download/v${LIBVIPS_VERSION}/vips-${LIBVIPS_VERSION}.tar.gz && \
  tar zxvf vips-$LIBVIPS_VERSION.tar.gz && \
  cd /tmp/vips-$LIBVIPS_VERSION && \
  ./configure --enable-debug=no --without-python $1 && \
  make && \
  make install && \
  ldconfig

RUN \
  # Clean up
  apt-get remove -y automake curl build-essential && \
  apt-get autoremove -y && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#CMD [ "/bin/bash" ]