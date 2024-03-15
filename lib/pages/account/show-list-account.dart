import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/list_role.dart';
import 'package:flutter_application_1/components/profile_pic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/pages/account/show-detail-account.dart';
import 'package:flutter_application_1/interfaces/Account/detail-account.dart';
import 'package:flutter_application_1/services/account-service.dart';
import 'package:flutter_application_1/services/global-service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ShowListAccount extends StatefulWidget {
  const ShowListAccount({Key? key}) : super(key: key);

  @override
  State<ShowListAccount> createState() => _ShowListAccountState();
}

class _ShowListAccountState extends State<ShowListAccount> {
  static const _pageSize = 5;

  late PagingController<int, Content> _pagingController;

  late TextEditingController searchController;
  late TextEditingController filterController;
  late String hintText;
  late String sort;
  late String activeFilter;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    searchController = TextEditingController();
    filterController = TextEditingController();
    hintText = 'Search Name';
    sort = 'asc';
    activeFilter = 'ALL';
  }

  @override
  void dispose() {
    _pagingController.dispose();
    searchController.dispose();
    filterController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      Uri url = AccountService.ListUsers(pageKey, _pageSize, sort,
          searchController.text, filterController.text);
      final newItems = await getDataAccount(GlobalService().accessToken, url);

      final isLastPage = newItems.data!.content!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data!.content!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems.data!.content!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<DetailAccount> getDataAccount(String token, Uri url) async {
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return DetailAccount.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to load");
    }
  }

  void _handleSearch(String query) {
    _pagingController.refresh();
  }

  void _handleCategorySelected(String category) {
    setState(() {
      filterController.text = category;
    });
    _handleSearch(filterController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'List of Accounts',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
        titleSpacing: 25,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         Color.fromARGB(255, 14, 44, 75),
        //         Color.fromARGB(0, 255, 255, 255),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: Column(
        children: [
          CustomCategoriesList( onCategorySelected: _handleCategorySelected,),
          Expanded(
            child: Container(
              color: Colors.white,
              child: PagedListView<int, Content>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Content>(
                  itemBuilder: (context, item, index) {
                    final user = item;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailAccountPage(userId: user.id),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ListTile(
                          leading: const ProfilePic(
                            imageUrl:
                                'https://www.w3schools.com/howto/img_avatar.png',
                            width: 56,
                            height: 56,
                          ),
                          title: Text(user.fullName ?? 'Unknown'),
                          subtitle: Text(user.email ?? 'Unknown'),
                          trailing: Text(user.roleName ?? 'Unknown'),
                        ),
                      ),
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) => const Center(
                    child: Text('Something went wrong!'),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const Center(
                    child: Text('Not found!'),
                  ),
                  newPageProgressIndicatorBuilder: (_) =>
                      const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  Future<List<Content>> searchAndFilter(String query) async {
    if (query.isEmpty) return [];

    try {
      final String token = GlobalService().accessToken;
      final Uri url = Uri.parse(
          'http://dekdee2.informatics.buu.ac.th:8019/api/users?page=0&size=10&sort=&keyword=$query');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final Data data = Data.fromJson(jsonData['data']);
        return data.content ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.white, // Set background color to white
      child: FutureBuilder<List<Content>>(
        future: searchAndFilter(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Content> results = snapshot.data ?? [];
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final Content item = results[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const ProfilePic(
                      imageUrl:
                          'https://www.w3schools.com/howto/img_avatar.png',
                      width: 56,
                      height: 56,
                    ),
                    title: Text(item.fullName ?? 'Unknown'),
                    subtitle: Text(item.email ?? 'Unknown'),
                    trailing: Text(item.roleName ?? 'Unknown'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailAccountPage(userId: item.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.white, // Set background color to white
      child: FutureBuilder<List<Content>>(
        future: searchAndFilter(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Content> results = snapshot.data ?? [];
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final Content item = results[index];
                return ListTile(
                  leading: const ProfilePic(
                    imageUrl: 'https://www.w3schools.com/howto/img_avatar.png',
                    width: 56,
                    height: 56,
                  ),
                  title: Text(item.fullName ?? 'Unknown'),
                  subtitle: Text(item.email ?? 'Unknown'),
                  trailing: Text(item.roleName ?? 'Unknown'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailAccountPage(userId: item.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
