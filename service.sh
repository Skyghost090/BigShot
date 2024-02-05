count=0

while [ -n $count ]; do
    timeout 2s getevent | grep '0001 0073 00000001' && timeout 2s getevent | grep '0001 0073 00000001' && sh 'bigshot.sh' performace
    timeout 2s getevent | grep '0001 0072' && timeout 2s getevent | grep '0001 0072' && sh 'bigshot.sh' eficient
    timeout 2s getevent | grep '0001 0074 00000001' && timeout 2s getevent | grep '0001 0074 00000001' && sh 'bigshot.sh' disable
done
