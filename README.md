# Embulk

## Migrate from mysql to mysql

1. Build docker iamge

    ```
    docker build -t embulk .
    ```

1. Prepare test databases (Insert 100,000 records)

    ```
    docker-compose -f docker-compose-mysql.yml up
    ```

    wait until all the records are inserted

    ```
    docker exec -it $(docker ps | grep embulk-test_from_mysql_1 | awk '{print $1}') bash -c 'echo "select count(*) from from_table;" | mysql -ufrom_user -pfrom_password from_db'
    mysql: [Warning] Using a password on the command line interface can be insecure.
    count(*)
    8183
    ```

    ...

    ```
    docker exec -it $(docker ps | grep embulk-test_from_mysql_1 | awk '{print $1}') bash -c 'echo "select count(*) from from_table;" | mysql -ufrom_user -pfrom_password from_db'
    mysql: [Warning] Using a password on the command line interface can be insecure.
    count(*)
    100000
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
    ...
    +---------+-------------+
    ```

1. Run

    ```
    docker run --network embulk_test --entrypoint="" --rm -it -v $(pwd):/work embulk sh -c 'java -jar /bin/embulk run ./mysql-config.yml'
    2020-06-18 13:31:36.672 +0000: Embulk v0.9.23
    2020-06-18 13:31:37.841 +0000 [WARN] (main): DEPRECATION: JRuby org.jruby.embed.ScriptingContainer is directly injected.
    2020-06-18 13:31:40.853 +0000 [INFO] (main): Gem's home and path are set by default: "/root/.embulk/lib/gems"
    2020-06-18 13:31:42.117 +0000 [INFO] (main): Started Embulk v0.9.23
    2020-06-18 13:31:42.270 +0000 [INFO] (0001:transaction): Loaded plugin embulk-input-mysql (0.10.1)
    2020-06-18 13:31:42.316 +0000 [INFO] (0001:transaction): Loaded plugin embulk-output-mysql (0.8.7)
    2020-06-18 13:31:42.370 +0000 [INFO] (0001:transaction): JDBC Driver = /root/.embulk/lib/gems/gems/embulk-input-mysql-0.10.1/default_jdbc_driver/mysql-connector-java-5.1.44.jar
    2020-06-18 13:31:42.383 +0000 [INFO] (0001:transaction): Fetch size is 10000. Using server-side prepared statement.
    2020-06-18 13:31:42.385 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://from_mysql:3306/from_db options {useCompression=true, socketTimeout=1800000, useSSL=false, user=from_user, useLegacyDatetimeCode=false, tcpKeepAlive=true, useCursorFetch=true, connectTimeout=300000, password=***, zeroDateTimeBehavior=convertToNull}
    2020-06-18 13:31:42.675 +0000 [INFO] (0001:transaction): Using JDBC Driver mysql-connector-java-5.1.44 ( Revision: b3cda4f864902ffdde495b9df93937c3e20009be )
    2020-06-18 13:31:42.675 +0000 [WARN] (0001:transaction): embulk-input-mysql 0.9.0 upgraded the bundled MySQL Connector/J version from 5.1.34 to 5.1.44 .
    2020-06-18 13:31:42.675 +0000 [WARN] (0001:transaction): And set useLegacyDatetimeCode=false by default in order to get correct datetime value when the server timezone and the client timezone are different.
    2020-06-18 13:31:42.675 +0000 [WARN] (0001:transaction): Set useLegacyDatetimeCode=true if you need to get datetime value same as older embulk-input-mysql.
    2020-06-18 13:31:42.749 +0000 [INFO] (0001:transaction): Using local thread executor with max_threads=12 / output tasks 6 = input tasks 1 * 6
    2020-06-18 13:31:42.775 +0000 [INFO] (0001:transaction): JDBC Driver = /root/.embulk/lib/gems/gems/embulk-output-mysql-0.8.7/default_jdbc_driver/mysql-connector-java-5.1.44.jar
    2020-06-18 13:31:42.787 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:43.046 +0000 [INFO] (0001:transaction): TransactionIsolation=repeatable_read
    2020-06-18 13:31:43.046 +0000 [INFO] (0001:transaction): Using JDBC Driver mysql-connector-java-5.1.44 ( Revision: b3cda4f864902ffdde495b9df93937c3e20009be )
    2020-06-18 13:31:43.046 +0000 [WARN] (0001:transaction): This plugin will update MySQL Connector/J version in the near future release.
    2020-06-18 13:31:43.046 +0000 [WARN] (0001:transaction): It has some incompatibility changes.
    2020-06-18 13:31:43.046 +0000 [WARN] (0001:transaction): For example, the 5.1.35 introduced `noTimezoneConversionForDateType` and `cacheDefaultTimezone` options.
    2020-06-18 13:31:43.046 +0000 [WARN] (0001:transaction): Please read a document and make sure configuration carefully before updating the plugin.
    2020-06-18 13:31:43.051 +0000 [WARN] (0001:transaction): The plugin will set `useLegacyDatetimeCode=false` by default in future.
    2020-06-18 13:31:43.051 +0000 [INFO] (0001:transaction): Using insert mode
    2020-06-18 13:31:43.082 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7a0ca59_embulk000` (`id` BIGINT, `name` TEXT)
    2020-06-18 13:31:43.113 +0000 [INFO] (0001:transaction): > 0.03 seconds
    2020-06-18 13:31:43.117 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7a0ca59_embulk001` (`id` BIGINT, `name` TEXT)
    2020-06-18 13:31:43.132 +0000 [INFO] (0001:transaction): > 0.02 seconds
    2020-06-18 13:31:43.136 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7a0ca59_embulk002` (`id` BIGINT, `name` TEXT)
    2020-06-18 13:31:43.150 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:43.154 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7a0ca59_embulk003` (`id` BIGINT, `name` TEXT)
    2020-06-18 13:31:43.169 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:43.173 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7a0ca59_embulk004` (`id` BIGINT, `name` TEXT)
    2020-06-18 13:31:43.196 +0000 [INFO] (0001:transaction): > 0.02 seconds
    2020-06-18 13:31:43.200 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE `to_table_00000172c7a0ca59_embulk005` (`id` BIGINT, `name` TEXT)
    2020-06-18 13:31:43.220 +0000 [INFO] (0001:transaction): > 0.02 seconds
    2020-06-18 13:31:43.372 +0000 [INFO] (0001:transaction): {done:  0 / 1, running: 0}
    2020-06-18 13:31:43.439 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:43.453 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 13:31:43.454 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7a0ca59_embulk000` (`id`, `name`) VALUES (?, ?)
    2020-06-18 13:31:43.473 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:43.487 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 13:31:43.487 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7a0ca59_embulk001` (`id`, `name`) VALUES (?, ?)
    2020-06-18 13:31:43.496 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:43.510 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 13:31:43.511 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7a0ca59_embulk002` (`id`, `name`) VALUES (?, ?)
    2020-06-18 13:31:43.517 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:43.529 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 13:31:43.529 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7a0ca59_embulk003` (`id`, `name`) VALUES (?, ?)
    2020-06-18 13:31:43.535 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:43.545 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 13:31:43.545 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7a0ca59_embulk004` (`id`, `name`) VALUES (?, ?)
    2020-06-18 13:31:43.550 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:43.565 +0000 [INFO] (0015:task-0000): TransactionIsolation=repeatable_read
    2020-06-18 13:31:43.565 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `to_table_00000172c7a0ca59_embulk005` (`id`, `name`) VALUES (?, ?)
    2020-06-18 13:31:43.672 +0000 [INFO] (0015:task-0000): Fetch size is 10000. Using server-side prepared statement.
    2020-06-18 13:31:43.672 +0000 [INFO] (0015:task-0000): Connecting to jdbc:mysql://from_mysql:3306/from_db options {useCompression=true, socketTimeout=1800000, useSSL=false, user=from_user, useLegacyDatetimeCode=false, tcpKeepAlive=true, useCursorFetch=true, connectTimeout=300000, password=***, zeroDateTimeBehavior=convertToNull}
    2020-06-18 13:31:43.684 +0000 [INFO] (0015:task-0000): SQL: SELECT * FROM `from_table`
    2020-06-18 13:31:43.790 +0000 [INFO] (0015:task-0000): > 0.10 seconds
    2020-06-18 13:31:43.836 +0000 [INFO] (0015:task-0000): Fetched 500 rows.
    2020-06-18 13:31:43.849 +0000 [INFO] (0015:task-0000): Fetched 1,000 rows.
    2020-06-18 13:31:43.869 +0000 [INFO] (0015:task-0000): Fetched 2,000 rows.
    2020-06-18 13:31:43.908 +0000 [INFO] (0015:task-0000): Fetched 4,000 rows.
    2020-06-18 13:31:43.941 +0000 [INFO] (0015:task-0000): Fetched 8,000 rows.
    2020-06-18 13:31:43.997 +0000 [INFO] (0015:task-0000): Fetched 16,000 rows.
    2020-06-18 13:31:44.093 +0000 [INFO] (0015:task-0000): Fetched 32,000 rows.
    2020-06-18 13:31:44.206 +0000 [INFO] (0015:task-0000): Fetched 64,000 rows.
    2020-06-18 13:31:44.308 +0000 [INFO] (0015:task-0000): Loading 17,254 rows
    2020-06-18 13:31:44.627 +0000 [INFO] (0015:task-0000): > 0.32 seconds (loaded 17,254 rows in total)
    2020-06-18 13:31:44.627 +0000 [INFO] (0015:task-0000): Loading 16,869 rows
    2020-06-18 13:31:44.878 +0000 [INFO] (0015:task-0000): > 0.25 seconds (loaded 16,869 rows in total)
    2020-06-18 13:31:44.878 +0000 [INFO] (0015:task-0000): Loading 16,468 rows
    2020-06-18 13:31:45.099 +0000 [INFO] (0015:task-0000): > 0.22 seconds (loaded 16,468 rows in total)
    2020-06-18 13:31:45.100 +0000 [INFO] (0015:task-0000): Loading 16,469 rows
    2020-06-18 13:31:45.364 +0000 [INFO] (0015:task-0000): > 0.26 seconds (loaded 16,469 rows in total)
    2020-06-18 13:31:45.365 +0000 [INFO] (0015:task-0000): Loading 16,473 rows
    2020-06-18 13:31:45.644 +0000 [INFO] (0015:task-0000): > 0.28 seconds (loaded 16,473 rows in total)
    2020-06-18 13:31:45.644 +0000 [INFO] (0015:task-0000): Loading 16,467 rows
    2020-06-18 13:31:45.842 +0000 [INFO] (0015:task-0000): > 0.20 seconds (loaded 16,467 rows in total)
    2020-06-18 13:31:45.848 +0000 [INFO] (0001:transaction): {done:  1 / 1, running: 0}
    2020-06-18 13:31:45.850 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=2700000}
    2020-06-18 13:31:45.859 +0000 [INFO] (0001:transaction): TransactionIsolation=repeatable_read
    2020-06-18 13:31:45.861 +0000 [INFO] (0001:transaction): SQL: CREATE TABLE IF NOT EXISTS `to_table` (`id` BIGINT, `name` TEXT)
    2020-06-18 13:31:45.871 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:45.872 +0000 [INFO] (0001:transaction): SQL: INSERT INTO `to_table` (`id`, `name`) SELECT `id`, `name` FROM `to_table_00000172c7a0ca59_embulk000` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7a0ca59_embulk001` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7a0ca59_embulk002` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7a0ca59_embulk003` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7a0ca59_embulk004` UNION ALL SELECT `id`, `name` FROM `to_table_00000172c7a0ca59_embulk005`
    2020-06-18 13:31:46.646 +0000 [INFO] (0001:transaction): > 0.77 seconds (100,000 rows)
    2020-06-18 13:31:46.675 +0000 [INFO] (0001:transaction): Connecting to jdbc:mysql://to_mysql:3306/to_db options {user=to_user, password=***, tcpKeepAlive=true, useSSL=false, useCompression=true, rewriteBatchedStatements=true, connectTimeout=300000, socketTimeout=1800000}
    2020-06-18 13:31:46.685 +0000 [INFO] (0001:transaction): TransactionIsolation=repeatable_read
    2020-06-18 13:31:46.685 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7a0ca59_embulk000`
    2020-06-18 13:31:46.695 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:46.695 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7a0ca59_embulk001`
    2020-06-18 13:31:46.706 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:46.706 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7a0ca59_embulk002`
    2020-06-18 13:31:46.716 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:46.716 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7a0ca59_embulk003`
    2020-06-18 13:31:46.726 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:46.727 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7a0ca59_embulk004`
    2020-06-18 13:31:46.737 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:46.738 +0000 [INFO] (0001:transaction): SQL: DROP TABLE IF EXISTS `to_table_00000172c7a0ca59_embulk005`
    2020-06-18 13:31:46.749 +0000 [INFO] (0001:transaction): > 0.01 seconds
    2020-06-18 13:31:46.750 +0000 [INFO] (main): Committed.
    2020-06-18 13:31:46.750 +0000 [INFO] (main): Next config diff: {"in":{},"out":{}}
    ```

1. Check

    `from_db`:

    ```
    ± docker exec -it $(docker ps | grep embulk-test_from_mysql_1 | awk '{print $1}') bash -c 'echo "select count(*) from from_table;" | mysql -ufrom_user -pfrom_password from_db'
    mysql: [Warning] Using a password on the command line interface can be insecure.
    count(*)
    100006
    ```

    `to_db`:

    ```
    ± docker exec -it $(docker ps | grep embulk-test_to_mysql_1 | awk '{print $1}') bash -c 'echo "select count(*) from to_table;" | mysql -uto_user -pto_password to_db'
    mysql: [Warning] Using a password on the command line interface can be insecure.
    count(*)
    100006
    ```
