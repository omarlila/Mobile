import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Chat
  {
    'bad4ig28': {
      'en': 'Ask anything',
      'ar': '',
    },
    '23fy6ufv': {
      'en': 'Listening...',
      'ar': '',
    },
    'fzu2n0zr': {
      'en': 'New Chat',
      'ar': '',
    },
    'wz2khzkr': {
      'en': 'NeuroLift',
      'ar': '',
    },
    'l1wuzz6w': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Landing
  {
    'jq9f4h06': {
      'en': 'NeuroLift',
      'ar': '',
    },
    'n4thx2hy': {
      'en': 'The Brain Your Business Has Been Missing.',
      'ar': '',
    },
    '9s9un6lu': {
      'en': 'Begin',
      'ar': '',
    },
    '8a56atbu': {
      'en': 'Home',
      'ar': '',
    },
  },
  // auth_Login
  {
    'plfocplu': {
      'en': 'NeuroLift',
      'ar': '',
    },
    'zvyl4u9t': {
      'en': 'Welcome Back',
      'ar': '',
    },
    '4upxw45j': {
      'en': 'Fill out the information below to access your account.',
      'ar': '',
    },
    'e0atk9kw': {
      'en': 'Email',
      'ar': '',
    },
    '3zxct2on': {
      'en': 'Password',
      'ar': '',
    },
    'rxsmfani': {
      'en': 'Field is required',
      'ar': '',
    },
    'jc4dstkr': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'ucr26103': {
      'en': 'Field is required',
      'ar': '',
    },
    's5srdvqo': {
      'en': '',
      'ar': '',
    },
    'q4vdwcgk': {
      'en': '',
      'ar': '',
    },
    '9ibisj9y': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'eq5ajrff': {
      'en': 'Sign In',
      'ar': '',
    },
    'x8d2rwz0': {
      'en': 'Or sign in with',
      'ar': '',
    },
    '0sgieoax': {
      'en': 'Continue with Google',
      'ar': '',
    },
    'iuxdu5kh': {
      'en': 'Don\'t have an account?  ',
      'ar': '',
    },
    'z63phzs4': {
      'en': 'Create Account',
      'ar': '',
    },
    'ex8obaqb': {
      'en': 'Forgot password?',
      'ar': '',
    },
    'qf9zh1l3': {
      'en': 'Home',
      'ar': '',
    },
  },
  // auth_ForgotPassword
  {
    'm6h3bnws': {
      'en': 'NeuroLift',
      'ar': '',
    },
    't5atim44': {
      'en': 'Forgot Password',
      'ar': '',
    },
    'uopvp3n7': {
      'en':
          'Please fill out your email below in order to receive a reset password link.',
      'ar': '',
    },
    'v3v45a9t': {
      'en': 'Email',
      'ar': '',
    },
    'bo6xkp22': {
      'en': 'Send Reset Link',
      'ar': '',
    },
    '38j4eb54': {
      'en': 'Home',
      'ar': '',
    },
  },
  // auth_create
  {
    'n4so32aa': {
      'en': 'NeuroLift',
      'ar': '',
    },
    '40420yo3': {
      'en': 'Get Started',
      'ar': '',
    },
    'wpbbuflh': {
      'en': 'Create an account by using the form below.',
      'ar': '',
    },
    'sxz6nnim': {
      'en': 'Email',
      'ar': '',
    },
    '5pduqycz': {
      'en': 'Password',
      'ar': '',
    },
    'u8d6qepq': {
      'en': 'Confirm Password',
      'ar': '',
    },
    'afm0rxej': {
      'en': 'Field is required',
      'ar': '',
    },
    'znmybrvv': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'pmaeqnbt': {
      'en': 'Field is required',
      'ar': '',
    },
    'gqa4mpv7': {
      'en': '',
      'ar': '',
    },
    'xg489t4l': {
      'en': '',
      'ar': '',
    },
    '1lj4hbho': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'thh0tion': {
      'en': 'Sign Up',
      'ar': '',
    },
    'tlfk783e': {
      'en': 'Or sign in with',
      'ar': '',
    },
    'mn79752q': {
      'en': 'Continue with Google',
      'ar': '',
    },
    'feq5s7yl': {
      'en': 'Home',
      'ar': '',
    },
  },
  // CodeCard
  {
    'rsjib220': {
      'en': 'Copy',
      'ar': '',
    },
  },
  // Drawer
  {
    'xp10swnv': {
      'en': 'Chats',
      'ar': '',
    },
  },
  // AddAPIKey
  {
    'mk1qwy55': {
      'en': 'Add Your API Key',
      'ar': '',
    },
    '27t2v6va': {
      'en': 'Find your OpenAI key at ',
      'ar': '',
    },
    'sdck9a4d': {
      'en': 'https://platform.openai.com/api-keys',
      'ar': '',
    },
    '08v2347i': {
      'en': 'Find your OpenAI key at https://platform.openai.com/api-keys',
      'ar': '',
    },
    '35b3w6kj': {
      'en': 'sk-proj-***',
      'ar': '',
    },
    '8f1re2km': {
      'en': 'Get Started',
      'ar': '',
    },
  },
  // EmailCard
  {
    'm77uzwia': {
      'en': 'EMAIL',
      'ar': '',
    },
    'dyllhi5t': {
      'en': 'To',
      'ar': '',
    },
    '5ba2hwac': {
      'en': 'Subject',
      'ar': '',
    },
    'kf7etwzj': {
      'en': 'Send',
      'ar': '',
    },
  },
  // EmptyMessages
  {
    'l6qgwjko': {
      'en': 'Start a conversation',
      'ar': '',
    },
  },
  // BannerCard
  {
    'lv3cfkkj': {
      'en': 'Details',
      'ar': '',
    },
  },
  // emptyList
  {
    'pw5jj6qj': {
      'en': 'Ai Chat Active!',
      'ar': '',
    },
    'o5q249ou': {
      'en':
          'IMPORTANT!!! Need to do:\nGo to the action below and update your API Key in order for this chat to function.\n\nYou can get an API key at:',
      'ar': '',
    },
    'yfq8e3da': {
      'en': 'https://platform.openai.com',
      'ar': '',
    },
    'vjo22ddd': {
      'en': 'Watch Tutorial',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'v38l4smy': {
      'en':
          'We use the camera to allow the user to take a photo and upload it in a message to the AI model.',
      'ar': '',
    },
    'k139w4cv': {
      'en':
          'We use the camera to allow the user to select a photo from their camera roll to upload it to the AI model.',
      'ar': '',
    },
    'hxqrimh6': {
      'en': 'We use the user\'s microphone to transcribe audio into text.',
      'ar': '',
    },
    '0x2pt37d': {
      'en': '',
      'ar': '',
    },
    '2b7cruy6': {
      'en': '',
      'ar': '',
    },
    '8xxuqb9i': {
      'en': '',
      'ar': '',
    },
    'on40jzhv': {
      'en': '',
      'ar': '',
    },
    '440qbn32': {
      'en': '',
      'ar': '',
    },
    'ahlyvnte': {
      'en': '',
      'ar': '',
    },
    'cf18ss3w': {
      'en': '',
      'ar': '',
    },
    'rz2pbnnj': {
      'en': '',
      'ar': '',
    },
    '3l5pt7gr': {
      'en': '',
      'ar': '',
    },
    'xq5632qy': {
      'en': '',
      'ar': '',
    },
    's8g7zhva': {
      'en': '',
      'ar': '',
    },
    'x8cijcg2': {
      'en': '',
      'ar': '',
    },
    'xdqr6kvh': {
      'en': '',
      'ar': '',
    },
    '8u3qqjl4': {
      'en': '',
      'ar': '',
    },
    'cnpaqtdy': {
      'en': '',
      'ar': '',
    },
    'uu5gbih9': {
      'en': '',
      'ar': '',
    },
    '63ctv6sp': {
      'en': '',
      'ar': '',
    },
    'bjgy8653': {
      'en': '',
      'ar': '',
    },
    'dwuam4aa': {
      'en': '',
      'ar': '',
    },
    'b4jxcwxo': {
      'en': '',
      'ar': '',
    },
    'v5vfh31q': {
      'en': '',
      'ar': '',
    },
    '8q1j9hc5': {
      'en': '',
      'ar': '',
    },
    'rd27n9su': {
      'en': '',
      'ar': '',
    },
    '2a30o47r': {
      'en': '',
      'ar': '',
    },
    '8kc5iea5': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
