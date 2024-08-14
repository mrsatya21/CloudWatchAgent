#!/bin/bash -xe

# Set the function to create config.json file
configfunction(){
    cat <<EOT > config.json
    {
        "agent": {
            "metrics_collection_interval": 60,
            "run_as_user": "cwagent"
        },
        "metrics": {
            "metrics_collected": {
                "mem": {
                    "measurement": ["used_percent", "total", "used"],
                    "metrics_collection_interval": 30
                },
                "cpu": {
                    "measurement": ["cpu_usage_idle", "cpu_usage_user", "cpu_usage_system"],
                    "metrics_collection_interval": 60,
                    "totalcpu": true
                },
                "disk": {
                    "measurement": ["used_percent", "used", "total"],
                    "metrics_collection_interval": 60,
                    "resources": ["*"]
                }
            }
        }
    }
EOT
}