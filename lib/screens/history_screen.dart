import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/provider/provider.dart';
import 'package:calculator/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.historyTitle,
            style: TextStyle(
              fontSize: width * 0.08,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _showClearDialog(context);
              },
              icon: Icon(
                Icons.delete_outline_sharp,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: Consumer<HistoryProvider>(
          builder: (context, historyProvider, child) {
            if (historyProvider.history.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: width * 0.2,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    SizedBox(height: width * 0.05),
                    TextWidget(
                      width: width,
                      text: l10n.noHistoryYet,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    SizedBox(height: width * 0.02),
                    TextWidget(
                      width: width,
                      text: l10n.calculationsAppearHere,
                      fontSize: width * 0.04,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(width * 0.03),
              itemCount: historyProvider.history.length,
              itemBuilder: (context, index) {
                final item = historyProvider.history[index];
                return Card(
                  margin: EdgeInsets.only(bottom: width * 0.02),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: width * 0.02,
                    ),
                    title: TextWidget(
                      width: width,
                      text: item.expression,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: width * 0.01),
                        TextWidget(
                          width: width,
                          text: l10n.result(item.result),
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(height: width * 0.01),
                        TextWidget(
                          width: width,
                          text: _formatDateTime(item.timestamp, l10n),
                          fontSize: width * 0.035,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        historyProvider.deleteHistoryItem(index);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    onTap: () {
                      final result = historyProvider.getResultByIndex(index);
                      if (result.isNotEmpty) {
                        context.read<ProviderClass>().setResultFromHistory(result);
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          title: TextWidget(
            width: width,
            text: l10n.clearHistory,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
          content: TextWidget(
            width: width,
            text: l10n.clearHistoryConfirm,
            fontSize: width * 0.04,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(
                width: width,
                text: l10n.cancel,
                fontSize: width * 0.04,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<HistoryProvider>().clearHistory();
                Navigator.of(context).pop();
              },
              child: TextWidget(
                width: width,
                text: l10n.clear,
                fontSize: width * 0.04,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime, AppLocalizations l10n) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return l10n.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return l10n.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return l10n.minutesAgo(difference.inMinutes);
    } else {
      return l10n.justNow;
    }
  }
}
