import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'single_action_card_model.dart';
export 'single_action_card_model.dart';

class SingleActionCardWidget extends StatefulWidget {
  const SingleActionCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.actionTitle,
    required this.action,
  });

  final String? title;
  final Widget? icon;
  final String? description;
  final String? actionTitle;
  final Future Function()? action;

  @override
  State<SingleActionCardWidget> createState() => _SingleActionCardWidgetState();
}

class _SingleActionCardWidgetState extends State<SingleActionCardWidget> {
  late SingleActionCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SingleActionCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 300.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.icon != null) widget.icon!,
                    if (widget.title != 'null')
                      Expanded(
                        child: AutoSizeText(
                          valueOrDefault<String>(
                            widget.title,
                            'Loading title',
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Outfit',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                  ].divide(SizedBox(width: 10.0)),
                ),
                if (widget.description != 'null')
                  Text(
                    valueOrDefault<String>(
                      widget.description,
                      'Loading description text',
                    ),
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
              ].divide(SizedBox(height: 5.0)),
            ),
            if (widget.actionTitle != 'null')
              FFButtonWidget(
                onPressed: () async {
                  await widget.action?.call();
                },
                text: widget.actionTitle!,
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
          ].divide(SizedBox(height: 15.0)),
        ),
      ),
    );
  }
}
