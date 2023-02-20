import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  List<String> listlanguages = ['English', 'Gujarati', 'Hindi'];
  var selectedvalue = "";

  @override
  void initState() {
    selectedvalue = listlanguages.first;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _formList = [
      {
        'url':
            'https://cot.gujarat.gov.in/writereaddata/Portal/Images/pdf/form6a-290120.pdf',
        'name': 'Issue Of International Driving Permit'
      },
      {
        'url':
            'https://cot.gujarat.gov.in/writereaddata/Portal/Images/pdf/form25-31012020.pdf',
        'name': 'Renewal Of Certificate Of Registration'
      },
      {'url': '', 'name': 'Permanent Registration'},
      {
        'url':
            'https://cot.gujarat.gov.in/writereaddata/images/pdf/form/lld.pdf',
        'name': 'Issue Of Duplicate Certificate Of Registration'
      },
      {'url': '', 'name': 'Transfer of Ownership'},
      {'url': '', 'name': 'Transfer of Ownership (If Covered By Finance)'},
      {'url': '', 'name': 'Termination Of Hire-Purchase Agreement'},
      {'url': '', 'name': 'Endorsement Of\nHire-Purchase Agreement'},
      {'url': '', 'name': 'All India Tourist Permit (Aitp)'},
      {'url': '', 'name': 'Application For Temporary Permit'},
      {'url': '', 'name': 'Application For Good Carriage Permit'},
      {'url': '', 'name': 'Application For Contract Carriage Permit'},
      {'url': '', 'name': 'Issue/Renewal Of Learner\'S Licence'},
      {'url': '', 'name': 'Issue Of Fresh Driving Licence'},
      {'url': '', 'name': 'Addition Of Another Class Of Vehicle'},
      {
        'url':
            'https://cot.gujarat.gov.in/writereaddata/Portal/Images/pdf/form9-290120.pdf',
        'name': 'Renewal Of Driving Licence'
      },
    ];

    // List<String> _formList = [
    //   'Issue Of International Driving Permit',
    //   'Renewal Of Certificate Of Registration',
    //   'Permanent Registration',
    //   'Issue Of Duplicate Certificate Of Registration',
    //   'Transfer of Ownership',
    //   'Transfer of Ownership (If Covered By Finance)',
    //   'Termination Of Hire-Purchase Agreement',
    //   'Endorsement Of\nHire-Purchase Agreement',
    //   'All India Tourist Permit (Aitp)',
    //   'Application For Temporary Permit',
    //   'Application For Good Carriage Permit',
    //   'Application For Contract Carriage Permit',
    //   'Issue/Renewal Of Learner\'S Licence',
    //   'Issue Of Fresh Driving Licence',
    //   'Addition Of Another Class Of Vehicle',
    //   'Renewal Of Driving Licence'
    // ];
    final String url = "https://example.com/example.pdf";

    Future<void> _launchURL() async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could not launch $url";
      }
    }

/*
    Future<File> downloadPDF(String url, String filename) async {
      var response = await http.get(Uri.parse(url));
      var bytes = response.bodyBytes;

      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
    }
ElevatedButton(
          onPressed: () async {
            String url = "https://example.com/example.pdf";
            String filename = "example.pdf";
            await downloadPDF(url, filename);
          },
          child: Text("Download PDF"),
        ),*/
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                  ),
                  child: Center(
                    child: DropdownButton(
                      hint: Text('Select Language'),
                      value: selectedvalue,
                      onChanged: (value) {
                        setState(() {
                          selectedvalue = value.toString();
                          print(selectedvalue);
                        });
                      },
                      items: listlanguages.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  )),
              ListView.separated(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _formList.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.format_align_left),
                    title: Text(_formList[index]["name"]),
                    trailing: InkWell(
                      child: Icon(Icons.download_sharp),
                      // onTap: ()=> openFile(url,fileName);
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future openFile({required String url, required String? fileName}) async {
  //   await downloadFile(url,fileName!);
  // }
  //
  // Future<File?>downloadFile(String url, String name) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final File file=File(fileBits, fileName)
  // }
  // Future<bool> saveFile(String url, String fileName) async {
  //   try {
  //     if (await _requestPermission(Permission.storage)) {
  //       Directory? directory;
  //       directory = await getExternalStorageDirectory();
  //       String newPath = "";
  //       List<String> paths = directory!.path.split("/");
  //       for (int x = 1; x < paths.length; x++) {
  //         String folder = paths[x];
  //         if (folder != "Android") {
  //           newPath += "/" + folder;
  //         } else {
  //           break;
  //         }
  //       }
  //       newPath = newPath + "/PDF_Download";
  //       directory = Directory(newPath);
  //
  //       File saveFile = File(directory.path + "/$fileName");
  //       if (kDebugMode) {
  //         print(saveFile.path);
  //       }
  //       if (!await directory.exists()) {
  //         await directory.create(recursive: true);
  //       }
  //       if (await directory.exists()) {
  //         await Dio().download(
  //           url,
  //           saveFile.path,
  //         );
  //       }
  //     }
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
  // Future<File> loadPdfFromNetwork(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   final bytes = response.bodyBytes;
  //   return _storeFile(url, bytes);
  // }
  //
  // Future<File> _storeFile(String url, List<int> bytes) async     up58'W258J`-U '{
  // final filename = basename(url);
  // final dir = await getApplicationDocumentsDirectory();
  // final file = File('${dir.path}/$filename');
  // File(file.writeAsBytes(bytes, flush: true), fileName)
  // await file.writeAsBytes(bytes, flush: true);
  // if (kDebugMode) {
  // print('$file');
  // }
  // return file;
  // }

}
