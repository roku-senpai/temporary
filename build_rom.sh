# sync rom

repo init --depth=1 --no-repo-verify -u https://github.com/Corvus-R/android_manifest.git -b 11 -g default,-mips,-darwin,-notdefault

git clone https://github.com/Dev0786s/local-manifest.git --depth 1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom 

. build/envsetup.sh 

lunch corvus_merlinx-userdebug

export ALLOW_MISSING_DEPENDENCIES=true 

export BUILD_BROKEN_DUP_RULES=true 

export TZ=Asia/Dhaka #put before last build command

make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
