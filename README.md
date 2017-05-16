# dnsdiff
## About
`dnsdiff` compares the responses between two nameservers and provides output
in universal diff format.

Run `dnsdiff` before delegating authority of a zone to a new provider to
ensure that the new provider has imported your zonefile correctly.

## Usage

```
usage: dnsdiff [-h] [-V] [-c] [-d SECONDS] [-t] -f FILENAME --from-ns
               NAMESERVER1[:PORT] --to-ns NAMESERVER2[:PORT]

Options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -c, --color           enable colorized output
  -d SECONDS, --delay-max SECONDS
                        maximum number of seconds of delay to introduce
                        between each request
  -t, --ignore-ttl      ignore changes to TTL values
  -f FILENAME, --zonefile FILENAME
                        FILENAME is expected to be a valid zonefile exported
                        from NAMESERVER1
                        https://tools.ietf.org/html/rfc1035#section-5
  --from-ns NAMESERVER1[:PORT]
                        compare responses to NAMESERVER2
  --to-ns NAMESERVER2[:PORT]
                        compare responses to NAMESERVER1
```

### Example

```
$ dnsdiff --zonefile example.com.zone --from-ns ns1.example.com --to-ns ns1.cloudflare.com
--- ns1.example.com         2015-05-24 06:00:40 +0000
+++ ns1.cloudflare.com      2015-05-24 06:00:40 +0000
-example.com. 172800 IN NS ns1.example.com.
-example.com. 172800 IN NS ns2.example.com.
+example.com. 86400 IN NS ns1.cloudflare.com.
+example.com. 86400 IN NS ns2.cloudflare.com.
-example.com. 900 IN SOA ns1.example.com. dns.example.com. 1 7200 900 1209600 86400
+example.com. 3600 IN SOA ns1.cloudflare.com. dns.example.com. 2 3600 600 604800 1800
```

### Docker
```
$ docker build -t dnsdiff .
$ docker run dnsdiff
$ docker run --rm -v example.com.zone:/zonefile.db dnsdiff --from-ns ns1.example.com --to-ns ns1.cloudflare.com --zonefile /zonefile.db
```

## Installation (Debian)
### Install system packages

```
sudo apt-get install python3.4 python3-pip
```

### Setup virtualenv (optional)

```
sudo pip3 install virtualenv
virtualenv .venv/dnsdiff
source .venv/dnsdiff/bin/activate
```

### Install dependencies

```
pip install dnspython3 blessings
```
