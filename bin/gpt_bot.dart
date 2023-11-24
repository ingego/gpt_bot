import 'package:dart_openai/dart_openai.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

const token = "6470199546:AAGRA0uTZwGMQQDvrgGdBiGTxEZ2xnZvwbk";
// const openai = "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";
const openai = "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"; //my key

const text = '''Привет, я чат-бот сервиса Glam Calendar! 

Я создан командой проекта Glam Calendar, чтобы наши пользователи всегда могли получить быстрый совет как сохранить здоровье, молодость и красоту лица и тела. 

Все мои советы носят рекомендательный характер и не являются обязательными к исполнению. 


Напиши свой вопрос с подробностями, указав проблему, часть тела и возможную причину возникновения, чтобы получить более развернутый ответ. Пример: Как избавиться от отека на лице после соленой пищи?

Стартуй! У тебя есть 3 запроса в день.

''';
OpenAIChatCompletionChoiceMessageModel message =
    OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content:
            '''Ответь на запрос, выступи в роли врача-косметолога, твоя задача - проконсультировать человека, рассказав о решении проблемы с помощью различных подходов и методов в косметологии. Ты можешь рекомендовать как современные косметологические средства, препараты и аппаратные методики, так и проверенные временем методы ухода за телом и лицом в домашних условиях и/или в косметологической клинике
Тема: Косметология и косметологический уход, уход за волосами, лицом и телом в домашних условиях, сохранение молодости и красоты тела и лица, улучшения во внешности с помощью современных средств, процедур и косметологических аппаратов, эффективное решение косметических недостатков кожи, тела и волос
Стиль: Медицинский
Тон: сочувственный
Аудитория: 30-летние
Объем: не более 200 слов 
Формат: Текст
Язык чата: Отвечай с учетом и на языке запроса
Задан вопрос не по теме, выдай сообщение: Я отвечаю только на вопросы по уходу за внешностью. Попробуй еще раз''');

Map<DateTime, String> users = {};
Future main(List<String> arguments) async {
  // print('Hello world: ${gpt_bot.calculate()}!');
  OpenAI.apiKey = openai;
  var chat = OpenAI.instance.chat;
  var dart = TeleDart(token, Event((await Telegram(token).getMe()).username!));
  var me = await dart.getMe();
  print(me.username);
  dart.onCommand("start").listen((event) async {
//     await event.reply(
//         '''1. Привет! Этот чат-бот создан командой Glam Calendar, чтобы наши пользователи всегда могли получить совет как сохранить молодость и красоту. ''');
//     await event.reply(
//         '''2. Этот бот отвечает только на вопросы касательно методов и подходов в уходе за внешностью. Все ответы бота носят исключительно рекомендательный характер и не являются обязательными к исполнению.
// ''');
//     await event.reply(
//         '''3. Напиши свой вопрос с деталями, указав проблему, часть тела и возможную причину возникновения. Пример: Как избавиться от отека на лице после соленой пищи?''',
//         replyMarkup: InlineKeyboardMarkup(inlineKeyboard: [
//           [InlineKeyboardButton(text: "начать", callbackData: "start")]
//         ]));
    await event.reply(text,
        replyMarkup: InlineKeyboardMarkup(inlineKeyboard: [
          [InlineKeyboardButton(text: "Начать", callbackData: "start")]
        ]));
  });

  dart.onCallbackQuery().listen((event) async {
    if (event.data == "start") {
      event.teledartMessage!.reply(
          '''Как избавиться от отека на лице после соленой   пищи? ⬇️⬇️⬇️''');
    }
    if (event.data == "prem") {
      event.answer();
      event.teledartMessage!.replyPhoto(
          "https://i.ibb.co/NnBwZ71/photo-2023-11-16-19-50-51.jpg",
          caption:
              "Glam bot\n Больше запросов в день и больше советов по уходу за внешностью",
          replyMarkup: InlineKeyboardMarkup(inlineKeyboard: [
            [
              InlineKeyboardButton(
                  text: "Заплатить 149,00 RUB", callbackData: "pay_m")
            ],
            [
              InlineKeyboardButton(
                  text: "Заплатить за год (скидка 55%)", callbackData: "pay_y")
            ]
          ]));
      event.teledartMessage!.reply(
          '''Нажимая на кнопку "Оплатить" и отправляя данные формы, Вы принимаете условия публичной оферты и соглашаетесь с политикой конфиденциальности.''',
          replyMarkup: InlineKeyboardMarkup(inlineKeyboard: [
            [
              InlineKeyboardButton(
                  text: '''Публичная оферта''',
                  url:
                      "https://firebasestorage.googleapis.com/v0/b/test-c5175.appspot.com/o/BeGlam%20%D0%BE%D1%84%D0%B5%D1%80%D1%82%D0%B0.docx%60%60%60%20-%3E%20%60%60%60BeGlam%20%D0%BE%D1%84%D0%B5%D1%80%D1%82%D0%B0.docx?alt=media&token=b799c783-4049-4e4f-b851-d0c842abd6cb"),
              InlineKeyboardButton(
                  text: '''Политика конфиденциальности''',
                  url:
                      "https://firebasestorage.googleapis.com/v0/b/test-c5175.appspot.com/o/%D0%9F%D0%BE%D0%BB%D0%B8%D1%82%D0%B8%D0%BA%D0%B0%20%D0%BF%D0%B5%D1%80%D1%81%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D1%85%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20BeGam.docx?alt=media&token=1ee1c078-7d59-49f0-b7ce-40fe7bca737e")
            ]
          ]));
    }
  });
  dart.onMessage(entityType: "*").listen((event) async {
    if (event.text?.contains("start") ?? true) {
      return;
    }
    var user = event.chat.id.toString();
    var cur = DateTime.now();
    var curUserRequest =
        users.values.where((element) => element == user).length;
    if (curUserRequest > 2) {
      event.reply(
          " Я смогу ответить на твой вопрос завтра, количество бесплатных запросов ограничено. Ты можешь приобрести полный доступ.",
          replyMarkup: InlineKeyboardMarkup(inlineKeyboard: [
            [InlineKeyboardButton(text: "Премиум", callbackData: "prem")]
          ]));
      return;
    }
    event.reply("бот думает над вопросом");
    try {
      var res = await chat.create(model: "gpt-3.5-turbo-1106", messages: [
        message,
        OpenAIChatCompletionChoiceMessageModel(
            content: event.text ?? "", role: OpenAIChatMessageRole.user)
      ]).timeout(Duration(minutes: 5));
      await event.reply(res.choices.first.message.content);
      users.addAll({DateTime.now(): user});
    } catch (e) {
      print(e);
      await event.reply("сервера приложения не отвечают");
      // event.replyInvoice(title, description, payload, providerToken, currency, prices)
    }
  });

  dart.start();
}
