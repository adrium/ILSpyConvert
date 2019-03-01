using System;
using ICSharpCode.Decompiler;
using ICSharpCode.Decompiler.CSharp;

namespace Adrium.Snippets
{
	class ILSpyConvert
	{
		public static void Main(string[] args)
		{
			if (args.Length < 2) {
				Console.WriteLine("Usage: ILSpyConvert.exe <langversion> <file>");
				return;
			}

			var versionInt = int.Parse(args[0]);

			if (!Enum.IsDefined(typeof(LanguageVersion), versionInt)) {
				Console.WriteLine("Invalid version");
				return;
			}

			var decompiler = new CSharpDecompiler(args[1], new DecompilerSettings((LanguageVersion)versionInt));
			var str = decompiler.DecompileWholeModuleAsString();

			Console.WriteLine(str);
		}
	}
}
