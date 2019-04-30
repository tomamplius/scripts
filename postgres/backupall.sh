su postgres <<'EOF'
cd ~postgres
retour=0
for db in $( psql -c "SELECT datname FROM pg_database" -At | grep -v -e template0) 
do
        echo -n "backup de la base de donnée $db : "
        /usr/bin/pg_dump --format custom --blobs --file /tmp/$db.dump.$(date +%w ) --verbose  $db &> /dev/null
        statut=$?
        [ $statut -ne 0 ] && echo --KO-- || echo OK
        [ $statut -ne 0 ] &&  retour=1
done
exit $retour
EOF
