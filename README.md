Hello World
===========

This is a simple Docker image that just gives http responses on port 8000. It's
small enough to fit on one floppy disk:

```bash
$ docker images | grep hell
REPOSITORY               TAG       IMAGE ID        CREATED          VIRTUAL SIZE
crccheck/hello-world     latest    2b28c6ad8d1b    4 months ago     1.2MB
```

I made this initially because there were lots of scenarios where I wanted a
Docker container that speaks HTTP, but every guide used images that took
seconds to download. Armed with a tiny Docker image, I could test things in a
fresh environment in under a second. I like faster feedback loops.

**THANK YOU** to the surprisingly large number of contributors that have made
this better for everyone over the years.


Sample Usage
------------

### Starting a web server on port 80

```bash
$ docker run -d --rm --name web-test -p 80:8000 crccheck/hello-world
```

You can now interact with this as if it were a dumb web server:

```
$ curl localhost
<xmp>
Hello World
...snip...
```

```
$ curl -I localhost
HTTP/1.0 200 OK
```

```
$ curl -X POST localhost/super/secret
<HTML><HEAD><TITLE>501 Not Implemented</TITLE></HEAD>
...snip...
```

```
$ curl --write-out %{http_code} --silent --output /dev/null localhost
200
```
