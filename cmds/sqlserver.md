
# install ssms
# move backups to /c/docker/vol/mssql/backup

docker volume create mssql

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Password1!" --name "mssql" --restart unless-stopped -p 1433:1433 -v mssql:/var/opt/mssql -v /c/docker/vol/mssql/backup:/var/opt/mssql/backup -d mcr.microsoft.com/mssql/server:2019-latest

# start sql server, connect using sa // Password1! -> restore from backup as normal