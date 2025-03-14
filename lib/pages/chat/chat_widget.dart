import '';
import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_streaming.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/add_a_p_i_key_widget.dart';
import '/components/empty_messages_widget.dart';
import '/components/message_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/navigation/drawer/drawer_widget.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  static String routeName = 'Chat';
  static String routePath = '/chat';

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> with TickerProviderStateMixin {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().OpenAIKey == 'NO_KEY') {
        await showDialog(
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: AddAPIKeyWidget(),
              ),
            );
          },
        );
      }
      _model.addToMessages(MessageStruct(
        role: 'system',
        content: functions.buildContent(FFAppConstants.ChatSystemPrompt, null),
        visible: false,
      ));
      safeSetState(() {});
    });

    _model.userMessageTextController ??= TextEditingController();
    _model.userMessageFocusNode ??= FocusNode();

    animationsMap.addAll({
      'blurOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          MoveEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 50.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 0.415,
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: null,
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).alternate,
          drawer: Container(
            width: MediaQuery.sizeOf(context).width * 0.75,
            child: Drawer(
              elevation: 16.0,
              child: Container(
                width: 300.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF232B3E),
                ),
                child: wrapWithModel(
                  model: _model.drawerModel2,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: DrawerWidget(),
                ),
              ),
            ),
          ),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.sizeOf(context).height * 0.035),
            child: AppBar(
              backgroundColor: Color(0xFFF7F7F8),
              iconTheme: IconThemeData(color: Color(0xFFC31010)),
              automaticallyImplyLeading: false,
              leading: Visibility(
                visible: responsiveVisibility(
                  context: context,
                  tablet: false,
                  tabletLandscape: false,
                  desktop: false,
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.menu,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: Visibility(
                visible: responsiveVisibility(
                  context: context,
                  phone: false,
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'wz2khzkr' /* NeuroLift */,
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            ),
          ),
          body: Stack(
            children: [
              Image.asset(
                'assets/images/Gridwave-Black.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2A2857),
                        Color(0xFF3F4C7A),
                        Color(0xFF686B9D),
                        Color(0xFF9196BE)
                      ],
                      stops: [0.2, 0.5, 0.7, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0x7F14181B),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                  ))
                    Container(
                      width: 100.0,
                      height: double.infinity,
                      constraints: BoxConstraints(
                        minWidth: 300.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: wrapWithModel(
                          model: _model.drawerModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: DrawerWidget(),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      width: 100.0,
                      height: double.infinity,
                      decoration: BoxDecoration(),
                      child: Stack(
                        children: [
                          Builder(
                            builder: (context) {
                              final message = _model.messages
                                  .where((e) => e.visible)
                                  .toList();
                              if (message.isEmpty) {
                                return EmptyMessagesWidget();
                              }

                              return ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  20.0,
                                  0,
                                  valueOrDefault<int>(
                                        functions.mapCharactersCount(_model
                                            .userMessageTextController
                                            .text
                                            .length),
                                        82,
                                      ) +
                                      100,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: message.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 20.0),
                                itemBuilder: (context, messageIndex) {
                                  final messageItem = message[messageIndex];
                                  return Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 700.0,
                                      ),
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: MessageWidget(
                                          key: Key(
                                              'Keyb0d_${messageIndex}_of_${message.length}'),
                                          type: messageItem.role == 'assistant'
                                              ? valueOrDefault<String>(
                                                  getJsonField(
                                                    functions.parsePartialJson(
                                                        messageItem.content
                                                            .firstOrNull!.text),
                                                    r'''$.type''',
                                                  )?.toString(),
                                                  'TextMessage',
                                                )
                                              : 'TextMessage',
                                          isUser: messageItem.role == 'user'
                                              ? true
                                              : false,
                                          data: messageItem.role == 'assistant'
                                              ? (messageIndex ==
                                                      (_model.messages.length -
                                                          2)
                                                  ? _model.messageBuffer!
                                                  : functions
                                                      .extractDataFromContent(
                                                          messageItem.content
                                                              .firstOrNull!))
                                              : functions.contentToJson(
                                                  messageItem.content.toList()),
                                          rawText: messageItem
                                              .content.firstOrNull?.text,
                                          img: messageItem.img,
                                          onTap: (prompt) async {
                                            // Add user message
                                            _model.addToMessages(MessageStruct(
                                              role: 'user',
                                              content: functions.buildContent(
                                                  prompt, null),
                                              visible: true,
                                            ));
                                            safeSetState(() {});
                                            // Initialize assistant message
                                            _model.addToMessages(MessageStruct(
                                              role: 'assistant',
                                              content: functions.buildContent(
                                                  null, null),
                                            ));
                                            safeSetState(() {});
                                            // Initialize a blank message buffer
                                            _model.messageBuffer =
                                                <String, dynamic>{
                                              'data': <String, String?>{
                                                'text': ' ',
                                              },
                                            };
                                            safeSetState(() {});
                                            // Reset generatingImage
                                            _model.generatingImage = false;
                                            safeSetState(() {});
                                            // Call AI API
                                            _model.apiResult = await OpenAIAPIGroup
                                                .createStructuredChatCompletionCall
                                                .call(
                                              messagesJson:
                                                  functions.formatMessages(
                                                      _model.messages.toList()),
                                              apiKey: FFAppState().OpenAIKey,
                                            );
                                            if (_model.apiResult?.succeeded ??
                                                true) {
                                              _model.apiResult?.streamedResponse
                                                  ?.stream
                                                  .transform(utf8.decoder)
                                                  .transform(
                                                      const LineSplitter())
                                                  .transform(
                                                      ServerSentEventLineTransformer())
                                                  .map((m) =>
                                                      ResponseStreamMessage(
                                                          message: m))
                                                  .listen(
                                                (onMessageInput) async {
                                                  var _shouldSetState = false;
                                                  if (!ChatCompletionChunkStruct
                                                          .maybeFromMap(
                                                              onMessageInput
                                                                  .serverSentEvent
                                                                  .jsonData)!
                                                      .hasChoices()) {
                                                    return;
                                                  }
                                                  // Update text on assistant message
                                                  _model.updateMessagesAtIndex(
                                                    _model.messages.length - 1,
                                                    (e) => e
                                                      ..content = functions
                                                          .buildContent(
                                                              '${_model.messages.lastOrNull?.content.firstOrNull?.text}${ChatCompletionChunkStruct.maybeFromMap(onMessageInput.serverSentEvent.jsonData)?.choices.firstOrNull?.delta.content}',
                                                              null)
                                                          .toList(),
                                                  );
                                                  safeSetState(() {});
                                                  if ((getJsonField(
                                                            functions.parsePartialJson(
                                                                _model
                                                                    .messages
                                                                    .lastOrNull!
                                                                    .content
                                                                    .firstOrNull!
                                                                    .text),
                                                            r'''$.data.text''',
                                                          ) !=
                                                          null) ||
                                                      (getJsonField(
                                                            functions.parsePartialJson(
                                                                _model
                                                                    .messages
                                                                    .lastOrNull!
                                                                    .content
                                                                    .firstOrNull!
                                                                    .text),
                                                            r'''$.data.description''',
                                                          ) !=
                                                          null)) {
                                                    // Update the message buffer
                                                    _model.messageBuffer =
                                                        getJsonField(
                                                      functions
                                                          .parsePartialJson(
                                                              _model
                                                                  .messages
                                                                  .lastOrNull!
                                                                  .content
                                                                  .firstOrNull!
                                                                  .text),
                                                      r'''$.data''',
                                                    );
                                                    safeSetState(() {});
                                                    HapticFeedback
                                                        .mediumImpact();
                                                    if (!_model
                                                            .generatingImage &&
                                                        (getJsonField(
                                                              _model
                                                                  .messageBuffer,
                                                              r'''$.imageDescription''',
                                                            ) !=
                                                            null)) {
                                                      // Update generatingImage to true
                                                      _model.generatingImage =
                                                          true;
                                                      safeSetState(() {});
                                                      // Create the image
                                                      _model.imageApiResult =
                                                          await OpenAIAPIGroup
                                                              .createImageCall
                                                              .call(
                                                        apiKey: FFAppState()
                                                            .OpenAIKey,
                                                        prompt: getJsonField(
                                                          _model.messageBuffer,
                                                          r'''$.imageDescription''',
                                                        ).toString(),
                                                      );

                                                      _shouldSetState = true;
                                                      if ((_model
                                                              .imageApiResult2
                                                              ?.succeeded ??
                                                          true)) {
                                                        // Update message with image
                                                        _model
                                                            .updateMessagesAtIndex(
                                                          _model.messages
                                                                  .length -
                                                              1,
                                                          (e) => e
                                                            ..img = OpenAIAPIGroup
                                                                .createImageCall
                                                                .imagePath(
                                                              (_model.imageApiResult2
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ),
                                                        );
                                                        safeSetState(() {});
                                                        // Reset value of generatingImage
                                                        _model.generatingImage =
                                                            false;
                                                        safeSetState(() {});
                                                      } else {
                                                        // Reset value of generatingImage
                                                        _model.generatingImage =
                                                            false;
                                                        safeSetState(() {});
                                                      }
                                                    }
                                                  }
                                                  // Scroll to end of list view
                                                  await _model
                                                      .listViewController
                                                      ?.animateTo(
                                                    _model
                                                        .listViewController!
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 150),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                                onError: (onErrorInput) async {
                                                  _model.updateMessagesAtIndex(
                                                    _model.messages.length - 1,
                                                    (e) => e
                                                      ..content = functions
                                                          .buildContent(
                                                              'There was an error!',
                                                              null)
                                                          .toList(),
                                                  );
                                                  safeSetState(() {});
                                                },
                                                onDone: () async {
                                                  // Set suggestions
                                                  _model.suggestions =
                                                      (getJsonField(
                                                    functions.parsePartialJson(
                                                        _model.messages
                                                            .where((e) =>
                                                                e.role ==
                                                                'assistant')
                                                            .toList()
                                                            .lastOrNull!
                                                            .content
                                                            .firstOrNull!
                                                            .text),
                                                    r'''$.suggested_responses''',
                                                    true,
                                                  ) as List)
                                                          .map<String>((s) =>
                                                              s.toString())
                                                          .toList()
                                                          .toList()
                                                          .cast<String>();
                                                  safeSetState(() {});
                                                },
                                              );
                                            }

                                            if (!(_model.apiResultCompletion
                                                    ?.succeeded ??
                                                true)) {
                                              // Show error
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text('Failed'),
                                                    content: Text((_model
                                                            .apiResultCompletion
                                                            ?.bodyText ??
                                                        '')),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                            // Delay
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
                                            // Scroll to end of list view
                                            await _model.listViewController
                                                ?.animateTo(
                                              _model.listViewController!
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.ease,
                                            );

                                            safeSetState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                controller: _model.listViewController,
                              );
                            },
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 4.0,
                                  sigmaY: 4.0,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  constraints: BoxConstraints(
                                    maxWidth: 700.0,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 40.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (valueOrDefault<bool>(
                                          _model.suggestions.length > 0,
                                          false,
                                        ))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 5.0),
                                            child: Builder(
                                              builder: (context) {
                                                final suggestion =
                                                    _model.suggestions.toList();

                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  controller: _model.row,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                            suggestion.length,
                                                            (suggestionIndex) {
                                                      final suggestionItem =
                                                          suggestion[
                                                              suggestionIndex];
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          safeSetState(() {
                                                            _model.userMessageTextController
                                                                    ?.text =
                                                                suggestionItem;
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 30.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent4,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
                                                              child: Text(
                                                                suggestionItem,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                        animationsMap[
                                                            'containerOnPageLoadAnimation']!,
                                                        effects: [
                                                          VisibilityEffect(
                                                              duration: max(
                                                                      1.0,
                                                                      [
                                                                            suggestionIndex *
                                                                                200
                                                                          ].reduce((curr, next) => curr < next
                                                                              ? curr
                                                                              : next) ??
                                                                          0)
                                                                  .toInt()
                                                                  .ms),
                                                          FadeEffect(
                                                            curve: Curves
                                                                .easeInOutQuint,
                                                            delay:
                                                                (suggestionIndex *
                                                                        200)
                                                                    .ms,
                                                            duration: 600.0.ms,
                                                            begin: 0.0,
                                                            end: 1.0,
                                                          ),
                                                        ],
                                                      );
                                                    })
                                                        .divide(SizedBox(
                                                            width: 10.0))
                                                        .addToStart(SizedBox(
                                                            width: 80.0))
                                                        .addToEnd(SizedBox(
                                                            width: 20.0)),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 5.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      if (_model.isRecording) {
                                                        return FlutterFlowIconButton(
                                                          borderRadius: 20.0,
                                                          buttonSize: 40.0,
                                                          hoverColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .accent4,
                                                          icon: Icon(
                                                            Icons.stop_circle,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            // Stop the recording
                                                            await stopAudioRecording(
                                                              audioRecorder: _model
                                                                  .audioRecorder,
                                                              audioName:
                                                                  'recordedFileBytes',
                                                              onRecordingComplete:
                                                                  (audioFilePath,
                                                                      audioBytes) {
                                                                _model.recordedAudio =
                                                                    audioFilePath;
                                                                _model.recordedFileBytes =
                                                                    audioBytes;
                                                              },
                                                            );

                                                            if (isWeb) {
                                                              // Set recordedAudioFile
                                                              _model.recordedAudioFile =
                                                                  _model
                                                                      .recordedFileBytes;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              // Fix audio format
                                                              _model.renamedAudioFile =
                                                                  await actions
                                                                      .renameAudio(
                                                                _model
                                                                    .recordedFileBytes,
                                                                _model
                                                                    .recordedAudio!,
                                                              );
                                                              // Set recordedAudioFile
                                                              _model.recordedAudioFile =
                                                                  _model
                                                                      .renamedAudioFile;
                                                              safeSetState(
                                                                  () {});
                                                            }

                                                            // Set isRecording to false
                                                            _model.isRecording =
                                                                false;
                                                            safeSetState(() {});
                                                            // Transcribe audio
                                                            _model.whisperResult =
                                                                await OpenAIAPIGroup
                                                                    .createTranscriptionCall
                                                                    .call(
                                                              apiKey:
                                                                  FFAppState()
                                                                      .OpenAIKey,
                                                              file: _model
                                                                  .recordedAudioFile,
                                                            );

                                                            if ((_model
                                                                    .whisperResult
                                                                    ?.succeeded ??
                                                                true)) {
                                                              // Update the text field with the API result
                                                              safeSetState(() {
                                                                _model.userMessageTextController
                                                                        ?.text =
                                                                    getJsonField(
                                                                  (_model.whisperResult
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.text''',
                                                                ).toString();
                                                              });
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    functions.printUploadedFile(
                                                                        _model
                                                                            .recordedFileBytes),
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                              // Show failure snack
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    (_model.whisperResult
                                                                            ?.bodyText ??
                                                                        ''),
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          5000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                        );
                                                      } else {
                                                        return FlutterFlowIconButton(
                                                          borderColor: Colors
                                                              .transparent,
                                                          borderRadius: 20.0,
                                                          buttonSize: 40.0,
                                                          hoverColor:
                                                              Color(0x40FFFFFF),
                                                          icon: Icon(
                                                            Icons.mic,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 20.0,
                                                          ),
                                                          onPressed: () async {
                                                            _model.isRecording =
                                                                true;
                                                            safeSetState(() {});
                                                            // Capture user input
                                                            await startAudioRecording(
                                                              context,
                                                              audioRecorder: _model
                                                                      .audioRecorder ??=
                                                                  AudioRecorder(),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      // Upload image to Firebase
                                                      final selectedMedia =
                                                          await selectMediaWithSourceBottomSheet(
                                                        context: context,
                                                        storageFolderPath: '',
                                                        maxWidth: 1000.00,
                                                        allowPhoto: true,
                                                      );
                                                      if (selectedMedia !=
                                                              null &&
                                                          selectedMedia.every((m) =>
                                                              validateFileFormat(
                                                                  m.storagePath,
                                                                  context))) {
                                                        safeSetState(() => _model
                                                                .isDataUploading =
                                                            true);
                                                        var selectedUploadedFiles =
                                                            <FFUploadedFile>[];

                                                        var downloadUrls =
                                                            <String>[];
                                                        try {
                                                          selectedUploadedFiles =
                                                              selectedMedia
                                                                  .map((m) =>
                                                                      FFUploadedFile(
                                                                        name: m
                                                                            .storagePath
                                                                            .split('/')
                                                                            .last,
                                                                        bytes: m
                                                                            .bytes,
                                                                        height: m
                                                                            .dimensions
                                                                            ?.height,
                                                                        width: m
                                                                            .dimensions
                                                                            ?.width,
                                                                        blurHash:
                                                                            m.blurHash,
                                                                      ))
                                                                  .toList();

                                                          downloadUrls =
                                                              await uploadSupabaseStorageFiles(
                                                            bucketName: '',
                                                            selectedFiles:
                                                                selectedMedia,
                                                          );
                                                        } finally {
                                                          _model.isDataUploading =
                                                              false;
                                                        }
                                                        if (selectedUploadedFiles
                                                                    .length ==
                                                                selectedMedia
                                                                    .length &&
                                                            downloadUrls
                                                                    .length ==
                                                                selectedMedia
                                                                    .length) {
                                                          safeSetState(() {
                                                            _model.uploadedLocalFile =
                                                                selectedUploadedFiles
                                                                    .first;
                                                            _model.uploadedFileUrl =
                                                                downloadUrls
                                                                    .first;
                                                          });
                                                        } else {
                                                          safeSetState(() {});
                                                          return;
                                                        }
                                                      }

                                                      if (_model
                                                              .messages
                                                              .lastOrNull
                                                              ?.role ==
                                                          'user') {
                                                        // Update last message in the list to include image
                                                        _model
                                                            .updateMessagesAtIndex(
                                                          _model.messages
                                                                  .length -
                                                              1,
                                                          (e) => e
                                                            ..updateContent(
                                                              (e) => e.add(
                                                                  ContentStruct(
                                                                imageUrl:
                                                                    ImageUrlStruct(
                                                                  url: _model
                                                                      .uploadedFileUrl,
                                                                ),
                                                                type:
                                                                    'image_url',
                                                              )),
                                                            ),
                                                        );
                                                        safeSetState(() {});
                                                      } else {
                                                        // Add new message
                                                        _model.addToMessages(
                                                            MessageStruct(
                                                          role: 'user',
                                                          content: functions
                                                              .buildContent(
                                                                  null,
                                                                  _model
                                                                      .uploadedFileUrl),
                                                          visible: false,
                                                        ));
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.image_outlined,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      size: 28.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    1.0, 1.0),
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Builder(
                                                        builder: (context) {
                                                          if (!_model
                                                              .isRecording) {
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                if ((_model
                                                                        .messages
                                                                        .isNotEmpty) &&
                                                                    _model
                                                                        .messages
                                                                        .lastOrNull!
                                                                        .content
                                                                        .firstOrNull!
                                                                        .hasImageUrl())
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final messageWithImage =
                                                                            _model.messages.lastOrNull?.content.where((e) => e.hasImageUrl()).toList().toList() ??
                                                                                [];

                                                                        return SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          controller:
                                                                              _model.uploadedImageThumbnails,
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                List.generate(messageWithImage.length, (messageWithImageIndex) {
                                                                              final messageWithImageItem = messageWithImage[messageWithImageIndex];
                                                                              return ClipRRect(
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                                child: Image.network(
                                                                                  messageWithImageItem.imageUrl.url,
                                                                                  width: 72.0,
                                                                                  height: 80.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              );
                                                                            }).divide(SizedBox(width: 8.0)).around(SizedBox(width: 8.0)),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                TextFormField(
                                                                  controller: _model
                                                                      .userMessageTextController,
                                                                  focusNode: _model
                                                                      .userMessageFocusNode,
                                                                  onChanged: (_) =>
                                                                      EasyDebounce
                                                                          .debounce(
                                                                    '_model.userMessageTextController',
                                                                    Duration(
                                                                        milliseconds:
                                                                            200),
                                                                    () async {
                                                                      unawaited(
                                                                        () async {
                                                                          await _model
                                                                              .listViewController
                                                                              ?.animateTo(
                                                                            _model.listViewController!.position.maxScrollExtent,
                                                                            duration:
                                                                                Duration(milliseconds: 100),
                                                                            curve:
                                                                                Curves.ease,
                                                                          );
                                                                        }(),
                                                                      );
                                                                    },
                                                                  ),
                                                                  autofocus:
                                                                      true,
                                                                  textCapitalization:
                                                                      TextCapitalization
                                                                          .sentences,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        false,
                                                                    labelStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Readex Pro',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    hintText: FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'bad4ig28' /* Ask anything */,
                                                                    ),
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Readex Pro',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    enabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    errorBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedErrorBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    contentPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            20.0,
                                                                            50.0,
                                                                            20.0),
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  maxLines: 6,
                                                                  minLines: 1,
                                                                  validator: _model
                                                                      .userMessageTextControllerValidator
                                                                      .asValidator(
                                                                          context),
                                                                ),
                                                              ],
                                                            );
                                                          } else {
                                                            return Builder(
                                                              builder:
                                                                  (context) {
                                                                if (!isWeb) {
                                                                  return Container(
                                                                    height:
                                                                        50.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Lottie
                                                                        .asset(
                                                                      'assets/jsons/Blue_Audio_Waveforms.json',
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              1.0,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      animate:
                                                                          true,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container(
                                                                    height:
                                                                        50.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '23fy6ufv' /* Listening... */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Readex Pro',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 10.0),
                                                    child: MouseRegion(
                                                      opaque: false,
                                                      cursor:
                                                          MouseCursor.defer ??
                                                              MouseCursor.defer,
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          if (_model
                                                                  .messages
                                                                  .lastOrNull
                                                                  ?.role ==
                                                              'user') {
                                                            // Update message with text
                                                            _model
                                                                .updateMessagesAtIndex(
                                                              _model.messages
                                                                      .length -
                                                                  1,
                                                              (e) => e
                                                                ..updateContent(
                                                                  (e) => e.insert(
                                                                      0,
                                                                      ContentStruct(
                                                                        text: _model
                                                                            .userMessageTextController
                                                                            .text,
                                                                        type:
                                                                            'text',
                                                                      )),
                                                                )
                                                                ..visible =
                                                                    true,
                                                            );
                                                            safeSetState(() {});
                                                          } else {
                                                            // Add user message
                                                            _model.addToMessages(
                                                                MessageStruct(
                                                              role: 'user',
                                                              content: functions
                                                                  .buildContent(
                                                                      _model
                                                                          .userMessageTextController
                                                                          .text,
                                                                      null),
                                                            ));
                                                            safeSetState(() {});
                                                          }

                                                          // Clear user input
                                                          safeSetState(() {
                                                            _model
                                                                .userMessageTextController
                                                                ?.clear();
                                                          });
                                                          // Scroll to the end of messages
                                                          unawaited(
                                                            () async {
                                                              await _model
                                                                  .listViewController
                                                                  ?.animateTo(
                                                                _model
                                                                    .listViewController!
                                                                    .position
                                                                    .maxScrollExtent,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        100),
                                                                curve:
                                                                    Curves.ease,
                                                              );
                                                            }(),
                                                          );
                                                          // Delay
                                                          await Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      300));
                                                          // Initialize assistant message
                                                          _model.addToMessages(
                                                              MessageStruct(
                                                            role: 'assistant',
                                                            content: functions
                                                                .buildContent(
                                                                    null, null),
                                                          ));
                                                          safeSetState(() {});
                                                          // Initialize a blank message buffer
                                                          _model.messageBuffer =
                                                              <String, dynamic>{
                                                            'data': <String,
                                                                String?>{
                                                              'text': ' ',
                                                            },
                                                          };
                                                          safeSetState(() {});
                                                          // Reset generatingImage
                                                          _model.generatingImage =
                                                              false;
                                                          safeSetState(() {});
                                                          // Call AI API
                                                          _model.apiResultCompletion =
                                                              await OpenAIAPIGroup
                                                                  .createStructuredChatCompletionCall
                                                                  .call(
                                                            messagesJson: functions
                                                                .formatMessages(
                                                                    _model
                                                                        .messages
                                                                        .toList()),
                                                            apiKey: FFAppState()
                                                                .OpenAIKey,
                                                          );
                                                          if (_model
                                                                  .apiResultCompletion
                                                                  ?.succeeded ??
                                                              true) {
                                                            _model
                                                                .apiResultCompletion
                                                                ?.streamedResponse
                                                                ?.stream
                                                                .transform(utf8
                                                                    .decoder)
                                                                .transform(
                                                                    const LineSplitter())
                                                                .transform(
                                                                    ServerSentEventLineTransformer())
                                                                .map((m) =>
                                                                    ResponseStreamMessage(
                                                                        message:
                                                                            m))
                                                                .listen(
                                                              (onMessageInput) async {
                                                                var _shouldSetState =
                                                                    false;
                                                                if (!ChatCompletionChunkStruct.maybeFromMap(onMessageInput
                                                                        .serverSentEvent
                                                                        .jsonData)!
                                                                    .hasChoices()) {
                                                                  return;
                                                                }
                                                                // Update text on assistant message
                                                                _model
                                                                    .updateMessagesAtIndex(
                                                                  _model.messages
                                                                          .length -
                                                                      1,
                                                                  (e) => e
                                                                    ..content = functions
                                                                        .buildContent(
                                                                            '${_model.messages.lastOrNull?.content.firstOrNull?.text}${ChatCompletionChunkStruct.maybeFromMap(onMessageInput.serverSentEvent.jsonData)?.choices.firstOrNull?.delta.content}',
                                                                            null)
                                                                        .toList(),
                                                                );
                                                                safeSetState(
                                                                    () {});
                                                                if ((getJsonField(
                                                                          functions.parsePartialJson(_model
                                                                              .messages
                                                                              .lastOrNull!
                                                                              .content
                                                                              .firstOrNull!
                                                                              .text),
                                                                          r'''$.data.text''',
                                                                        ) !=
                                                                        null) ||
                                                                    (getJsonField(
                                                                          functions.parsePartialJson(_model
                                                                              .messages
                                                                              .lastOrNull!
                                                                              .content
                                                                              .firstOrNull!
                                                                              .text),
                                                                          r'''$.data.description''',
                                                                        ) !=
                                                                        null)) {
                                                                  // Update the message buffer
                                                                  _model.messageBuffer =
                                                                      getJsonField(
                                                                    functions.parsePartialJson(_model
                                                                        .messages
                                                                        .lastOrNull!
                                                                        .content
                                                                        .firstOrNull!
                                                                        .text),
                                                                    r'''$.data''',
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                  HapticFeedback
                                                                      .mediumImpact();
                                                                  if (!_model
                                                                          .generatingImage &&
                                                                      (getJsonField(
                                                                            _model.messageBuffer,
                                                                            r'''$.imageDescription''',
                                                                          ) !=
                                                                          null)) {
                                                                    // Update generatingImage to true
                                                                    _model.generatingImage =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                    // Create the image
                                                                    _model.imageApiResult2 =
                                                                        await OpenAIAPIGroup
                                                                            .createImageCall
                                                                            .call(
                                                                      apiKey: FFAppState()
                                                                          .OpenAIKey,
                                                                      prompt:
                                                                          getJsonField(
                                                                        _model
                                                                            .messageBuffer,
                                                                        r'''$.imageDescription''',
                                                                      ).toString(),
                                                                    );

                                                                    _shouldSetState =
                                                                        true;
                                                                    if ((_model
                                                                            .imageApiResult2
                                                                            ?.succeeded ??
                                                                        true)) {
                                                                      // Update message with image
                                                                      _model
                                                                          .updateMessagesAtIndex(
                                                                        _model.messages.length -
                                                                            1,
                                                                        (e) => e
                                                                          ..img = OpenAIAPIGroup
                                                                              .createImageCall
                                                                              .imagePath(
                                                                            (_model.imageApiResult2?.jsonBody ??
                                                                                ''),
                                                                          ),
                                                                      );
                                                                      safeSetState(
                                                                          () {});
                                                                      // Reset value of generatingImage
                                                                      _model.generatingImage =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      // Reset value of generatingImage
                                                                      _model.generatingImage =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  }
                                                                }
                                                                // Scroll to end of list view
                                                                await _model
                                                                    .listViewController
                                                                    ?.animateTo(
                                                                  _model
                                                                      .listViewController!
                                                                      .position
                                                                      .maxScrollExtent,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          150),
                                                                  curve: Curves
                                                                      .ease,
                                                                );
                                                              },
                                                              onError:
                                                                  (onErrorInput) async {
                                                                _model
                                                                    .updateMessagesAtIndex(
                                                                  _model.messages
                                                                          .length -
                                                                      1,
                                                                  (e) => e
                                                                    ..content = functions
                                                                        .buildContent(
                                                                            'There was an error!',
                                                                            null)
                                                                        .toList(),
                                                                );
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              onDone: () async {
                                                                // Set suggestions
                                                                _model.suggestions =
                                                                    (getJsonField(
                                                                  functions.parsePartialJson(_model
                                                                      .messages
                                                                      .where((e) =>
                                                                          e.role ==
                                                                          'assistant')
                                                                      .toList()
                                                                      .lastOrNull!
                                                                      .content
                                                                      .firstOrNull!
                                                                      .text),
                                                                  r'''$.suggested_responses''',
                                                                  true,
                                                                ) as List)
                                                                        .map<String>((s) => s
                                                                            .toString())
                                                                        .toList()
                                                                        .toList()
                                                                        .cast<
                                                                            String>();
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                            );
                                                          }

                                                          if (!(_model
                                                                  .apiResultCompletion
                                                                  ?.succeeded ??
                                                              true)) {
                                                            // Show error
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Failed'),
                                                                  content: Text((_model
                                                                          .apiResultCompletion
                                                                          ?.bodyText ??
                                                                      '')),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Ok'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }
                                                          // Delay
                                                          await Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      300));
                                                          // Scroll to end of list view
                                                          await _model
                                                              .listViewController
                                                              ?.animateTo(
                                                            _model
                                                                .listViewController!
                                                                .position
                                                                .maxScrollExtent,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            curve: Curves.ease,
                                                          );

                                                          safeSetState(() {});
                                                        },
                                                        child:
                                                            AnimatedContainer(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  100),
                                                          curve:
                                                              Curves.easeInOut,
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                valueOrDefault<
                                                                    Color>(
                                                              _model.sendMouseRegionHovered
                                                                  ? Color(
                                                                      0xFF3F4C7A)
                                                                  : Color(
                                                                      0xFF9196BE),
                                                              Color(0xFF9196BE),
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_upward,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .info,
                                                              size: 16.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onEnter: ((event) async {
                                                        safeSetState(() => _model
                                                                .sendMouseRegionHovered =
                                                            true);
                                                      }),
                                                      onExit: ((event) async {
                                                        safeSetState(() => _model
                                                                .sendMouseRegionHovered =
                                                            false);
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]
                                              .divide(SizedBox(width: 20.0))
                                              .around(SizedBox(width: 20.0)),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ).animateOnPageLoad(
                                animationsMap['blurOnPageLoadAnimation']!),
                          ),
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 20.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                      tabletLandscape: false,
                                    ))
                                      FFButtonWidget(
                                        onPressed: () async {
                                          _model.messages = [];
                                          _model.suggestions = [];
                                          safeSetState(() {});
                                          _model.addToMessages(MessageStruct(
                                            role: 'system',
                                            content: functions.buildContent(
                                                FFAppConstants.ChatSystemPrompt,
                                                null),
                                            visible: false,
                                          ));
                                          safeSetState(() {});
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'fzu2n0zr' /* New Chat */,
                                        ),
                                        icon: Icon(
                                          Icons.add,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0x49FFFFFF),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
