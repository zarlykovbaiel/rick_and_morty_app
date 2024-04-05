import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/models/episode_model.dart';
import 'package:rick_and_morty/presentation/bloc/episode_bloc/episode_bloc.dart';
import 'package:rick_and_morty/presentation/theme/app_colors.dart';

class CharsDetailPage extends StatefulWidget {
  const CharsDetailPage({super.key, required this.data});

  final MyCharacterss data;

  @override
  State<CharsDetailPage> createState() => _CharsDetailPageState();
}

class _CharsDetailPageState extends State<CharsDetailPage> {
  List<EpisodeModel> episodeData = [];

  void getData() {
    for (int i = 0; i < widget.data.episode!.length; i++) {
      BlocProvider.of<EpisodeBloc>(context).add(
        GetEpisodeEvent(url: widget.data.episode?[i] ?? ''),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        height: 218,
                        widget.data.image ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 218,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xff0B1E2D).withOpacity(0.65)),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    widget.data.name ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                        height: 1.18,
                        letterSpacing: 0.25),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.data.status ?? '',
                    style: const TextStyle(
                        color: Color(0xff42D048),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: 1.60,
                        letterSpacing: 1.60),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.data.url ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: 0.50),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      DataWidget(
                          title: 'Пол', subTitle: widget.data.gender ?? ''),
                      const Spacer(),
                      DataWidget(
                          title: 'Расса', subTitle: widget.data.species ?? ''),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              DataWidget(
                                  title: 'Место рождение',
                                  subTitle: widget.data.origin?.name ?? '')
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              DataWidget(
                                  title: 'Местоположение',
                                  subTitle: widget.data.location?.name ?? '')
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  const Divider(
                    height: 5,
                    color: Color(0xff152A3A),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Эпизоды',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                              letterSpacing: 0.15),
                        ),
                        Spacer(),
                        Text(
                          ' Все Эпизоды',
                          style: TextStyle(
                              color: Color(0xff5B6975),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                              letterSpacing: 0.50),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.data.episode?.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          // data.episode,
                          //   style: TextStyle(
                          //       color: Color(0xff5B6975),
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.w400,
                          //       height: 1.60,
                          //       letterSpacing: 0.50),
                          // ),
                          Text(
                            widget.data.episode?[index] ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: episodeData.length,
                    itemBuilder: (context, index) => Text(
                      episodeData[index].name ?? '',
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 138,
              left: MediaQuery.of(context).size.width / 2 - 73,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: AppColors.darkBgColor,
                child: CircleAvatar(
                  radius: 73,
                  backgroundImage: NetworkImage(widget.data.image ?? ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  const DataWidget({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Color(0xff5B6975),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.33,
              letterSpacing: 0.50),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          subTitle,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.43,
              letterSpacing: 0.25),
        ),
      ],
    );
  }
}
