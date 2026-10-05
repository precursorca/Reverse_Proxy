# Reverse_Proxy
Instructions for setting up reverse proxy on macOS-native Apache

In smaller organizations, it may be necessary to run more than one server on the same
computer or run more than one server behind a single WAN i.p. address. When macOS
Server was a thing, this guide helped run multiple server apps/appliances like FileMaker
Server, Kerio Connect, Maxum Rumpus and Synology NAS on the same computer/net-
work as macOS Server.*

When macOS Server stopped providing web services (in 10.14 Mojave) I still had some or-
ganizations using Reverse Proxy who needed to upgrade the OS for security and other
reasons. So I have developed this guide to do Reverse Proxy using the native Apache web
server built into every macOS from Mojave to macOS 27 Golden Gate.

*Not saying it is "Best Practices", nor that we recommend it; just saying you can do it.

<img width="833" height="446" alt="i p address_scarcity" src="https://github.com/user-attachments/assets/1775f1f7-2ea5-4a18-b664-2d0f502e2604" />

This version of the tutorial has been tested on macOS 27 Golden Gate. For earlier versions refer to the chart below.

<img width="423" height="220" alt="Tutorial_Versions" src="https://github.com/user-attachments/assets/070d8948-fe7f-468c-ab7a-ce8578d88058" />

Alex Narvey
