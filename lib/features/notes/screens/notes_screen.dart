import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../../../features/calculator/screens/calculator_screen.dart';
import '../../../features/calculator/providers/calculator_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          Consumer<NotesProvider>(
            builder: (context, notesProvider, child) {
              return IconButton(
                icon: Icon(notesProvider.searchQuery.isEmpty
                    ? Icons.search
                    : Icons.close),
                onPressed: () {
                  if (notesProvider.searchQuery.isNotEmpty) {
                    notesProvider.setSearchQuery('');
                    _searchController.clear();
                  } else {
                    _showSearchDialog(context);
                  }
                },
                tooltip: 'Search',
              );
            },
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final notes = notesProvider.notes;

          if (notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    notesProvider.searchQuery.isEmpty
                        ? 'No notes yet'
                        : 'No notes found',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              if (notesProvider.searchQuery.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Searching: "${notesProvider.searchQuery}"',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          notesProvider.setSearchQuery('');
                          _searchController.clear();
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return _buildNoteCard(context, note);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, note) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _openNote(context, note),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (note.isPinned)
                    Icon(
                      Icons.push_pin,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                  if (note.isPinned) const SizedBox(width: 4),
                  if (note.isLocked)
                    Icon(
                      Icons.lock,
                      size: 16,
                      color: Colors.grey,
                    ),
                  if (note.isLocked) const SizedBox(width: 4),
                  if (note.deleteAt != null)
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: Colors.orange,
                    ),
                  const Spacer(),
                  Text(
                    DateFormat('MMM d, y • h:mm a').format(note.updatedAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.content.length > 200
                    ? '${note.content.substring(0, 200)}...'
                    : note.content,
                style: const TextStyle(fontSize: 16),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (_hasNumbers(note.content))
                    TextButton.icon(
                      icon: const Icon(Icons.calculate, size: 18),
                      label: const Text('Calculate'),
                      onPressed: () => _calculateFromNote(context, note),
                    ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      size: 20,
                    ),
                    onPressed: () {
                      context.read<NotesProvider>().togglePin(note.id);
                    },
                    tooltip: note.isPinned ? 'Unpin' : 'Pin',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: () => _deleteNote(context, note.id),
                    tooltip: 'Delete',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _hasNumbers(String text) {
    return RegExp(r'\d+').hasMatch(text);
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Notes'),
        content: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter keyword...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<NotesProvider>().setSearchQuery(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotesProvider>().setSearchQuery('');
              _searchController.clear();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    final controller = TextEditingController();
    bool addTemporaryNote = false;
    int daysToDelete = 1;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('New Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: 'Enter your note...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Temporary note'),
                  subtitle: const Text('Auto-delete after specified time'),
                  value: addTemporaryNote,
                  onChanged: (value) {
                    setState(() => addTemporaryNote = value ?? false);
                  },
                ),
                if (addTemporaryNote)
                  Row(
                    children: [
                      const Text('Delete after: '),
                      DropdownButton<int>(
                        value: daysToDelete,
                        items: [1, 7, 30, 90].map((days) {
                          return DropdownMenuItem(
                            value: days,
                            child: Text('$days ${days == 1 ? 'day' : 'days'}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => daysToDelete = value);
                          }
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  final notesProvider = context.read<NotesProvider>();
                  if (addTemporaryNote) {
                    notesProvider.createNote(
                      controller.text.trim(),
                      autoDeleteAfter: Duration(days: daysToDelete),
                    );
                  } else {
                    notesProvider.createNote(controller.text.trim());
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _openNote(BuildContext context, note) {
    if (note.isLocked) {
      _showLockDialog(context, note);
    } else {
      _editNote(context, note);
    }
  }

  void _showLockDialog(BuildContext context, note) {
    final pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Locked Note'),
        content: TextField(
          controller: pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter PIN',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final notesProvider = context.read<NotesProvider>();
              if (notesProvider.verifyNotePin(note.id, pinController.text)) {
                Navigator.pop(context);
                _editNote(context, note, isUnlocking: true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Incorrect PIN')),
                );
              }
            },
            child: const Text('Unlock'),
          ),
        ],
      ),
    );
  }

  void _editNote(BuildContext context, note, {bool isUnlocking = false}) {
    final controller = TextEditingController(text: note.content);
    final notesProvider = context.read<NotesProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              if (isUnlocking) const SizedBox(height: 16),
              if (isUnlocking)
                TextButton(
                  onPressed: () {
                    notesProvider.unlockNote(note.id);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    _editNote(context, note);
                  },
                  child: const Text('Remove Lock'),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _showNoteOptions(context, note),
            child: const Text('Options'),
          ),
          TextButton(
            onPressed: () {
              notesProvider.updateNote(note.id, controller.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showNoteOptions(BuildContext context, note) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final notesProvider = context.read<NotesProvider>();
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  note.isLocked ? Icons.lock_open : Icons.lock,
                ),
                title: Text(note.isLocked ? 'Unlock Note' : 'Lock Note'),
                onTap: () {
                  Navigator.pop(context);
                  if (note.isLocked) {
                    notesProvider.unlockNote(note.id);
                  } else {
                    _showSetPinDialog(context, note);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: const Text('Set Auto-Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _showAutoDeleteDialog(context, note);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSetPinDialog(BuildContext context, note) {
    final pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lock Note'),
        content: TextField(
          controller: pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'Enter PIN',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (pinController.text.length >= 4) {
                context.read<NotesProvider>().lockNote(
                      note.id,
                      pinController.text,
                    );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Note locked')),
                );
              }
            },
            child: const Text('Lock'),
          ),
        ],
      ),
    );
  }

  void _showAutoDeleteDialog(BuildContext context, note) {
    int days = 1;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Set Auto-Delete'),
          content: Row(
            children: [
              const Text('Delete after: '),
              DropdownButton<int>(
                value: days,
                items: [1, 7, 30, 90].map((d) {
                  return DropdownMenuItem(
                    value: d,
                    child: Text('$d ${d == 1 ? 'day' : 'days'}'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => days = value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<NotesProvider>().setAutoDelete(
                      note.id,
                      Duration(days: days),
                    );
                Navigator.pop(context);
              },
              child: const Text('Set'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<NotesProvider>().deleteNote(id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _calculateFromNote(BuildContext context, note) {
    final numbers = RegExp(r'-?\d+\.?\d*')
        .allMatches(note.content)
        .map((m) => m.group(0))
        .where((n) => n != null)
        .map((n) => n!)
        .toList();

    if (numbers.length == 1) {
      // Single number found, directly open calculator with it
      context.read<CalculatorProvider>().setValue(numbers.first);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CalculatorScreen(),
        ),
      );
    } else if (numbers.isNotEmpty) {
      // Multiple numbers found, show dialog to select
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Calculate with number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: numbers.map((number) {
              return ListTile(
                title: Text(number),
                onTap: () {
                  Navigator.pop(context);
                  context.read<CalculatorProvider>().setValue(number);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalculatorScreen(),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      );
    } else {
      // No numbers found, just open calculator
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CalculatorScreen(),
        ),
      );
    }
  }
}

