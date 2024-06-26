import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/feature/auth/controller/authController.dart';
import 'package:whatsapp/feature/chat/widgets/contact_list.dart';
import 'package:whatsapp/feature/group/screen/create_group_screen.dart';
import 'package:whatsapp/feature/status/screen/status_contact_screen.dart';
import 'package:whatsapp/widgets/dynamic_floating_action.dart';


class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 248, 245, 245),
                size: 25,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  labelTextStyle: MaterialStatePropertyAll(TextStyle(
                    color: currentBrightness == Brightness.light ? Colors.black : Colors.white,
                  )),
                  child: const Text(
                    'Create Group',
                  ),
                  onTap: () => Future(
                    () => Navigator.pushNamed(
                        context, CreateGroupScreen.routeName),
                  ),
                )
              ],
            ),
          ],
          bottom: TabBar(
            indicatorWeight: 4,
            tabs: const [
              Tab(text: 'Chats'),
              Tab(text: 'Updates'),
              Tab(text: 'Calls'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            ContactsList(),
            StatusContactsScreen(),
            Center(
              child: Text('Calls Tab Content'),
            ),
          ],
        ),
        floatingActionButton:
            dynamicFloatingActionButton(_currentIndex, context),
      ),
    );
  }
}