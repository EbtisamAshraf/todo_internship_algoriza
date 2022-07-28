import 'package:flutter/material.dart';
import 'package:todo_internship_algoriza/config/routes/app_routes.dart';
import 'package:todo_internship_algoriza/core/widgets/custom_button.dart';
import 'package:todo_internship_algoriza/features/tasks/data/models/enum_filtration.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/widgets/task_group_widget.dart';
import 'package:todo_internship_algoriza/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    TasksCubit.get(context).getTasks();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Board'),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            controller: tabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                icon: Text('All'),
              ),
              Tab(
                icon: Text('Completed'),
              ),
              Tab(
                icon: Text('Uncompleted'),
              ),
              Tab(
                icon: Text('Favorite'),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.scheduleRoute),
              icon: const Icon(Icons.calendar_month, color: Colors.black),
            )
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            TaskGroupWidget(
              isFiltration: false,
              isSchedule: false,
              notifyHelper: notifyHelper,
            ),
            TaskGroupWidget(
              isFiltration: true,
              isSchedule: false,
              filtration: Filtration.isCompleted,
              isCompleted: 1,
            ),
            TaskGroupWidget(
              isFiltration: true,
              isSchedule: false,
              filtration: Filtration.isCompleted,
              isCompleted: 0,
            ),
            TaskGroupWidget(
              isFiltration: true,
              isSchedule: false,
              filtration: Filtration.isFavorite,
              isFavorite: 1,
            ),
          ],
        ),
        bottomSheet: CustomButton(
          text: 'Add Task',
          onTap: () => Navigator.pushNamed(context, Routes.addTaskRoute),
        ));
  }
}
