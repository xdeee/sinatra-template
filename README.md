# sinatra-template
Working skeleton for Sinatra Ruby simple application

Using *Thin* as webserver, *Sequel + SQLite* as database and *Bootstrap CSS* on layout.

Ready to use with:
```bash
$ bundle update
$ sequel -m ./migration sqlite://db.sqlite
$ ./server.sh start
````
Open http://127.0.0.1:4567 in the browser.

New files in `routes` or `models` folders are 'requiring' automatically.

Script `./server.sh start [development|production|test]` runs the server in a develompent mode by default. Also `stop` or `status` or `restart` available. By default production mode requires ssl certificate to run. 

Simple script `watchdog.sh` can be used on cron, checking if the server is running.
