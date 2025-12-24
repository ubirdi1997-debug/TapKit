import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../../notes/providers/notes_provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          Consumer<CalculatorProvider>(
            builder: (context, calculator, child) {
              if (calculator.history.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: () => _showHistory(context),
                  tooltip: 'History',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: _buildDisplay(context),
            ),
            Expanded(
              flex: 3,
              child: _buildKeypad(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, calculator, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (calculator.expression.isNotEmpty)
                Text(
                  calculator.expression,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                ),
              const SizedBox(height: 8),
              SelectableText(
                calculator.display,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: calculator.display));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Result copied')),
                      );
                    },
                    tooltip: 'Copy',
                  ),
                  IconButton(
                    icon: const Icon(Icons.note_add),
                    onPressed: () => _saveToNotes(context, calculator.display),
                    tooltip: 'Save to Notes',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeypad(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildButton(context, 'C', isFunction: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().clear();
                }),
                _buildButton(context, 'CE', isFunction: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().clearEntry();
                }),
                _buildButton(context, '⌫', isFunction: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().deleteLast();
                }),
                _buildButton(context, '÷', isOperator: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().inputOperator('÷');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                _buildButton(context, '7', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('7');
                }),
                _buildButton(context, '8', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('8');
                }),
                _buildButton(context, '9', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('9');
                }),
                _buildButton(context, '×', isOperator: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().inputOperator('×');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                _buildButton(context, '4', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('4');
                }),
                _buildButton(context, '5', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('5');
                }),
                _buildButton(context, '6', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('6');
                }),
                _buildButton(context, '-', isOperator: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().inputOperator('-');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                _buildButton(context, '1', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('1');
                }),
                _buildButton(context, '2', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('2');
                }),
                _buildButton(context, '3', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('3');
                }),
                _buildButton(context, '+', isOperator: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().inputOperator('+');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                _buildButton(context, '%', isFunction: true, onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CalculatorProvider>().calculatePercentage();
                }),
                _buildButton(context, '0', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputNumber('0');
                }),
                _buildButton(context, '.', onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<CalculatorProvider>().inputDecimal();
                }),
                _buildButton(
                  context,
                  '=',
                  isEquals: true,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    context.read<CalculatorProvider>().calculate();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildButton(
                    context,
                    'GST',
                    isFunction: true,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.read<CalculatorProvider>().calculateGST();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label, {
    bool isOperator = false,
    bool isFunction = false,
    bool isEquals = false,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;

    if (isEquals) {
      backgroundColor = theme.colorScheme.primary;
      textColor = Colors.white;
    } else if (isOperator) {
      backgroundColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5);
      textColor = theme.colorScheme.primary;
    } else if (isFunction) {
      backgroundColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5);
      textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;
    } else {
      backgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
      textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: isEquals ? FontWeight.w600 : FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer<CalculatorProvider>(
          builder: (context, calculator, child) {
            if (calculator.history.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Text('No history'),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          calculator.clearHistory();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: calculator.history.length,
                    itemBuilder: (context, index) {
                      final item = calculator.history[index];
                      return ListTile(
                        title: Text(item.expression),
                        subtitle: Text(
                          item.result,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: item.result));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Copied')),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          calculator.clear();
                          calculator.inputNumber(item.result.replaceAll(',', ''));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _saveToNotes(BuildContext context, String result) {
    final notesProvider = context.read<NotesProvider>();
    notesProvider.createNote('Calculator result: $result');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved to Notes')),
    );
  }
}

