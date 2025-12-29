sudo apt update
sudo apt install -y curl ca-certificates
# Install Globus Connect Server 5.4 packages (Ubuntu)
curl -LOs https://downloads.globus.org/globus-connect-server/stable/installers/repo/deb/globus-repo_latest_all.deb
sudo dpkg -i globus-repo_latest_all.deb
sudo apt update
sudo apt install -y globus-connect-server54
#Create the endpoint (run once, non-root)
globus-connect-server endpoint setup "Vinnie GCSv5.4 Endpoint" \
    --organization "vinnielee.io" \
    --owner vinnie@vinnielee.io \
    --contact-email vinnie@vinnielee.io
# Set up services on the Data Transfer Node
sudo globus-connect-server node setup
# Log into the endpoint
globus-connect-server login localhost
