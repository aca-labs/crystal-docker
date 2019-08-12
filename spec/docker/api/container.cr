require "../../spec_helper"

describe Docker::Api::Daemon do
  client = Docker::Api::Client.new

  describe "#inspect_container" do
    it "inspects container objects" do
      id = "abc123"
      WebMock.stub(:get, "#{client.client.host}/containers/#{id}/json").to_return(body: <<-JSON
        {
          "AppArmorProfile": "",
          "Args": [
            "-c",
            "exit 9"
          ],
          "Config": {
            "AttachStderr": true,
            "AttachStdin": false,
            "AttachStdout": true,
            "Cmd": [
              "/bin/sh",
              "-c",
              "exit 9"
            ],
            "Domainname": "",
            "Env": [
              "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Hostname": "ba033ac44011",
            "Image": "ubuntu",
            "Labels": {
              "com.example.vendor": "Acme",
              "com.example.license": "GPL",
              "com.example.version": "1.0"
            },
            "MacAddress": "",
            "NetworkDisabled": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Tty": false,
            "User": "",
            "Volumes": {
              "/volumes/data": {}
            },
            "WorkingDir": "",
            "StopSignal": "SIGTERM",
            "StopTimeout": 10
          },
          "Created": "2015-01-06T15:47:31.485331387Z",
          "Driver": "devicemapper",
          "ExecIDs": [
            "b35395de42bc8abd327f9dd65d913b9ba28c74d2f0734eeeae84fa1c616a0fca",
            "3fc1232e5cd20c8de182ed81178503dc6437f4e7ef12b52cc5e8de020652f1c4"
          ],
          "HostConfig": {
            "MaximumIOps": 0,
            "MaximumIOBps": 0,
            "BlkioWeight": 0,
            "BlkioWeightDevice": [
              {}
            ],
            "BlkioDeviceReadBps": [
              {}
            ],
            "BlkioDeviceWriteBps": [
              {}
            ],
            "BlkioDeviceReadIOps": [
              {}
            ],
            "BlkioDeviceWriteIOps": [
              {}
            ],
            "ContainerIDFile": "",
            "CpusetCpus": "",
            "CpusetMems": "",
            "CpuPercent": 80,
            "CpuShares": 0,
            "CpuPeriod": 100000,
            "CpuRealtimePeriod": 1000000,
            "CpuRealtimeRuntime": 10000,
            "Devices": [],
            "IpcMode": "",
            "LxcConf": [],
            "Memory": 0,
            "MemorySwap": 0,
            "MemoryReservation": 0,
            "KernelMemory": 0,
            "OomKillDisable": false,
            "OomScoreAdj": 500,
            "NetworkMode": "bridge",
            "PidMode": "",
            "PortBindings": {},
            "Privileged": false,
            "ReadonlyRootfs": false,
            "PublishAllPorts": false,
            "RestartPolicy": {
              "MaximumRetryCount": 2,
              "Name": "on-failure"
            },
            "LogConfig": {
              "Type": "json-file"
            },
            "Sysctls": {
              "net.ipv4.ip_forward": "1"
            },
            "Ulimits": [
              {}
            ],
            "VolumeDriver": "",
            "ShmSize": 67108864
          },
          "HostnamePath": "/var/lib/docker/containers/ba033ac4401106a3b513bc9d639eee123ad78ca3616b921167cd74b20e25ed39/hostname",
          "HostsPath": "/var/lib/docker/containers/ba033ac4401106a3b513bc9d639eee123ad78ca3616b921167cd74b20e25ed39/hosts",
          "LogPath": "/var/lib/docker/containers/1eb5fabf5a03807136561b3c00adcd2992b535d624d5e18b6cdc6a6844d9767b/1eb5fabf5a03807136561b3c00adcd2992b535d624d5e18b6cdc6a6844d9767b-json.log",
          "Id": "ba033ac4401106a3b513bc9d639eee123ad78ca3616b921167cd74b20e25ed39",
          "Image": "04c5d3b7b0656168630d3ba35d8889bd0e9caafcaeb3004d2bfbc47e7c5d35d2",
          "MountLabel": "",
          "Name": "/boring_euclid",
          "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "SandboxKey": "",
            "EndpointID": "",
            "Gateway": "",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "",
            "IPPrefixLen": 0,
            "IPv6Gateway": "",
            "MacAddress": "",
            "Networks": {
              "bridge": {
                "NetworkID": "7ea29fc1412292a2d7bba362f9253545fecdfa8ce9a6e37dd10ba8bee7129812",
                "EndpointID": "7587b82f0dada3656fda26588aee72630c6fab1536d36e394b2bfbcf898c971d",
                "Gateway": "172.17.0.1",
                "IPAddress": "172.17.0.2",
                "IPPrefixLen": 16,
                "IPv6Gateway": "",
                "GlobalIPv6Address": "",
                "GlobalIPv6PrefixLen": 0,
                "MacAddress": "02:42:ac:12:00:02"
              }
            }
          },
          "Path": "/bin/sh",
          "ProcessLabel": "",
          "ResolvConfPath": "/var/lib/docker/containers/ba033ac4401106a3b513bc9d639eee123ad78ca3616b921167cd74b20e25ed39/resolv.conf",
          "RestartCount": 1,
          "State": {
            "Error": "",
            "ExitCode": 9,
            "FinishedAt": "2015-01-06T15:47:32.080254511Z",
            "OOMKilled": false,
            "Dead": false,
            "Paused": false,
            "Pid": 0,
            "Restarting": false,
            "Running": true,
            "StartedAt": "2015-01-06T15:47:32.072697474Z",
            "Status": "running"
          },
          "Mounts": [
            {
              "Name": "fac362...80535",
              "Source": "/data",
              "Destination": "/data",
              "Driver": "local",
              "Mode": "ro,Z",
              "RW": false,
              "Propagation": ""
            }
          ]
        }
      JSON
      )
      container = client.inspect_container id
      container.path.should eq("/bin/sh")
    end
  end
end
