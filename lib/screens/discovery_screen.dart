import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/responsive.dart';

class DiscoveryScreen extends ConsumerWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: R.sw(16, context)),
          child: Column(children: [
            TextField(
              controller: ref.watch(texteditingProvider),
              decoration: InputDecoration(
                hintText: 'Search here...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => ref.watch(texteditingProvider).clear(),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(R.sw(20, context)),
                ),
              ),
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                ref.invalidate(searchNewsProvider);
              },
            ),
            ref.watch(searchNewsProvider).when(
                  data: (data) {
                    if (data == null) {
                      return Expanded(
                          child: ref.watch(getAllNewsProvider).when(
                                data: (data) {
                                  return ListView.builder(
                                    itemCount: data!.data.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: R.sh(16, context)),
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.data[index].title,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        R.sw(24, context)),
                                              ),
                                              Text(
                                                data.data[index].author ==
                                                            null ||
                                                        data.data[index]
                                                                .author ==
                                                            "-"
                                                    ? "Unknown"
                                                    : data.data[index].author
                                                        .toString(),
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                'Published 3 hours ago ',
                                              ),
                                              SizedBox(
                                                height: R.sh(16, context),
                                              ),
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                height: R.sh(200, context),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          data.data[index]
                                                                  .image ??
                                                              "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                                        ),
                                                        fit: BoxFit.cover),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            R.sw(6, context))),
                                              ),
                                              SizedBox(
                                                height: R.sh(16, context),
                                              ),
                                              Text(
                                                data.data[index].description,
                                              ),
                                              SizedBox(
                                                height: R.sh(20, context),
                                              ),
                                              Divider(
                                                color: primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                error: (error, stackTrace) =>
                                    Text(error.toString()),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: R.sh(16, context)),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: R.sw(24, context)),
                                  ),
                                  Text(
                                    data.data[index].author == null ||
                                            data.data[index].author == "-"
                                        ? "Unknown"
                                        : data.data[index].author.toString(),
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  const Text(
                                    'Published 3 hours ago ',
                                  ),
                                  SizedBox(
                                    height: R.sh(16, context),
                                  ),
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: R.sh(200, context),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              data.data[index].image ??
                                                  "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(
                                            R.sw(6, context))),
                                  ),
                                  SizedBox(
                                    height: R.sh(16, context),
                                  ),
                                  Text(
                                    data.data[index].description,
                                  ),
                                  SizedBox(
                                    height: R.sh(20, context),
                                  ),
                                  Divider(
                                    color: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text("$error"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ]),
        ),
      ),
    );
  }
}
