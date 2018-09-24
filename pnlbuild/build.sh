#!/usr/bin/env bash

source /opt/conda3/etc/profile.d/conda.sh
conda activate pnlbuild

mkdir -p source

git clone https://github.com/BRAINSia/BRAINSTools

mkdir -p build && cd build

cmake ../BRAINSTools \
 -DBRAINSTools_INSTALL_DEVELOPMENT=OFF \
 -DBRAINSTools_MAX_TEST_LEVEL=0 \
 -DBRAINSTools_SUPERBUILD=ON \
 -DBRAINSTools_USE_QT=OFF \
 -DBRAINS_DEBUG_IMAGE_WRITE=OFF \
 -DBUILD_STYLE_UTILS=OFF \
 -DBUILD_TESTING=OFF \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_COLOR_MAKEFILE=ON \
 -DCMAKE_EXPORT_COMPILE_COMMANDS=OFF \
 -DCMAKE_PROJECT_NAME:STATIC=SuperBuild_BRAINSTools \
 -DCMAKE_SKIP_INSTALL_RPATH=NO \
 -DCMAKE_SKIP_RPATH=NO \
 -DCMAKE_USE_RELATIVE_PATHS=OFF \
 -DCMAKE_VERBOSE_MAKEFILE=FALSE \
 -DCOVERAGE_EXTRA_FLAGS=-l \
 -DEXTERNAL_PROJECT_BUILD_TYPE=Release \
 -DFORCE_EXTERNAL_BUILDS=OFF \
 -DITK_VERSION_MAJOR=4 \
 -DSuperBuild_BRAINSTools_BUILD_DICOM_SUPPORT=ON \
 -DSuperBuild_BRAINSTools_USE_CTKAPPLAUNCHER=OFF \
 -DSuperBuild_BRAINSTools_USE_GIT_PROTOCOL=ON \
 -DUSE_ANTS=ON \
 -DUSE_AutoWorkup=OFF \
 -DUSE_BRAINSABC=OFF \
 -DUSE_BRAINSConstellationDetector=OFF \
 -DUSE_BRAINSContinuousClass=OFF \
 -DUSE_BRAINSCreateLabelMapFromProbabilityMaps=OFF \
 -DUSE_BRAINSCut=OFF \
 -DUSE_BRAINSDWICleanup=OFF \
 -DUSE_BRAINSDemonWarp=OFF \
 -DUSE_BRAINSFit=OFF \
 -DUSE_BRAINSInitializedControlPoints=OFF \
 -DUSE_BRAINSLabelStats=OFF \
 -DUSE_BRAINSLandmarkInitializer=OFF \
 -DUSE_BRAINSMultiModeSegment=OFF \
 -DUSE_BRAINSMultiSTAPLE=OFF \
 -DUSE_BRAINSMush=OFF \
 -DUSE_BRAINSPosteriorToContinuousClass=OFF \
 -DUSE_BRAINSROIAuto=OFF \
 -DUSE_BRAINSResample=OFF \
 -DUSE_BRAINSSnapShotWriter=OFF \
 -DUSE_BRAINSStripRotation=OFF \
 -DUSE_BRAINSSurfaceTools=OFF \
 -DUSE_BRAINSTalairach=OFF \
 -DUSE_BRAINSTransformConvert=OFF \
 -DUSE_ConvertBetweenFileFormats=ON \
 -DUSE_DWIConvert=ON \
 -DUSE_DebugImageViewer=OFF \
 -DUSE_GTRACT=OFF \
 -DUSE_ICCDEF=OFF \
 -DUSE_ImageCalculator=OFF \
 -DUSE_ReferenceAtlas=OFF \
 -DUSE_SYSTEM_DCMTK=OFF \
 -DUSE_SYSTEM_ITK=OFF \
 -DUSE_SYSTEM_SlicerExecutionModel=OFF \
 -DUSE_SYSTEM_VTK=OFF \
 -DVTK_GIT_REPOSITORY=git://vtk.org/VTK.git

# Use lower number in docker container to avoid errors due to
# interrupted processes.
make -j4
