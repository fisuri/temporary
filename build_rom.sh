# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Havoc-OS/android_manifest.git -b thirteen --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Koushikdey2003/local_manifest.git --depth 1 -b Havoc-OS-thirteen-rui2 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom #3
source build/envsetup.sh
export TZ=Asia/Dhaka #put before last build command
brunch RMX2020 user

# upload rom - (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
