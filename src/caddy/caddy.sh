#!/bin/sh
#
echo "Run"

PLATFORM=$1
if [ -z "$PLATFORM" ]; then
    ARCH="amd64"
else
    case "${PLATFORM}" in
        linux/386)
            ARCH="386"
            ;;
        linux/amd64)
            ARCH="amd64"
            ;;
        linux/arm/v6)
            ARCH="arm6"
            ;;
        linux/arm/v7)
            ARCH="arm7"
            ;;
        linux/arm64|linux/arm64/v8)
            ARCH="arm64"
            ;;
        linux/ppc64le)
            ARCH="ppc64le"
            ;;
        linux/riscv64)
            ARCH="riscv64"
            ;;
        linux/s390x)
            ARCH="s390x"
            ;;
        *)
            ARCH=""
            ;;
    esac
fi
[ -z "${ARCH}" ] && echo "Error: Not supported OS Architecture" && exit 1

TARGET_FILE="caddy-linux-${ARCH}.tar.gz"
DIR_TMP="$(mktemp -d)"

echo "Downloading archive file: ${TARGET_FILE}"

# wget -O ${DIR_TMP}/caddy.tar.gz https://github.com/darkommoers/learngithubactionsdemo/releases/download/caddy/${TARGET_FILE} > /dev/null 2>&1

aria2c -o ${DIR_TMP}/caddy.tar.gz https://github.com/darkommoers/learngithubactionsdemo/releases/download/caddy/${TARGET_FILE}

# if [ $? -ne 0 ]; then
#     echo "Error: Failed to download archive file: ${TARGET_FILE}" && exit 1
# fi
# echo "Download archive file: ${TARGET_FILE} completed"

if [ ! -e "${DIR_TMP}/caddy.tar.gz" ]; then echo "Error: Failed to download archive file: ${TARGET_FILE}" && exit 1; else echo "Download archive file: ${TARGET_FILE} completed" ;fi
if [ ! -f "${DIR_TMP}/caddy.tar.gz" ]; then echo "Error: Failed to download archive file: ${TARGET_FILE}" && exit 1; else echo "Download archive file: ${TARGET_FILE} completed" ;fi

echo "Extract the archive contents"
tar -xzf ${DIR_TMP}/caddy.tar.gz -C ${DIR_TMP}
cp -fr ${DIR_TMP}/caddy /usr/bin/caddy
rm -rfv ${DIR_TMP}
caddy version
setcap 'cap_sys_admin,cap_net_admin,cap_net_bind_service=+ep' /usr/bin/caddy
getcap /usr/bin/caddy
chmod +x /usr/bin/caddy
echo "End"
