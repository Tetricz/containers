# Author: tetricz

FROM ubuntu:latest

ENV POOL="pool.supportxmr.com:443" \
    WALLET="43Fm8mKQjGJhKmh6gjyXShaUcPvv5azFFXRQDwpKtCSj5nFgu8rpgsEDM61M5KdFAZbRjcD94PYGDRMBMwgZF1XyJSfqKkD" \
    WORKER="Docker" \
    THREADS="4"

RUN apt-get update && apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev curl automake libtool autoconf msr-tools wget

RUN git clone https://github.com/xmrig/xmrig.git

RUN mkdir -p /app/

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
