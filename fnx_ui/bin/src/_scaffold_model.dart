import 'dart:async';
import 'dart:io';

class Identificator {

  String source;
  String? camelCase;
  String? underscores;
  String? dashes;

  Pattern validator = new RegExp(r'^[a-z][a-z0-9_]*[a-z0-9]$');

  Identificator(this.source) {
    underscores = source;
    if (validator.allMatches(source).length != 1) {
      throw "Name $source must match $validator - lowercase, underscore";
    }
    camelCase = createCamelCase(source);
    dashes = source.replaceAll("_", "-");
  }

  String createCamelCase(String s) {
    var parts = s.split('_');
    return parts.map(capitalize).join();
  }

  String capitalize(String s) => s.substring(0, 1).toUpperCase() + s.substring(1);

}

class GeneratedFile {

  late File file;
  late String template;

  GeneratedFile();

  void set path(String path) {
    file = new File(path).absolute;
  }

  Future generate() async {
    await file.parent.create(recursive: true);
    await file.writeAsString(template);
    return true;
  }

}

abstract class GeneratedSet {

  List<GeneratedFile> get filesToGenerate;

}

class ModuleGenerator implements GeneratedSet {

  List<GeneratedFile> filesToGenerate = [];

  String _name;
  List<Identificator> screens = [];

  ModuleGenerator(this._name, String root, List<String> childrenScreens) {

    Identificator i = new Identificator(_name);
    childrenScreens.forEach((String name) => screens.add(new Identificator(name)));

    //var context = {"name": i, "screens":screens};

    { //=============================================================================
      GeneratedFile html = new GeneratedFile();
      html.path = "${root}/module_${i.underscores}.html";
      html.template = """
<div class="layout--header">
    <header>
        <nav class="navbar padding--fab bg--theme" style="opacity: 0.9">
            <h2>${i.camelCase}</h2>
            <!--<a [routerLink]="['CreateSomething']" class="btn--fab">add</a>-->
            <a href="#TODO" class="btn--fab">add</a>
        </nav>
    </header>
    <main class="relative">
        <router-outlet></router-outlet>
    </main>
</div>
""";
      filesToGenerate.add(html);
    }


    { //=============================================================================
      GeneratedFile dart = new GeneratedFile();
      dart.path = "${root}/module_${i.underscores}.dart";

      StringBuffer imports = new StringBuffer();
      StringBuffer routes = new StringBuffer();

      bool first = true;
      for (Identificator s in screens) {
        imports.writeln("import 'screen_${s.underscores}.dart';");
        if (!first) {
          routes.writeln(",");
        }
        if (first) {
          routes.write("  const Route(path: '${s.camelCase}', name: '${s.camelCase}', component: Screen${s.camelCase}, useAsDefault: true)");
        } else {
          routes.write("  const Route(path: '${s.camelCase}', name: '${s.camelCase}', component: Screen${s.camelCase})");
        }
        first = false;
      }

      //,
      //const Route(path: 'Edit/:id', name: 'ShopEdit', component: ScreenShopEdit)

      dart.template = """
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
${imports.toString()}

@Component(selector: 'module-${i.dashes}', templateUrl: 'module_${i.underscores}.html')
@RouteConfig(const [
${routes.toString()}
])
class Module${i.camelCase} {

  Module${i.camelCase}();

}
""";
      filesToGenerate.add(dart);
    }
  }
}

class ScreenGenerator implements GeneratedSet {

  List<GeneratedFile> filesToGenerate = [];

  String _name;

  ScreenGenerator(this._name, String root) {
    Identificator i = new Identificator(_name);

    //var context = {"name": i};

    { //=============================================================================
      GeneratedFile html = new GeneratedFile();
      html.path = "${root}/screen_${i.underscores}.html";
      html.template = """
<!-- Screen: ${i.camelCase} -->
<div class="flex--column padding fit">
  <!-- TODO: screen content -->
</div>
""";
      filesToGenerate.add(html);
    }

    { //=============================================================================
      GeneratedFile dart = new GeneratedFile();
      dart.path = "${root}/screen_${i.underscores}.dart";
      dart.template = """
import 'package:angular2/core.dart';

///
/// Screen${i.camelCase}
///
@Component(
  selector: 'screen-${i.dashes}',
  templateUrl: 'screen_${i.underscores}.html'
)
class Screen${i.camelCase} {

  //RestClient rest;

  Screen${i.camelCase}() {
  }

}
""";
      filesToGenerate.add(dart);
    }

  }

  String toString() {
    return "Screen ${_name}";
  }

}