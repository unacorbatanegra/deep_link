import 'dart:async';

import 'package:app_links/app_links.dart';

class DeepLink {
  static final _controller = StreamController<Uri>.broadcast();
  static Stream<Uri> get uriLinkStream => _controller.stream;

  static void setup(AppLinks appLinks) {
    _appLinks = appLinks;
    _appLinks!.uriLinkStream.listen(_controller.add);
  }

  static AppLinks? _appLinks;
  static AppLinks get appLink => _appLinks!;
}
