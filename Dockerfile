FROM arm64v8/alpine:3.18
WORKDIR /usr/src

RUN apk add \
  alsa-utils \
  mawk \
  pulseaudio~=16 \
  pulseaudio-alsa \
  pulseaudio-utils \
  xxd \
  bash \
  udev \
  dbus

# PulseAudio configuration
COPY pulseaudio/block.pa /etc/pulse/default.pa.d/00-audioblock.pa
COPY pulseaudio/client.conf /etc/pulse/client.conf
COPY pulseaudio/daemon.conf /etc/pulse/daemon.conf

# UDev configuration
COPY udev/95-ritmo-audio.rules /etc/udev/rules.d/95-ritmo-audio.rules

# Entrypoint
COPY entry.sh .
ENTRYPOINT [ "/bin/bash", "/usr/src/entry.sh" ]

CMD [ "pulseaudio" ]