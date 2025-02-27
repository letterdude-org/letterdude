import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final List<String> methods = ['GET', 'POST', 'PUT', 'DELETE'];

  RequestMethod selectedMethod = RequestMethod.get;
  String url = '';
  final FocusNode textFieldFocusNode = FocusNode();

  void _makeRequest(RequestMethod method, String url) {
    BlocProvider.of<RequestBloc>(context).add(MakeRequest(method, url));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => url = value,
                    focusNode: textFieldFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    borderRadius: BorderRadius.circular(8),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 0,
                                    ),
                                    value: selectedMethod.value,
                                    isExpanded: true,
                                    isDense: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedMethod = RequestMethod.values
                                            .firstWhere(
                                                (e) => e.value == value);
                                      });
                                      textFieldFocusNode.requestFocus();
                                    },
                                    items: methods
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 2,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.zero,
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () => _makeRequest(selectedMethod, url),
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
