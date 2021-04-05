# ILSpyConvert

Convert C# code to different language versions.

Uses [ICSharpCode.Decompiler](https://github.com/icsharpcode/ILSpy) under the hood.

The command-line tool decompiles an assembly with a user-definable language version.
Additionally, it contains a decompiler binary built for .NET Framework 4.5 for compatibility.

## Usage

	ILSpyConvert.exe <langversion> <assembly.exe> > assembly.cs

`langversion` can be one of the values defined in:
https://github.com/icsharpcode/ILSpy/blob/master/ICSharpCode.Decompiler/CSharp/CSharpLanguageVersion.cs
