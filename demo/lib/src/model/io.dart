class IoModel {
  final String name;
  final String type;
  final String description;

  final bool isInput;
  final bool isOutput;

  const IoModel.input({this.name, this.type, this.description})
      : isInput = true,
        isOutput = false;

  const IoModel.output({this.name, this.type, this.description})
      : isInput = false,
        isOutput = true;

  const IoModel.inputOutput({this.name, this.type, this.description})
      : isInput = true,
        isOutput = true;
}
