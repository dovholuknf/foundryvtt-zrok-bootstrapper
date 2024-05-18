This repository is meant to help people use `zrok` to run Foundry Virutual Tabletop (VTT).

### Prerequisites
* download/install/start Foundry VTT and make sure it works
* download [the latest zrok for windows](https://github.com/openziti/zrok/releases/latest) and invite yourself to the platform. See [this video for a quick/easy walkthrough](https://youtu.be/Je5j4ThouCo) of downloading and installing zrok in windows
* if you didn't watch/follow the video above, put the zrok.exe somewhere you can find, for example `c:\zrok\zrok.exe`
* if you didn't watch/follow the video above, invite yourself to zrok using: `zrok invite`. see https://docs.zrok.io/docs/getting-started/#generating-an-invitation

### On the Foundry VTT server:
* `zrok enable` the server. see [Enabling Your zrok Environment](https://docs.zrok.io/docs/getting-started/#enabling-your-zrok-environment)
* download: [the start-server script](https://raw.githubusercontent.com/dovholuknf/foundryvtt-zrok-bootstrapper/main/start-server.ps1)
* edit the script and update the PATH_TO_ZROK with the location of your zrok.exe
* run `start-server.ps1` (the script is not signed, research this if you don't understand it):

      powershell.exe -ExecutionPolicy Bypass -File start-server.ps1

* after `zrok` starts, there will be a private token that you need to distribute to the people you want to allow to access the Foundry VTT server:
* ![image](https://github.com/dovholuknf/foundryvtt-zrok-bootstrapper/assets/46322585/8bdc6d16-5569-43f8-b6a5-c96653b35a5d)

### Inviting people to join:
* `zrok enable` the client. see [Enabling Your zrok Environment](https://docs.zrok.io/docs/getting-started/#enabling-your-zrok-environment)
* download [the start-client script](https://raw.githubusercontent.com/dovholuknf/foundryvtt-zrok-bootstrapper/main/start-client.ps1)
* update the start-client script and update the PATH_TO_ZROK with the location of your zrok.exe
* run `start-client.ps1` (the script is not signed, research this if you don't understand it):

	  powershell.exe -ExecutionPolicy Bypass -File start-client.ps1
* when the `start-client.ps1` script executes, you'll be prompted to enter the secret token from the server:
  ![image](https://github.com/dovholuknf/foundryvtt-zrok-bootstrapper/assets/46322585/7dfb8105-4f81-4345-a2c1-ad19b6f43ca2)

### YouTube Video Overview:
[<img src="https://img.youtube.com/vi/Sq43hp6n9rE/hqdefault.jpg">](https://youtu.be/Sq43hp6n9rE)
