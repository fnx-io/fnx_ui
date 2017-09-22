class IoModel {
  final String name;
  final String description;
  final String type;

  final bool isInput;
  final bool isOutput;

  const IoModel.input({this.name, this.description, this.type})
      : isInput = true,
        isOutput = false;

  const IoModel.output({this.name, this.description, this.type})
      : isInput = false,
        isOutput = true;

  const IoModel.inputOutput({this.name, this.description, this.type})
      : isInput = true,
        isOutput = true;
}
