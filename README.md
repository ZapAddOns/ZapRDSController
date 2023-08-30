# ZapRDSController
PowerShell script to handle access to Zap TPS for more than one user.

### Intro
This script is used to give access to a TPS for more than one 
person. Normally you couldn't see, if someone else already use 
the RDS connection to the TPS. With this script it is possible 
to see, if, and if yes, who is connected.

### How it works
All team members, that like to use the RDS connection to the TPS start 
this connection with the same script. This script checks, if a special 
text file exists. If this is the case, then the name contained in the 
text file is printed and the RDS isn't started. 

If the text file doesn't exists, then the text file is created, the content 
is set to the name of the user, that is signed in on the current PC and the 
RDS is started. When the user closes the RDS connection, the text file 
is deleted.

### How to setup the script
First of all copy the script to a place, where all team members could access 
it. Then you have to change a few things:

1. In line 2 replace "\<Common used path\>" with a path to a folder 
location all team members could access
2. In line 5 replace "\<IP of TPS\>" with the IP adress of your TPS system. 
If it is behind a firewall, then use the adress of the firewall.
3. In line 6 replace "\<Port of TPS\>" with the port adress of your TPS system. 
If it is behind a firewall, then use the port of the firewall. Normally you 
use 3390 for the port.
4. In line 9 replace "\<User TPS\>" with the username you want to login to the TPS 
(normally "Zap")
5. In line 10 replace "\<Password TPS\>" with the password for the user you 
set instead of "\<User TPS\>"
4. In line 13 replace "\<Domain\>" with the name of your domain. 
It is then deleted from the displayed name.

### More than one TPS
If you have more than one TPS, the only you have to do is to create for each 
TPS an own script and change the file name for the special text file (from 
TPS.txt in line 2 to e.g. TPS1.txt).

If this TPSs behind a firewall, then you need perhaps different ports. You 
could use 3390 for the first, 3389 for the second TPS. You need then port 
forwards in the firewall too. The forward could be \<IP address firewall\>:3390 
to \<IPaddress TPS1\>:3390 and \<IP address firewall\>:3389 to \<IPaddress TPS2\>:3390.

### No PowerShell scrpits allowed
If on your PC no PowerShell scripts allowed, you could compile the script to an 
exe with e.g PS2EXE or Win-PS2EXE. So you could start it as any other app.