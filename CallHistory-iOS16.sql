Select 
datetime("ZCALLRECORD"."ZDATE" + 978307200, 'UNIXEPOCH') As "Call Date/Time", 
Case 
	When "ZCALLRECORD"."ZDATE" = ("ZCALLRECORD"."ZDATE" + "ZCALLRECORD"."ZDURATION") Then NULL
	Else datetime(("ZCALLRECORD"."ZDATE" + "ZCALLRECORD"."ZDURATION")+ 978307200, 'UNIXEPOCH') End As "Call End Date/Time", 
ZSERVICE_PROVIDER AS "Service Provider",
CASE ZCALLTYPE
	WHEN 0 then 'Third-Party App'
	WHEN 1 then 'Phone Call'
	WHEN 8 then 'FaceTime Video'
	WHEN 16 then 'FaceTime Audio'
	ELSE ZCALLTYPE
END AS "Call Type", 
CASE ZORIGINATED
	WHEN 0 then 'Incoming'
	WHEN 1 then 'Outgoing'
END AS "Call Direction", 
GROUP_CONCAT(ZHANDLE.ZVALUE, ', ') AS "Phone Number",
CASE 
   WHEN COUNT(z_2remoteparticipanthandles.z_2remoteparticipantcalls) = 1 
   THEN 'Direct Call' 
   WHEN COUNT(z_2remoteparticipanthandles.z_2remoteparticipantcalls) > 1 
   THEN 'Group Call - ' || COUNT(z_2remoteparticipanthandles.z_2remoteparticipantcalls) || ' other parties'
END AS "Call Description",
CASE ZANSWERED
	WHEN 0 then 'No'
	WHEN 1 then 'Yes'
END AS "Answered",
CASE
	WHEN ZDURATION IS '0.0'
	THEN "No Call Duration" 
	WHEN ZDURATION > 0 THEN strftime('%H:%M:%S',(ZDURATION), 'unixepoch')  
END AS "Call Duration",
ZFACE_TIME_DATA AS "FaceTime Data",
CASE
	WHEN ZDISCONNECTED_CAUSE = 6 AND ZSERVICE_PROVIDER LIKE '%whatsapp' AND ZDURATION <> '0.0' then 'Ended'
	WHEN ZDISCONNECTED_CAUSE = 6 AND ZSERVICE_PROVIDER LIKE '%whatsapp' AND ZORIGINATED = 1 then 'Missed or Rejected'
	WHEN ZDISCONNECTED_CAUSE = 2 AND ZSERVICE_PROVIDER LIKE '%whatsapp' then 'Rejected'
	WHEN ZDISCONNECTED_CAUSE = 6 AND ZSERVICE_PROVIDER LIKE '%whatsapp' then 'Missed'
	WHEN ZDISCONNECTED_CAUSE = 0 then 'Ended'
	WHEN ZDISCONNECTED_CAUSE = 2 then 'No Answer'
	WHEN ZDISCONNECTED_CAUSE = 6 then 'Rejected'
	WHEN ZDISCONNECTED_CAUSE = 41 then 'Ended'
	WHEN ZDISCONNECTED_CAUSE = 49 then 'No Answer'
	ELSE ZDISCONNECTED_CAUSE
END AS "Disconnected Cause",
UPPER(ZISO_COUNTRY_CODE),
ZLOCATION
From ZCALLRECORD
LEFT OUTER JOIN Z_2REMOTEPARTICIPANTHANDLES ON Z_2REMOTEPARTICIPANTHANDLES.Z_2REMOTEPARTICIPANTCALLS IS ZCALLRECORD.Z_PK
LEFT OUTER JOIN ZHANDLE ON Z_2REMOTEPARTICIPANTHANDLES.Z_3REMOTEPARTICIPANTHANDLES IS ZHANDLE.Z_PK
GROUP BY Z_2REMOTEPARTICIPANTCALLS