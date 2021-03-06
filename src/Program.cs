using System;
using ICSharpCode.Decompiler;
using ICSharpCode.Decompiler.CSharp;
using ICSharpCode.Decompiler.CSharp.Transforms;

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
			decompiler.AstTransforms.Add(new EscapeInvalidIdentifiers());
			decompiler.AstTransforms.Add(new RemoveCLSCompliantAttribute());
			var str = decompiler.DecompileWholeModuleAsString();

			var version = typeof(CSharpDecompiler).Assembly.GetName().Version.ToString();

			Console.Error.WriteLine("/* ICSharpCode.Decompiler v" + version + " */");
			Console.WriteLine(str);
		}
	}
}
