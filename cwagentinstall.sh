#!/bin/bash -xe

# Get region through IMDS
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document/ | grep -i region | awk '{print $3}' | tr -d ",[] \"")

# Get the architecture of the instance
ARCH=$(uname -m)

# Get the linux distribution
PLATFORM=$(source /etc/os-release; echo $ID;)

# Import configuration file
source $(dirname "$0")/configuration.sh


# Function to install CloudWatch Agent
cwafunction(){
    NAM=$1
    if [[ $NAM == "ubuntu" || $NAM == "debian" ]]
    then
        PKG=deb
    else
        PKG=rpm
    fi
    mkdir -p /opt/aws/
    cd /opt/aws/
    if [[ $ARCH == "x86_64" ]]
    then
        URL=https://amazoncloudwatch-agent-$REGION.s3.$REGION.amazonaws.com/$NAM/amd64/latest/amazon-cloudwatch-agent.$PKG
    else 
        URL=https://amazoncloudwatch-agent-$REGION.s3.$REGION.amazonaws.com/$NAM/arm64/latest/amazon-cloudwatch-agent.$PKG
    fi
    wget $URL
    if [[ $PKG == "rpm" ]]
    then
        rpm -U ./amazon-cloudwatch-agent.$PKG
    else
        dpkg -i -E ./amazon-cloudwatch-agent.$PKG
    fi
    cd /opt/aws/amazon-cloudwatch-agent/bin
    configfunction
    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
}

# Based on the architecture and OS, installing and configuring CloudWatch agent 

# For AMD64
if [[ $ARCH == "x86_64" ]]
then
    # For SuSE Linux [suse]
    if [[ $PLATFORM == "sles" ]]
    then
        NAME=$(source /etc/os-release; echo $ID_LIKE;)
        cwafunction $NAME

    # For Amazon Linux {2/2023} [amazon_linux]
    elif [[ $PLATFORM == "amzn" ]]
    then
        NAME="amazon_linux"
        cwafunction $NAME

    # For RHEL [redhat]
    elif [[ $PLATFORM == "rhel" ]]
    then
        NAME="radhat"
        cwafunction $NAME

    # For Debian [debian] and Ubuntu [ubuntu]
    elif [[ $PLATFORM == "debian" || $PLATFORM == "ubuntu" ]]
    then
        NAME=$(source /etc/os-release; echo $ID;)
        cwafunction $NAME

    else
        echo "This script is not supported on $PLATFORM"
    fi

# For ARM64
elif [[ $ARCH == "aarch64" ]]
then
    # For SuSE Linux [suse]
    if [[ $PLATFORM == "sles" ]]
    then
        NAME=$(source /etc/os-release; echo $ID_LIKE;)
        cwafunction $NAME

    # For Amazon Linux {2/2023} [amazon_linux]
    elif [[ $PLATFORM == "amzn" ]]
    then
        NAME=$(cat /etc/amazon-linux-release-cpe | awk -F':' '{print $5}')
        cwafunction $NAME

    # For RHEL [redhat]
    elif [[ $PLATFORM == "rhel" ]]
    then
        NAME=radhat
        cwafunction $NAME

    # For Ubuntu [ubuntu]
    elif [[ $PLATFORM == "ubuntu" ]]
    then
        NAME=$(source /etc/os-release; echo $ID;)
        cwafunction $NAME

    # For un-supported platform(s)
    else
        echo "This script is not supported on $PLATFORM"
    fi

# For un-supported architecture(s)
else
    echo "This script is not supported on $ARCH"
fi