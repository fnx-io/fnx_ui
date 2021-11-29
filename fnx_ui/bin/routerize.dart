
import 'dart:collection';
import 'dart:io';

List<String> components = [
  "example",
  "screen",
  "module",
  "step",
  "cookbook"
];

void main() async {
  Directory d = new Directory("lib");
  var fileInfo = await d.list(recursive: true).toList();
  List<FileInfo> infos = [];
  fileInfo.forEach((FileSystemEntity e) {
    infos.addAll(parseInfos(e));
  });
  Set<String?> templates = new HashSet();
  templates.addAll(infos.map((FileInfo i)=>i.template));
  templates.forEach((String? s) {
     print("import 'package:fnx_ui_showcase/$s';");
  });

  print(" ");

  infos.forEach((FileInfo i) {
    String? lw = i.compId;
     print('RoutePath $lw = new RoutePath(path: "$lw", parent:null);');
  });

  print(" ");

  infos.forEach((FileInfo i) {
    String? lw = i.compId;
    print('<li><a [routerLink]="routing.$lw.toUrl()">${i.comp}</a></li>');
  });

  print(" ");

  infos.forEach((FileInfo i) {
    String? lw = i.compId;
    print('routes.add(new RouteDefinition(routePath: $lw, component: ${i.comp}NgFactory));');
  });

}

Iterable<FileInfo> parseInfos(FileSystemEntity e) {
  String path = e.path;
  List<FileInfo> result = [];
  RegExp className = new RegExp(r".*class[\s]*([a-zA-Z0-9]+).*$");
  if (path.contains(".dart")) {
    String tpl = path.replaceAll(".dart", ".template.dart");
    tpl = tpl.replaceFirst("lib/", "");
    String content = new File(e.path).readAsStringSync();
    List<String> lines = content.split("\n");
    lines.where((String l) => l.contains("class")).forEach((String l) {
       l = l.replaceAllMapped(className, (Match m) =>m[1]!);
       String cmp = l.toLowerCase();
       if (components.any((String c) => cmp.contains(c))) {
         FileInfo i = new FileInfo();
         i.template = tpl;
         i.comp = l;
         String id = l.toLowerCase();
         components.forEach((String s) {
           id = id.replaceAll(s, "");
         });
         i.compId = id;
         result.add(i);
       }
    });
  }
  return result;
}

class FileInfo {
  String? template;
  String? comp;
  String? compId;
}

