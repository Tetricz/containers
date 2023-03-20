#!/bin/bash
if [ ! -f /app/xmrig ]; then
    echo "Building xmrig"
    mkdir xmrig/build && cd xmrig/scripts
    ./randomx_boost.sh
    ./build_deps.sh && cd ../build
    cmake .. -DXMRIG_DEPS=scripts/deps
    make -j$(nproc)
    cp -v /xmrig/build/xmrig /app/xmrig
fi
# https://xmrig.com/docs/miner/build/ubuntu

echo "Starting xmrig"
echo "/app/xmrig -o ${POOL} -u ${WALLET} -k --tls -p ${WORKER} -t ${THREADS} --donate-level=1 --randomx-1gb-pages"
/app/xmrig -o ${POOL} -u ${WALLET} -k --tls -p ${WORKER} -t ${THREADS} --donate-level=1 --randomx-1gb-pages
