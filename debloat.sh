#! /bin/sh
#
# Debloater for Redmi 8A global ROM
#
# credit to https://selivan.github.io/2020/02/25/removing-bloatware-from-xiaomi-miui-android.html

set -- \
"com.baidu.input_mi" \
"com.android.bips" \
"com.android.bookmarkprovider" \
"com.android.browser" \
"com.android.calendar" \
"com.android.cellbroadcastreceiver" \
"com.android.cellbroadcastreceiver.overlay.common" \
"com.android.chrome" \
"com.android.deskclock" \
"com.android.dreams.basic" \
"com.android.dreams.phototable" \
"com.android.emergency" \
"com.android.hotwordenrollment.okgoogle" \
"com.android.mms" \
"com.android.mms.service" \
"com.android.printspooler" \
"com.android.statementservice" \
"com.android.stk" \
"com.android.wallpaper.livepicker" \
"com.android.wallpaperbackup" \
"com.android.wallpapercropper" \
"com.google.android.apps.docs" \
"com.google.android.apps.maps" \
"com.google.android.apps.photos" \
"com.google.android.apps.tachyon" \
"com.google.android.apps.wellbeing" \
"com.google.android.feedback" \
"com.google.android.gm" \
"com.google.android.gms" \
"com.google.android.gms.location.history" \
"com.google.android.googlequicksearchbox" \
"com.google.android.inputmethod.latin" \
"com.google.android.marvin.talkback" \
"com.google.android.music" \
"com.google.android.printservice.recommendation" \
"com.google.android.syncadapters.calendar" \
"com.google.android.tts" \
"com.google.android.videos" \
"com.google.android.youtube" \
"com.google.ar.lens" \
"com.mfashiongallery.emag" \
"com.mi.android.globalFileexplorer" \
"com.mi.android.globallauncher" \
"com.mi.android.globalpersonalassistant" \
"com.mi.globalTrendNews" \
"com.mi.health" \
"com.mi.webkit.core" \
"com.milink.service" \
"com.mipay.wallet.id" \
"com.mipay.wallet.in" \
"com.miui.accessibility" \
"com.miui.analytics" \
"com.miui.android.fashiongallery" \
"com.miui.aod" \
"com.miui.backup" \
"com.miui.bugreport" \
"com.miui.calculator" \
"com.miui.cit" \
"com.miui.cleanmaster" \
"com.miui.cloudbackup" \
"com.miui.cloudservice" \
"com.miui.cloudservice.sysbase" \
"com.miui.compass" \
"com.miui.contentcatcher" \
"com.miui.enbbs" \
"com.miui.extraphoto" \
"com.miui.face" \
"com.miui.fm" \
"com.miui.fmservice" \
"com.miui.freeform" \
"com.miui.gallery" \
"com.miui.greenguard" \
"com.miui.huanji" \
"com.miui.hybrid" \
"com.miui.hybrid.accessory" \
"com.miui.micloudsync" \
"com.miui.miservice" \
"com.miui.mishare.connectivity" \
"com.miui.misound" \
"com.miui.miwallpaper" \
"com.miui.miwallpaper.earth" \
"com.miui.miwallpaper.mars" \
"com.miui.msa.global" \
"com.miui.newmidrive" \
"com.miui.nextpay" \
"com.miui.notes" \
"com.miui.phrase" \
"com.miui.player" \
"com.miui.qr" \
"com.miui.screenrecorder" \
"com.miui.smsextra" \
"com.miui.system" \
"com.miui.systemui.carriers.overlay" \
"com.miui.touchassistant" \
"com.miui.translation.kingsoft" \
"com.miui.userguide" \
"com.miui.videoplayer" \
"com.miui.virtualsim" \
"com.miui.vsimcore" \
"com.miui.weather2" \
"com.miui.wmsvc" \
"com.miui.yellowpage" \
"com.miui.zman" \
"com.sohu.inputmethod.sogou.xiaomi" \
"com.xiaomi.account" \
"com.xiaomi.calendar" \
"com.xiaomi.cameratools" \
"com.xiaomi.channel" \
"com.xiaomi.discover" \
"com.xiaomi.glgm" \
"com.xiaomi.joyose" \
"com.xiaomi.location.fused" \
"com.xiaomi.mi_connect_service" \
"com.xiaomi.micloud.sdk" \
"com.xiaomi.midrop" \
"com.xiaomi.mipicks" \
"com.xiaomi.miplay_client" \
"com.xiaomi.mircs" \
"com.xiaomi.mirecycle" \
"com.xiaomi.mirror" \
"com.xiaomi.misettings" \
"com.xiaomi.payment" \
"com.xiaomi.scanner" \
"com.xiaomi.simactivate.service" \
"com.xiaomi.xmsf" \
"com.xiaomi.xmsfkeeper" \
"cn.wps.xiaomi.abroad.lite" \
"com.autonavi.minimap" \
"com.caf.fmradio" \
"com.duokan.phone.remotecontroller" \
"com.samsung.aasaservice" \
"org.simalliance.openmobileapi.service" \
"com.duokan.phone.remotecontroller.peel.plugin" \
"in.amazon.mShop.android.shopping" \
"com.bsp.catchlog" \
"com.netflix.partner.activation" \
"com.netflix.mediaclient" \
"com.opera.app.news" \
"com.opera.branding" \
"com.opera.branding.news" \
"com.opera.mini.native" \
"com.opera.preinstall" \
"com.tencent.soter.soterserver" \
"com.facebook.katana" \
"com.facebook.appmanager" \
"com.facebook.services" \
"com.facebook.system" \
"pl.zdunex25.updater" \
"ros.ota.updater" \
"com.syberia.ota" \
"com.syberia.SyberiaPapers" \
"org.lineageos.recorder" \
"org.lineageos.snap" \
"com.alibaba.aliexpresshd" \
"com.sukhavati.gotoplaying.bubble.BubbleShooter.mint" \
"com.block.puzzle.game.hippo.mi" \
"com.crazy.juicer.xm" \
"com.logame.eliminateintruder3d" \
"com.ebay.carrier" \
"com.ebay.mobile" \
"com.linkedin.android" \
"com.mi.globalbrowser" \
"com.opera.browser" \
"com.zhiliaoapp.musically" \
"com.mintgames.triplecrush.tile.fun" \
"cn.wps.moffice_eng" \
"com.hampusolsson.abstruct" \
"code.name.monkey.retromusic"

uninstall()
{
	ERROR=$(adb shell pm uninstall -k --user 0 $1 2>&1)
	if [ $? != 0 ]; then
		echo "\r$(tput setaf 1)FAILED $(tput sgr0)$1 $(tput setaf 3)${ERROR}"
	else
		echo "\r$(tput setaf 2)SUCCESS $(tput sgr0)$1"
	fi
}

adb start-server # initialise adb first
printf "Uninstalling..."
for PACKAGE; do
	uninstall ${PACKAGE} &
done
wait
