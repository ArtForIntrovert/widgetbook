class ArgMeta {
  const ArgMeta({
    required this.name,
    required this.type,
    required this.docs,
    required this.defaultValue,
    required this.required,
    required this.named,
  });

  final String name;
  final String type;
  final String? docs;
  final String? defaultValue;
  final bool required;
  final bool named;
}
