import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final notifs = profile.notifications;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notification',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  if (profile.unreadCount > 0)
                    TextButton(
                      onPressed: profile.markAllRead,
                      child: const Text('Mark all read',
                          style: TextStyle(
                              color: Colors.black, fontSize: 13)),
                    ),
                ],
              ),
            ),
            // List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: notifs.length,
                itemBuilder: (_, i) {
                  final n = notifs[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: n.isRead
                          ? Colors.white
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Image.asset(
                              n.productImage,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade100,
                                child: const Icon(Icons.image_outlined,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                n.title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: n.isRead
                                      ? FontWeight.normal
                                      : FontWeight.w600,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(n.subtitle,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12),
                                        maxLines: 1,
                                        overflow:
                                            TextOverflow.ellipsis),
                                  ),
                                  if (n.tag.isNotEmpty)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 8),
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: n.tag == 'New'
                                            ? const Color(0xFF4CAF50)
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        n.tag,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}