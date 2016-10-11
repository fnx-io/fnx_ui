import 'src/_scaffold_model.dart';
import 'src/_utils.dart';

void main(List<String> a) {
  List<String> args = [];
  args.addAll(a);

  if (args == null || args.length < 2) {
    error("Usage: pub run fnx_ui:scaffold_module [--dry] module_name screen_name1 screen_name2 ...");
    error("       If your module name or screen name consists of more words,");
    error("       please separate them with underscore: user_edit");
    error("Parameters:");
    error("       --dry:     dry run, nothing gets created");
    return;
  }

  bool dryRun = args.remove("--dry");

  String moduleName = args.removeAt(0);

  Identificator moduleIdentificator = new Identificator(moduleName);

  List<String> screens = args;

  List<GeneratedFile> files = [];

  String root = "lib/${moduleIdentificator.underscores}";

  files.addAll(new ModuleGenerator(moduleName, root, screens).filesToGenerate);
  screens.forEach((String name) => files.addAll(new ScreenGenerator(name, root).filesToGenerate));

  if (dryRun) {
    print("Running dry:");
    files.forEach((GeneratedFile f) => print("would generate: ${f.file}"));
  } else {
    files.forEach((GeneratedFile f) => f.generate());
  }

  print("Add app routing:");
  print('const Route(path: "/${moduleIdentificator.camelCase}/...", name: "${moduleIdentificator.camelCase}", component: Module${moduleIdentificator.camelCase})');
  print("Import module:");
  print("import '${moduleIdentificator.underscores}/module_${moduleIdentificator.underscores}.dart'");

}