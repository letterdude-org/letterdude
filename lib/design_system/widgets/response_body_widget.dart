import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/languages/xml.dart';
import 'package:highlight/languages/json.dart';
import 'package:highlight/languages/plaintext.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/core/utils/logger.dart';
import 'package:xml/xml.dart';

class ResponseBodyWidget extends StatefulWidget {
  const ResponseBodyWidget({super.key, required this.result});

  final RequestSuccess result;

  @override
  State<ResponseBodyWidget> createState() => _ResponseBodyWidgetState();
}

class _ResponseBodyWidgetState extends State<ResponseBodyWidget> {
  late final CodeController controller;

  @override
  void initState() {
    super.initState();
    final contentType = ResponseContentType.fromString(
      (widget.result.response.headers['content-type'] ?? '').split(';')[0],
    );

    final body = formatResponseBody(widget.result.response.body, contentType);

    controller = CodeController(
      text: body,
      language: getResponseContentLanguage(contentType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: CodeTheme(
        data: CodeThemeData(styles: draculaTheme),
        child: CodeField(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Theme.of(context).colorScheme.primary,
            selectionColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            selectionHandleColor: Theme.of(context).colorScheme.primary,
          ),
          textStyle: GoogleFonts.jetBrainsMono(fontSize: 12),
          wrap: true,
          controller: controller,
          readOnly: true,
        ),
      ),
    );
  }
}

enum ResponseContentType {
  json,
  xml,
  html,
  text;

  static ResponseContentType fromString(String value) {
    switch (value) {
      case 'application/json':
        return ResponseContentType.json;
      case 'application/xml':
        return ResponseContentType.xml;
      case 'text/html':
        return ResponseContentType.html;
      default:
        return ResponseContentType.text;
    }
  }
}

dynamic getResponseContentLanguage(ResponseContentType contentType) {
  switch (contentType) {
    case ResponseContentType.json:
      return json;
    case ResponseContentType.xml:
      return xml;
    case ResponseContentType.html:
      return xml;
    case ResponseContentType.text:
      return plaintext;
  }
}

String formatResponseBody(String body, ResponseContentType contentType) {
  try {
    switch (contentType) {
      case ResponseContentType.json:
        final encoder = JsonEncoder.withIndent('  ');
        final formatted = encoder.convert(jsonDecode(body));
        return formatted;
      case ResponseContentType.xml:
        return XmlDocument.parse(body)
            .toXmlString(pretty: true, indent: '    ');
      default:
        return body;
    }
  } catch (e) {
    logger.e('Error formatting response body: $e');
    return body;
  }
}
