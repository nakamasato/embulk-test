# Embulk

## test

```
docker run --entrypoint="" --rm -it -v $(pwd):/work embulk sh -c 'java -jar /bin/embulk example ./sample && embulk guess ./sample/seed.yml -o config.yml && cat config.yml && embulk preview ./config.yml && embulk run ./config.yml'
```

## from mysql to mysql

```
docker run --network embulk_test --entrypoint="" --rm -it -v $(pwd):/work embulk sh -c 'java -jar /bin/embulk example ./sample'
```
