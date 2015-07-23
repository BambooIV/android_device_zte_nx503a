#!/system/bin/sh

powermode=`getprop sys.perf.profile`
dev_governor=`ls /sys/class/devfreq/qcom,cpubw*/governor`
        case "$powermode" in
            "2")
		 stop mpdecision
		 sleep 1
                 echo 2265600                              > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                 echo 2265600                              > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
                 echo 2265600                              > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
                 echo 2265600                              > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
                 echo 0                                    > /sys/devices/system/cpu/sched_mc_power_savings
                 echo performance                          > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                 echo performance                          > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                 echo performance                          > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                 echo performance                          > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                 echo 20                                   > /sys/module/cpu_boost/parameters/boost_ms
                 echo 1728000                              > /sys/module/cpu_boost/parameters/sync_threshold
                 echo 1497600                              > /sys/module/cpu_boost/parameters/input_boost_freq
                 echo 40                                   > /sys/module/cpu_boost/parameters/input_boost_ms
                 echo 578000000                            > /sys/class/kgsl/kgsl-3d0/max_gpuclk
                 echo performance                          > /sys/class/kgsl/kgsl-3d0/devfreq/governor
                 echo "msm_cpufreq"                        > $dev_governor
              ;;
            "1")
		 start mpdecision
		 sleep 1
                 echo 2265600                              > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                 echo 2265600                              > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
                 echo 2265600                              > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
                 echo 2265600                              > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
                 echo 2                                    > /sys/devices/system/cpu/sched_mc_power_savings
                 echo interactive                          > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                 echo interactive                          > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                 echo interactive                          > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                 echo interactive                          > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                 echo "20000 1400000:40000 1700000:20000"  > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
                 echo 90                                   > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
                 echo 1497600                              > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
                 echo "85 1500000:99"                      > /sys/devices/system/cpu/cpufreq/interactive/target_loads
                 echo 40000                                > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
                 echo 20                                   > /sys/module/cpu_boost/parameters/boost_ms
                 echo 1728000                              > /sys/module/cpu_boost/parameters/sync_threshold
                 echo 1497600                              > /sys/module/cpu_boost/parameters/input_boost_freq
                 echo 40                                   > /sys/module/cpu_boost/parameters/input_boost_ms
                 echo 578000000                            > /sys/class/kgsl/kgsl-3d0/max_gpuclk
                 echo msm-adreno-tz                        > /sys/class/kgsl/kgsl-3d0/devfreq/governor
                 echo "cpubw_hwmon"                        > $dev_governor
             ;;
             "0")
		 start mpdecision
		 sleep 1
                 echo 1574400                              > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                 echo 1574400                              > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
                 echo 1574400                              > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
                 echo 1574400                              > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
                 echo 2                                    > /sys/devices/system/cpu/sched_mc_power_savings
                 echo conservative                         > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                 echo conservative                         > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                 echo conservative                         > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                 echo conservative                         > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                 echo 0                                    > /sys/module/cpu_boost/parameters/boost_ms
                 echo 960000                               > /sys/module/cpu_boost/parameters/sync_threshold
                 echo 960000                               > /sys/module/cpu_boost/parameters/input_boost_freq
                 echo 40                                   > /sys/module/cpu_boost/parameters/input_boost_ms
                 echo 389000000                            > /sys/class/kgsl/kgsl-3d0/max_gpuclk
                 echo msm-adreno-tz                        > /sys/class/kgsl/kgsl-3d0/devfreq/governor
                 echo "cpubw_hwmon"                        > $dev_governor
              ;;
        esac

