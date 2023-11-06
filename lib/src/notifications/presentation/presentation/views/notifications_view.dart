import 'package:badges/badges.dart';
import 'package:tunceducationn/core/common/views/loading_view.dart';
import 'package:tunceducationn/core/common/widgets/nested_back_button.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:tunceducationn/src/notifications/presentation/presentation/widgets/no_notifications.dart';
import 'package:tunceducationn/src/notifications/presentation/presentation/widgets/notification_options.dart';
import 'package:tunceducationn/src/notifications/presentation/presentation/widgets/notification_tile.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Bağımlılıklar değiştikçe yapılması gereken işlemler
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  void dispose() {
    // Burada widget temizliği veya kaynak serbest bırakma işlemleri yapabilirsiniz
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
        leading: const NestedBackButton(),
        actions: const [NotificationOptions()],
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is NotificationError) {
            CoreUtils.showSnackBar(context, state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is GettingNotifications || state is ClearingNotifications) {
            return const LoadingView();
          } else if (state is NotificationsLoaded &&
              state.notifications.isEmpty) {
            return const NoNotifications();
          } else if (state is NotificationsLoaded) {
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (_, index) {
                final notification = state.notifications[index];
                return Badge(
                  showBadge: !notification.seen,
                  position: BadgePosition.topEnd(top: 30, end: 20),
                  child: NotificationTile(notification),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
