#! /bin/sh
#
# Generic android batch package remover

CACHE="${XDG_CACHE_HOME}"/Android-Debloater/"$(adb get-serialno)"

gen_cache()
{
	mkdir -p "${XDG_CACHE_HOME}"/Android-Debloater
	adb shell pm list packages -f -u | cut -f 2 -d ':' > "${XDG_CACHE_HOME}"/Android-Debloater/"$(adb get-serialno)"
}

install()
{
	if ! grep -q "${1}" "${CACHE}"; then
		printf "\r%sSKIPPED %s${1} \n" "$(tput setaf 4)" "$(tput sgr0)"
		return
	fi

	# Get common name
	APKPATH=$(adb shell pm path "${1}" 2>&1 | cut -f 2 -d ":")
	NAME=$(adb shell /data/local/tmp/aapt-arm-pie d badging "${APKPATH}" 2>&1 | grep "application-label:" | cut -f 2 -d ":" | tr -d \')
	if [ -z "${NAME}" ]; then # Set to package name if no common name
		NAME="${1}"
	fi

	ERROR=$(adb shell cmd package install-existing "${1}" 2>&1)
	RETURN=$?
	if [ ${RETURN} != 0 ]; then
		printf "\r%sFAILURE %s${NAME} %s${ERROR}\n" "$(tput setaf 1)" "$(tput sgr0)" "$(tput setaf 3)"
	else
		printf "\r%sSUCCESS %s${NAME}\n" "$(tput setaf 2)" "$(tput sgr0)"
	fi
}

uninstall()
{
	CACHED_DATA=$(grep "${1}" "${CACHE}" | grep ".apk")
	if [ -z "${CACHED_DATA}" ]; then
		printf "\r%sSKIPPED %s${1} \n" "$(tput setaf 4)" "$(tput sgr0)"
		return
	else
		APKPATH=$(echo "${CACHED_DATA}" | cut -c 9- | sed "s/\.apk=.*/.apk/")
	fi

	# Get common name
	NAME=$(adb shell /data/local/tmp/aapt-arm-pie d badging "${APKPATH}" 2>&1 | grep "application-label:" | cut -f 2 -d ":" | tr -d \')
	if [ -z "${NAME}" ]; then # Set to package name if no common name
		NAME="${1}"
	fi

	ERROR=$(adb shell pm uninstall -k --user 0 "${1}" 2>&1)
	RETURN=$?
	if [ ${RETURN} != 0 ]; then
		printf "\r%sFAILURE %s${NAME} %s${ERROR}\n" "$(tput setaf 1)" "$(tput sgr0)" "$(tput setaf 3)"
	else
		printf "\r%sSUCCESS %s${NAME}\n" "$(tput setaf 2)" "$(tput sgr0)"
	fi
}

BASENAME=$(basename "${0}")
adb start-server
if ! adb devices | grep -m 1 "[0-9]" ; then
	exit 1
fi
adb push aapt-arm-pie /data/local/tmp >/dev/null
adb shell chmod 0755 /data/local/tmp/aapt-arm-pie

# Check if files were specified
if [ "$#" = 0 ]; then
	echo "error: specify file as package list"
	exit 1
fi


# Generate cache if not present
if [ ! -e "${CACHE}" ]; then
	gen_cache
fi

# Either debloat or rebloat or fail
if [ "${BASENAME}" = "debloat.sh" ]; then
	echo "Uninstalling..."
	while IFS= read -r PACKAGE; do
		uninstall "${PACKAGE}" &
	done < "$@"
elif [ "${BASENAME}" = "rebloat.sh" ]; then
	echo "Reinstalling..."
	while IFS= read -r PACKAGE; do
		install "${PACKAGE}" &
	done < "$@"
else
	echo "error: executable must be called 'debloat.sh' or 'rebloat.sh'"
	exit 1
fi

wait
adb shell rm /data/local/tmp/aapt-arm-pie
