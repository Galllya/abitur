import 'dart:async';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      /// вызываем загрузку следующей страницы;
    }
  }

  /// проверяем на достижения нижней позиции скролла
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          /// выводим индикатор загрузки, если индекс выходит за длину массива
          if (index >= listWithElements.length)
            return const LoadingIndicator();

          final element =
          listWithElements.elementAt(index);
          return Widget();
        },
        separatorBuilder: (context, index) =>
        const SizedBox(height: 16),
        itemCount:
        ? // число элементов списка равно числу элементов в списке(данных)
        : // число элементов списка равно числу элементов в списке(данных) плюс один, чтобы вывести индикатор загрузки,
    );
  }
}
