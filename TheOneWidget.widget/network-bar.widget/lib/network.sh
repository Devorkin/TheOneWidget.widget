#!/bin/bash
function getBytes {
    netstat -w1 > TheOneWidget.widget/network-throughput.widget/lib/network.out & sleep 1.5; kill $!;
}
BYTES=$(getBytes > /dev/null);
BYTES=$(cat TheOneWidget.widget/network-throughput.widget/lib/network.out | grep '[0-9].*');
BYTES=$(echo $BYTES | awk '{print $3 "^" $6}');
echo $BYTES;
