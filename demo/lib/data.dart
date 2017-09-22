import 'package:fnx_ui_demo/src/model/component.dart';

export 'package:fnx_ui_demo/src/model/component.dart';

List<ComponentModel> componentsData = [
  const ComponentModel(
    tag: 'fnx-modal',
    className: 'FnxModal',
    linkName: 'Modal',
    description: 'Awesome modalx, component blablabla',
    ios: const [
      const IoModel.input(name: 'width', description: 'Optional CSS width of this modal window. Possibly 90vw etc.', type: 'int'),
      const IoModel.output(name: 'close', description: 'Output. Catch it and hide this window, user clicked the "close" icon.', type: 'bool'),
    ],
  ),
  const ComponentModel(
    tag: 'fnx-panel',
    className: 'FnxPanel',
    linkName: 'Panel',
    description: 'Cool panel component',
    ios: const [
      const IoModel.input(name: 'readonly', description: 'Disable write access, a user is able only to read.', type: 'bool'),
      const IoModel.output(name: 'alfa', description: 'Popis alfa output parametru.', type: 'String'),
      const IoModel.output(name: 'beta', description: 'Popis beta output parametru.', type: 'int'),
      const IoModel.inputOutput(name: 'data', description: 'blablabla', type: 'String'),
    ],
    ngModelCompatible: true,
  ),
  const ComponentModel(
    tag: 'fnx-tab',
    className: 'FnxTab',
    linkName: 'Tab',
    description: 'Some tab component',
    ios: const [
      const IoModel.input(name: 'required', description: 'Determines if the component is required to fill or not.', type: 'bool'),
      const IoModel.output(name: 'gama', description: 'Popis gama output parametru.', type: 'FancyModelObject'),
    ],
  ),
];
