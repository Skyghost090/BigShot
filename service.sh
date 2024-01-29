function kill_background_apps {
    CurrentApp=$(dumpsys window | grep mCurrentFocus | tr -d '}' | tr -d '{' | tr -d '=' | cut -c33- | rev | cut -d '/' -f2-2 | rev)
    UserPackagesList=$(pm list packages -3 | cut -c9- | tr "\n" " ")
    ParableApps=$(echo $UserPackagesList | sed "s/$(echo $CurrentApp | cut -d ' ' -f2)/ /g")
    for str in ${ParableApps[@]}; do
        pm disable-user --user 0 $str
    done
    pm disable-user --user 0 com.google.android.gms
    CurrentApp=$(echo $CurrentApp | cut -d " " -f2)
    am start -n $CurrentApp/$CurrentApp.MainActivity
}

function open_background_apps {
    CurrentApp=$(dumpsys window | grep mCurrentFocus | tr -d '}' | tr -d '{' | tr -d '=' | cut -c33- | rev | cut -d '/' -f2-2 | rev)
    UserPackagesList=$(pm list packages -3 | cut -c9- | tr "\n" " ")
    ParableApps=$(echo $UserPackagesList | sed "s/$CurrentApp/ /g")
    for str in ${ParableApps[@]}; do
        pm enable $str
    done
    pm enable com.google.android.gms
}

function performace {
    kill_background_apps
}

function eficient {
    kill_background_apps
    wm size $(($(wm size | awk '{print $3}' | cut -dx -f1) / 3 * 2))x$(($(wm size | awk '{print $3}' | cut -dx -f2) / 3 * 2))
    wm density $(($(wm density | sed -n '1p' | cut -c19-) / 3 * 2))

}

function disable {
    open_background_apps
    wm size reset
    wm density reset
}

case $1 in
    "performace") performace ;;
    "eficient") eficient ;;
    "disable") disable ;;
    "*") echo "Unknown Command" ;;
esac
