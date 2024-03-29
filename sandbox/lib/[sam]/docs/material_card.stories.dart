import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

part 'material_card.stories.book.dart';

final meta = Meta<Card>();

final $Default = CardStory(
  args: CardArgs(
    child: const ConstArg(
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Hello world 👋'),
      ),
    ),
  ),
);
