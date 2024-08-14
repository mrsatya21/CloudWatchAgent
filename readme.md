## How to use

#### Considerations

1. The script is tested on the following architecture and only work on the following OS : 

    > ```
    > x86_64 : Amazon Linux 2, Amazon Linux 2023, SLES, RHEL, Debian, Ubuntu
    > aarch64 : Amazon Linux 2, Amazon Linux 2023, SLES, RHEL, Ubuntu
    > ``` 

#### Prerequisites

1. Please make sure that the EC2 instance(s) have `wget` package installed in it. 
2. Please make sure that the EC2 instance have **[necessary permission](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-iam-roles-for-cloudwatch-agent-commandline.html)** attached to it.

#### Download the script 

```sh 
wget https://raw.githubusercontent.com/mrsatya21/CloudWatchAgent/main/configuration.sh

wget https://raw.githubusercontent.com/mrsatya21/CloudWatchAgent/main/cwagentinstall.sh
```

#### Give executable permission

```sh
chmod u+x cwagentinstall.sh
```

#### Execute the script

```sh
./cwagentinstall.sh
```

