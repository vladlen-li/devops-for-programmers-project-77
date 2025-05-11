#!/usr/bin/env bash

set -euo pipefail

DNS_FILE="/etc/dnsmasq.d/terraform-vms.conf"

echo "[*] Checking dnsmasq..."

if ! command -v dnsmasq > /dev/null; then
  echo "[✗] DNS records update failed. dnsmasq is not installed. Install it with: sudo apt install dnsmasq"
  exit 1
fi

if ! pgrep -x dnsmasq > /dev/null; then
  echo "[!] DNS records update failed. dnsmasq is installed but not running. Start it with: sudo systemctl start dnsmasq"
  exit 1
fi

echo "[✓] dnsmasq checks passed"

echo "[*] Generating DNS records from terraform output..."

terraform -chdir=./terraform output -json | jq -r '
  to_entries[]
  | select(.key | test("^vm[0-9]+_ip$"))
  | "address=/"+(.key | sub("_ip$"; ".internal")) + "/" + .value.value
' | sudo tee "$DNS_FILE" > /dev/null

echo "[*] Restarting dnsmasq..."
sudo systemctl restart dnsmasq

echo "[✓] DNS records updated and dnsmasq restarted successfully."

