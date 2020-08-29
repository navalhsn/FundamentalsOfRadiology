// 1.

// # MARK : Payment Gateway

//  https://github.com/MyFatoorahHub/MFSDKiOS


//When you try to distribute your app to app store, you may get error like that:
//
//Failed to verify bitcode in MFSDK.framework/MFSDK: error: Cannot extract bundle from /var/folders/jl/mpz7pnbs5v9_lx6qjd_2zjr40000gn/T/IDEDistributionOptionThinning.FiO/Payload/YOUR_APP_NAME.app/Frameworks/MFSDK.framework/MFSDK (x86_64)
//
//So do following steps to fix it :
//
//Select the Project, Choose Target → Project Name → Select Build Phases → Press “+” → New Run Script Phase → Name the Script as “Remove Unused Architectures Script” :

//FRAMEWORK="MFSDK"
//FRAMEWORK_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/$FRAMEWORK.framework/$FRAMEWORK"
//EXTRACTED_ARCHS=()
//for ARCH in $ARCHS
//do
//lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
//EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
//done
//lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
//rm "${EXTRACTED_ARCHS[@]}"
//rm "$FRAMEWORK_EXECUTABLE_PATH"
//mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"
