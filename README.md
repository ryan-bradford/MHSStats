# MHSStats
A school project for the national honors society that displays and analyzes school sports records.

The app is built using a simple, stacked window system. The first screen displayed 
(known as the TeamsScreen, which displays different team names) is on the bottom of the stack. 
Every other window (either category windows or record windows) are stored off-screen to the right. 
When these windows are called, they are simply slid on screen over the base window. 
All the windows are loaded onto the ScreenDisplay platform. 

The notifications are built using a background loop and checking a separate "hash" file stored on the server. 
If the background loop detects the hash has changed, it notifies the user through a notification. 

Some future advancements for the application include remote notifications, 
outside of MHS school records and stats, 
School comparison, 
and club notifications. 
