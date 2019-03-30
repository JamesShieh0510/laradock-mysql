while !(mysqladmin -u $MYSQL_USER -p$MYSQL_PASSWORD ping)
do
   sleep 3
   echo "waiting for mysql ..."
done
echo "starting the main script"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e " CREATE USER $(echo \'$MYSQL_USER\')@'localhost' IDENTIFIED BY $(echo \'$MYSQL_PASSWORD\') ; FLUSH PRIVILEGES ; "
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS 	$(echo '`'$MYSQL_USER'`') CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin' ;FLUSH PRIVILEGES ; "
mysql $MYSQL_DATABASE -u root -p$MYSQL_ROOT_PASSWORD < /docker-entrypoint-initdb.d/createdb.sql 
