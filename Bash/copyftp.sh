#!/bin/sh
HOST="XXX.XXX.XXX.XXX"
USER="XXX"
PASSWD="XXX"
FILE="$1"

echo "SERVIDOR FTP: $HOST" > /tmp/uptocel.tmp
echo "USUARIO: $USER" > /tmp/uptocel.tmp
echo "--------------------" > /tmp/uptocel.tmp
echo "ENVIANDO: $FILE..." > /tmp/uptocel.tmp
if grep -Fxq "$FILE" /home/alejandro/VideoOnWatch/copiados.txt; then
	echo -e "Archivo ya copiado...\nlocal: $FILE" > /tmp/uptocel.tmp
	exit
fi
echo "$FILE" >> /home/alejandro/VideoOnWatch/copiados.txt
touch /tmp/uptocel.tmp
{
ftp -nv $HOST 2221 <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
binary
put "$FILE"
quit
END_SCRIPT
exit 0
}>/tmp/uptocel.tmp

