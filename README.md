#Noise-tester
Noise-tester is a highly experimental project made by Mikko P�yh�nen`. 
This tool is used to test any program or service that uses internet connectivity.

Noise-tester is a proxy server which is used as a gatewat and whit what we can simulate bad network conditions.
With noise-tester  we are able to simulate different kinds of network conditions such as delay, latency and packetloss.

This repository contains scripts to deploy noise-tester service

###quirements 

1. Server with two interfaces, eth 0 and eth1.

2. Public IP addresses for both interfaces (if you dont run service in LAN)



###How does it work?
See the following chart to understand the inner workings of the noise-tester.
![lucidchart](http://i64.tinypic.com/29w8l69.png "Noise-tester")

#### If you have git clone this repository
And run
 
<sudo su

<./startup.sh

####OR
Copy startup.sh into text file and run:
<sudo chmod +x startup.sh
<sudo su
<sudo ./startup.sh
####Run startup.sh
Startup.sh will build up the dependences for Noise-tester and start up services

###NOTICE!
#### Packages and scripts are designed to run on Centos4 Amazon AMI. It is not guaranteed that same installation packages will work on other UNIX distros

##Connecting Noise-PROXY

####Windows users

####Unix users

### API
You are able to send configuration parameters in `application/json` format to configure the noise container.

#### /limit
*Method:* PUT

*Parameters:* limit, delay, delayvariance, corrupt, duplicate, loss, reorder, rate

*Usage:* This will set the noise emulation.

*Example:*
```json
{
    "delay": 10,
    "loss": 5,
    "corrupt": 1
}
```

***

#### /script
*Method:* PUT

*JSON parameters:* limit, delay, delayvariance, corrupt, duplicate, loss, reorder, rate
*Other parameters:* loop, jsonscript(of json parameters)

*Usage:* Will start running the defined parameters. This is similar to /limit but with set time delays. 

*Example:*
In the begining (at 0 seconds) loss will be set to 20% and delay to 5ms. After 5 seconds from the script start loss is set to 10% and delay to 2ms.
```json
{
    "jsonscript": {
        "0": {
            "loss": 20,
            "delay": 5
        },
        "5": {
            "loss": 10,
            "delay": 2
        }
    },
    "loop": 0
}
```

***

#### /limit/reset
*Method:* PUT

*Usage:* This will reset all delays and settings to 0.

***

#### Parameter description
*limit*
(packet amount) Limits the effect of selected options to the indicated number of next packets.

*delay*
(milliseconds) Delay packet traffic by set amount.

*delayvariance*
(milliseconds) REQUIRES delay. Optional parameter for delay which introduces a delay variation.

*corrupt*
(percent) Allows the emulation of random noise introducing an error in a random position for a chosen percent of packets.

*duplicate*
(percent) Duplicates the chosen percent of packets before queuing them.

*loss*
(percent) Adds an independent loss probability to the packets outgoing from the chosen network interface.

*reorder*
(percent) REQUIRES delay. Set percent of packets are sent immediately, while others are delayed by set delay time

*rate*
(bits) Delay packets based on packet size.
