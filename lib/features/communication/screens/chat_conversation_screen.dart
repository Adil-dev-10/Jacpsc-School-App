import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class ChatConversationScreen extends StatefulWidget {
  final String chatId;
  final String chatTitle;
  final String? imageUrl;

  const ChatConversationScreen({
    super.key,
    required this.chatId,
    required this.chatTitle,
    this.imageUrl,
  });

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock messages data
  final List<Map<String, dynamic>> _messages = [
    {
      'id': '1',
      'text': 'Hello Adil, have you reviewed the Chapter 4 formulas?',
      'time': '10:30 AM',
      'isSent': false,
    },
    {
      'id': '2',
      'text': 'Let me know if you have questions.',
      'time': '10:31 AM',
      'isSent': false,
    },
    {
      'id': '3',
      'text': 'Yes Sir, I have. Just a few doubts.',
      'time': '10:32 AM',
      'isSent': true,
      'isRead': true,
    },
    {
      'id': '4',
      'text': 'Let me know if you have questions.',
      'time': '10:31 AM',
      'isSent': false,
    },
    {
      'id': '5',
      'text': 'When are you free for a call?',
      'time': '10:33 AM',
      'isSent': true,
      'isRead': true,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': _messageController.text.trim(),
        'time': _getCurrentTime(),
        'isSent': true,
        'isRead': false,
      });
    });

    _messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:${now.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            // Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Title and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'online',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length + 1, // +1 for date header
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Date header
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                }

                final message = _messages[index - 1];
                return _buildMessageBubble(message, isDark);
              },
            ),
          ),

          // Footer
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Made with Adil-Dev',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
              ),
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Add button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                  // Input field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                            color: isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade500,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isDark) {
    final isSent = message['isSent'] as bool;
    final isRead = message['isRead'] as bool? ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: isSent
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for received messages
          if (!isSent) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSent
                    ? AppColors.primary
                    : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isSent ? 16 : 4),
                  bottomRight: Radius.circular(isSent ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message['text'],
                    style: TextStyle(
                      fontSize: 15,
                      color: isSent
                          ? Colors.white
                          : (isDark ? Colors.white : Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message['time'],
                        style: TextStyle(
                          fontSize: 11,
                          color: isSent
                              ? Colors.white70
                              : (isDark
                                    ? Colors.grey.shade500
                                    : Colors.grey.shade600),
                        ),
                      ),
                      if (isSent) ...[
                        const SizedBox(width: 4),
                        Icon(
                          isRead ? Icons.done_all : Icons.done,
                          size: 14,
                          color: Colors.white70,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
