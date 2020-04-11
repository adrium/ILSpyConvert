#!/bin/sh

if [ ! -d "/tmp/ILSpy/ICSharpCode.Decompiler" ]; then
	echo "/tmp/ILSpy/ICSharpCode.Decompiler does not exist"
	exit
fi

cd /tmp/ILSpy/ICSharpCode.Decompiler

baseCommit=d779383cb85003d6dabeb976f0845631e07bf463
baseCommitRev=1

major=5
minor=0
build=2
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
sed -i 's/Target Name="BeforeBuild"/Target Name="BeforeBuildBak"/' ICSharpCode.Decompiler.csproj

msbuild /p:Configuration=Release *.csproj
