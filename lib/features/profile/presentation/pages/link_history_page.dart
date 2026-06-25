import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class LinkHistoryPage extends StatefulWidget {
  const LinkHistoryPage({super.key});

  @override
  State<LinkHistoryPage> createState() => _LinkHistoryPageState();
}

class _LinkHistoryPageState extends State<LinkHistoryPage> {
  final TextEditingController _urlController = TextEditingController();

  // TODO: replace with real scanned link history from domain layer
  final List<String> _scannedLinks = [];

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _onScan() {
    // TODO: wire to link scanner domain use case
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(height: 1, thickness: 0.5),
            _buildUrlBar(),
            Expanded(
              child: _scannedLinks.isEmpty
                  ? _buildEmptyState()
                  : _buildLinkList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, size: 22),
          ),
          const SizedBox(width: 16),
          const Text(
            'Link history',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'GlacialIndifference',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrlBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paste a product link to identify the brand',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'GlacialIndifference',
              color: darkgreyColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: greyColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Icon(Icons.link, size: 18, color: darkgreyColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _urlController,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'GlacialIndifference',
                          ),
                          decoration: InputDecoration(
                            hintText: 'https://brand.com/product...',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GlacialIndifference',
                              color: darkgreyColor.withValues(alpha: 0.6),
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _onScan,
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Scan',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: darkgreyColor.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.link,
              size: 30,
              color: darkgreyColor.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No links scanned yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'GlacialIndifference',
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Paste any product URL above — we\'ll identify the brand and show you similar MENA labels',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'GlacialIndifference',
                color: darkgreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkList() {
    // TODO: build real link history list items
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _scannedLinks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.link, color: darkgreyColor),
          title: Text(
            _scannedLinks[index],
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'GlacialIndifference',
            ),
          ),
        );
      },
    );
  }
}
