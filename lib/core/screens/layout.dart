import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/screens/active_screen.dart';
import 'package:second_app/core/screens/call_screen.dart';
import 'package:second_app/core/screens/groups_screen.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/features/home/provider/home_provider.dart';
import 'package:second_app/features/home/provider/home_state.dart';
import 'package:second_app/features/home/ui/home_screen.dart';

class MyTabScreen extends StatelessWidget {
  const MyTabScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeProvider>(context);
    return BlocConsumer<HomeProvider, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/system_and_computter_engineering.jpg'),
                    radius: 25,
                  ),
                  horizontalSpace(4),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        cubit.updateSearchQuery(value);
                        debugPrint(value);
                      },
                      decoration: InputDecoration(
                        hintText: AppString.search,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  horizontalSpace(4),
                  const Icon(
                    Icons.edit,
                    size: 28,
                    color: Colors.blue,
                  ),
                ],
              ),
              bottom: TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: AppString.message),
                    Tab(text: AppString.active),
                    Tab(text: AppString.group),
                    Tab(text: AppString.calls)
                  ]),
            ),
            body: const TabBarView(
              children: [
                HomeScreen(),
                ActiveScreen(),
                GroupsScreen(),
                CallScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
