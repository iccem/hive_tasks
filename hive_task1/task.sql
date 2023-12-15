USE test_01;


DROP TABLE IF EXISTS IPRegions;
CREATE external TABLE IPRegions (
        ip string,
        region string
) ROW format delimited fields terminated BY '\t'
stored AS textfile
LOCATION '/data/user_logs/ip_data_M/';

SELECT * FROM IPRegions LIMIT 10;


DROP TABLE IF EXISTS Subnets;
CREATE external TABLE Subnets (
        ip string,
        mask string
) ROW format delimited fields terminated BY '\t'
stored AS textfile
LOCATION '/data/subnets/variant1';

SELECT * FROM Subnets LIMIT 10;


DROP TABLE IF EXISTS Users;
CREATE external TABLE Users (
        ip string,
        browser string,
        gender string,
        age INT
) ROW format delimited fields terminated BY '\t'
stored AS textfile
LOCATION '/data/user_logs/user_data_M';

SELECT * FROM Users LIMIT 10;


ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

DROP TABLE IF EXISTS logs_draft;
CREATE EXTERNAL TABLE logs_draft (
    ip STRING,
    dt INT,
    url STRING,
    size SMALLINT,
    status STRING,
    info STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = '^((?:\\d{1,3}\\.){3}\\d{1,3})\\s+(\\d{8})\\d+\\s+((?:http|ftp)://?\\S+)\\s+(\\d+)\\s+(\\d{3})\\s+(\.+)$'
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_logs_M';

SELECT * FROM logs_draft LIMIT 10;


SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=116;
SET hive.exec.max.dynamic.partitions.pernode=116;


DROP TABLE IF EXISTS Logs;
CREATE EXTERNAL TABLE Logs (
    ip STRING,
    url STRING,
    size SMALLINT,
    status STRING,
    info STRING
)
PARTITIONED BY (dt INT)
STORED AS TEXTFILE;


INSERT OVERWRITE TABLE Logs PARTITION (dt)
SELECT
    ip, 
    url, 
    size, 
    status, 
    info, 
    dt
FROM logs_draft;


SELECT * FROM Logs LIMIT 10;
