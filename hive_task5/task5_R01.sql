USE test_01;

SET hive.auto.convert.join = false;

DROP TABLE IF EXISTS samp;
CREATE EXTERNAL TABLE samp (
    region STRING,
    male INT,
    female INT
) STORED AS TEXTFILE;
INSERT OVERWRITE TABLE samp
SELECT *
FROM (
        SELECT ipregions.region region_,
            IF(sex = 'male', count(1), 0) AS male,
            IF(sex = 'female', count(1), 0) AS female
        FROM ipregions
            INNER JOIN (
                SELECT ip,
                    sex
                FROM users
            ) AS sel_users ON ipregions.ip = sel_users.ip
        GROUP BY ipregions.region,
            sel_users.sex
    ) tbl;
SELECT region,
    SUM(male) AS s_male,
    SUM(female) AS s_female
FROM samp TABLESAMPLE(0.5 PERCENT) s
GROUP BY region
ORDER BY s_female DESC;
