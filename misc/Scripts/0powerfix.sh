#!/run/current-system/sw/bin/bash
# This Script Is For Fixing The 0 False Positive Reading For Power Usage in Mangohud
sudo chmod o+r /sys/class/powercap/intel-rapl\:0/energy_uj
