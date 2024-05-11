param2=$2
param3=$3
param4=$4
param5=$5
param6=$6
param7=$7
function kill_background_apps {
    echo $param2

    if [[ $param2 = "" ]]; then
        echo "Please type id from the app"
        exit 3
    fi

    UserPackagesList=$(pm list packages -3 | cut -c9- | tr "\n" " ")

    for str in ${UserPackagesList[@]}; do
        pm disable-user --user 0 $str
    done

    pm disable-user --user 0 com.google.android.gms
    pm enable $param2
    pm enable $param3
    pm enable $param2
    pm enable $param3
    pm enable $param4
    pm enable $param5
    pm enable $param6
    pm enable $param7
}

function open_background_apps {
    UserPackagesList=$(pm list packages -3 | cut -c9- | tr "\n" " ")

    for str in ${UserPackagesList[@]}; do
        pm enable $str
    done

    pm enable com.google.android.gms
}

function performace {
    kill_background_apps
}

function eficient {
    kill_background_apps
    wm size $(($(wm size | awk '{print $3}' | cut -dx -f1) / 3))x$(($(wm size | awk '{print $3}' | cut -dx -f2) / 3))
    wm density $(($(wm density | sed -n '1p' | cut -c19-) / 3))
}

function disable {
    open_background_apps
    wm size reset
    wm density reset
}

case $1 in
    "enable") eficient ;;
    "disable") disable ;;
    "*") echo "Unknown Command" ;;
esac
