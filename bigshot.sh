function kill_background_apps {
    UserPackagesList=$(pm list packages -3 | cut -c9- | tr "\n" " ")
    FocusedApp=$(dumpsys activity activities | grep topResumedActivity=ActivityRecord | tr ={/ ' ' | awk '{print $5}')

    for str in ${UserPackagesList[@]}; do
        if [[ "$str" == "com.bigshot" ]]; then
            echo "Bigshot App..."
        else
            if [[ "$str" == "$FocusedApp" ]]; then
                echo "Focused App..."
            else
                pm disable-user --user 0 $str
            fi
        fi
    done

    pm disable-user --user 0 com.google.android.gms
}

function open_background_apps {
    UserPackagesList=$(pm list packages -3 | cut -c9- | tr "\n" " ")

    for str in ${UserPackagesList[@]}; do
        pm enable $str
    done

    pm enable com.google.android.gms
}

function eficient {
    sleep 10
    kill_background_apps
    su -c stop thermal-engine
    su -c stop thermald
    wm size $(($(wm size | awk '{print $3}' | cut -dx -f1) / 3 * 2))x$(($(wm size | awk '{print $3}' | cut -dx -f2) / 3 * 2))
    wm density $(($(wm density | sed -n '1p' | cut -c19-) / 3 * 2))
}

function disable {
    open_background_apps
    su -c start thermal-engine
    su -c start thermald
    wm size reset
    wm density reset
}

case $1 in
    "enable") eficient ;;
    "disable") disable ;;
    "*") echo "Unknown Command" ;;
esac
