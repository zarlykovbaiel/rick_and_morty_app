import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/presentation/bloc/chars_bloc/chars_bloc_bloc.dart';
import 'package:rick_and_morty/presentation/theme/app_colors.dart';
import 'package:rick_and_morty/presentation/widgets/list_view_widgets.dart';
import 'package:rick_and_morty/resources/resources.dart';
import 'package:rick_and_morty/screens/chars_detail_page.dart';

class CharectersPage extends StatefulWidget {
  const CharectersPage({super.key});

  @override
  State<CharectersPage> createState() => _CharectersPageState();
}

class _CharectersPageState extends State<CharectersPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CharsBlocBloc>(context).add(GetCharsList());

    super.initState();
  }

  bool isGridView = false;
  int charsCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (val) {
                BlocProvider.of<CharsBlocBloc>(context)
                    .add(GetCharsList(name: val));
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: SvgPicture.asset(AppSvgs.search),
                  onPressed: () {},
                ),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(AppSvgs.filter),
                  onPressed: () {},
                ),
                hintText: 'Найти персонажа',
                hintStyle: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: 0.44,
                ),
                fillColor: AppColors.darkTextFieldColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.darkTextFieldColor,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              controller: controller,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Text(
                  'ВСЕГО ПЕРСОНАЖЕЙ 200',
                  style: TextStyle(
                    color: AppColors.darkTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.60,
                    letterSpacing: 1.50,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      isGridView = !isGridView;
                      setState(() {});
                    },
                    icon: SvgPicture.asset(
                        isGridView ? AppSvgs.bullet : AppSvgs.grid))
              ],
            ),
            BlocBuilder<CharsBlocBloc, CharsBlocState>(
              builder: (context, state) {
                if (state is CharsSucces) {
                  return isGridView
                      ? Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.model.results?.length ?? 0,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 0.8),
                              itemBuilder: (context, index) => GridViewWidget(
                                  characters: state.model.results?[index] ??
                                      MyCharacterss())),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.model.results?.length ?? 0,
                            itemBuilder: (context, index) => ListViewWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CharsDetailPage(
                                      data: state.model.results?[index] ??
                                          MyCharacterss(),
                                    ),
                                  ),
                                );
                              },
                              characters: state.model.results?[index] ??
                                  MyCharacterss(),
                            ),
                          ),
                        );
                }
                if (state is CharsError) {
                  return Center(
                      child: Column(
                    children: [
                      Image.asset(
                        AppPngs.notFound,
                        width: 250,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      const Text(
                        'Персонаж с таким именем не найден',
                        style: TextStyle(
                          color: Color(0xff5B6975),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ],
                  ));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required this.characters,
  });

  final MyCharacterss characters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(characters.image ?? ''),
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          characters.status ?? '',
          style: TextStyle(
            color: characters.status == 'Alive' ? Colors.green : Colors.red,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            height: 1.60,
            letterSpacing: 1.50,
          ),
        ),
        Text(
          characters.name ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            height: 1.60,
            letterSpacing: 1.50,
          ),
        ),
        Text(
          '${characters.species}, ${characters.gender}',
          style: const TextStyle(
            color: Color(0xff6E798C),
            fontSize: 10,
            fontWeight: FontWeight.w500,
            height: 1.60,
            letterSpacing: 1.50,
          ),
        ),
      ],
    );
  }
}
