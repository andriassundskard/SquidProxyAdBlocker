## Squid Proxy Ad Blocker
Fork of project from Pedro Nunes (https://github.com/pgnunes/SquidProxyAdBlocker)

SquidProxyAdBlocker is a filtering adblocker (and track-blocker) ([Squid](http://www.squid-cache.org/ "Squid")) proxy.

### Run 
`docker run --rm --name squidproxyadblocker -p 3128:3128 -p 3129:3129 andriassundskard/squidproxyadblocker` 

### Browser/Network Configuration
Configure your browser/network proxy settings to the host where SquidProxyAdBlocker is running like (running locally):
- Host: `127.0.0.1`
- Port: `3128` (`3129` for transparent proxy)

### Help / Requests
If you need help or want to request a new feature please [open an issue](https://github.com/andriassundskard/SquidProxyAdBlocker/issues).
