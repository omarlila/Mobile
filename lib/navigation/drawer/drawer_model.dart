import '/flutter_flow/flutter_flow_util.dart';
import '/navigation/chat_thread_tile/chat_thread_tile_widget.dart';
import 'drawer_widget.dart' show DrawerWidget;
import 'package:flutter/material.dart';

class DrawerModel extends FlutterFlowModel<DrawerWidget> {
  ///  Local state fields for this component.
  /// lhjn
  String now = 'gkbkb';

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Model for ChatThreadTile component.
  late ChatThreadTileModel chatThreadTileModel1;
  // Model for ChatThreadTile component.
  late ChatThreadTileModel chatThreadTileModel2;
  // Model for ChatThreadTile component.
  late ChatThreadTileModel chatThreadTileModel3;

  @override
  void initState(BuildContext context) {
    chatThreadTileModel1 = createModel(context, () => ChatThreadTileModel());
    chatThreadTileModel2 = createModel(context, () => ChatThreadTileModel());
    chatThreadTileModel3 = createModel(context, () => ChatThreadTileModel());
  }

  @override
  void dispose() {
    chatThreadTileModel1.dispose();
    chatThreadTileModel2.dispose();
    chatThreadTileModel3.dispose();
  }
}
