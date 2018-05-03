#!/bin/bash
peerNumberFlag="false"
connectedNum=0
gluster peer status > tmp
while read LINE
do
        if [[ $LINE == "Number of Peers: 3" ]]
         then
                peerNumberFlag="true"
        else
                echo "in else"
                x=$(echo $LINE | tr "/n" "/n")
                y=$(echo $x | awk '{print $1}')
                z=$(echo $x | awk '{print $5}')
                echo $y || $z
                if [[ $y == "State:" && $z == "(Connected)" ]]
                 then
                        connectedNum=$(($connectedNum+1))
                fi
        fi
done < tmp
if [[ $peerNumberFlag=="true" && $connectedNum=="3" ]] ; then
        echo "Connected"
else
        echo "DissConnected"
fi