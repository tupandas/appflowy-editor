import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:equatable/equatable.dart';

final class Section extends Equatable {
  final int index;
  final String text;
  final Selection selection;
  final Node parent;
  final int characterCount;

  int? characterOffset;

  Section({
    required this.index,
    required this.text,
    required this.selection,
    required this.parent,
  }) : characterCount = text.length;

  @override
  List<Object?> get props => [
    index,
    text,
    selection,
    characterCount,
    characterOffset,
  ];
}

extension type const Sections(List<Section> sections) implements List<Section> {
  const Sections.empty() : sections = const [];
}
