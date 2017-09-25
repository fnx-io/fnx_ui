class IoModel {
  final String name;
  final String type;

  final bool isInput;
  final bool isOutput;

  const IoModel.input({this.name, this.type})
      : isInput = true,
        isOutput = false;

  const IoModel.output({this.name, this.type})
      : isInput = false,
        isOutput = true;

  const IoModel.inputOutput({this.name, this.type})
      : isInput = true,
        isOutput = true;
}
