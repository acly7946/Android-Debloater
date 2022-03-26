# Android-Debloater

## Requirements:

* A Shell
* ADB

## Usage

To debloat:
```
debloat.sh <INPUTFILE> <INPUTFILE2>
```

To rebloat:
```
ln -sf debloat.sh rebloat.sh
rebloat.sh <INPUTFILE> <INPUTFILE2>
```

Output:

If possible, the human readable/common name of a package will be shown. If not possible, then the package name itself will be shown.

Example Output:

```
SUCCESS Google Text-to-speech Engine
SKIPPED com.opera.branding
FAILED Gmail cmd: Failure calling service package: Broken pipe (32)
```

| Meaning |  |
|---|---|
| SUCCESS | The package was successfully processed |
| SKIPPED | The package was ignored as it has already been processed/does not exist |
| FAILED | An error has occured and and is shown on the same line|

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
