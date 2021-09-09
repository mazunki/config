export internet_route="$(ip route get 1.1.1.1 | grep "via" | awk '{ print $3 }')"
export internet_interface="$(ip route get 1.1.1.1 | grep "via" | awk '{ print $5 }')"
export ipv4="$(ip addr show $internet_interface | grep "inet[^6]" | awk '{ print $2 }')"
export ipv6="$(ip addr show $internet_interface | grep "inet6" | awk '{ print $2 }')"
