import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rto_app/model/rto_offices_model.dart';
import 'package:rto_app/screen/subscreen/repository.dart';

import '../../widget/office_tile.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  List<String> stateList = ['Gujarati', 'Maharashtra', 'Delhi'];
  var selectedvalue = "";
  bool _isLoading = true;
  List<RTOofficeModel> _allUser = <RTOofficeModel>[];

  List<RTOofficeModel> _foundUser = <RTOofficeModel>[];

  @override
  void initState() {
    selectedvalue = stateList.first;
    //_foundUser = _allUser;
    fetchUsers().then((value) {
      setState(() {
        _isLoading = false;
        _allUser.addAll(value);
        _foundUser = _allUser;
        print(_foundUser.length);
      });
    });
    // readJson();
    super.initState();
  }

  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/rtos.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _allUser = data["items"];
  //   });
  //   print(_allUser.length);
  // }

  /*void _runFilter(String enter) {
    List<RTOofficeModel> result = <RTOofficeModel>[];
    if (enter.isEmpty) {
      result = _allUser;
    } else {
      result = _allUser
          .where(
              (user) => user.name!.toLowerCase().contains(enter.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUser = result;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Office Information"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                    ),
                    child: DropdownButtonFormField(
                        value: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                        items: stateList.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 0, bottom: 0, top: 0),
                              child: Text(item),
                            ),
                          );
                        }).toList()),
                  ),
                ),
                const SizedBox(height: 5),
                // SizedBox(
                //   width: double.infinity,
                //   child: _searchBar(),
                // ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    //   itemCount: _foundUser.length,
                    itemCount: _foundUser.length + 1,
                    itemBuilder: (context, index) {
                      if (!_isLoading) {
                        return index == 0
                            ? _searchBar()
                            : RtoTile(
                                rtOofficeModel: this._foundUser[index - 1]);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _searchBar() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        onChanged: (value) => (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _foundUser = _allUser.where((u) {
              var fName = u.name.toString().toLowerCase();
              // var lName = u.product_price.toLowerCase();
              //var job = u.job.toLowerCase();
              return fName
                  .contains(searchText) /*|| lName.contains(searchText)*/;
            }).toList();
          });
        },
        autofocus: false,
        decoration: InputDecoration(
          fillColor: Colors.grey[300],
          filled: true,
          border: const UnderlineInputBorder(
              borderRadius: BorderRadius.horizontal()),
          hintText: 'Search RTO Office',
          hintStyle: const TextStyle(color: Colors.grey),
          suffix: const Icon(Icons.search),
        ),
      ),
    );
  }

// _searchBar() {
// return Padding(
// padding: EdgeInsets.all(12.0),
// child: TextField(
// autofocus: false,
// onChanged: (searchText) {
// searchText = searchText.toLowerCase();
// setState(() {
// _foundUser = _allUser.where((u) {
// var fName = u.name?.toLowerCase();
// //var job = u.job.toLowerCase();
// return fName.contains(searchText) ;
// }).toList();
// });
// },
// // controller: _textController,
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// prefixIcon: Icon(Icons.search),
// hintText: 'Search Users',
// ),
// ),
// );
// }
}
