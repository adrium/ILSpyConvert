#!/bin/sh

if [ ! -d "/tmp/ILSpy/ICSharpCode.Decompiler" ]; then
	echo "/tmp/ILSpy/ICSharpCode.Decompiler does not exist"
	exit
fi

cp *.patch /tmp/ILSpy/ICSharpCode.Decompiler
cd /tmp/ILSpy/ICSharpCode.Decompiler

git checkout v6.2.1

baseCommit=d779383cb85003d6dabeb976f0845631e07bf463
baseCommitRev=1

major=6
minor=2
build=1
versionName=

revision=$(( $(git rev-list --count "$baseCommit..HEAD") + 1 ))
shortCommitHash=$(git rev-parse --short=8 HEAD)

fullVersionNumber="$major.$minor.$build.$revision"

fileAssemblyInfo=Properties/AssemblyInfo.cs
cp Properties/AssemblyInfo.template.cs Properties/AssemblyInfo.cs

sed -i s/'\$INSERTVERSION\$'/"$fullVersionNumber"/g Properties/AssemblyInfo.cs
sed -i s/'\$INSERTBRANCHPOSTFIX\$'//g Properties/AssemblyInfo.cs
sed -i s/'\$INSERTVERSIONNAMEPOSTFIX\$'/"$versionName"/g Properties/AssemblyInfo.cs
sed -i s/'\$INSERTSHORTCOMMITHASH\$'/"$shortCommitHash"/g Properties/AssemblyInfo.cs

sed -i 's/netstandard2.0/net45/' ICSharpCode.Decompiler.csproj
sed -i '/Target/s/"BeforeBuild"/"BeforeBuildBak"/' ICSharpCode.Decompiler.csproj

patch -Nt -p 2 < EmptyList.patch

nuget restore ../ILSpy.sln
nuget restore ../ILSpy.sln # seems necessary
msbuild /p:Configuration=Release *.csproj
find bin # force successful exit
