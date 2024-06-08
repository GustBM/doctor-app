class TermsModel {
  final String header;
  final List<TermParagraph> termParagraphs;

  TermsModel({required this.header, required this.termParagraphs});
}

class TermParagraph {
  String title;
  String content;

  TermParagraph({required this.title, required this.content});
}
