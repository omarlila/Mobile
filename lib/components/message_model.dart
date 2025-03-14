import '/cards/banner_card/banner_card_widget.dart';
import '/cards/code_card/code_card_widget.dart';
import '/cards/detail_card/detail_card_widget.dart';
import '/cards/email_card/email_card_widget.dart';
import '/cards/image_card/image_card_widget.dart';
import '/cards/single_action_card/single_action_card_widget.dart';
import '/cards/text_message/text_message_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'message_widget.dart' show MessageWidget;
import 'package:flutter/material.dart';

class MessageModel extends FlutterFlowModel<MessageWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TextMessage component.
  late TextMessageModel textMessageModel1;
  // Model for ImageCard component.
  late ImageCardModel imageCardModel1;
  // Model for TextMessage component.
  late TextMessageModel textMessageModel2;
  // Model for DetailCard component.
  late DetailCardModel detailCardModel;
  // Model for CodeCard component.
  late CodeCardModel codeCardModel;
  // Model for SingleActionCard component.
  late SingleActionCardModel singleActionCardModel;
  // Model for ImageCard component.
  late ImageCardModel imageCardModel2;
  // Model for ImageCard component.
  late ImageCardModel imageCardModel3;
  // Model for EmailCard component.
  late EmailCardModel emailCardModel;
  // Model for BannerCard component.
  late BannerCardModel bannerCardModel;

  @override
  void initState(BuildContext context) {
    textMessageModel1 = createModel(context, () => TextMessageModel());
    imageCardModel1 = createModel(context, () => ImageCardModel());
    textMessageModel2 = createModel(context, () => TextMessageModel());
    detailCardModel = createModel(context, () => DetailCardModel());
    codeCardModel = createModel(context, () => CodeCardModel());
    singleActionCardModel = createModel(context, () => SingleActionCardModel());
    imageCardModel2 = createModel(context, () => ImageCardModel());
    imageCardModel3 = createModel(context, () => ImageCardModel());
    emailCardModel = createModel(context, () => EmailCardModel());
    bannerCardModel = createModel(context, () => BannerCardModel());
  }

  @override
  void dispose() {
    textMessageModel1.dispose();
    imageCardModel1.dispose();
    textMessageModel2.dispose();
    detailCardModel.dispose();
    codeCardModel.dispose();
    singleActionCardModel.dispose();
    imageCardModel2.dispose();
    imageCardModel3.dispose();
    emailCardModel.dispose();
    bannerCardModel.dispose();
  }
}
