// Converts the JSON text returned by the Wikipedia API into Dart objects.
import 'dart:convert';
// Provides HttpException, which we use when the API request fails.
import 'dart:io';

// Flutter's Material Design widgets, such as Scaffold, AppBar, and Text.
import 'package:flutter/material.dart';
// The http package provides the get() function for making web requests.
import 'package:http/http.dart';

// Our own model class that knows how to read a Wikipedia summary from JSON.
import 'summary.dart';

// Every Flutter app starts by calling runApp with its root widget.
void main() {
  runApp(const MainApp());
}

// StatelessWidget means this widget does not store changing UI state itself.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Material 3 gives the app modern components, spacing, and typography.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ArticleView(),
    );
  }
}

// The model is responsible for getting data. Keeping API code here prevents
// the widgets from needing to know how Wikipedia's web service works.
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    // Uri.https safely builds this URL from a host and a path.
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );

    // await pauses this method until Wikipedia sends back a response.
    final response = await get(uri);

    // HTTP status code 200 means the request succeeded.
    if (response.statusCode != 200) {
      throw const HttpException('Failed to update resource');
    }

    // The response body is JSON text. jsonDecode turns it into a Map, which
    // Summary.fromJson then converts into our strongly typed Summary object.
    return Summary.fromJson(jsonDecode(response.body) as Map<String, Object?>);
  }
}

// ChangeNotifier can notify widgets when its data changes. This class holds
// the current article, loading state, and any error from the API request.
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  // ? means these values are allowed to be null because they may not exist yet.
  Summary? summary;
  Exception? error;
  bool isLoading = false;

  ArticleViewModel(this.model) {
    // Start loading an article when the view model is created.
    fetchArticle();
  }

  Future<void> fetchArticle() async {
    // Tell the UI to show a loading indicator before starting the request.
    isLoading = true;
    notifyListeners();

    try {
      summary = await model.getRandomArticleSummary();
      // ! is the null-assertion operator. At this point the request succeeded,
      // so summary is expected to contain an article.
      // print('Article loaded: ${summary!.titles.normalized}');
      error = null;
    } on HttpException catch (e) {
      // If the request fails, save the exception so the UI can display it.
      // print('Error loading article: ${e.message}');
      error = e;
      summary = null;
    }

    // The request is finished, so the UI can stop showing the spinner and
    // display either the article or the error.
    isLoading = false;
    notifyListeners();
  }
}

// StatefulWidget is used because this screen observes changing article data.
class ArticleView extends StatefulWidget {
  const ArticleView({super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  void initState() {
    super.initState();
    // initState runs once when this screen is inserted into the widget tree.
    viewModel.fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 24,
        title: Row(
          children: [
            Icon(Icons.menu_book_rounded, color: colorScheme.primary),
            const SizedBox(width: 10),
            const Text(
              'WikiDiscover',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Load another article',
            onPressed: viewModel.isLoading ? null : viewModel.fetchArticle,
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 12),
        ],
      ),
      // ListenableBuilder rebuilds its contents whenever viewModel calls
      // notifyListeners(). This keeps the screen synchronized with the data.
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          // Pattern matching chooses which UI to show based on three values:
          // loading state, article data, and error data.
          return switch ((
            viewModel.isLoading,
            viewModel.summary,
            viewModel.error,
          )) {
            // _ means "any value"; while loading, show a centered spinner.
            (true, _, _) => const _LoadingView(),
            // If there is an exception, show a friendly recovery message.
            (_, _, final Exception e) => _ErrorView(
              error: e,
              onRetry: viewModel.fetchArticle,
            ),
            // summary? matches a non-null Summary and unwraps it into summary.
            (_, final summary?, _) => ArticlePage(
              summary: summary,
              nextArticleCallback: viewModel.fetchArticle,
            ),
            // A fallback for an unexpected combination of states.
            _ => const Text('something went wrong'),
          };
        },
      ),
    );
  }
}

// This widget lays out the current article and the button for loading another.
// It is stateless because the changing data is owned by ArticleViewModel.
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });

  final Summary summary;
  // VoidCallback is a function that takes no arguments and returns nothing.
  final VoidCallback nextArticleCallback;

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder lets the page use more width on a desktop browser while
    // keeping the reading column comfortable on larger screens.
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth > 820
            ? 760.0
            : constraints.maxWidth;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PageIntro(summary: summary),
                  const SizedBox(height: 20),
                  ArticleWidget(summary: summary),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    // Pass the callback without parentheses. Flutter calls it
                    // when the user taps the button.
                    onPressed: nextArticleCallback,
                    icon: const Icon(Icons.auto_awesome_rounded),
                    label: const Text('Discover another article'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PageIntro extends StatelessWidget {
  const _PageIntro({required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A moment of discovery',
          style: textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          summary.titles.normalized,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        if (summary.description != null) ...[
          const SizedBox(height: 8),
          Text(
            summary.description!,
            style: textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Finding something interesting…',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});

  final Exception error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 56, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'We couldn’t load an article',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Check your connection and try again.\n$error',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

// Displays the individual pieces of an article: image, title, description,
// and the main extract text.
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.zero,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: colorScheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The image is only created when the article contains an image.
            if (summary.hasImage)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  summary.originalImage!.source,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 48,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
              child: Text(
                // The extract is the main summary text returned by Wikipedia.
                summary.extract,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.65,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
