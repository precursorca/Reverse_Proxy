# Reverse_Proxy
Instructions for setting up reverse proxy on macOS-native Apache

In smaller organizations, it may be necessary to run more than one server on the same computer or run more than one server behind a single WAN i.p. address. When macOS Server was a thing, this guide helped run multiple server apps/appliances like FileMaker Server, Kerio Connect, Maxum Rumpus and Synology NAS on the same computer/network as macOS Server.*

When macOS Server stopped providing web services (in 10.14 Mojave) I still had some organizations using Reverse Proxy who needed to upgrade the OS for security and other
reasons. So I have developed this guide to do Reverse Proxy using the native Apache web server built into every macOS from Mojave to macOS 27 Golden Gate.

*Not saying it is "Best Practices", nor that we recommend it; just saying you can do it.

<img width="833" height="446" alt="i p address_scarcity" src="https://github.com/user-attachments/assets/1775f1f7-2ea5-4a18-b664-2d0f502e2604" />

This version of the tutorial has been tested on macOS 27 Golden Gate. For earlier versions refer to the chart below:

<img width="423" height="220" alt="Tutorial_Versions" src="https://github.com/user-attachments/assets/070d8948-fe7f-468c-ab7a-ce8578d88058" />

Revision History:
- 3.17 Oct/1/26. Tested on Tahoe and Golden Gate Updates to docs to mention Golden Gate. Added Appendix C for notes on Google
Chrome balking on self-signed certs.
- 3.16 Oct/24/24. Tested on Sequoia. Updates to docs to mention Sequoia. Correct Site File permissions after deployment. Add home-
bridge.conf for Synology homebridge. Add Paul Royse methods for FileMaker Websockets and Azure Oauth to FileMaker.conf
3.15 Jan/30/22. Fix permissions on Site files. Add better rewrite rule for https. Add ProxyRemote directive for same computer site files
3.14 Oct/3/20. Update ProxyTimeout for Kerio to avoid ActiveSync errors. Rewrite SSL Certificate instructions (Appendix A).
3.13 Sept/28/20. Numerous typo fixes, update SSL config for TLS 1.2. Some permission fixes for editing purposes.
3.12 Aug 10/20. Numerous fixes, code-signed commands, added a set certificate permissions command. Improved documentation.
3.1.0 May 6/20. Provided scripting for backup and restore plus a full slate of example host files and include statements to match.
3.0.0 March 23/20. FMReverse Proxy using the native apache in macOS 10.14 Mojave and 10.15 Catalina.
2.0.6 March 17/20. Fixed two example files..
2.0.5 March 15/20. Added a missing example file.
2.0.4 March 14/20. Added information on Reverse Proxy to Synology NAS and fixed various typoes in documentation and example
files.
2.0.3 October 1/17. Tested on macOS High Sierra 10.13/macOS Server 5.4. Added some examples for the one external i.p./ mulitple internal computers case. FileMaker Server 16.0.2 WebDirect is now working with reverse proxy!
2.0.2 September 24/16. Re-edited for macOS Sierra and macOS Server 5.2. Included "SSLProxyEngine on" for SSL conf files necessitated by changes in macOS Server 5.2. Fixed a problem in FixKerioProxyTimeout.sh for macOS Server 5.2. Added Appendix F: Trou-
bleshooting.
NB. FileMaker routines do not work - waiting for Sierra compatible FileMaker Server to test again.
2.0.1 August 5/16. Amended FileMaker web app conf for FileMaker Server 15 compatibility. Updated throughout to refer to Server
5.1.7.
2.0.0 June 12/16. Completely revised for El Capitan and Server app 5.1.5.
Includes critical info for dealing with the Kerio Connect proxy timeout issue.
1.0.10 October 24/15. Corrected for OS X Server 5.0.15 fixes and revised instructions for v.3.x and v.4.x to be inline with v.5.0.15.
1.09 October 10/15. Corrected typos in Appendix C: Server 5 and in the kerio example files.
1.08 October 1/15. Revised with a working solution for the recently Server app 5.
Changed ports for Kerio to 8003 and 8013 to avoid conflicts with Server 5,
Renamed example files from "fms13" to "filemaker" for clarity.
Detailed Info on OS X Server 5 appears in newly added Appendix C.
1.0.7 July 14/15. Added an Appendix B to cover Reverse Proxy to a second internal server
1.06 May 31/15. Now includes Instructions for FileMaker Server 14.
1.0.5 May 11/15. Corrections in the certificates appendix and corrections of typos in the example files.
1.0.4 January 24/15, Important config info about using commercial certs (GoDaddy etc); Fixed typo in httpd_Keriowebapp.conf example file;.
1.0.3 December 30/14, Re-edited for Yosemite and Server.app 4. Added file ownership and permission info.
1.0.2 September 29/14, Added Appendix A with info on importing/Exporting SSL certificates.
1.0.1 July 22/14, Add reference to Automatica's AppleScript
1.0 July 19/14, Show how to set up reverse proxies for Rumpus, Kerio Connect, and FileMaker Server 13 on OS Mavericks with Server.
app 3.

---
Alex Narvey
