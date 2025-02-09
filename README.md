# Call_History_Group_Calls
Parsing group call data from the CallHistory.storedata and interactionC.db that was always present, just not supported. These queries are free to use and share.

It is our hope these SQL queries aid in the accurate parsing and analysis of call log artifacts, both from the CallHistory.storedata and the interactionC.db.

# Where to Use:

- The SQL queries will work in most SQLite database viewers able to execute SQL queries. Note: due to column name changes with iOS updates, one CallHistory.storedata query will work while the other will not.
- The callHistoryGroupCall.xml file is a Magnet AXIOM Custom Artifact, which can be added to Magnet AXIOM Process through Tools > Manage custom artifacts > ADD NEW CUSTOM ARTIFACT. Once added, the artifacts are named Call History - Group Call v3, Call History - Group Call v4, and Call History interactionC - Group Call.
- **Update!** The artifact work herein is now available within iLEAPP as well, available [here](https://github.com/abrignoni/iLEAPP). Thanks to all on the LEAPPs team for the review and approval of these artifacts! As always, we remain a proud support of the LEAPPS project.

# Artifact Examples:
Call History - Group Call:

![Image2](https://github.com/user-attachments/assets/7fed2368-9abb-4672-a206-2a0ccce24d24)


interactionC Call History - Group Call:

![Image3](https://github.com/user-attachments/assets/8b594baa-d65e-414e-88e6-f3e5b33d5ead)


# File Location
This data pertains to Apple devices recorded within the CallHistory.storedata and interactionC databases, available through encrypted Advanced Logical and Full File System Extractions.

# iOS Support
At the time of testing, these queries supported iOS 16, 17, and 18.

# More Details
Additional details published within 'Hello! Who is on the Line?' at [URL](https://metadataperspective.com/2025/02/05/hello-who-is-on-the-line/).
