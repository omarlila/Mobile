import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'email_card_model.dart';
export 'email_card_model.dart';

class EmailCardWidget extends StatefulWidget {
  const EmailCardWidget({
    super.key,
    required this.toEmail,
    required this.subject,
    required this.text,
  });

  final String? toEmail;
  final String? subject;
  final String? text;

  @override
  State<EmailCardWidget> createState() => _EmailCardWidgetState();
}

class _EmailCardWidgetState extends State<EmailCardWidget> {
  late EmailCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmailCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 300.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 37.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: FlutterFlowTheme.of(context).info,
                      size: 16.0,
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'm77uzwia' /* EMAIL */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(width: 6.0)),
                ),
              ),
            ),
            Padding(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              FFLocalizations.of(context).getText(
                                'dyllhi5t' /* To */,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          if ((widget.toEmail != null &&
                                  widget.toEmail != '') &&
                              (widget.toEmail != 'null'))
                            Expanded(
                              flex: 3,
                              child: AutoSizeText(
                                valueOrDefault<String>(
                                  widget.toEmail,
                                  'Recipient',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              FFLocalizations.of(context).getText(
                                '5ba2hwac' /* Subject */,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          if ((widget.subject != null &&
                                  widget.subject != '') &&
                              (widget.subject != 'null'))
                            Expanded(
                              flex: 3,
                              child: AutoSizeText(
                                valueOrDefault<String>(
                                  widget.subject,
                                  'Subject',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                      Opacity(
                        opacity: 0.25,
                        child: Divider(
                          height: 10.0,
                          thickness: 1.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(1.0, -1.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // Copy to clipboard
                                await Clipboard.setData(
                                    ClipboardData(text: widget.text!));
                                // Show snack
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Copied to clipboard',
                                      style: TextStyle(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 14.0,
                                        height: 2.0,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    duration: Duration(milliseconds: 2500),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.content_copy_rounded,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 16.0,
                              ),
                            ),
                          ),
                          if ((widget.text != null && widget.text != '') &&
                              (widget.text != 'null'))
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 10.0),
                                child: MarkdownBody(
                                  data: widget.text!,
                                  selectable: true,
                                  onTapLink: (_, url, __) => launchURL(url!),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ].divide(SizedBox(height: 10.0)),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: FFLocalizations.of(context).getText(
                      'kf7etwzj' /* Send */,
                    ),
                    icon: Icon(
                      Icons.send,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
          ],
        ),
      ),
    );
  }
}
