import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:highlight/languages/xml.dart';
import 'package:highlight/languages/json.dart';
import 'package:highlight/languages/plaintext.dart';
import 'package:letterdude/core/utils/logger.dart';
import 'package:xml/xml.dart';

class ResponseWidget extends StatefulWidget {
  const ResponseWidget({super.key, required this.response});

  final http.Response response;

  @override
  State<ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<ResponseWidget> {
  late final CodeController controller;

  @override
  void initState() {
    super.initState();
    final contentType = ResponseContentType.fromString(
      (widget.response.headers['content-type'] ?? '').split(';')[0],
    );

    final body = formatResponseBody(widget.response.body, contentType);

    controller = CodeController(
      text: body,
      language: getResponseContentLanguage(contentType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status: ${widget.response.statusCode}'),
        Expanded(
          child: CodeTheme(
            data: CodeThemeData(styles: githubTheme),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: CodeField(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Theme.of(context).colorScheme.primary,
                  selectionColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.3),
                  selectionHandleColor: Theme.of(context).colorScheme.primary,
                ),
                textStyle: GoogleFonts.jetBrainsMono(fontSize: 12),
                wrap: true,
                controller: controller,
                readOnly: true,
              ),
            ),
          ),
        ),
      ],
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
