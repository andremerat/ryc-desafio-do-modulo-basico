import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final DateTime date;
  final bool isCompleted;
  bool isExpired;

  Task({
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.isExpired = false,
  });

  Task copyWith({
    String? title,
    String? description,
    DateTime? date,
    bool? isCompleted,
    bool? isExpired,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      isExpired: isExpired ?? this.isExpired,
    );
  }

  @override
  List<Object?> get props => [title, description, date, isCompleted, isExpired];
}
