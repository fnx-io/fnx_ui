import 'package:intl/intl.dart';

class GlobalMessages {

  static String formSubmitLabelMessage() => Intl.message(
      "Submit",
      name: "formSubmitLabelMessage",
      args: [],
      desc: "Label on the submit button");


  static String formBackLabelMessage() => Intl.message(
      "Back",
      name: "formBackLabelMessage",
      args: [],
      desc: "Label on the back button");

  static String selectSelectionEmptyLabel() => Intl.message(
      "Select...",
      name: "selectSelectionEmptyLabel",
      args: [],
      desc: "Select - nothing selected");

  static String selectOptionsEmptyLabel() => Intl.message(
      "No options to choose from",
      name: "selectOptionsEmptyLabel",
      args: [],
      desc: "Select - empty options");

  static String selectOptionsEmptySearchLabel() => Intl.message(
      "No option matches your search",
      name: "selectOptionsEmptySearchLabel",
      args: [],
      desc: "Select - filter on options is too restrictive");

  static String selectFilterPlaceholder() => Intl.message(
      "Search..",
      name: "selectFilterPlaceholder",
      args: [],
      desc: "Select - search field placeholder");
  
  static String fileDragAndDropHere() => Intl.message(
      "Drag'n'drop a file here",
      name: "fileDragAndDropHere",
      args: [],
      desc: "File - drop area is empty");

  static String fileSomeFilesSelected(int count) => Intl.message(
      "$count files selected",
      name: "fileSomeFilesSelected",
      args: [count],
      desc: "File - some files are chosen");

  static String fileBrowse() => Intl.message(
      "Browse",
      name: "fileBrowse",
      args: [],
      desc: "File - browse button label");

  static String inputGenericError() => Intl.message(
      "Value is not valid",
      name: "inputGenericError",
      args: [],
      desc: "Input - generic validation error");

  static appDefaultAlertHeadline() => Intl.message(
      "Alert",
      name: "appDefaultAlertHeadline",
      args: [],
      desc: "App - default headline for 'alert' dialog");

  static appDefaultInputHeadline() => Intl.message(
      "Input",
      name: "appDefaultInputHeadline",
      args: [],
      desc: "App - default headline for 'input' dialog");

  static appDefaultConfirmHeadline() => Intl.message(
      "Confirm",
      name: "appDefaultConfirmHeadline",
      args: [],
      desc: "App - default headline for 'confirm' dialog");

  static String ok() => Intl.message(
      "OK",
      name: "ok",
      args: [],
      desc: "App - global 'ok'");

  static String yes() => Intl.message(
      "Yes",
      name: "yes",
      args: [],
      desc: "App - global 'yes'");

  static String no() => Intl.message(
      "no",
      name: "no",
      args: [],
      desc: "App - global 'no'");

  static String cancel() => Intl.message(
      "cancel",
      name: "cancel",
      args: [],
      desc: "App - global 'cancel'");
  
}
