# TP 1

## Part I : Init

### I : Installation de Docker

> Passée car déjà installé

### II : Un premier conteneur en vif

#### 1. Simple Run

##### Lancer un conteneur `meow-api` :

```
> docker run -p 8000:8000 it4lik/meow-api:arm
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://172.17.0.2:8000
Press CTRL+C to quit
```

##### Visitons

- vérifier que le conteneur est actif avec une commande qui liste les conteneurs en cours de fonctionnement
```
> docker ps
CONTAINER ID   IMAGE                 COMMAND           CREATED         STATUS         PORTS                    NAMES
66fc6b8bd9cd   it4lik/meow-api:arm   "python app.py"   3 seconds ago   Up 3 seconds   0.0.0.0:8000->8000/tcp   modest_goodall
```
- afficher les logs du conteneur
```
docker logs 66fc6b8bd9cd
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://172.17.0.2:8000
Press CTRL+C to quit
```
- afficher toutes les informations relatives au conteneur avec une commande docker inspect
[```docker inspect 66fc6b8bd9cd```](#la-commande-docker-inspect-66fc6b8bd9cd-et-son-output)
- depuis le navigateur de votre PC, visiter la route / de l'API sur http://votre_ip:8000
[```http://127.0.0.1:800/```](http://127.0.0.1:800/)

##### Lancer le conteneur en tâche de fond

- ajoutez `-d` à la commande
```
docker run -d -p 8000:8000 it4lik/meow-api:arm
66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f
```

- consultez les logs du conteneur
```
docker logs 66fc6b8bd9cd
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://172.17.0.2:8000
Press CTRL+C to quit
172.17.0.1 - - [23/Jun/2025 08:26:29] "GET / HTTP/1.1" 200 -
```

#### 2. Volumes

##### Remplacer le code de `app.py`
```
docker run -d -v "$(pwd)/app.py:/app/app.py" -p 8000:8000 it4lik/meow-api:arm
2e53ba08b35c4c4f05e32afb9a442dec817f1e405f0f81cd2107becc969d7a67
```

##### Prouvez que ça fonctionne avec une requête Web
```
curl http://127.0.0.1:8000
{"message":"Le curl fonctionne chef !"}
```

#### 3. Variables d'environnement

##### Définir une variable d'environnement au lancement du conteneur / Mettez à jour l'option `-p`
```
docker run -d -v "$(pwd)/app.py:/app/app.py" -e LISTEN_PORT=16789 -p 16789:16789 it4lik/meow-api:arm
2e0df2d1018426fe0a5569b28544f9f8f3501a86fd2e5ff10c449872ef4eda37
```

##### Prouvez que ça fonctionne avec une requête Web
```
curl http://127.0.0.1:16789
{"listen_port":"16789","message":"Le curl fonctionne chef !"}
```

## Annexe

####### La commande `docker inspect 66fc6b8bd9cd` et son output

```
> docker inspect 66fc6b8bd9cd
[
    {
        "Id": "66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f",
        "Created": "2025-06-23T08:11:28.275360263Z",
        "Path": "python",
        "Args": [
            "app.py"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 34799,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2025-06-23T08:11:28.316022888Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:aa62b5955aa84ac21143ef9294108b06701d36d3e90ad49896e811066542a107",
        "ResolvConfPath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/hostname",
        "HostsPath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/hosts",
        "LogPath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f-json.log",
        "Name": "/modest_goodall",
        "RestartCount": 0,
        "Driver": "overlayfs",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "bridge",
            "PortBindings": {
                "8000/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "8000"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "ConsoleSize": [
                53,
                187
            ],
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "private",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": [],
            "BlkioDeviceWriteBps": [],
            "BlkioDeviceReadIOps": [],
            "BlkioDeviceWriteIOps": [],
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": null,
            "PidsLimit": null,
            "Ulimits": [],
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware",
                "/sys/devices/virtual/powercap"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": null,
            "Name": "overlayfs"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "66fc6b8bd9cd",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "8000/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "GPG_KEY=7169605F62C751356D054A26A821E680E5FA6305",
                "PYTHON_VERSION=3.13.5",
                "PYTHON_SHA256=93e583f243454e6e9e4588ca2c2662206ad961659863277afcdb96801647d640"
            ],
            "Cmd": [
                "python",
                "app.py"
            ],
            "Image": "it4lik/meow-api:arm",
            "Volumes": null,
            "WorkingDir": "/app",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "c18e29927a3d5777f8f2fa1428ffb5f34d863454ad5dfb501033cc6248cda3dd",
            "SandboxKey": "/var/run/docker/netns/c18e29927a3d",
            "Ports": {
                "8000/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "8000"
                    }
                ]
            },
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "6a14cee168a1a55fcf185f5bd2082b732bc305b04472ba822ce90cdc7d19d056",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null,
                    "NetworkID": "92028fc84abf3c36ec406a4b2bff55effbcefa85a627dfb2aba5e054b288f305",
                    "EndpointID": "6a14cee168a1a55fcf185f5bd2082b732bc305b04472ba822ce90cdc7d19d056",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "DNSNames": null
                }
            }
        }
    }
]
```