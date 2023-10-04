import 'package:flutter/material.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/responsive.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: R.sw(16, context), vertical: R.sh(10, context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: secondaryColor,
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: secondaryColor,
                        child: const Icon(Icons.bookmark_border),
                      ),
                      SizedBox(
                        width: R.sw(15, context),
                      ),
                      CircleAvatar(
                        backgroundColor: secondaryColor,
                        child: const Icon(Icons.share),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: R.sh(20, context),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: R.sw(14, context),
                    backgroundImage: const AssetImage("assets/rafi.jpeg"),
                  ),
                  SizedBox(
                    width: R.sw(5, context),
                  ),
                  Text(
                    'John Doe - 3 hours ago - Sports',
                    style: TextStyle(
                      color: Color(0xFF4B4B4B),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: R.sh(4, context),
              ),
              Text(
                'A Number of Problems at the Indonesian U20 World Cup',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: R.sw(24, context)),
              ),
              SizedBox(
                height: R.sh(10, context),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: R.sh(250, context),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/rafi.jpeg',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(R.sw(12, context))),
              ),
              SizedBox(
                height: R.sh(20, context),
              ),
              Text(
                "Rafi" * 1000,
              )
            ],
          ),
        ),
      )),
    );
  }
}
