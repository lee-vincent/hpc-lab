#!/bin/bash
set -euo pipefail

# Update system and install dependencies
sudo apt update
sudo apt install -y curl ca-certificates

# Install Globus Connect Server 5.4 repository and packages
curl -LOs https://downloads.globus.org/globus-connect-server/stable/installers/repo/deb/globus-repo_latest_all.deb
sudo dpkg -i globus-repo_latest_all.deb
sudo apt update
sudo apt install -y globus-connect-server54

echo "=========================================="
echo "GCS 5.4 packages installed successfully."
echo ""
echo "Next steps (run manually):"
echo "Run endpoint setup:"
echo "   globus-connect-server endpoint setup \"Vinnie GCSv5.4 Endpoint\" \\"
echo "       --organization \"vinnielee.io\" \\"
echo "       --owner vinnie@vinnielee.io \\"
echo "       --contact-email vinnie@vinnielee.io \\"

echo ""
echo "Run node setup:"
echo "   sudo globus-connect-server node setup"
echo ""
echo "Login to manage endpoint:"
echo "   globus-connect-server login localhost"
echo "=========================================="
