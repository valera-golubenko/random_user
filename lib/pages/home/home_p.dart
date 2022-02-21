import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:random_user/pages/details_user/details_user.dart';

import 'models/model.dart';
import 'network_api/network_api.dart';

class HomeP extends StatefulWidget {
  const HomeP({Key? key}) : super(key: key);

  @override
  HomePState createState() => HomePState();
}

enum SortType {
  nameDown,
  nameUp,
  ageDown,
  ageUp,
}

class HomePState extends State<HomeP> {
  final _myStream = StreamController.broadcast();
  final _controller = ScrollController();
  final list = <User>[];
  List<User> listFiltred = <User>[];
  bool _isLoading = false;
  bool _checkedMale = true;
  bool _checkedFemale = true;
  int countUsers = 0;
  SortType _sortTipe = SortType.nameDown;

  @override
  void initState() {
    super.initState();
    _getUsers();
    _addListnerToScroll();
  }

  Future<void> _getUsers() async {
    _isLoading = true;
    _myStream.add(null);
    final listUsers = await getData();
    list.addAll(listUsers);

    _onFiltredList();
    _isLoading = false;
    _myStream.add(null);
  }

  void _onFiltredList() {
    listFiltred = list.where((user) {
      if ((user.gender == 'male') && _checkedMale) {
        return true;
      } else if ((user.gender == 'female') && _checkedFemale) {
        return true;
      }
      return false;
    }).toList();
    countUsers = listFiltred.length;
    _myStream.add(null);
  }

  void _addListnerToScroll() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.offset != 0) {
          _getUsers();
        }
      }
    });
  }

  sortListName() {
    final isForeign = [SortType.ageDown, SortType.ageUp].contains(_sortTipe);
    if (isForeign) {
      _sortTipe = SortType.nameDown;
    } else {
      final isDefault = _sortTipe == SortType.nameDown;
      if (isDefault) {
        _sortTipe = SortType.nameUp;
      } else {
        _sortTipe = SortType.nameDown;
      }
    }
    _myStream.add(null);
  }

  sortListAge() {
    final isForeign = [SortType.nameDown, SortType.nameUp].contains(_sortTipe);
    if (isForeign) {
      _sortTipe = SortType.ageDown;
    } else {
      final isDefault = _sortTipe == SortType.ageDown;
      if (isDefault) {
        _sortTipe = SortType.ageUp;
      } else {
        _sortTipe = SortType.ageDown;
      }
    }
    _myStream.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(child: _buildContent()),
      // floatingActionButton: _buildFloatBatton(),
      // bottomNavigationBar: _buildBottomSheet(),
    );
  }

  Widget _buildContent() {
    return StreamBuilder<dynamic>(
      stream: _myStream.stream,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                _buildAppBar(),
                _buildListUsers(),
              ],
            ),
            _buildLoader(),
          ],
        );
      },
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<dynamic>(
                  stream: _myStream.stream,
                  builder: (context, snapshot) {
                    return Text(
                      'Users:  $countUsers',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    );
                  },
                ),
                Row(
                  children: [
                    StreamBuilder<dynamic>(
                        stream: _myStream.stream,
                        builder: (context, snapshot) {
                          return Checkbox(
                            value: _checkedFemale,
                            onChanged: (value) {
                              _checkedFemale = value ?? _checkedFemale;
                              _onFiltredList();
                            },
                          );
                        }),
                    const Text(
                      "Female",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    StreamBuilder<dynamic>(
                        stream: _myStream.stream,
                        builder: (context, snapshot) {
                          return Checkbox(
                            value: _checkedMale,
                            onChanged: (value) {
                              _checkedMale = value ?? _checkedMale;
                              _onFiltredList();
                            },
                          );
                        }),
                    const Text(
                      "Male",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    list.clear();
                    setState(() {
                      _checkedMale = true;
                      _checkedFemale = true;
                    });
                    _getUsers();
                  },
                  icon: const Icon(
                    Icons.restart_alt_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<dynamic>(
                    stream: _myStream.stream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: [SortType.nameDown, SortType.nameUp]
                                  .contains(_sortTipe)
                              ? Colors.red
                              : Colors.blue,
                        ),
                        onPressed: tapButtonName,
                        child: Row(
                          children: [
                            Icon([SortType.nameDown].contains(_sortTipe)
                                ? Icons.arrow_downward
                                : Icons.arrow_upward),
                            SizedBox(width: 20),
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                StreamBuilder<dynamic>(
                    stream: _myStream.stream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: [SortType.ageDown, SortType.ageUp]
                                  .contains(_sortTipe)
                              ? Colors.red
                              : Colors.blue,
                        ),
                        onPressed: tapButtonAge,
                        child: Row(
                          children: [
                            Icon([SortType.ageDown].contains(_sortTipe)
                                ? Icons.arrow_downward
                                : Icons.arrow_upward),
                            const SizedBox(width: 20),
                            const Text(
                              'Age',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Icon _buildFloatBatton() {
  //   return const Icon(Icons.ac_unit);
  // }

  // Widget _buildBottomSheet() {
  //   return Container(
  //     height: 75,
  //     color: Colors.lightBlueAccent,
  //   );
  // }

  Widget _buildListUsers() {
    // final List<User> listFilter = <User>[];

// //Первый способ отобрать женщин и мужчин
//     for (var user in list) {
//       final isMale = user.gender == 'male';
//       final isFemale = user.gender == 'female';
//       if (isMale && _checkedMale) {
//         listFilter.add(user);
//       } else if (isFemale && _checkedFemale) {
//         listFilter.add(user);
//       }
//     }

//     if (countUsers != listFilter.length) {
//       setState(() {});
//       countUsers = listFilter.length;
//     }

// //Второй способ

    // final newList = list.where((user) {
    //   if ((user.gender == 'male') && _checkedMale) {
    //     return true;
    //   } else if ((user.gender == 'female') && _checkedFemale) {
    //     return true;
    //   }
    //   return false;
    // });

    switch (_sortTipe) {
      case SortType.nameDown:
        listFiltred.sort((a, b) => (a.name).compareTo(b.name));
        break;
      case SortType.nameUp:
        listFiltred.sort((a, b) => (b.name).compareTo(a.name));
        break;
      case SortType.ageDown:
        listFiltred.sort((a, b) => (a.age).compareTo(b.age));
        break;
      case SortType.ageUp:
        listFiltred.sort((a, b) => (b.age).compareTo(a.age));
        break;
      default:
    }

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        controller: _controller,
        children: listFiltred.map((e) {
          return _buildButtonOpenUser(e);
        }).toList(),
      ),
    );
  }

  Widget _buildButtonOpenUser(User e) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        splashColor: Colors.blue,
        padding: const EdgeInsets.only(),
        child: Row(
          children: [
            Image.network(e.urlminimg),
            const SizedBox(width: 15),
            Expanded(child: Text(e.name)),
          ],
        ),
        onPressed: () => _openUser(e),
      ),
    );
  }

  _openUser(User e) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return UserDetailsWidget(
            user: e,
          );
        },
      ),
    );
  }

  Widget _buildLoader() {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: _isLoading ? 1 : 0,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  void tapButtonName() {
    final isSelf = [SortType.nameDown, SortType.nameUp].contains(_sortTipe);
    if (isSelf) {
      if (_sortTipe == SortType.nameDown) {
        _sortTipe = SortType.nameUp;
      } else {
        _sortTipe = SortType.nameDown;
      }
    } else {
      _sortTipe = SortType.nameDown;
    }
    _myStream.add(null);
  }

  void tapButtonAge() {
    final isSelf = [SortType.ageDown, SortType.ageUp].contains(_sortTipe);
    if (isSelf) {
      if (_sortTipe == SortType.ageUp) {
        _sortTipe = SortType.ageDown;
      } else {
        _sortTipe = SortType.ageUp;
      }
    } else {
      _sortTipe = SortType.ageDown;
    }
    _myStream.add(null);
  }
}
