import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  bool _loadingPage = true;
  List<dynamic> responseData = [];

  void getUniversityList({String univName = "Indonesia"}) async {
    try {
      setState(() {
        _loadingPage = true;
      });
      final dio = Dio();
      final response = await dio
          .get('http://universities.hipolabs.com/search?country=$univName');
      setState(() {
        responseData = response.data;
        _loadingPage = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUniversityList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: CustomTextField(
            controller: searchController,
            labelText: "Search University",
            errorValidation: "none",
            suffixIcon: IconButton(
              onPressed: () {
                getUniversityList(univName: searchController.text);
              },
              icon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: _loadingPage
                ? [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LinearProgressIndicator(),
                    ),
                  ]
                : responseData.isEmpty
                    ? [
                        Text(
                          "No Data",
                          textAlign: TextAlign.center,
                        )
                      ]
                    : responseData
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              _dialogBuilder(context, e);
                            },
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e['name'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(e['country']),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
          ),
        )
      ],
    );
  }
}

Future<void> _dialogBuilder(BuildContext context, dynamic content) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(content['name']),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Country : ${content['country']}'),
            Text('Country Code : ${content['alpha_two_code']}'),
            Text('Domains : ${content['domains'][0]}'),
            Text('Web Pages : ${content['web_pages'][0]}'),
          ],
        ),
      );
    },
  );
}
