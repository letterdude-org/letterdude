import 'package:flutter/material.dart';

class ResponseCookiesWidget extends StatelessWidget {
  final Map<String, String> headers;

  const ResponseCookiesWidget({
    super.key,
    required this.headers,
  });

  Map<String, String> _parseCookies() {
    final cookies = <String, String>{};
    final setCookieHeaders = headers['set-cookie'];

    if (setCookieHeaders == null) return cookies;

    final cookiesList = setCookieHeaders.split(',');

    for (var cookieString in cookiesList) {
      final mainPart = cookieString.split(';')[0].trim();
      final parts = mainPart.split('=');
      if (parts.length == 2) {
        cookies[parts[0]] = parts[1];
      }
    }

    return cookies;
  }

  @override
  Widget build(BuildContext context) {
    final cookies = _parseCookies();

    if (cookies.isEmpty) {
      return const Center(
        child: Text('No cookies found'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Value',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...cookies.entries.map(
              (cookie) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(cookie.key),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(cookie.value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
