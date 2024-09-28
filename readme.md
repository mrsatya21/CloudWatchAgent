## How to use

#### Considerations

> [!IMPORTANT]
> 
> + The script is tested on the following architecture and only works on the following OS : 
>
>    > ```
>    > x86_64 (amd64): Amazon Linux 2, Amazon Linux 2023, SLES, RHEL, Ubuntu, Debian
>    > aarch64 (arm64): Amazon Linux 2, Amazon Linux 2023, SLES, RHEL, Ubuntu
>    > ``` 

#### Prerequisites

> [!WARNING]
>
> 1. Please make sure that the EC2 instance(s) have **[necessary permission](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-iam-roles-for-cloudwatch-agent-commandline.html)** attached to it.

#### Download the script 

```sh 
wget "https://raw.githubusercontent.com/sattyagrah/CloudWatchAgent/main/configuration.sh"
```
or

```sh
curl "https://raw.githubusercontent.com/sattyagrah/CloudWatchAgent/main/cwagentinstall.sh" -o "cwagentinstall.sh"
```

#### Give executable permission

```sh
chmod u+x cwagentinstall.sh
```

#### Execute the script

```sh
./cwagentinstall.sh
```

> [!NOTE]
>
> - If users want to change the configuration file of Cloudwatch agent or set the configuration file using wizards, they can do so by following the steps below : 
>
> 1. Before executimg *(after downloading)* the **cwagentinstall.sh** file, make sure to comment the line [42](https://github.com/mrsatya21/CloudWatchAgent/blob/main/cwagentinstall.sh#L42) and [43](https://github.com/mrsatya21/CloudWatchAgent/blob/main/cwagentinstall.sh#L43). 
> 
> 2. Log in to your EC2 instance. 
>
> 3. Run the command :
>    > ```sh
>    > sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
>    > ```
>
> 4. Follow the prompt and answer the questions asked and your configuration file will be ready.
>
> 5. After that you need to run the command *(to start the CloudWatch agent)* : 
>    > ```sh
>    > sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
>    > ```
>
> 6. Bingo! You are all set now. 
