export DEBIAN_FRONTEND=noninteractive

echo "Start script"

## repo for git
add-apt-repository -y ppa:git-core/ppa

apt-get update -y
apt-get upgrade -y

# install dependencies
apt-get install -y  \
      curl \
      sudo \
      git \
      tar \
      unzip \
      zip \
      wget \
      apt-transport-https \
      ca-certificates \
      software-properties-common \
      make \
      jq \
      gnupg2 \
      openssh-client

# docker
echo "installing docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
apt update -y
apt-get install -y docker.io

# curl -fsSL https://get.docker.com -o get-docker.sh
# sh get-docker.sh

# Enable docker.service
systemctl is-active --quiet docker.service || systemctl start docker.service
systemctl is-enabled --quiet docker.service || systemctl enable docker.service

if ! command -v docker &> /dev/null
then
    echo "docker could not be found"
    exit 1
fi

# Install latest docker-compose from releases
echo "installing docker compose"
URL="https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64"
curl -L $URL -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose



# # Inialize Disk if necessary
# curl -o /tmp/vm-disk-utils-0.1.sh https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/shared_scripts/ubuntu/vm-disk-utils-0.1.sh
# chmod +x /tmp/vm-disk-utils-0.1.sh
# bash /tmp/vm-disk-utils-0.1.sh

# # Extract diskname with LUM = 10
# DISKNAME=$(lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep '.:.:.:${disk_lun}' | awk '{ print $1 }')
# echo "Diskname found : $DISKNAME"

# # Create directory 
# if [[ -d "/datadrive" ]]; then
#     echo "datadrive directory found"
# else
#     echo "datadrive directory not found, create it"
#     mkdir /datadrive
# fi

# PARTITION=$(printf "%s1" "$DISKNAME"
# mount /dev/$PARTITION /datadrive
# echo "Datadrive mounted"