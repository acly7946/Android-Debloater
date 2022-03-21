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
if [ "$#" = 0 ]; then
	echo "Usage: ${0} <INPUTFILE> <INPUTFILE2>"
	exit 1
fi
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
