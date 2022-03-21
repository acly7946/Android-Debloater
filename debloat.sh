#! /bin/sh
#
# Debloater for Redmi 8A global ROM
#
# credit to https://selivan.github.io/2020/02/25/removing-bloatware-from-xiaomi-miui-android.html

install()
{
	ERROR=$(adb shell cmd package install-existing "${1}" 2>&1)
	RETURN=$?
	if [ ${RETURN} != 0 ]; then
		printf "\r%sFAILED %s${1} %s${ERROR}\n" "$(tput setaf 1)" "$(tput sgr0)" "$(tput setaf 3)"
	else
		printf "\r%sSUCCESS ${1}\n%s" "$(tput setaf 2)" "$(tput sgr0)"
	fi
}

uninstall()
{
	ERROR=$(adb shell pm uninstall -k --user 0 "${1}" 2>&1)
	RETURN=$?
	if [ ${RETURN} != 0 ]; then
		printf "\r%sFAILED %s${1} %s${ERROR}\n" "$(tput setaf 1)" "$(tput sgr0)" "$(tput setaf 3)"
	else
		printf "\r%sSUCCESS ${1}\n%s" "$(tput setaf 2)" "$(tput sgr0)"
	fi
}

BASENAME=$(basename "${0}")

adb start-server # initialise adb first
if [ "${BASENAME}" = "debloat.sh" ]; then
	printf "Uninstalling..."
	while IFS= read -r PACKAGE; do
		uninstall "${PACKAGE}" &
	done < "$@"
elif [ "${BASENAME}" = "rebloat.sh" ]; then
	printf "Reinstalling..."
	while IFS= read -r PACKAGE; do
		install "${PACKAGE}" &
	done < "$@"
fi
wait
