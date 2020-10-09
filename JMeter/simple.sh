working_dir="`pwd`"

#Get namesapce variable

jmx="simple.jmx"
[ -n "$jmx" ] || read -p 'Enter path to the jmx file ' jmx

if [ ! -f "$jmx" ];
then
    echo "Test script file was not found in PATH"
    echo "Kindly check and input the correct file path"
    exit
fi

test_name="$(basename "$jmx")"

#Get Master pod details

master_pod=`kubectl get po  | grep jmeter-master | awk '{print $1}'`

kubectl cp "$jmx"  "$master_pod:/$test_name"

## Echo Starting Jmeter load test

kubectl exec -ti $master_pod -- /bin/bash /load_test "$test_name"