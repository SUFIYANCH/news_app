import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/services/user_service.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/responsive.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: R.sw(16, context)),
            child: ref.watch(singleUserProvider).when(
                  data: (data) {
                    return Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: R.sh(200, context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: R.sw(50, context),
                                  backgroundImage:
                                      const AssetImage("assets/rafi.jpeg"),
                                ),
                                SizedBox(
                                  height: R.sh(16, context),
                                ),
                                Text(
                                  data.data()!.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: R.sw(28, context)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: R.sh(10, context),
                        ),
                        ProfileWidget(
                          categoryname: 'Email',
                          category: data.data()!.email,
                          icon: Icons.email,
                        ),
                        ProfileWidget(
                          categoryname: 'Phone number',
                          category: data.data()!.phone,
                          icon: Icons.phone,
                        ),
                        ProfileWidget(
                          categoryname: 'Country',
                          category: data.data()!.country,
                          icon: Icons.flag,
                        ),
                        ProfileWidget(
                          categoryname: 'Pin',
                          category: data.data()!.pin,
                          icon: Icons.pin,
                        ),
                        SizedBox(
                          height: R.sh(10, context),
                        ),
                        TextButton.icon(
                            style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: tertiaryColor,
                                fixedSize: Size(
                                    R.sw(200, context), R.sh(50, context))),
                            onPressed: () async {
                              await ref.read(authServiceProvider).logout();
                            },
                            icon: const Icon(Icons.logout),
                            label: Text(
                              'Log out',
                              style: TextStyle(fontSize: R.sw(18, context)),
                            )),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String categoryname;
  final IconData icon;
  final String category;
  const ProfileWidget({
    required this.categoryname,
    super.key,
    required this.icon,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: R.sw(2, context)),
          child: Text(
            categoryname,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: R.sw(16, context)),
          ),
        ),
        SizedBox(
          height: R.sh(2, context),
        ),
        Container(
          height: R.sh(60, context),
          width: R.sw(375, context),
          padding: EdgeInsets.symmetric(horizontal: R.sw(10, context)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(R.sw(12, context)),
              border: Border.all(color: Colors.black.withOpacity(0.3))),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(
                width: R.sw(10, context),
              ),
              Text(
                category,
                style: TextStyle(
                    fontSize: R.sw(18, context),
                    color: const Color(0xFF777777)),
              )
            ],
          ),
        ),
        SizedBox(
          height: R.sh(20, context),
        )
      ],
    );
  }
}
