## Usage

```sh
clojure -T:build uber
./compile.sh
./target/jna
```

Config files are from https://github.com/oracle/graalvm-reachability-metadata/blob/master/metadata/net.java.dev.jna/jna/5.8.0/resource-config.json.


## Try with Docker

If you have Docker you can try this without installing anything locally.

Try these commands:

* `make test`

  Set up all dependencies, run and run example.

* `make test-shell`

  Same as above but leaves you in a Bash shell inside the container afterwards.

* `make clean`

  Remove generated files.
