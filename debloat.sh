#! /bin/sh
#
# Generic android batch package remover

install()
{
	ERROR=$(adb shell cmd package install-existing "${1}" 2>&1)
	RETURN=$?
	if [ ${RETURN} != 0 ]; then
		printf "\r%sFAILED %s${1} %s${ERROR}\n" "$(tput setaf 1)" "$(tput sgr0)" "$(tput setaf 3)"
	else
		APKPATH=$(adb shell pm path "${1}" 2>&1 | cut -f 2 -d ":")
		if [ -z "${APKPATH}" ]; then
			printf "\r%sSKIPPED %s${1} \n" "$(tput setaf 4)" "$(tput sgr0)"
			return
		fi

		# Get common name
		NAME=$(adb shell /data/local/tmp/aapt-arm-pie d badging "${APKPATH}" 2>&1 | grep "application-label:" | cut -f 2 -d ":" | tr -d \')
		if [ -z "${NAME}" ]; then # Set to package name if no common name
			NAME="${1}"
			return
		fi
		printf "\r%sSUCCESS %s${NAME}\n" "$(tput setaf 2)" "$(tput sgr0)"
	fi
}

uninstall()
{
	APKPATH=$(adb shell pm path "${1}" 2>&1 | cut -f 2 -d ":")
	if [ -z "${APKPATH}" ]; then
		printf "\r%sSKIPPED %s${1} \n" "$(tput setaf 4)" "$(tput sgr0)"
		return
	fi

	# Get common name
	NAME=$(adb shell /data/local/tmp/aapt-arm-pie d badging "${APKPATH}" 2>&1 | grep "application-label:" | cut -f 2 -d ":" | tr -d \')
	if [ -z "${NAME}" ]; then # Set to package name if no common name
		NAME="${1}"
		return
	fi

	ERROR=$(adb shell pm uninstall -k --user 0 "${1}" 2>&1)
	RETURN=$?
	if [ ${RETURN} != 0 ]; then
		printf "\r%sFAILED %s${NAME} %s${ERROR}\n" "$(tput setaf 1)" "$(tput sgr0)" "$(tput setaf 3)"
	else
		printf "\r%sSUCCESS %s${NAME}\n" "$(tput setaf 2)" "$(tput sgr0)"
	fi
}

BASENAME=$(basename "${0}")
adb start-server # initialise adb first
adb push aapt-arm-pie /data/local/tmp >/dev/null
adb shell chmod 0755 /data/local/tmp/aapt-arm-pie

# Check if files were specified
if [ "$#" = 0 ]; then
	echo "Usage: ${0} <INPUTFILE> <INPUTFILE2>"
	exit 1
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
	echo "File must be called 'debloat.sh' or 'rebloat.sh'"
	exit 1
fi

wait
adb shell rm /data/local/tmp/aapt-arm-pie
