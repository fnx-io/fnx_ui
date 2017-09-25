import 'package:fnx_ui_demo/src/model/io.dart';

export 'package:fnx_ui_demo/src/model/io.dart';

class ComponentModel {
  final String tag;
  final String className;
  final String linkName;
  final String description;
  final bool ngModelCompatible;
  final List<IoModel> ios;

  const ComponentModel({
    this.tag,
    this.description,
    this.className,
    this.linkName,
    this.ios: const [],
    this.ngModelCompatible: false,
  });
}
