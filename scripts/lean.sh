#!/bin/bash

# Add luci-app-ssr-plus
pushd package/lean
git clone --depth=1 https://github.com/fw876/helloworld
popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Lienol's Packages
#git clone --depth=1 https://github.com/Lienol/openwrt-package
# Plagiarism wish you wealthy family
# Add luci-app-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add luci-app-vssr <M>
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add mentohust & luci-app-mentohust
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust
git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk

# Add luci-proto-minieap
git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap

# Add luci-app-bypass
git clone https://github.com/garypang13/luci-app-bypass.git

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add luci-app-onliner (need luci-app-nlbwmon)
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-oled (R2S Only)
git clone --depth=1 https://github.com/NateLol/luci-app-oled

# Add luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome

# Add luci-app-smartdns & smartdns
svn co https://github.com/281677160/openwrt-package/trunk/feeds/luci/applications/luci-app-smartdns
svn co https://github.com/281677160/openwrt-package/trunk/feeds/packages/net/smartdns

# Add luci-app-diskman
git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-dockerman
rm -rf ../lean/luci-app-docker
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-theme-argon
#git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
#rm -rf ../lean/luci-theme-argon

# Add subconverter
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add extra wireless drivers
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8812au-ac
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8821cu
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8188eu
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8192du
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl88x2bu

# Add apk (Apk Packages Manager)
svn co https://github.com/openwrt/packages/trunk/utils/apk

# Add luci-udptools
svn co https://github.com/zcy85611/Openwrt-Package/trunk/luci-udptools
svn co https://github.com/zcy85611/Openwrt-Package/trunk/udp2raw
svn co https://github.com/zcy85611/Openwrt-Package/trunk/udpspeeder-tunnel

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter
popd

# Add luci-app-ddnsto
pushd package/network/services
git clone --depth=1 https://github.com/linkease/ddnsto-openwrt
popd

# Add luci-app-linkease
pushd package/network/services
git clone --depth=1 https://github.com/linkease/linkease-openwrt
popd

# Add Pandownload
pushd package/lean
svn co https://github.com/immortalwrt/packages/trunk/net/pandownload-fake-server
popd

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
sed -i "s/${orig_version}/${orig_version} ($(date +"%Y.%m.%d"))/g" zzz-default-settings
popd

# 修复libssh
pushd feeds/packages/libs
rm -rf libssh
svn co https://github.com/openwrt/packages/trunk/libs/libssh
popd

# Use Lienol's https-dns-proxy package
#pushd feeds/packages/net
#rm -rf https-dns-proxy
#svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy
#popd

# 使用快照 syncthing package
pushd feeds/packages/utils
rm -rf syncthing
svn co https://github.com/openwrt/packages/trunk/utils/syncthing
popd

# 修复mt76无线驱动程序
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Add po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd

# 将默认 shell 更改为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate
#sed -i '/uci commit system/i\uci set system.@system[0].hostname='FusionWrt'' package/lean/default-settings/files/zzz-default-settings
#sed -i "s/OpenWrt /DHDAXCW @ FusionWrt /g" package/lean/default-settings/files/zzz-default-settings

# Test kernel 5.10
#sed -i 's/5.4/5.10/g' target/linux/rockchip/Makefile

# 自定义配置
#git am $GITHUB_WORKSPACE/patches/lean/*.patch
#echo -e " DHDAXCW's FusionWrt built on "$(date +%Y.%m.%d)"\n -----------------------------------------------------" >> package/base-files/files/etc/banner

# Add CUPInfo
pushd package/lean/autocore/files/arm/sbin
cp -f $GITHUB_WORKSPACE/scripts/cpuinfo cpuinfo
popd
