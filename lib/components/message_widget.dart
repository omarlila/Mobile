import '/cards/banner_card/banner_card_widget.dart';
import '/cards/code_card/code_card_widget.dart';
import '/cards/detail_card/detail_card_widget.dart';
import '/cards/email_card/email_card_widget.dart';
import '/cards/image_card/image_card_widget.dart';
import '/cards/single_action_card/single_action_card_widget.dart';
import '/cards/text_message/text_message_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'message_model.dart';
export 'message_model.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.type,
    required this.data,
    bool? isUser,
    this.rawText,
    this.img,
    this.onTap,
  }) : this.isUser = isUser ?? false;

  final String? type;
  final dynamic data;
  final bool isUser;
  final String? rawText;
  final String? img;
  final Future Function(String prompt)? onTap;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late MessageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: AlignmentDirectional(
              valueOrDefault<double>(
                widget.isUser ? 1.0 : -1.0,
                -1.0,
              ),
              -1.0),
          child: Builder(
            builder: (context) {
              if (widget.type == 'TextMessage') {
                return Builder(
                  builder: (context) {
                    if (widget.isUser) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wrapWithModel(
                            model: _model.textMessageModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: TextMessageWidget(
                              sender: 'Maggie',
                              text: widget.rawText!,
                              isUser: widget.isUser,
                              image:
                                  'https://firebasestorage.googleapis.com/v0/b/g-p-t-4o-gwizk5.appspot.com/o/Screenshot%202024-09-20%20at%201.53.48%E2%80%AFPM.png?alt=media&token=0db1da2e-7e31-48a5-8d92-e78582a0f79d',
                              time: getCurrentTimestamp,
                            ),
                          ),
                          if (((widget.data
                                          ?.toList()
                                          .map<ContentStruct?>(
                                              ContentStruct.maybeFromMap)
                                          .toList() as Iterable<ContentStruct?>)
                                      .withoutNulls
                                      .where((e) => e.type == 'image_url')
                                      .toList())
                                  .isNotEmpty)
                            Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 45.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.imageCardModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ImageCardWidget(
                                    images: functions.extractImgs((getJsonField(
                                      widget.data,
                                      r'''$[*].image_url''',
                                      true,
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList())!,
                                  ),
                                ),
                              ),
                            ),
                        ].divide(SizedBox(height: 4.0)),
                      );
                    } else {
                      return wrapWithModel(
                        model: _model.textMessageModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: TextMessageWidget(
                          sender: 'Assistant',
                          text: getJsonField(
                            widget.data,
                            r'''$.text''',
                          ).toString(),
                          isUser: widget.isUser,
                          image:
                              'https://storage.googleapis.com/flutterflowdev.appspot.com/marketplace/template_assets/Logo%20Profile%20Pic.png',
                          time: getCurrentTimestamp,
                        ),
                      );
                    }
                  },
                );
              } else if (widget.type == 'DetailCard') {
                return wrapWithModel(
                  model: _model.detailCardModel,
                  updateCallback: () => safeSetState(() {}),
                  child: DetailCardWidget(
                    title: getJsonField(
                      widget.data,
                      r'''$.title''',
                    ).toString(),
                    subtitle: getJsonField(
                      widget.data,
                      r'''$.subtitle''',
                    ).toString(),
                    description: getJsonField(
                      widget.data,
                      r'''$.description''',
                    ).toString(),
                    image: widget.img!,
                  ),
                );
              } else if (widget.type == 'CodeCard') {
                return wrapWithModel(
                  model: _model.codeCardModel,
                  updateCallback: () => safeSetState(() {}),
                  child: CodeCardWidget(
                    code:
                        '{\n        \"identifier\": { \"name\": \"dateInMonth\", \"key\": \"6907g\" },\n        \"arguments\": [\n          {\n            \"identifier\": { \"name\": \"monthName\", \"key\": \"canfxk\" },\n            \"type\": \"String\",\n            \"is_list\": false,\n            \"non_nullable\": false\n          },\n          {\n            \"identifier\": { \"name\": \"date\", \"key\": \"t930x8\" },\n            \"type\": \"DateTime\",\n            \"is_list\": false,\n            \"non_nullable\": false\n          }\n        ],',
                  ),
                );
              } else if (widget.type == 'SingleActionCard') {
                return wrapWithModel(
                  model: _model.singleActionCardModel,
                  updateCallback: () => safeSetState(() {}),
                  child: SingleActionCardWidget(
                    title: getJsonField(
                      widget.data,
                      r'''$.title''',
                    ).toString(),
                    icon: FaIcon(
                      FontAwesomeIcons.solidBell,
                      size: 16.0,
                    ),
                    description: getJsonField(
                      widget.data,
                      r'''$.description''',
                    ).toString(),
                    actionTitle: getJsonField(
                      widget.data,
                      r'''$.actionTitle''',
                    ).toString(),
                    action: () async {},
                  ),
                );
              } else if (widget.type == 'MultiImageCard') {
                return wrapWithModel(
                  model: _model.imageCardModel2,
                  updateCallback: () => safeSetState(() {}),
                  child: ImageCardWidget(
                    images: getJsonField(
                      widget.data,
                      r'''$.images''',
                      true,
                    )!,
                  ),
                );
              } else if (widget.type == 'ImageCard') {
                return wrapWithModel(
                  model: _model.imageCardModel3,
                  updateCallback: () => safeSetState(() {}),
                  child: ImageCardWidget(
                    images: getJsonField(
                      widget.data,
                      r'''$.images''',
                      true,
                    )!,
                  ),
                );
              } else if (widget.type == 'EmailCard') {
                return wrapWithModel(
                  model: _model.emailCardModel,
                  updateCallback: () => safeSetState(() {}),
                  child: EmailCardWidget(
                    toEmail: getJsonField(
                      widget.data,
                      r'''$.toEmail''',
                    ).toString(),
                    subject: getJsonField(
                      widget.data,
                      r'''$.subject''',
                    ).toString(),
                    text: getJsonField(
                      widget.data,
                      r'''$.text''',
                    ).toString(),
                  ),
                );
              } else if (widget.type == 'BannerCard') {
                return wrapWithModel(
                  model: _model.bannerCardModel,
                  updateCallback: () => safeSetState(() {}),
                  child: BannerCardWidget(
                    description: getJsonField(
                      widget.data,
                      r'''$.description''',
                    ).toString(),
                    label: getJsonField(
                      widget.data,
                      r'''$.label''',
                    ).toString(),
                    onTap: (prompt) async {
                      // Execute callback to send user message
                      await widget.onTap?.call(
                        prompt,
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  width: double.infinity,
                  height: 45.0,
                  decoration: BoxDecoration(),
                );
              }
            },
          ),
        ),
      ].divide(SizedBox(height: 20.0)),
    );
  }
}
