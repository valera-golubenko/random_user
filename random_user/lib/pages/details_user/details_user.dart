import 'package:flutter/material.dart';
import 'package:random_user/pages/home/home_p.dart';

class UserDetailsWidget extends StatelessWidget {
  final user;

  const UserDetailsWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _UserNameWidget(username: user),
              const Divider(
                height: 5,
                color: Colors.grey,
              ),
              _UserInfoWidget(info: user),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserNameWidget extends StatelessWidget {
  const _UserNameWidget({
    Key? key,
    required this.username,
  }) : super(key: key);

  final username;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: double.infinity,
              child: Image.network(
                username.urlmaximg,
                fit: BoxFit.fill,
              )),
          const SizedBox(height: 25),
          Text(
            username.name,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserInfoWidget extends StatelessWidget {
  const _UserInfoWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  final info;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(
                Icons.accessibility_rounded,
                color: Colors.red,
              ),
              const SizedBox(width: 15),
              Text(
                '${info.age}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(
                Icons.location_city,
                color: Colors.red,
              ),
              const SizedBox(width: 15),
              Text(
                info.city,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(
                Icons.email,
                color: Colors.red,
              ),
              const SizedBox(width: 15),
              Text(
                info.email,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(
                Icons.account_box,
                color: Colors.red,
              ),
              const SizedBox(width: 15),
              Text(
                info.gender,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
