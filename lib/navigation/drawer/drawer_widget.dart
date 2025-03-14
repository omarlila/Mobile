import '';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navigation/chat_thread_tile/chat_thread_tile_widget.dart';
import 'package:flutter/material.dart';
import 'drawer_model.dart';
export 'drawer_model.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late DrawerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrawerModel());

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
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(1.0, 0.0),
            child: Container(
              width: 80.0,
              height: 62.11,
              decoration: BoxDecoration(
                color: Color(0x0014181B),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.7, 0.5),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).info,
                    size: 40.0,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.844,
              height: 47.6,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  _model.mouseRegionHovered
                      ? Color(0x08000000)
                      : Colors.transparent,
                  Colors.transparent,
                ),
              ),
              child: MouseRegion(
                opaque: false,
                cursor: MouseCursor.defer ?? MouseCursor.defer,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_outlined,
                        color: FlutterFlowTheme.of(context).info,
                        size: valueOrDefault<double>(
                          () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return 30.0;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return 40.0;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointLarge) {
                              return 40.0;
                            } else {
                              return 40.0;
                            }
                          }(),
                          40.0,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'xp10swnv' /* Chats */,
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: valueOrDefault<double>(
                                      () {
                                        if (MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall) {
                                          return 25.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointMedium) {
                                          return 25.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointLarge) {
                                          return 30.0;
                                        } else {
                                          return 30.0;
                                        }
                                      }(),
                                      30.0,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                onEnter: ((event) async {
                  safeSetState(() => _model.mouseRegionHovered = true);
                }),
                onExit: ((event) async {
                  safeSetState(() => _model.mouseRegionHovered = false);
                }),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: wrapWithModel(
                          model: _model.chatThreadTileModel1,
                          updateCallback: () => safeSetState(() {}),
                          updateOnChange: true,
                          child: ChatThreadTileWidget(
                            label: 'now',
                            title: 'German Expat Advice',
                            excerpt:
                                'Navigating life as an expat in Germany can be both challenging and rewarding',
                            active: true,
                            tapAction: () async {},
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.chatThreadTileModel2,
                        updateCallback: () => safeSetState(() {}),
                        updateOnChange: true,
                        child: ChatThreadTileWidget(
                          label: '5 minutes ago',
                          title: 'How to Prep for a Talk',
                          excerpt:
                              'Follow these tips to help prepare to give a talk on AI',
                          active: false,
                          tapAction: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.chatThreadTileModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: ChatThreadTileWidget(
                          label: '2 days ago',
                          title: 'Airbnb Review Advice',
                          excerpt:
                              'Writing an honest and accurate review can sometimes be challenging,',
                          active: false,
                          tapAction: () async {},
                        ),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
