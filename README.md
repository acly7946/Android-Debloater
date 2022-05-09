# Android-Debloater

## Requirements:

* A Shell
* ADB

## Usage

To debloat:
``` sh
./debloat.sh <INPUTFILE> <INPUTFILE2>
```

To rebloat:
``` sh
ln -sf debloat.sh rebloat.sh
./rebloat.sh <INPUTFILE> <INPUTFILE2>
```

## Output:

If possible, the human readable/common name of a package will be shown. If not possible, then the package name itself will be shown.

Example Output:

![Unsaved Image 1 resized](https://user-images.githubusercontent.com/66972514/167492490-6aae2335-408c-4877-a611-a08ea047cc14.png)

| Output | Description |
|---|---|
| SUCCESS | The package was successfully processed |
| SKIPPED | The package was ignored as it has already been processed/does not exist |
| FAILURE | An error has occured and and is shown on the same line|

## Input Files

```<INPUTFILE>``` is the path to a file containing a list of package names. Any number of files can be specified.

Example File:
```
com.android.bookmarkprovider
com.android.browser
com.android.calendar
com.android.cellbroadcastreceiver
com.android.cellbroadcastreceiver.overlay.common
com.android.chrome
```

## Notes
aapt binary comes from here: https://github.com/Calsign/APDE/blob/fdc22eb31048862e1484f4b6eca229accda61466/APDE/src/main/assets/aapt-binaries/aapt-arm-pie
