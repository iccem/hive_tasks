# hive_tasks

Task 1
Hive Project Description: Log Analysis and Data Processing

Objective:
This project involves the development of Hive scripts to create and manage five tables for the analysis and processing of user logs. The tables include four external tables based on raw data and a fifth table partitioned by dates, with each partition representing a day.

Raw Data Description:
The raw data consists of user logs stored in Hadoop Distributed File System (HDFS). The data is organized into three parts, each residing in its subdirectory. The log entries vary in the number and type of columns, separated by tab ('\t') or space characters.

Table Specifications:

A. User Query Logs (user_logs):

IP address of the querying user (STRING),
Timestamp of the query (TIMESTAMP or INT),
HTTP request details (STRING),
Size of the transmitted page to the client (INT),
HTTP status code (INT).
Information about the client application used for the query, including browser details (STRING).
B. User Information (user_data):

IP address (STRING),
User's browser (STRING),
Gender (STRING) //male, female,
Age (INT).
C. IP Address Location Information (ip_data):

IP address (STRING),
Region (STRING).
Implementation:
The Hive script generates the four external tables based on the raw user log data. Additionally, it creates a partitioned table based on dates, with each partition corresponding to a day. This structure facilitates efficient querying and analysis of user interactions with news messages.

Note: This project showcases the utilization of Hive for data processing, table creation, and partitioning to derive meaningful insights from user logs stored in HDFS. It encompasses the extraction of relevant information such as user queries, user details, and IP address locations for further analysis.