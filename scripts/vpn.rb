#!/usr/bin/env ruby

require 'json'

def is_vpn_active()
  `systemctl is-active openvpn-client@client`.strip == 'active'
end

def toggle_vpn()
  if is_vpn_active()
    `sudo systemctl stop openvpn-client@client`
  else
    `sudo systemctl start openvpn-client@client`
  end
end

if ARGV[0] == 'exec'
  vpn_status = is_vpn_active()

  output = {
    "text" => vpn_status ? "VPN Connected" : "VPN Disconnected",
    "alt" => vpn_status ? "VPN is connected" : "VPN is disconnected",
    "tooltip" => vpn_status ? "VPN is currently active" : "Click to toggle VPN",
    "class" => vpn_status ? "active" : "inactive",
    "percentage" => vpn_status ? 100 : 0
  }

  puts output.to_json
  $stdout.flush

elsif ARGV[0] == 'toggle'
  toggle_vpn()

else
  puts "Invalid argument. Use 'exec' or 'toggle'."

end

