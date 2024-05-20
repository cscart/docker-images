#!/bin/sh

useradd -ms /bin/bash $FTP_USER_NAME

echo "${FTP_USER_NAME}:${FTP_USER_PASS}" | chpasswd

usermod -u 0 -o $FTP_USER_NAME

setftpconfigsetting() {
    if [ $# -ne 3 ] || [ ! -e "$3" ]; then
        echo "Set an FTP configuration setting in the given file."
        echo "Usage: setftpconfigsetting <setting_hame> <setting_value> <config_file>"

        return 1
    fi

    if [ -z "$(grep -m1 -Gi "^${1}=" "$3")" ]; then
        echo "${1}=${2}" >> "$3"
    else
        sed -i "s~^${1}=.*~${1}=${2}~" "$3"
    fi
}

setftpconfigsetting "pasv_address" "$PASV_ADDRESS" /etc/vsftp/vsftp.conf


CONF_FILE="/etc/vsftp/vsftp.conf"

echo "Launching vsftp on ftp protocol"

&>/dev/null /usr/sbin/vsftpd $CONF_FILE
