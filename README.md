![Build and Push](https://github.com/binbashing/fail2ban-docker/actions/workflows/build-push.yaml/badge.svg)
# fail2ban-docker

A simple Docker container based on Alpine Linux with Fail2Ban installed.

## Usage

To configure Fail2Ban, you can mount your `jail.local` file to `/jail.local` inside the container. You can use environment variables in your `jail.local` file, which will be substituted at runtime.

Here's an example of how to run the container:

```bash
docker run -d \
    --name fail2ban \
    -v /path/to/access.log:/var/log/nginx/access.log \
    -v /path/to/jail.local:/jail.local \
    -e BANTIME=3600 \
    binbashing/fail2ban
```

In this example, `access.log` is the log file that Fail2Ban will monitor, and `jail.local` is the configuration file for Fail2Ban. The BANTIME environment variable is used to set the ban time in seconds.

Please replace /path/to/access.log and /path/to/jail.local with the actual paths to your access.log and jail.local files on your host machine.

### Environment Variables in jail.local
You can use environment variables in your `jail.local` file. On container startup `envsubst` is used to replace instances of `$VAR_NAME` or `${VAR_NAME}` in the file with the value of the corresponding environment variable.

For example, if your jail.local file contains a line like this:

```bash
bantime = ${BANTIME}
```

And you run your Docker container with an environment variable BANTIME set to 600, like this:

```bash
docker run -d \
    --name fail2ban \
    -v /path/to/access.log:/var/log/nginx/access.log \
    -v /path/to/jail.local:/jail.local \
    -e BANTIME=600 \
    binbashing/fail2ban
```

Then `envsubst` will replace ${BANTIME} with 600 in the /etc/fail2ban/jail.local file.