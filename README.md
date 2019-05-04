Hello World
===========

This is a simple image that just gives a response on port 8000. Use this to
test your web orchestration. It's small enough to fit on one floppy disk:

```bash
$ docker images | grep hell
REPOSITORY               TAG       IMAGE ID        CREATED          VIRTUAL SIZE
crccheck/hello-world     latest    2b28c6ad8d1b    4 months ago     1.2MB
```

I made this because there were lots of scenarios where wanted a Docker
container that speaks HTTP, but every image used in guides took seconds to
download. With a tiny Docker image, I could test things from a fresh
environment in under a second. I like faster feedback loops.


Sample Usage
------------

### Starting a web server on port 80

```bash
$ docker run -d --rm --name web-test -p 80:8000 crccheck/hello-world
```

You can now interact with this as if it were a dumb web server:
```
$ curl localhost
Hello World
...

# Every request returns the same thing
$ curl -X POST localhost/super/secret
Hello World
...

# Does not send actual HTTP responses (this should probably change so this can
# be used with load balancers)
$ curl --write-out %{http_code} --silent --output /dev/null localhost
000
```
