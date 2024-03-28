import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

part 'material_card.stories.book.dart';

final meta = Meta<Card>();

final $Default = CardStory(
  args: CardArgs.fixed(
    child: const Text('Hello world 👋'),
  ),
);
