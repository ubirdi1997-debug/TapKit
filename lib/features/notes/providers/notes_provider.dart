import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/models/note_model.dart';
import '../../../core/services/storage_service.dart';

class NotesProvider with ChangeNotifier {
  final List<NoteModel> _notes = [];
  String _searchQuery = '';
  String? _lockPin;

  List<NoteModel> get notes {
    var filteredNotes = _notes.where((note) {
      if (_searchQuery.isEmpty) return true;
      return note.content.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Sort: pinned first, then by updated date
    filteredNotes.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });

    return filteredNotes;
  }

  String get searchQuery => _searchQuery;
  bool get hasLock => _lockPin != null;

  NotesProvider() {
    _loadNotes();
    _loadLockPin();
    _checkExpiredNotes();
  }

  void _loadNotes() {
    final box = StorageService.notesBox;
    _notes.clear();
    _notes.addAll(
      box.values.map((item) => NoteModel.fromJson(item as Map)).toList(),
    );
    _checkExpiredNotes();
    notifyListeners();
  }

  void _loadLockPin() {
    final box = StorageService.settingsBox;
    _lockPin = box.get('notes_pin') as String?;
  }

  void _checkExpiredNotes() {
    final now = DateTime.now();
    final expiredIds = <String>[];

    for (var note in _notes) {
      if (note.deleteAt != null && now.isAfter(note.deleteAt!)) {
        expiredIds.add(note.id);
      }
    }

    if (expiredIds.isNotEmpty) {
      for (var id in expiredIds) {
        deleteNote(id);
      }
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void createNote(String content, {Duration? autoDeleteAfter}) {
    final note = NoteModel(
      id: const Uuid().v4(),
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deleteAt: autoDeleteAfter != null
          ? DateTime.now().add(autoDeleteAfter)
          : null,
    );

    _notes.add(note);
    _saveNote(note);
    notifyListeners();
  }

  void updateNote(String id, String content) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final note = _notes[index].copyWith(
        content: content,
        updatedAt: DateTime.now(),
      );
      _notes[index] = note;
      _saveNote(note);
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    StorageService.notesBox.delete(id);
    notifyListeners();
  }

  void togglePin(String id) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final note = _notes[index].copyWith(
        isPinned: !_notes[index].isPinned,
        updatedAt: DateTime.now(),
      );
      _notes[index] = note;
      _saveNote(note);
      notifyListeners();
    }
  }

  void setLockPin(String pin) {
    _lockPin = pin;
    StorageService.settingsBox.put('notes_pin', pin);
    notifyListeners();
  }

  bool verifyLockPin(String pin) {
    return _lockPin == pin;
  }

  void removeLockPin() {
    _lockPin = null;
    StorageService.settingsBox.delete('notes_pin');
    notifyListeners();
  }

  void lockNote(String id, String pinCode) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final note = _notes[index].copyWith(
        isLocked: true,
        pinCode: pinCode,
        updatedAt: DateTime.now(),
      );
      _notes[index] = note;
      _saveNote(note);
      notifyListeners();
    }
  }

  void unlockNote(String id) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final note = _notes[index].copyWith(
        isLocked: false,
        pinCode: null,
        updatedAt: DateTime.now(),
      );
      _notes[index] = note;
      _saveNote(note);
      notifyListeners();
    }
  }

  bool verifyNotePin(String id, String pin) {
    final note = _notes.firstWhere((note) => note.id == id);
    return note.pinCode == pin;
  }

  void setAutoDelete(String id, Duration duration) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final note = _notes[index].copyWith(
        deleteAt: DateTime.now().add(duration),
        updatedAt: DateTime.now(),
      );
      _notes[index] = note;
      _saveNote(note);
      notifyListeners();
    }
  }

  void _saveNote(NoteModel note) {
    StorageService.notesBox.put(note.id, note.toJson());
  }

  NoteModel? getNoteById(String id) {
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  List<NoteModel> extractNumbersFromNotes() {
    final numbers = <String>[];
    final regex = RegExp(r'-?\d+\.?\d*');

    for (var note in _notes) {
      final matches = regex.allMatches(note.content);
      for (var match in matches) {
        numbers.add(match.group(0)!);
      }
    }

    return numbers.map((n) => NoteModel(
          id: const Uuid().v4(),
          content: n,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )).toList();
  }
}

