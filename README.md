# Embulk

## Migrate from mysql to mysql

1. Build docker iamge

    ```
    docker build -t embulk .
    ```

1. Preview

    ```
    docker run --network embulk_test --entrypoint="" --rm -it -v $(pwd):/work embulk sh -c 'java -jar /bin/embulk preview ./mysql-config.yml'
    2020-06-18 12:57:48.684 +0000: Embulk v0.9.23
    2020-06-18 12:57:49.658 +0000 [WARN] (main): DEPRECATION: JRuby org.jruby.embed.ScriptingContainer is directly injected.
    2020-06-18 12:57:52.390 +0000 [INFO] (main): Gem's home and path are set by default: "/root/.embulk/lib/gems"
    2020-06-18 12:57:53.389 +0000 [INFO] (main): Started Embulk v0.9.23
    2020-06-18 12:57:53.550 +0000 [INFO] (0001:preview): Loaded plugin embulk-input-mysql (0.10.1)
    2020-06-18 12:57:53.600 +0000 [INFO] (0001:preview): JDBC Driver = /root/.embulk/lib/gems/gems/embulk-input-mysql-0.10.1/default_jdbc_driver/mysql-connector-java-5.1.44.jar
    2020-06-18 12:57:53.615 +0000 [INFO] (0001:preview): Fetch size is 10000. Using server-side prepared statement.
    2020-06-18 12:57:53.618 +0000 [INFO] (0001:preview): Connecting to jdbc:mysql://from_mysql:3306/from_db options {useCompression=true, socketTimeout=1800000, useSSL=false, user=from_user, useLegacyDatetimeCode=false, tcpKeepAlive=true, useCursorFetch=true, connectTimeout=300000, password=***, zeroDateTimeBehavior=convertToNull}
    2020-06-18 12:57:53.951 +0000 [INFO] (0001:preview): Using JDBC Driver mysql-connector-java-5.1.44 ( Revision: b3cda4f864902ffdde495b9df93937c3e20009be )
    2020-06-18 12:57:53.952 +0000 [WARN] (0001:preview): embulk-input-mysql 0.9.0 upgraded the bundled MySQL Connector/J version from 5.1.34 to 5.1.44 .
    2020-06-18 12:57:53.952 +0000 [WARN] (0001:preview): And set useLegacyDatetimeCode=false by default in order to get correct datetime value when the server timezone and the client timezone are different.
    2020-06-18 12:57:53.952 +0000 [WARN] (0001:preview): Set useLegacyDatetimeCode=true if you need to get datetime value same as older embulk-input-mysql.
    2020-06-18 12:57:54.110 +0000 [INFO] (0001:preview): Fetch size is 10000. Using server-side prepared statement.
    2020-06-18 12:57:54.111 +0000 [INFO] (0001:preview): Connecting to jdbc:mysql://from_mysql:3306/from_db options {useCompression=true, socketTimeout=1800000, useSSL=false, user=from_user, useLegacyDatetimeCode=false, tcpKeepAlive=true, useCursorFetch=true, connectTimeout=300000, password=***, zeroDateTimeBehavior=convertToNull}
    2020-06-18 12:57:54.122 +0000 [INFO] (0001:preview): SQL: SELECT * FROM `from_table`
    2020-06-18 12:57:54.129 +0000 [INFO] (0001:preview): > 0.00 seconds
    +---------+-------------+
    | id:long | name:string |
    +---------+-------------+
    |       1 |         dog |
    |       2 |         cat |
    |       3 |     penguin |
    |       4 |         lax |
    |       5 |       whale |
    |       6 |     ostrich |
    +---------+-------------+
    ```

1. Run

    ```
    ± docker run --network embulk_test --entrypoint="" --rm -it -v $(pwd):/work embulk sh -c 'java -jar /bin/embulk run ./mysql-config.yml'
    2020-06-18 12:59:05.601 +0000: Embulk v0.9.23
    2020-06-18 12:59:06.563 +0000 [WARN] (main): DEPRECATION: JRuby org.jruby.embed.ScriptingContainer is directly injected.
    2020-06-18 12:59:09.162 +0000 [INFO] (main): Gem's home and path are set by default: "/root/.embulk/lib/gems"
    2020-06-18 12:59:10.078 +0000 [INFO] (main): Started Embulk v0.9.23
    2020-06-18 12:59:10.224 +0000 [INFO] (0001:transaction): Loaded plugin embulk-input-mysql (0.10.1)
    2020-06-18 12:59:10.274 +0000 [INFO] (0001:transaction): Loaded plugin embulk-output-mysql (0.8.7)
    2020-06-18 12:59:10.327 +0000 [INFO] (0001:transaction): JDBC Driver = /root/.embulk/lib/gems/gems/embulk-input-mysql-0.10.1/default_jdbc_driver/mysql-connector-java-5.1.44.jar
    2020-06-18 12:59:10.347 +0000 [INFO] (0001:transaction): Fetch size is 10000. Using server-side prepared statement.
    2020-06-18 12:59:10.349 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://from_mysql:3306/from_db options {useCompression=true, socketTimeout=1800000, useSSL=false, user=from_user, useLegacyDatetimeCode=false, tcpKeepAlive=true, useCursorFetch=true, connectTimeout=300000, password=***, zeroDateTimeBehavior=convertToNull}
    2020-06-18 12:59:10.639 +0000 [INFO] (0001:transaction): Using JDBC Driver mysql-connector-java-5.1.44 ( Revision: b3cda4f864902ffdde495b9df93937c3e20009be )
    2020-06-18 12:59:10.639 +0000 [WARN] (0001:transaction): embulk-input-mysql 0.9.0 upgraded the bundled MySQL Connector/J version from 5.1.34 to 5.1.44 .
    2020-06-18 12:59:10.639 +0000 [WARN] (0001:transaction): And set useLegacyDatetimeCode=false by default in order to get correct datetime value when the server timezone and the client timezone are different.
    2020-06-18 12:59:10.640 +0000 [WARN] (0001:transaction): Set useLegacyDatetimeCode=true if you need to get datetime value same as older embulk-input-mysql.
    2020-06-18 12:59:10.708 +0000 [INFO] (0001:transaction): Using local thread executor with max_threads=12 / output tasks 6 = input tasks 1 * 6
    2020-06-18 12:59:10.733 +0000 [INFO] (0001:transaction): JDBC Driver = /root/.embulk/lib/gems/gems/embulk-output-mysql-0.8.7/default_jdbc_driver/mysql-connector-java-5.1.44.jar
    2020-06-18 12:59:10.749 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.027 +0000 [INFO] (0001:transaction): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.028 +0000 [INFO] (0001:transaction): Using JDBC Driver mysql-connector-java-5.1.44 ( Revision: b3cda4f864902ffdde495b9df93937c3e20009be )
    2020-06-18 12:59:11.028 +0000 [WARN] (0001:transaction): This plugin will update MySQL Connector/J version in the near future release.
    2020-06-18 12:59:11.028 +0000 [WARN] (0001:transaction): It has some incompatibility changes.
    2020-06-18 12:59:11.028 +0000 [WARN] (0001:transaction): For example, the 5.1.35 introduced `noTimezoneConversionForDateType` and `cacheDefaultTimezone` options.
    2020-06-18 12:59:11.028 +0000 [WARN] (0001:transaction): Please read a document and make sure configuration carefully before updating the plugin.
    2020-06-18 12:59:11.032 +0000 [WARN] (0001:transaction): The plugin will set `useLegacyDatetimeCode=false` by default in future.
    2020-06-18 12:59:11.033 +0000 [INFO] (0001:transaction): Using insert mode
    2020-06-18 12:59:11.052 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7830145_embulk000` (`id` BIGINT, `name` TEXT)
    2020-06-18 12:59:11.077 +0000 [INFO] (0001:transaction): > 0.02 seconds
    2020-06-18 12:59:11.079 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7830145_embulk001` (`id` BIGINT, `name` TEXT)
    2020-06-18 12:59:11.090 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.093 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7830145_embulk002` (`id` BIGINT, `name` TEXT)
    2020-06-18 12:59:11.105 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.108 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7830145_embulk003` (`id` BIGINT, `name` TEXT)
    2020-06-18 12:59:11.117 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.121 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7830145_embulk004` (`id` BIGINT, `name` TEXT)
    2020-06-18 12:59:11.133 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.135 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7830145_embulk005` (`id` BIGINT, `name` TEXT)
    2020-06-18 12:59:11.149 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.214 +0000 [INFO] (0001:transaction): {done:  0 / 1, running: 0}
    2020-06-18 12:59:11.291 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.306 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.307 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7830145_embulk000` (`id`, `name`) VALUES (?, ?)
    2020-06-18 12:59:11.328 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.340 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.341 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7830145_embulk001` (`id`, `name`) VALUES (?, ?)
    2020-06-18 12:59:11.349 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.364 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.364 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7830145_embulk002` (`id`, `name`) VALUES (?, ?)
    2020-06-18 12:59:11.370 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.382 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.383 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7830145_embulk003` (`id`, `name`) VALUES (?, ?)
    2020-06-18 12:59:11.388 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.399 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.400 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7830145_embulk004` (`id`, `name`) VALUES (?, ?)
    2020-06-18 12:59:11.406 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.418 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.418 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7830145_embulk005` (`id`, `name`) VALUES (?, ?)
    2020-06-18 12:59:11.502 +0000 [INFO] (0015:task-0000): Fetch size is 10000. Using server-side prepared statement.
    2020-06-18 12:59:11.502 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://from_mysql:3306/from_db options {useCompression=true, socketTimeout=1800000, useSSL=false, user=from_user, useLegacyDatetimeCode=false, tcpKeepAlive=true, useCursorFetch=true, connectTimeout=300000, password=***, zeroDateTimeBehavior=convertToNull}
    2020-06-18 12:59:11.513 +0000 [INFO] (0015:task-0000): SQL: SELECT * FROM `from_table`
    2020-06-18 12:59:11.521 +0000 [INFO] (0015:task-0000): > 0.00 seconds
    2020-06-18 12:59:11.527 +0000 [INFO] (0015:task-0000): Loading 6 rows
    2020-06-18 12:59:11.532 +0000 [INFO] (0015:task-0000): > 0.00 seconds (loaded 6 rows in total)
    2020-06-18 12:59:11.538 +0000 [INFO] (0001:transaction): {done:  1 / 1, running: 0}
    2020-06-18 12:59:11.540 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=2700000}
    2020-06-18 12:59:11.548 +0000 [INFO] (0001:transaction): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.550 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE IF NOT EXISTS `to_table` (`id` BIGINT, `name` TEXT)
    2020-06-18 12:59:11.563 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.564 +0000 [INFO] (0001:transaction): SQL: INSERT INTO `to_table` (`id`, `name`) SELECT `id`, `name` FROM `to_table_00000172c7830145_embulk000` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7830145_embulk001` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7830145_embulk002` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7830145_embulk003` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7830145_embulk004` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7830145_embulk005`
    2020-06-18 12:59:11.568 +0000 [INFO] (0001:transaction): > 0.00 seconds (6 rows)
    2020-06-18 12:59:11.583 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 12:59:11.612 +0000 [INFO] (0001:transaction): TransactionIsolation=repeatable_read
    2020-06-18 12:59:11.612 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7830145_embulk000`
    2020-06-18 12:59:11.655 +0000 [INFO] (0001:transaction): > 0.04 seconds
    2020-06-18 12:59:11.656 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7830145_embulk001`
    2020-06-18 12:59:11.674 +0000 [INFO] (0001:transaction): > 0.02 seconds
    2020-06-18 12:59:11.674 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7830145_embulk002`
    2020-06-18 12:59:11.684 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.685 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7830145_embulk003`
    2020-06-18 12:59:11.693 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.693 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7830145_embulk004`
    2020-06-18 12:59:11.714 +0000 [INFO] (0001:transaction): > 0.02 seconds
    2020-06-18 12:59:11.715 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7830145_embulk005`
    2020-06-18 12:59:11.727 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 12:59:11.729 +0000 [INFO] (main): Committed.
    2020-06-18 12:59:11.729 +0000 [INFO] (main): Next config diff: {"in":{},"out":{}}
    ```

1. Check

    ```
    ± docker exec -it ef80b9e3270e mysql -uto_user -p
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 11
    Server version: 5.7.30 MySQL Community Server (GPL)

    Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | to_db              |
    +--------------------+
    2 rows in set (0.01 sec)

    mysql> use to_db;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A

    Database changed
    mysql> show tables;
    +-----------------+
    | Tables_in_to_db |
    +-----------------+
    | to_table        |
    +-----------------+
    1 row in set (0.00 sec)

    mysql> select * from to_table;
    +------+---------+
    | id   | name    |
    +------+---------+
    |    1 | dog     |
    |    2 | cat     |
    |    3 | penguin |
    |    4 | lax     |
    |    5 | whale   |
    |    6 | ostrich |
    +------+---------+
    6 rows in set (0.01 sec)

    mysql>
    ```
