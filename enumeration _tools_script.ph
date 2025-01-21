!/bin/bash


# Check if an IP address is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

IP_ADDRESS=$1

# Create a directory for the output
OUTPUT_DIR="enumeration_results_$IP_ADDRESS"
mkdir -p "$OUTPUT_DIR"

echo "Starting enumeration for IP: $IP_ADDRESS"
echo "Results will be saved in: $OUTPUT_DIR"

# Nikto scan
echo "Running Nikto..."
nikto -h "$IP_ADDRESS" -output "$OUTPUT_DIR/nikto_results.txt"

# Nmap scan with default scripts and aggressive mode
echo "Running Nmap (aggressive mode)..."
nmap -A "$IP_ADDRESS" -oN "$OUTPUT_DIR/nmap_aggressive_results.txt"

# Nmap scan with scripts
#echo "Running Nmap with scripts..."
#nmap --script vuln "$IP_ADDRESS" -oN "$OUTPUT_DIR/nmap_vuln_results.txt"

# Enum4linux
echo "Running Enum4linux..."
enum4linux -a "$IP_ADDRESS" > "$OUTPUT_DIR/enum4linux_results.txt"

echo "Enumeration completed. Check the $OUTPUT_DIR directory for results."


