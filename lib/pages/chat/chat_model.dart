import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navigation/drawer/drawer_widget.dart';
import 'chat_widget.dart' show ChatWidget;
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class ChatModel extends FlutterFlowModel<ChatWidget> {
  ///  Local state fields for this page.

  List<MessageStruct> messages = [];
  void addToMessages(MessageStruct item) => messages.add(item);
  void removeFromMessages(MessageStruct item) => messages.remove(item);
  void removeAtIndexFromMessages(int index) => messages.removeAt(index);
  void insertAtIndexInMessages(int index, MessageStruct item) =>
      messages.insert(index, item);
  void updateMessagesAtIndex(int index, Function(MessageStruct) updateFn) =>
      messages[index] = updateFn(messages[index]);

  bool isRecording = false;

  List<String> suggestions = [];
  void addToSuggestions(String item) => suggestions.add(item);
  void removeFromSuggestions(String item) => suggestions.remove(item);
  void removeAtIndexFromSuggestions(int index) => suggestions.removeAt(index);
  void insertAtIndexInSuggestions(int index, String item) =>
      suggestions.insert(index, item);
  void updateSuggestionsAtIndex(int index, Function(String) updateFn) =>
      suggestions[index] = updateFn(suggestions[index]);

  dynamic messageBuffer;

  bool generatingImage = false;

  FFUploadedFile? recordedAudioFile;

  ///  State fields for stateful widgets in this page.

  // Model for Drawer component.
  late DrawerModel drawerModel1;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // Stores action output result for [Backend Call - API (createStructuredChatCompletion )] action in Message widget.
  ApiCallResponse? apiResult;
  // Stores action output result for [Backend Call - API (createImage)] action in Message widget.
  ApiCallResponse? imageApiResult;
  // State field(s) for Row widget.
  ScrollController? row;
  String? recordedAudio;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  // Stores action output result for [Custom Action - renameAudio] action in StopButton widget.
  FFUploadedFile? renamedAudioFile;
  // Stores action output result for [Backend Call - API (createTranscription)] action in StopButton widget.
  ApiCallResponse? whisperResult;
  AudioRecorder? audioRecorder;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for UploadedImageThumbnails widget.
  ScrollController? uploadedImageThumbnails;
  // State field(s) for UserMessage widget.
  FocusNode? userMessageFocusNode;
  TextEditingController? userMessageTextController;
  String? Function(BuildContext, String?)? userMessageTextControllerValidator;
  // State field(s) for SendMouseRegion widget.
  bool sendMouseRegionHovered = false;
  // Stores action output result for [Backend Call - API (createStructuredChatCompletion )] action in Container widget.
  ApiCallResponse? apiResultCompletion;
  // Stores action output result for [Backend Call - API (createImage)] action in Container widget.
  ApiCallResponse? imageApiResult2;
  // Model for Drawer component.
  late DrawerModel drawerModel2;

  @override
  void initState(BuildContext context) {
    drawerModel1 = createModel(context, () => DrawerModel());
    listViewController = ScrollController();
    row = ScrollController();
    uploadedImageThumbnails = ScrollController();
    drawerModel2 = createModel(context, () => DrawerModel());
  }

  @override
  void dispose() {
    drawerModel1.dispose();
    listViewController?.dispose();
    row?.dispose();
    uploadedImageThumbnails?.dispose();
    userMessageFocusNode?.dispose();
    userMessageTextController?.dispose();

    drawerModel2.dispose();
  }
}
