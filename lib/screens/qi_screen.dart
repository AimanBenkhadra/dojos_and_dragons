import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';

import '../model/ability.dart';
import '../model/skills.dart';
import '../widgets/drawer_adventurer.dart';
import '../widgets/skill_item.dart';

class QiScreen extends StatefulWidget {
  static const routeName = '/qi';
  @override
  State<QiScreen> createState() => _QiScreenState();
}

class _QiScreenState extends State<QiScreen> {
  var _pageIndex = 3;
  final _pageNames = [
    'Push Qi',
    'Pull Qi',
    'Flex Qi',
    'Qi',
    'Stam Qi',
    'Core Qi',
    'Legs Qi',
  ];
  final _pageAbilities = [
    [Ability.push],
    [Ability.pull],
    [Ability.flex],
    Ability.values,
    [Ability.stam],
    [Ability.core],
    [Ability.legs],
  ];

  @override
  Widget build(BuildContext context) {
    final List<TabItem> _tabItems = [
      TabItem(
          icon: const Icon(
            Icons.push_pin,
            color: Colors.white,
          ),
          activeIcon: Icon(
            Icons.push_pin,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: 'push'),
      TabItem(
          icon: const Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.white,
          ),
          activeIcon: Icon(
            Icons.arrow_right_alt_sharp,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: 'pull'),
      TabItem(
          icon: const Icon(
            Icons.terrain_rounded,
            color: Colors.white,
          ),
          activeIcon: Icon(
            Icons.terrain_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: 'flex'),
      TabItem(
          icon: const Icon(
            Icons.fireplace,
            color: Colors.white,
          ),
          activeIcon: Icon(
            Icons.fireplace,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: 'qi'),
      TabItem(
          icon: const Icon(
            Icons.air,
            color: Colors.white,
          ),
          activeIcon: Icon(
            Icons.air,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: 'stam'),
      TabItem(
          icon: const Icon(
            Icons.radio_button_checked_rounded,
            color: Colors.white,
          ),
          activeIcon: Icon(
            Icons.radio_button_checked_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: 'core'),
      TabItem(
          icon: const Icon(
            Icons.horizontal_split_rounded,
            color: Colors.white,
          ),
          activeIcon: Icon(
            Icons.horizontal_split_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: 'legs'),
    ];
    final skills = Provider.of<Skills>(context, listen: false).skills;
    List<Widget> _pages = [
      for (int i = 0; i < _pageNames.length; i++)
        ListView.builder(
            itemCount: skills
                .where((s) => _pageAbilities[i].contains(s.associatedAbility))
                .length,
            itemBuilder: (_, y) {
              if (skills
                  .where((s) => _pageAbilities[i].contains(s.associatedAbility))
                  .isNotEmpty)
                return SkillItem(skills
                    .where(
                        (s) => _pageAbilities[i].contains(s.associatedAbility))
                    .toList()[y]);
              else
                return (Center(
                  child: Text('No such skill yet'),
                ));
            })
    ];
    return DefaultTabController(
      length: 7,
      initialIndex: _pageIndex,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              _pageNames[_pageIndex],
            ),
          ),
          drawer: DrawerAdventurer(),
          body: TabBarView(children: _pages),
          bottomNavigationBar: ConvexAppBar(
            onTabNotify: (ind) {
              _pageIndex = ind;
              // _tabItems[ind].i
              setState(() {});
              return true;
            },
            color: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            style: TabStyle.reactCircle,
            items: _tabItems,
            onTap: (ind) {
              _pageIndex = ind;
              setState(() {});
            },
          )),
    );
  }
}
