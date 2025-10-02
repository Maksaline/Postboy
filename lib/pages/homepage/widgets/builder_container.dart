import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_api_tester/cubits/collection_cubit.dart';
import 'package:minimalist_api_tester/cubits/theme_cubit.dart';
import 'package:minimalist_api_tester/models/collection.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/key_value_pair.dart';

import '../../../cubits/response_cubit.dart';
import 'key_value_row.dart';

class BuilderContainer extends StatefulWidget {
  const BuilderContainer({super.key});

  @override
  State<BuilderContainer> createState() => _BuilderContainerState();
}

class _BuilderContainerState extends State<BuilderContainer> {
  String requestType = 'GET';
  String jsonBody = '';
  String authToken = '';
  String title = 'New Request';
  int tabIndex = 0;
  int collectionIndex = 0;
  int requestId = 0;
  bool bodyNeeded = false;
  bool authNeeded = false;
  bool expectOutput = false;
  bool automationOn = false;
  Map<String, dynamic> paramsMap = {};
  Map<String, dynamic> jsonBodyMap = {};
  Map<String, dynamic> expectedOutputMap = {};
  Map<String, dynamic> automationMap = {};
  final TextEditingController urlController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController jsonController = TextEditingController();
  final tabs = ['Params', 'Body', 'JSON', 'Authentication'];
  final key = GlobalKey<FormState>();
  List<KeyValuePair> paramsPairs = [];
  List<KeyValuePair> bodyPairs = [];
  List<KeyValuePair> expectedPairs = [];

  //----- Query Parameters' function start -----//
  void addParamsPair() {
    if (paramsPairs.isNotEmpty) {
      bool hasEmptyFields = paramsPairs.any((pair) =>
      pair.keyController.text.isEmpty || pair.valueController.text.isEmpty
      );

      if (hasEmptyFields) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8.0),
              Text('Please fill all the key and value before adding a new pair'),
            ],
          )
          ),
        );
        return;
      }
    }

    setState(() {
      paramsPairs.add(KeyValuePair());
    });
  }

  void clearParamsPair(int index) {
    setState(() {
      paramsMap.remove(paramsPairs[index].keyController.text.trim());
      paramsPairs[index].keyController.clear();
      paramsPairs[index].valueController.clear();
    });
    buildUrlWithQueryParams();
    updateRequest();
  }

  void deleteParamsPair(int index) {
    setState(() {
      paramsMap.remove(paramsPairs[index].keyController.text.trim());
      paramsPairs[index].keyController.dispose();
      paramsPairs[index].valueController.dispose();
      paramsPairs.removeAt(index);
    });
    buildUrlWithQueryParams();
    updateRequest();
  }

  void buildUrlWithQueryParams() {
    String baseUrl = urlController.text.trim();

    if (baseUrl.isEmpty) {
      return;
    }

    String cleanBaseUrl = baseUrl.split('?')[0];

    List<String> queryParams = [];
    for (var pair in paramsPairs) {
      String key = pair.keyController.text.trim();
      String value = pair.valueController.text.trim();

      if(value.isNotEmpty) {
        paramsMap[key] = value;
      }

      String encodedKey = Uri.encodeComponent(key);
      String encodedValue = Uri.encodeComponent(value);
      if(key.isNotEmpty || value.isNotEmpty) queryParams.add('$encodedKey=$encodedValue');
    }

    String finalUrl;
    if (queryParams.isNotEmpty) {
      finalUrl = '$cleanBaseUrl?${queryParams.join('&')}';
    } else {
      finalUrl = cleanBaseUrl;
    }

    setState(() {
      urlController.text = finalUrl;
    });
  }
  //----- Query Parameters' function end -----//


  //----- Body Parameters' function start -----//
  void addBodyParamsPair() {
    setState(() {
      bodyPairs.add(KeyValuePair());
    });
  }

  void clearBodyParamsPair(int index) {
    String key = bodyPairs[index].keyController.text.trim();
    setState(() {
      jsonBodyMap.remove(key);
      bodyPairs[index].keyController.clear();
      bodyPairs[index].valueController.clear();
    });
    buildJsonBody();
  }

  void deleteBodyParamsPair(int index) {
    String key = bodyPairs[index].keyController.text.trim();
    setState(() {
      jsonBodyMap.remove(key);
      bodyPairs[index].keyController.dispose();
      bodyPairs[index].valueController.dispose();
      bodyPairs.removeAt(index);
    });
    buildJsonBody();
  }

  void buildJsonBody() {
    jsonBodyMap.clear(); // Clear previous map
    for (var pair in bodyPairs) {
      String key = pair.keyController.text.trim();
      String value = pair.valueController.text.trim();

      if (key.isNotEmpty || value.isNotEmpty) {
        if (value.toLowerCase() == 'true') {
          jsonBodyMap[key] = true;
        } else if (value.toLowerCase() == 'false') {
          jsonBodyMap[key] = false;
        } else if (value.toLowerCase() == 'null') {
          jsonBodyMap[key] = null;
        } else if (int.tryParse(value) != null) {
          jsonBodyMap[key] = int.parse(value);
        } else if (double.tryParse(value) != null) {
          jsonBodyMap[key] = double.parse(value);
        } else {
          jsonBodyMap[key] = value; // Keep as string if no other type matches
        }
      }
    }

    setState(() {
      jsonBody = jsonBodyMap.isNotEmpty ? JsonEncoder.withIndent('    ').convert(jsonBodyMap) : '{\n\n}';
      jsonController.text = jsonBody;
    });
  }
  //----- Body Parameters' function end -----//


  //----- JSON function start -----//
  void buildJSONMap(String jsonText) {
    try {
      Map<String, dynamic> parsedJson = {};
      if(jsonText.isNotEmpty) {
        parsedJson = json.decode(jsonText);
      }
      setState(() {
        jsonBodyMap = parsedJson;
      });
    } catch (e) {
      return;
    }
    bodyPairs.clear();
    jsonBodyMap.forEach((key, value) {
      KeyValuePair pair = KeyValuePair();
      pair.keyController.text = key;
      if(value == null) {
        pair.valueController.text = 'null';
      } else if(value is bool) {
        pair.valueController.text = value.toString();
      } else {
        pair.valueController.text = value.toString();
      }
      bodyPairs.add(pair);
    });
    if(bodyPairs.isEmpty) {
      addBodyParamsPair();
    }
  }


  //----- JSON function start -----//


  //----- Expected Output Parameters' function start -----//
  void addExpectedOutputParamsPair() {
    setState(() {
      expectedPairs.add(KeyValuePair());
    });
  }

  void clearExpectedOutputParamsPair(int index) {
    setState(() {
      expectedPairs[index].keyController.clear();
      expectedPairs[index].valueController.clear();
    });
    buildExpectedOutput();
  }

  void deleteExpectedOutputParamsPair(int index) {
    setState(() {
      expectedPairs[index].keyController.dispose();
      expectedPairs[index].valueController.dispose();
      expectedPairs.removeAt(index);
    });
    buildExpectedOutput();
  }

  void buildExpectedOutput() {
    expectedOutputMap.clear(); // Clear previous map
    for (var pair in expectedPairs) {
      String key = pair.keyController.text.trim();
      String value = pair.valueController.text.trim();

      if (key.isNotEmpty) {
        if(value.isEmpty) {
          expectedOutputMap[key] = "<<<Anything>>>";
        } else if (value.toLowerCase() == 'true') {
          expectedOutputMap[key] = true;
        } else if (value.toLowerCase() == 'false') {
          expectedOutputMap[key] = false;
        } else if (value.toLowerCase() == 'null') {
          expectedOutputMap[key] = null;
        } else if (int.tryParse(value) != null) {
          expectedOutputMap[key] = int.parse(value);
        } else if (double.tryParse(value) != null) {
          expectedOutputMap[key] = double.parse(value);
        } else {
          expectedOutputMap[key] = value; // Keep as string if no other type matches
        }
      }
    }
  }
  //----- Expected Output Parameters' function end -----//


  //----- Automation Handlers start-----//
  void onTypeChanged(int index, String newType) {
    setState(() {
      bodyPairs[index].selectedType = newType;
    });
  }

  void onOptionChanged(int index, String newOption) {
    setState(() {
      bodyPairs[index].selectedOption = newOption;
    });
  }

  void onLowerChanged(int index, String newLower) {
    int? lower = int.tryParse(newLower);
    lower ??= -1;
    setState(() {
      bodyPairs[index].lower = lower!;
    });
  }

  void onUpperChanged(int index, String newUpper) {
    int? upper = int.tryParse(newUpper);
    upper ??= -1;
    setState(() {
      bodyPairs[index].upper = upper!;
    });
  }

  void onSavePressed(BuildContext context, int index) {
    if(bodyPairs[index].keyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Row(
          children: [
            Icon(Icons.warning),
            SizedBox(width: 8.0),
            Text('Please enter a key First'),
          ],
        )),
      );
      return;
    }

    if(bodyPairs[index].lower == -1 && bodyPairs[index].upper == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a range for automation')),
      );
      return;
    }
    String newType = bodyPairs[index].selectedType;
    String newOption = bodyPairs[index].selectedOption;
    int? lower = bodyPairs[index].lower == -1 ? null : bodyPairs[index].lower;
    int? upper = bodyPairs[index].upper == -1 ? null : bodyPairs[index].upper;

    Map<String, dynamic> newPair = {
      'type': newType,
      'option': newOption,
      'lower': lower,
      'upper': upper,
    };

    setState(() {
      automationMap[bodyPairs[index].keyController.text.trim()] = newPair;
      bodyPairs[index].valueController.text = '<<<Automation>>>';
    });
    buildJsonBody();

    Navigator.of(context).pop();
  }
  //----- Automation Handlers end-----//


  //----- Communication with cubit functions start-----//
  void requestBuilder(Collection collection, int index) {
    setState(() {
      title = collection.name;
      requestType = collection.method;
      collectionIndex = index;
      requestId = collection.id;

      if(collection.url != null && collection.url!.isNotEmpty) {
        urlController.text = collection.url!;
      } else {
        urlController.text = '';
      }

      if(collection.headers != null && collection.headers!.isNotEmpty) {
        paramsPairs.clear();
        collection.headers!.forEach((key, value) {
          addParamsPair();
          paramsPairs.last.keyController.text = key;
          paramsPairs.last.valueController.text = value.toString();
        });
        buildUrlWithQueryParams();
      } else {
        paramsPairs.clear();
        paramsMap.clear();
        addParamsPair();
        buildUrlWithQueryParams();
      }


      if(collection.body != null && collection.body!.isNotEmpty) {
        bodyPairs.clear();
        collection.body!.forEach((key, value) {
          addBodyParamsPair();
          bodyPairs.last.keyController.text = key;
          bodyPairs.last.valueController.text = value.toString();
          if(collection.automation != null && collection.automation!.isNotEmpty && collection.automation!.containsKey(key)) {
            final map = collection.automation![key]!;
            automationMap[key] = map;
            bodyPairs.last.selectedType = map['type'];
            bodyPairs.last.selectedOption = map['option'];
            bodyPairs.last.lower = map['lower'] ?? -1;
            bodyPairs.last.upper = map['upper'] ?? -1;
            bodyPairs.last.valueController.text = '<<<Automation>>>';
          } else {
            automationMap.remove(key);
          }
        });
        buildJsonBody();
      } else {
        jsonBodyMap = {};
        jsonBody = '';
        jsonController.text = jsonBody;
        bodyPairs.clear();
        addBodyParamsPair();
      }

      if(collection.count != null) {
        countController.text = collection.count.toString();
      } else {
        countController.text = '';
      }

      bodyNeeded = collection.jsonOn;
      authNeeded = collection.authOn;
      expectOutput = collection.expectedOn;
      automationOn = collection.automationOn;

      if(collection.authToken != null && collection.authToken!.isNotEmpty) {
        authToken = collection.authToken!;
      } else {
        authToken = '';
      }

      if(collection.expected != null && collection.expected!.isNotEmpty) {
        expectedPairs.clear();
        collection.expected!.forEach((key, value) {
          addExpectedOutputParamsPair();
          expectedPairs.last.keyController.text = key;
          expectedPairs.last.valueController.text = value.toString() == "<<<Anything>>>" ? '' : value.toString();
        });
        buildExpectedOutput();
      } else {
        expectedOutputMap = {};
        expectedPairs.clear();
        addExpectedOutputParamsPair();
        buildExpectedOutput();
      }
    });
  }

  void updateRequest() {
    Collection updatedCollection = Collection(
      name: title,
      id: requestId,
      method: requestType,
      url: urlController.text.trim(),
      headers: paramsMap.isNotEmpty ? paramsMap.map((key, value) => MapEntry(key, value.toString())) : null,
      body: jsonBodyMap.isNotEmpty ? jsonBodyMap.map((key, value) => MapEntry(key, value.toString())) : null,
      authToken: authToken.isNotEmpty ? authToken : null,
      expected: expectedOutputMap.isNotEmpty ? expectedOutputMap.map((key, value) => MapEntry(key, value.toString())) : null,
      automation: automationMap.isNotEmpty ? automationMap.map((key, value) => MapEntry(key, value)) : null,
      count: countController.text.isNotEmpty ? int.tryParse(countController.text) : null,
      jsonOn: bodyNeeded,
      authOn: authNeeded,
      expectedOn: expectOutput,
      automationOn: automationOn,
    );
    context.read<CollectionCubit>().updateCollection(collectionIndex, updatedCollection);
  }

  //----- Communication with cubit functions End-----//

  void saveReq() {
    Collection updatedCollection = Collection(
      name: title,
      id: requestId,
      method: requestType,
      url: urlController.text.trim(),
      headers: paramsMap.isNotEmpty ? paramsMap.map((key, value) => MapEntry(key, value.toString())) : null,
      body: jsonBodyMap.isNotEmpty ? jsonBodyMap.map((key, value) => MapEntry(key, value.toString())) : null,
      authToken: authToken.isNotEmpty ? authToken : null,
      expected: expectedOutputMap.isNotEmpty ? expectedOutputMap.map((key, value) => MapEntry(key, value.toString())) : null,
      automation: automationMap.isNotEmpty ? automationMap.map((key, value) => MapEntry(key, value)) : null,
      count: countController.text.isNotEmpty ? int.tryParse(countController.text) : null,
      jsonOn: bodyNeeded,
      authOn: authNeeded,
      expectedOn: expectOutput,
      automationOn: automationOn,
    );
    context.read<CollectionCubit>().saveRequest(updatedCollection, collectionIndex, requestId);
  }

  @override
  void initState() {
    super.initState();
    addParamsPair(); // Initialize with one key-value pair
    addBodyParamsPair();
    addExpectedOutputParamsPair();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionCubit, CollectionState>(
  listener: (context, state) {
    if (state is CollectionLoaded) {
      if (state.index >= 0 && state.index < state.collections.length) {
        requestBuilder(state.collections[state.index], state.index);
      }
    }
  },
  child:
  BlocSelector<CollectionCubit, CollectionState, Collection?>(
  selector: (state) {
    if (state is CollectionLoaded) {
      if (state.index >= 0 && state.index < state.collections.length) {
        return state.collections[state.index];
      }
    }
    return null;
  },
  builder: (context, selectedCollection) {
    if (selectedCollection == null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 1.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            'Please create a request to get started',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }
    return MouseRegion(
      onExit: (PointerExitEvent event) {
      updateRequest();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 1.0,
            ),
          ),
        ),
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            return SizedBox(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: theme.colorScheme.onPrimary,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: EditableText(
                            controller: TextEditingController(text: title),
                            focusNode: FocusNode(),
                            style: Theme.of(context).textTheme.titleLarge!,
                            cursorColor: Theme.of(context).colorScheme.primary,
                            backgroundCursorColor: Colors.transparent,
                            onSubmitted: (newValue) {
                              if(newValue.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Title cannot be empty')),
                                );
                              } else {
                                setState(() {
                                  title = newValue;
                                });
                                updateRequest();
                              }
                            },
                          ),
                        ),
                        const Spacer(),
                        if(requestId >= 0) ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (theme.brightness == Brightness.dark) ? Theme.of(context).colorScheme.secondary : Colors.grey.shade400,
                            foregroundColor: Theme.of(context).colorScheme.onSecondary,
                          ),
                          onPressed: () {
                            context.read<CollectionCubit>().unSaveRequest(collectionIndex);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.bookmark_remove_rounded, color: Theme.of(context).colorScheme.onSecondary),
                              SizedBox(width: 8.0),
                              Text('Unsave', style: Theme.of(context).textTheme.labelLarge),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (theme.brightness == Brightness.dark) ? Theme.of(context).colorScheme.secondary : Colors.grey.shade400,
                            foregroundColor: Theme.of(context).colorScheme.onSecondary,
                          ),
                          onPressed: () {
                            (requestId < 0) ? saveReq() :
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  title: Text('Update Saved Request ?', style: Theme.of(context).textTheme.titleMedium),
                                  content: Text('Updating the request would override your previously saved information with current information.\nDo you like to proceed?', style: Theme.of(context).textTheme.bodyMedium),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel', style: Theme.of(context).textTheme.labelLarge),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colorScheme.onPrimary,
                                      ),
                                      onPressed: () {
                                        saveReq();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Update', style: Theme.of(context).textTheme.labelLarge),
                                    ),
                                  ],
                                );
                              }
                            )
                            ;
                          },
                          child: Row(
                            children: [
                              Icon(Icons.save, color: Theme.of(context).colorScheme.onSecondary),
                              SizedBox(width: 8.0),
                              Text(requestId < 0 ? 'Save' : 'Update', style: Theme.of(context).textTheme.labelLarge),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Theme.of(context).colorScheme.outline,
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  )
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    onChanged: (value) {
                                      setState(() {
                                        requestType = value.toString();
                                      });
                                      // context.read<CollectionCubit>().updateMethod(collectionIndex, value.toString());
                                      updateRequest();
                                    },
                                    value: requestType,
                                    items: const [
                                      DropdownMenuItem(value: 'GET', child: Text('GET', style: TextStyle(color: Colors.green))),
                                      DropdownMenuItem(value: 'POST', child: Text('POST', style: TextStyle(color: Colors.blue))),
                                      DropdownMenuItem(value: 'PUT', child: Text('PUT', style: TextStyle(color: Colors.orange))),
                                      DropdownMenuItem(value: 'DELETE', child: Text('DELETE', style: TextStyle(color: Colors.red))),
                                      DropdownMenuItem(value: 'PATCH', child: Text('PATCH', style: TextStyle(color: Colors.purple))),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Form(
                                key: key,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: urlController,
                                    onFieldSubmitted: (value) {
                                      if(value.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Please enter a valid URL')),
                                        );
                                      } else {
                                        context.read<ResponseCubit>().loadResponse(urlController.text.toString().trim(), requestType,
                                          bodyMap: (jsonBodyMap.isNotEmpty && bodyNeeded) ? jsonBodyMap : null,
                                          authToken: (authToken.isNotEmpty && authNeeded) ? authToken : null,
                                          expectedMap: (expectedOutputMap.isNotEmpty && expectOutput) ? expectedOutputMap : null,
                                          automationMap: (automationMap.isNotEmpty) ? automationMap : null,
                                          count: (automationOn && countController.text.isNotEmpty) ? int.tryParse(countController.text) : null,
                                        );
                                      }
                                    },
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {
                                        return 'Please enter a valid URL';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.outline,
                                      hintText: 'https://api.example.com/endpoint',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              ElevatedButton(
                                onPressed: () {
                                  if(urlController.text.isNotEmpty) {
                                    context.read<ResponseCubit>().loadResponse(urlController.text.toString().trim(), requestType,
                                      bodyMap: (jsonBodyMap.isNotEmpty && bodyNeeded) ? jsonBodyMap : null,
                                      authToken: (authToken.isNotEmpty && authNeeded) ? authToken : null,
                                      expectedMap: (expectedOutputMap.isNotEmpty && expectOutput) ? expectedOutputMap : null,
                                      automationMap: (automationMap.isNotEmpty) ? automationMap : null,
                                      count: (automationOn && countController.text.isNotEmpty) ? int.tryParse(countController.text) : null,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Please enter a valid URL')),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.send, color: Theme.of(context).colorScheme.onSecondary),
                                      SizedBox(width: 8.0),
                                      Text('Send', style: Theme.of(context).textTheme.bodyLarge),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            padding: EdgeInsets.all(4.0),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: tabs.map((tab) => Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tabIndex = tabs.indexOf(tab);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: tabIndex == tabs.indexOf(tab) ? Theme.of(context).colorScheme.surface : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        tab,
                                        style: Theme.of(context).textTheme.labelLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              )).toList(),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(24.0),
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).colorScheme.outline,
                                          blurRadius: 2.0,
                                          spreadRadius: 3.0,
                                        ),
                                      ],
                                      color: Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                    child: tabIndex == 0 ?
                                    paramsBuilder(context) :
                                      tabIndex == 1 ?
                                          bodyParamsBuilder(context) :
                                      tabIndex == 2 ?
                                          jsonBuilder(context) :
                                      authBuilder(context)
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    width: double.infinity,
                                    height: double.infinity,
                                    margin: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).colorScheme.outline,
                                          blurRadius: 2.0,
                                          spreadRadius: 3.0,
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                    child: expectedOutputBuilder(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  },
),
);}

  SingleChildScrollView paramsBuilder(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Query Parameters', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary.withAlpha(200)
            )),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Key', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Value', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Actions', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...paramsPairs.asMap().entries.map((entry) {
                  int index = entry.key;
                  KeyValuePair pair = entry.value;

                  return KeyValueRow(
                    keyController: pair.keyController,
                    valueController: pair.valueController,
                    onClear: () => clearParamsPair(index),
                    onDelete: () => deleteParamsPair(index),
                    onKeyChanged: (value) => buildUrlWithQueryParams(),
                    onValueChanged: (value) => buildUrlWithQueryParams(),
                    onKeySubmitted: (value) => buildUrlWithQueryParams(),
                    onValueSubmitted: (value) => buildUrlWithQueryParams(),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: addParamsPair,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.outline,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondary),
                        SizedBox(width: 8.0),
                        Text('Add Parameter', style: Theme.of(context).textTheme.labelLarge),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
  }

  SingleChildScrollView bodyParamsBuilder(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Parameters for Raw JSON Body', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary.withAlpha(200)
                )),
                Row(
                  children: [
                    Checkbox(
                      value: bodyNeeded,
                      onChanged: (value) {
                        setState(() {
                          bodyNeeded = value ?? false;
                        });
                      },
                      // activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 4.0),
                    Text('Provide Body', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Text('You can use this to send raw JSON data in the body of your request. '
                'Each key-value pair will be converted to a JSON object.',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: automationOn,
                  onChanged: (value) {
                    setState(() {
                      automationOn = value ?? false;
                    });
                  },
                ),
                SizedBox(width: 8.0),
                Text('Run  ', style: Theme.of(context).textTheme.labelLarge),
                SizedBox(
                  width: 40,
                  height: 30,
                  child: TextFormField(
                    controller: countController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Only digits 0-9
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(4.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Text('  times', style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Key', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Value', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Actions', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...bodyPairs.asMap().entries.map((entry) {
                  int index = entry.key;
                  KeyValuePair pair = entry.value;

                  return KeyValueRow(
                    keyController: pair.keyController,
                    valueController: pair.valueController,
                    onClear: () => clearBodyParamsPair(index),
                    onDelete: () => deleteBodyParamsPair(index),
                    onKeyChanged: (value) => buildJsonBody(),
                    onValueChanged: (value) => buildJsonBody(),
                    onKeySubmitted: (value) => buildJsonBody(),
                    onValueSubmitted: (value) => buildJsonBody(),
                    advance: true,
                    onTypeChanged: (value) => onTypeChanged(index, value!),
                    onOptionChanged: (value) => onOptionChanged(index, value!),
                    selectedOption: pair.selectedOption,
                    selectedType: pair.selectedType,
                    lower: pair.lower,
                    upper: pair.upper,
                    onOkPressed: (context) => onSavePressed(context, index),
                    onlowerChanged: (value) => onLowerChanged(index, value!),
                    onUpperChanged: (value) => onUpperChanged(index, value!)
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: addBodyParamsPair,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.outline,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondary),
                        SizedBox(width: 8.0),
                        Text('Add Parameter', style: Theme.of(context).textTheme.labelLarge),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
  }

  Column jsonBuilder(BuildContext context) {
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('JSON Body', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary.withAlpha(200)
              )),
              Row(
                children: [
                  Checkbox(
                    value: bodyNeeded,
                    onChanged: (value) {
                      setState(() {
                        bodyNeeded = value ?? false;
                      });
                    },
                    // activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 4.0),
                  Text('Provide Body', style: Theme.of(context).textTheme.bodyLarge),
                ],
              )
            ],
          ),
          const SizedBox(height: 8.0),
          Text('JSON body will be generated based on the key-value pairs you provide. ',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16.0),
          Flexible(
            child: TextFormField(
              controller: jsonController,
              maxLines: null,
              decoration: InputDecoration(),
              onChanged: (value) => buildJSONMap(value),
              onFieldSubmitted: (value) => buildJSONMap(value),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.outline,
                ),
                onPressed: () {
                  setState(() {
                    jsonBody = jsonBodyMap.isNotEmpty ? JsonEncoder.withIndent('    ').convert(jsonBodyMap) : '';
                    jsonController.text = jsonBody;
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.format_align_left, size: 16.0),
                    const SizedBox(width: 4.0),
                    Text('Format'),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.outline,
                ),
                onPressed: () {
                  // Handle copy response action
                  Clipboard.setData(ClipboardData(text: jsonBody));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 8.0),
                            Text('JSON copied to clipboard'),
                          ],
                        )
                      )
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 16.0),
                    const SizedBox(width: 4.0),
                    Text('Copy'),
                  ],
                ),
              )

            ],
          ),
        ],
      );
  }

  Column authBuilder(BuildContext context) {
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Authentication', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary.withAlpha(200)
              )),
              Row(
                children: [
                  Checkbox(
                    value: authNeeded,
                    onChanged: (value) {
                      setState(() {
                        authNeeded = value ?? false;
                      });
                    },
                    // activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 4.0),
                  Text('Provide Token', style: Theme.of(context).textTheme.bodyLarge),
                ],
              )
            ],
          ),
          const SizedBox(height: 8.0),
          Text('Provide your authentication token here. Only bearer tokens are supported.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Text('Token:', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: TextEditingController(text: authToken),
                  onChanged: (value) {
                    setState(() {
                      authToken = value.trim();
                    });
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      authToken = value.trim();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your authentication token',
                  ),
                ),
              )
            ],
          )
        ],
      );
  }

  SingleChildScrollView expectedOutputBuilder(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: expectOutput,
                  onChanged: (value) {
                    setState(() {
                      expectOutput = value ?? false;
                    });
                  },
                ),
                SizedBox(width: 4.0),
                Text('Expected Output', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary.withAlpha(200)
                )),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Key', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Value', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Actions', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...expectedPairs.asMap().entries.map((entry) {
                  int index = entry.key;
                  KeyValuePair pair = entry.value;

                  return KeyValueRow(
                    enabled: expectOutput,
                    keyController: pair.keyController,
                    valueController: pair.valueController,
                    onClear: () => clearExpectedOutputParamsPair(index),
                    onDelete: () => deleteExpectedOutputParamsPair(index),
                    onKeyChanged: (value) => buildExpectedOutput(),
                    onValueChanged: (value) => buildExpectedOutput(),
                    onKeySubmitted: (value) => buildExpectedOutput(),
                    onValueSubmitted: (value) => buildExpectedOutput(),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (expectOutput) ? addExpectedOutputParamsPair : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.outline,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondary),
                        SizedBox(width: 8.0),
                        Text('Add New Key Value', style: Theme.of(context).textTheme.labelLarge),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
  }
}
