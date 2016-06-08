# MHSStats
A school project for the national honors society that displays and analyzes school sports records.

The app is built using a simple, stacked window system. The first screen displayed 
(known as the TeamsScreen, which displays different team names) is on the bottom of the stack. 
Every other window (either category windows or record windows) are stored off-screen to the right. 
When these windows are called, they are simply slid on screen over the base window. 
All the windows are loaded onto the ScreenDisplay platform. 

The notifications are built using APNS and server infrastructure. The server sends a notification to APNS which communicated with the phone to send a notification. If the application is open, the phone will refresh the UI. 

Some future advancements for the application include
outside of MHS school records and stats, 
School comparison, 
and club notifications. 
