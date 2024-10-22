import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class BusinessCard extends Card {
  final String unreadCount;
  final String businessName;

  const BusinessCard(
      {super.key, required this.unreadCount, required this.businessName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 16),
          Text(
            this.businessName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          SizedBox(width: 28),
          badges.Badge(
            badgeContent: Text(
              this.unreadCount,
              style: TextStyle(color: Colors.white),
            ),
            showBadge: this.unreadCount != '0',
            child: Icon(Icons.notifications),
          )
        ],
      ),
    );
  }
}
