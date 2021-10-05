# NSConnect V1.1

## *What is this?*

  This is a system used with any exploit that supports Read/Write.
The purpose of this is to be able to simulate Non-FE. You and your
friends will be able to exploit together. This setup brings in the
possibility for two+ games to connect and replicate changes in
game, however, only those using this setup will see the changes.

### Requirements
 - InfinitySploit V2 (ISV2)

## **Instructions**

### Adding a connection

To start NSConnect, click the start button in the ISV2 settings. use the dropdown to see other nsconnect users on
the same wifi as you. select one to connect to it. type an ip and press enter to add a remote ip.

The checkbox in the settings is for enabling or disabling cross game connections. By default this
is disabled as it can be buggy, but if enabled, will still allow sending data between players
even if in different games.

### Remote Connections

You will need port forward the port (Default 5555)

If you do not know how to port forward or can't, use [NGROK](https://ngrok.com/download).
It is a tunneling software, follow the setup, then forward TCP on the NSConnect port (default 5555)

other players can be found in game through the *search method*.
You can request the found players to connect to you

When players try to connect to you, you will be prompted in the bottom right, similar to a friend request
if you are not port forwarded, you can only connect to other players, you cannot request them to connect to you.

Accepting a request will automatically connect you to them

Do not request players to connect to you when you are not port forwarded. This will result in a connection error
if they accept it. It will be automatically handled so you cannot troll with this "Feature".

### Commands

You can use commands through the chat, using the prefix "NSC/"

Syntax: NSC/[Command] [Args] EX: NSC/scan OR NSC/execute me (script link)
 - Execute [Playername/IP/Me/All] [Script Link]
 	 - executes onto the target the given script link
 - Scan
 	 - Scans for other players using NSConnect and lists them in a GUI
 - Incognito [On/Off]
 	 - Hides your player from the scan. If on, you cannot be found by other players
 - Disconnect [Player Name/IP/All]
 	 - Disconnects from the given player
 - Exit
 	 - Disconnects from everyone and leaves the game
 - Send [All/Player/IP] [Text]
 	 - Sends the text to the target and prints it into their game console (*F9*)

### scripting

NSConnect's main feature is the ability to write scripts with it. You can incorperate the LUA script into others to use it's various functions to make your scripts semi-serverside.

## **Disclaimers**

*This is a beta software, this document is subject to update and when
it does, you can check the version at the top*

**This software and documentation are owned and managed by NightShade, any support or feedback are
appreciated.**

## Links

[Discord](https://discord.com/invite/w7FATqK3cx) [Site](https://demonfall.ml)