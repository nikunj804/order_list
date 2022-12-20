// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nikunj_practical/utils/api.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> orderArrayList = [];
  List<dynamic> selectorderArrayList = [];
  final box = GetStorage();
  String? prime_or_not;
  @override
  void initState() {
    super.initState();

    get_order();
  }

  bool isPrime(N) {
    for (var i = 2; i <= N / i; ++i) {
      if (N % i == 0) {
        return false;
      }
    }
    return true;
  }

  void get_order() async {
    try {
      APIs().order().then((response) async {
        var responseData = json.decode(response.body);
        if (response.statusCode == 200) {
          for (var i = 0;
              i < responseData['data']['orderInfo']['orders'].length;
              i++) {
            isPrime(
                responseData['data']['orderInfo']['orders'][i]['sequence_no']);

            if (isPrime(responseData['data']['orderInfo']['orders'][i]
                ['sequence_no'])) {
              prime_or_not = 'Prime';
            } else {
              prime_or_not = 'Not Prime';
            }

            var orderobj = {
              "order_id": responseData['data']['orderInfo']['orders'][i]
                  ['order_id'],
              "sequence_no": responseData['data']['orderInfo']['orders'][i]
                  ['sequence_no'],
              'primtornot': prime_or_not,
              "order_type": responseData['data']['orderInfo']['orders'][i]
                  ['order_type'],
              "expected_date": responseData['data']['orderInfo']['orders'][i]
                  ['expected_date'],
            };
            setState(() {
              orderArrayList.add(orderobj);
            });
          }
        }
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    Widget order_id(index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Order Id",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(orderArrayList[index]['order_id'].toString()),
        ],
      );
    }

    Widget sequance(index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sequence Number",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(orderArrayList[index]['sequence_no'].toString() +
              ' - ' +
              orderArrayList[index]['primtornot']),
        ],
      );
    }

    Widget order_type(index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Order Type",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(orderArrayList[index]['order_type'])
        ],
      );
    }

    Widget expected_date(index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Expected Date",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat("dd-MM-yyyy").format(
              DateTime.parse(
                orderArrayList[index]['expected_date'],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orderArrayList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    box.write('mydata', orderArrayList[index]);
                    selectorderArrayList.add(orderArrayList[index]);

                    print("selectorderArrayList" +
                        selectorderArrayList.toString());
                  });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        order_id(index),
                        sequance(index),
                        order_type(index),
                        expected_date(index)
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            box.remove('mydata');

            selectorderArrayList = [];

            print("mydata" + selectorderArrayList.toString());
          });
        },
      ),
    );
  }
}
