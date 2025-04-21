import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_taskhub/logic/auth/auth_cubit.dart';
import 'package:mini_taskhub/logic/auth/auth_state_cubit.dart';
import 'package:mini_taskhub/services/service_locator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStateCubit>(
      bloc: getIt<AuthCubit>(),
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Text(state.userId.toString()),
                Center(
                  child: InkWell(
                    onTap: () => getIt<AuthCubit>().signOut(),
                    child: Text('Sign Out'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
