import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'chat_thread_tile_model.dart';
export 'chat_thread_tile_model.dart';

class ChatThreadTileWidget extends StatefulWidget {
  const ChatThreadTileWidget({
    super.key,
    this.label,
    this.title,
    this.excerpt,
    bool? active,
    this.tapAction,
  }) : this.active = active ?? false;

  final String? label;
  final String? title;
  final String? excerpt;
  final bool active;
  final Future Function()? tapAction;

  @override
  State<ChatThreadTileWidget> createState() => _ChatThreadTileWidgetState();
}

class _ChatThreadTileWidgetState extends State<ChatThreadTileWidget> {
  late ChatThreadTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatThreadTileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.tapAction?.call();
      },
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: widget.active
              ? FlutterFlowTheme.of(context).secondaryBackground
              : Color(0x00000000),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null && widget.label != '')
                Text(
                  valueOrDefault<String>(
                    widget.label,
                    'Loading',
                  ),
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).secondary,
                        letterSpacing: 0.0,
                      ),
                ),
              if (widget.title != null && widget.title != '')
                Text(
                  valueOrDefault<String>(
                    widget.title,
                    'Loading',
                  ),
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: valueOrDefault<Color>(
                          widget.active
                              ? FlutterFlowTheme.of(context).primaryText
                              : FlutterFlowTheme.of(context).info,
                          FlutterFlowTheme.of(context).info,
                        ),
                        letterSpacing: 0.0,
                      ),
                ),
              if (widget.excerpt != null && widget.excerpt != '')
                Text(
                  valueOrDefault<String>(
                    widget.excerpt,
                    'Loading',
                  ),
                  maxLines: 1,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Readex Pro',
                        color: valueOrDefault<Color>(
                          widget.active
                              ? FlutterFlowTheme.of(context).primaryText
                              : FlutterFlowTheme.of(context).info,
                          FlutterFlowTheme.of(context).info,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w300,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
