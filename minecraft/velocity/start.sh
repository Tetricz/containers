#!/bin/bash
echo -e "Starting proxy server..."
/usr/bin/java -Xms${MEMORY} -Xmx${MEMORY} -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 -jar /velocity.jar
