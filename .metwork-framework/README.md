## What is it ?

A cron job wrapper to add some missing features (locks, timeouts, random sleeps, env loading...).

## Usage

```
Usage: cronwrap.py [options]

Options:
  -h, --help            show this help message and exit
  -t TIMEOUT, --timeout=TIMEOUT
                        command timeout (in seconds); 0 means no timeout;
                        default: 3600
  -r RVALUE, --random-sleep=RVALUE
                        wait a random value of seconds between 0 and RVALUE
                        before executing command (default 0: no random wait)
  -l, --lock            don't execute the command another time if still
                        running (default False)
  -e, --load-env        load environnement file before executing command
                        (default: False)
  -f LOAD_ENV_FILE, --load-env-file=LOAD_ENV_FILE
                        set the environnement file to load if load-env option
                        is set (default: ~/.bashrc)
  -s SHELL, --shell=SHELL
                        full path of the shell to use (default /bin/sh)
  -n NICE, --nice=NICE  'nice' value (from -20 (most favorable scheduling) to
                        19 (least favorable))
  -i IONICE, --ionice=IONICE
                        'ionice' class (1 for realtime, 2 for best-effort, 3
                        for idle)
  --low                 short cut for '-i 3 -n 19' (minimum priority)
```

## Real-life usage example

In a user `crontab`:

```
*/10 * * * * cronwrap.py --load-env --lock --low -- slow_cleaning_command.sh slow_cleaning_command_option
```

to run `slow_cleaning_command.sh slow_cleaning_command_option` every 10 minutes but with:

- the user environement loaded before execution
- with a (default) execution timeout of 3600 seconds
- minimal system priority
- with a lock to avoid several execution at the same time (if the previous run is still alive)

