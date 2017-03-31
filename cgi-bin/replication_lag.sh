#!/bin/bash
THISNODE=`hostname`


if [ -n "$GATEWAY_INTERFACE" ]; then # are we running on the command-line, or via the Python CGI server?
    echo "Content-Type: text/html"
    echo
    echo '<html><head>'
    echo '<meta http-equiv="refresh" content="5">'
    echo '</head>'
    psql -d $PGDATABASE -H -q  -f ../replication_lag.sql | perl -p -i -e "s/Bytes Behind This Node/Bytes Behind $THISNODE/" | perl -p -i -e "s,REMOTE_NODE(.*)REMOTE_NODE,<a href='http://\1:4500/cgi-bin/replication_lag.sh'>\1</a>,"
    echo '</html>'
else
    psql -d $PGDATABASE -q  -f ../replication_lag.sql | perl -p -i -e "s/REMOTE_NODE/           /g"
fi
