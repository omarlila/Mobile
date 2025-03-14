import '/flutter_flow/flutter_flow_util.dart';
import 'add_a_p_i_key_widget.dart' show AddAPIKeyWidget;
import 'package:flutter/material.dart';

class AddAPIKeyModel extends FlutterFlowModel<AddAPIKeyWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
