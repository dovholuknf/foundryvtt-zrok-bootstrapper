![image](https://github.com/dovholuknf/foundryvtt-zrok-bootstrapper/assets/46322585/d7e30ecf-06be-4a6e-b14b-82aa0154ba87)

# zrok and Foundry Virutual Tabletop (VTT)

This repository is meant to help people use `zrok` to run Foundry Virutual Tabletop (VTT). There are two basic sections, using
a zrok public share, accessable to anyone on the internet who knows the url or a zrok private share, where there users need
to also have zrok installed and is **only** available via zrok (but available to anyone who has zrok running).

### YouTube Video Overview:
![image](https://github.com/dovholuknf/foundryvtt-zrok-bootstrapper/assets/46322585/50579267-af7a-4a3f-ba30-a17f8b30c47f)

## Prerequisites
* download/install/start Foundry VTT and make sure it works
* download [the latest zrok for windows](https://github.com/openziti/zrok/releases/latest) and invite yourself to the platform. See [this video for a quick/easy walkthrough](https://youtu.be/Je5j4ThouCo) walkthrough of the process.
* if you didn't watch/follow the video above, put the zrok.exe somewhere you can find, for example `c:\zrok\zrok.exe`
* if you didn't watch/follow the video above, invite yourself to zrok using: `zrok invite`. see https://docs.zrok.io/docs/getting-started/#generating-an-invitation

## On the Foundry VTT server Prerequisites:
* `zrok enable` the server. see [Enabling Your zrok Environment](https://docs.zrok.io/docs/getting-started/#enabling-your-zrok-environment)
* download: [the start-server script](https://raw.githubusercontent.com/dovholuknf/foundryvtt-zrok-bootstrapper/main/start-server.ps1)
* if zrok isn't on your path, edit the script and update the PATH_TO_ZROK with the location of your zrok.exe or provide it when running the script.
	It's really easiest if you [just watch and follow that video](https://youtu.be/Je5j4ThouCo).


## Public Foundry VTT server - So Easy!

A public Foundry VTT server is one that is exposed to anyone on the internet but to access the server people will need to know your special url.
This makes it **highly** unlikely for random people to find your Foundry server, it won't be scannable by traditional port scanning. 
Still you should follow the Foundry VTT best practices for securing your game. Use strong passwords, etc. 

Another nice bonus is that with zrok, you'll be getting HTTPS/TLS for free since https://zrok.io or the selfhosted zrok instances 
will enable it. This option is great for most people since it will make it very easy to expose your Foundry VTT server without
needing to setup TLS and without needing to figure out how to forward ports in your firewall. You can also run this from anywhere, even if you
pick your laptop/pc up and move it. You won't have to deal with IP addresses, dynamic DNS, etc.

### Starting the Foundry VTT share with zrok
To run a public Foundry VTT server run the `start-server.ps1` script with the -Public option as shown (the script is not signed, research this if you don't understand it):

      powershell.exe -ExecutionPolicy Bypass -File start-server.ps1 -Public
	  
> [!NOTE]
This will release any pre-existing share, then share it back again "publicly".

### Inviting people to join a zrok-public Foundry VTT server
Inviting people to join your publicly hosted Foundry VTT server is incredibly easy. When the screen pops up, just send them the url!
Tell them their username and password and have fun! (so easy)


## Private Foundry VTT server

A "private" Foundry VTT server is one that is not exposed to the internet at all. In order to access the server, your friends will need to know
the special token --and-- they will have to run zrok as well. It has all the benefits of a public VTT server except it tunnels the traffic from
clients to the server securely using a fully zero trust connection (mutual TLS etc) without the need for setting TLS up in the Foundry server. 
That does have the down side of forcing you how to figure out using TLS/certs so you can configure voice/video chat, but it's entirely hidden from
the internet. If there's demand for it, I'll see if i can figure out an easy guide for that, but I expect there's plenty online already.

Here's how you keep your Foundry VTT server even away from the public entirely.

### Start the Foundry VTT share with zrok
To run a zrok-private Foundry VTT server run the `start-server.ps1` script **without** the -Public option as shown (the script is not signed, research this if you don't understand it):

      powershell.exe -ExecutionPolicy Bypass -File start-server.ps1

> [!NOTE]
This will release any pre-existing share, then share it back again "privately".

### Inviting people to join a zrok-private Foundry VTT server
* download/install zrok as described in the prerequisites
* `zrok enable` the client. see [Enabling Your zrok Environment](https://docs.zrok.io/docs/getting-started/#enabling-your-zrok-environment)
* download [the start-client script](https://raw.githubusercontent.com/dovholuknf/foundryvtt-zrok-bootstrapper/main/start-client.ps1)
* if zrok isn't on your path, update the start-client script and update the PATH_TO_ZROK with the location of your zrok.exe or provide it when running the script
	It's really easiest if you [just watch and follow that video](https://youtu.be/Je5j4ThouCo).
* run `start-client.ps1` (the script is not signed, research this if you don't understand it):

	  powershell.exe -ExecutionPolicy Bypass -File start-client.ps1
	  
* when the `start-client.ps1` script executes, you'll be prompted to enter the secret token from the server:
  ![image](https://github.com/dovholuknf/foundryvtt-zrok-bootstrapper/assets/46322585/7dfb8105-4f81-4345-a2c1-ad19b6f43ca2)



