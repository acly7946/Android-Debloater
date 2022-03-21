# Android-Debloater

## Requirements:

* A Shell
* ADB

## Usage

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

To debloat:

```
debloat.sh <INPUTFILE> <INPUTFILE2>
```

To rebloat:

```
ln -sf debloat.sh rebloat.sh
rebloat.sh <INPUTFILE> <INPUTFILE2>
```
