import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final int index;
  final String text;
  final Selection selection;
  final Node parent;

  const Section(
      {required this.index,
      required this.text,
      required this.selection,
      required this.parent});

  @override
  List<Object?> get props => [index, text, selection];
}
