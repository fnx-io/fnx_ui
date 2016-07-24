import 'dart:html';

class BenevolentNodeValidator implements NodeValidator {

  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    return true;
  }

  @override
  bool allowsElement(Element element) {
    return true;
  }
}

class BenevolentTreeSanitizer implements NodeTreeSanitizer {

  @override
  void sanitizeTree(Node node) {
    // nothing
  }
}

Node createElement(String element) {
  return new Element.html(
      element,
      treeSanitizer: new BenevolentTreeSanitizer()
  );
}
