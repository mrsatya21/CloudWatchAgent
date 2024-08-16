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

#### Note 

- If user want to change the configuration file of cloudwatch agent or set the configuration file using wizard, they can do so by following the steps below : 

1. Before executimg *(after downloading)* the **cwagentinstall.sh** file, make sure to comment the line [42](https://github.com/mrsatya21/CloudWatchAgent/blob/main/cwagentinstall.sh#L42) and [43](https://github.com/mrsatya21/CloudWatchAgent/blob/main/cwagentinstall.sh#L43). 

2. Log in to your EC2 instane. 

3. Run the command :
    > ```sh
    > sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
    > ```

4. Follow the prompt and answer few questions and your configuration file will be ready.

5. After that you need to run the command *(to start the CloudWatch agent)* : 
    > ```sh
    > sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
    > ```

6. Bingo! You are all set now. 