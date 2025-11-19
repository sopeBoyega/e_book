import '../models/book.dart';

class CategoryItem {
  final String name;
  final String imagePath;

  const CategoryItem({
    required this.name,
    required this.imagePath,
  });
}

class CategoryData {
  // ------------ CATEGORY DATA ------------

  static const List<CategoryItem> categories = [
    CategoryItem(
      name: 'Non-fiction',
      imagePath: 'assets/images/category_nonfiction.png',
    ),
    CategoryItem(
      name: 'Classics',
      imagePath: 'assets/images/category_classics.png',
    ),
    CategoryItem(
      name: 'Fantasy',
      imagePath: 'assets/images/category_fantasy.png',
    ),
    CategoryItem(
      name: 'Young Adult',
      imagePath: 'assets/images/category_young_adult.png',
    ),
    CategoryItem(
      name: 'Crime',
      imagePath: 'assets/images/category_crime.png',
    ),
    CategoryItem(
      name: 'Horror',
      imagePath: 'assets/images/category_horror.png',
    ),
    CategoryItem(
      name: 'Sci-fi',
      imagePath: 'assets/images/category_scifi.png',
    ),
    CategoryItem(
      name: 'Drama',
      imagePath: 'assets/images/category_drama.png',
    ),
  ];

  // ------------ BOOKS BY CATEGORY ------------

  static final Map<String, List<Book>> booksByCategory = {
    'Non-fiction': [
      Book(
        id: 'nf1',
        title: 'The Ultimate Anxiety Free Collection',
        author: '',
        category: 'Non-fiction',
        price: '15.00',
        imagePath: 'assets/images/book6.png',
        rating: 4.3,
        description: """
This collection focuses on everyday tools for easing anxious thoughts. Each section offers short practices, breathing exercises, and journal prompts that can be done in a few minutes.

The tone stays gentle and practical, which makes it easy to pick up when your thoughts already feel loud.
""",
      ),
      Book(
        id: 'nf2',
        title: 'Mindful Mornings',
        author: 'Cara Lewis',
        category: 'Non-fiction',
        price: '18.00',
        imagePath: 'assets/images/book5.png',
        rating: 4.1,
        description: """
A short guide to building calmer morning routines. It covers simple rituals, light stretches, and ways to plan your day without stressing yourself before breakfast.

Good for readers who want structure without strict rules.
""",
      ),
      Book(
        id: 'nf3',
        title: 'Deep Work Journal',
        author: 'Evan Hart',
        category: 'Non-fiction',
        price: '19.00',
        imagePath: 'assets/images/book1.jpg',
        rating: 4.0,
        description: """
Designed as a companion notebook, this book combines short lessons about focus with guided pages for planning deep work sessions.

It suits students and creatives who want to track progress and avoid constant distraction.
""",
      ),
      Book(
        id: 'nf4',
        title: 'Pocket Guide to Better Sleep',
        author: 'Lena Ortiz',
        category: 'Non-fiction',
        price: '14.00',
        imagePath: 'assets/images/book2.png',
        rating: 4.2,
        description: """
This compact guide looks at evening habits, screen use, and simple relaxation exercises that support better sleep.

Chapters are brief and practical so you are not reading a textbook at midnight.
""",
      ),
      Book(
        id: 'nf5',
        title: 'Small Habits, Quiet Changes',
        author: 'Mara Rivera',
        category: 'Non-fiction',
        price: '17.00',
        imagePath: 'assets/images/book3.png',
        rating: 4.1,
        description: """
The book focuses on tiny daily actions rather than big life overhauls. Each chapter pairs a story with one small habit you can test that week.

It is ideal for readers who want progress to feel steady and realistic.
""",
      ),
    ],

    'Classics': [
      Book(
        id: 'cl1',
        title: 'The Picture of Dorian Gray',
        author: 'Oscar Wilde',
        category: 'Classics',
        price: '25.00',
        imagePath: 'assets/images/book1.jpg',
        rating: 4.11,
        description: """
Dorian Gray is a charming young man whose portrait ages and decays while he stays outwardly perfect. As he chases pleasure and ignores consequences, the painting records every choice he would rather forget.

Wilde mixes gothic atmosphere with sharp social commentary, creating a classic that still feels unsettling and modern.
""",
      ),
      Book(
        id: 'cl2',
        title: 'The Catcher in the Rye',
        author: 'J.D. Salinger',
        category: 'Classics',
        price: '30.00',
        imagePath: 'assets/images/book2.png',
        rating: 3.9,
        description: """
Holden Caulfield wanders New York City over a few restless days, skipping school and putting off going home. His search for honesty reveals more about his own hurt than he admits.

The novel explores grief, loneliness, and the awkward space between teenager and adult.
""",
      ),
      Book(
        id: 'cl3',
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        category: 'Classics',
        price: '22.00',
        imagePath: 'assets/images/book3.png',
        rating: 4.3,
        description: """
Elizabeth Bennet clashes with the proud Mr. Darcy while navigating family pressures and social expectations.

It is a witty romance that looks at class, first impressions, and how people slowly change their minds.
""",
      ),
      Book(
        id: 'cl4',
        title: 'Frankenstein',
        author: 'Mary Shelley',
        category: 'Classics',
        price: '21.00',
        imagePath: 'assets/images/book4.png',
        rating: 4.0,
        description: """
A scientist assembles life in a laboratory and then recoils from what he created. The story shifts between creator and creature, asking who is responsible for the damage that follows.

Perfect for readers who like early science fiction with a strong moral core.
""",
      ),
      Book(
        id: 'cl5',
        title: 'Jane Eyre',
        author: 'Charlotte Brontë',
        category: 'Classics',
        price: '24.00',
        imagePath: 'assets/images/book5.png',
        rating: 4.2,
        description: """
Jane grows up in harsh conditions and slowly carves out her own path as a governess. At Thornfield Hall she finds both independence and a complicated romance.

The novel mixes gothic mystery with a strong, steady heroine.
""",
      ),
    ],

    'Fantasy': [
      Book(
        id: 'fa1',
        title: 'Zodiac Academy',
        author: 'Caroline Peckham',
        category: 'Fantasy',
        price: '29.00',
        imagePath: 'assets/images/book4.png',
        rating: 4.4,
        description: """
At Zodiac Academy, star signs decide your power and your place. Two sisters arrive and discover they are heirs to a throne many powerful students want for themselves.

Expect cutthroat classes, elemental magic, and rivalries that blur into complicated attraction.
""",
      ),
      Book(
        id: 'fa2',
        title: 'Sorrow and Starlight',
        author: 'Caroline Peckham, Susanne Valenti',
        category: 'Fantasy',
        price: '30.00',
        imagePath: 'assets/images/book10.png',
        rating: 4.5,
        description: """
This installment pulls together years of prophecy, found family, and slow-burn tension. War finally catches up with the characters, and every choice feels like it could cost a kingdom or a relationship.

It is a strong pick if you enjoy sweeping series filled with emotion and big battles.
""",
      ),
      Book(
        id: 'fa3',
        title: 'Queen of Myth and Monsters',
        author: 'Scarlett St. Clair',
        category: 'Fantasy',
        price: '28.00',
        imagePath: 'assets/images/book11.jpg',
        rating: 4.2,
        description: """
A queen bound to ancient magic must face gods, monsters, and a marriage that blurs friend and foe. Court politics, forbidden power, and intense romance twist together as she tries to protect her people.
""",
      ),
      Book(
        id: 'fa4',
        title: 'Harry Potter and the Philosopher\'s Stone',
        author: 'J. K. Rowling',
        category: 'Fantasy',
        price: '24.00',
        imagePath: 'assets/images/book12.jpg',
        rating: 4.0,
        description: """
Harry discovers he is a wizard and leaves his ordinary life for Hogwarts School of Witchcraft and Wizardry. There he learns magic, makes friends, and uncovers a secret tied to his past.
""",
      ),
      Book(
        id: 'fa5',
        title: 'Harry Potter and the Goblet of Fire',
        author: 'J. K. Rowling',
        category: 'Fantasy',
        price: '24.00',
        imagePath: 'assets/images/book14.jpg',
        rating: 4.0,
        description: """
Harry returns to Hogwarts and is unexpectedly entered into the dangerous Triwizard Tournament. Each task is riskier than the last, and dark forces use the event to move closer to their goal.
""",
      ),
    ],

    'Young Adult': [
      Book(
        id: 'ya1',
        title: 'Nine Liars',
        author: 'Maureen Johnson',
        category: 'Young adult',
        price: '16.00',
        imagePath: 'assets/images/book3.png',
        rating: 4.0,
        description: """
Years ago, a college friend group called themselves the Nine. Two members died at a party in the woods, and the survivors have been repeating the same story ever since.

Teen detective Stevie Bell visits England and starts asking the questions no one wants to answer.
""",
      ),
      Book(
        id: 'ya2',
        title: 'Sunsets with Annie',
        author: 'Mindset',
        category: 'Young adult',
        price: '33.00',
        imagePath: 'assets/images/book5.png',
        rating: 4.2,
        description: """
Annie’s life runs on quiet routines until a sunset photography project pushes her to meet new people and try small, brave things.

It is a cozy, reflective story about friendship, gentle romance, and choosing joy on ordinary days.
""",
      ),
      Book(
        id: 'ya3',
        title: 'Hearts on the Line',
        author: 'Rae Collins',
        category: 'Young adult',
        price: '18.00',
        imagePath: 'assets/images/book2.png',
        rating: 4.1,
        description: """
Two teens bond over late-night customer service shifts and anonymous calls. As school drama grows louder, their shared headphones and quiet conversations become a lifeline.
""",
      ),
      Book(
        id: 'ya4',
        title: 'The Summer Between',
        author: 'N. K. James',
        category: 'Young adult',
        price: '19.00',
        imagePath: 'assets/images/book4.png',
        rating: 4.0,
        description: """
Set over one humid summer, this story follows friends facing university decisions, family changes, and the possibility that their group will split.

Ideal for readers who like emotional but hopeful contemporary YA.
""",
      ),
      Book(
        id: 'ya5',
        title: 'Paper Planes and Promises',
        author: 'Aisha Grant',
        category: 'Young adult',
        price: '17.00',
        imagePath: 'assets/images/book6.png',
        rating: 4.2,
        description: """
Old notes and paper planes from primary school send two classmates on a small quest to find out who started the tradition.

Along the way, they unpack friendship, crushes, and how people grow apart and back together.
""",
      ),
    ],

    'Crime': [
      Book(
        id: 'cr1',
        title: 'Nine Liars',
        author: 'Maureen Johnson',
        category: 'Crime',
        price: '20.00',
        imagePath: 'assets/images/book3.png',
        rating: 4.0,
        description: """
Labelled as an accident, the deaths at a country house party never sat quite right. Every surviving friend remembers the night differently, and small contradictions keep slipping through.

The book blends cold-case investigation with modern campus life.
""",
      ),
      Book(
        id: 'cr2',
        title: 'The Riverside Case',
        author: 'Leo Marsh',
        category: 'Crime',
        price: '19.00',
        imagePath: 'assets/images/book1.jpg',
        rating: 4.0,
        description: """
A body found by the river pulls a tired detective back into a case that echoes his first big investigation. New evidence suggests the earlier verdict missed something important.

Great for readers who enjoy slow, steady police procedurals.
""",
      ),
      Book(
        id: 'cr3',
        title: 'Silent Witnesses',
        author: 'Kyra Holden',
        category: 'Crime',
        price: '21.00',
        imagePath: 'assets/images/book2.png',
        rating: 4.1,
        description: """
A forensic specialist notices patterns that link several unrelated crimes. When she speaks up, she finds herself caught between office politics and a clever killer.

It balances lab work, field work, and personal stakes.
""",
      ),
      Book(
        id: 'cr4',
        title: 'The Thursday Street Club',
        author: 'Helen Porter',
        category: 'Crime',
        price: '18.00',
        imagePath: 'assets/images/book4.png',
        rating: 4.2,
        description: """
A group of retirees meets weekly to discuss fictional mysteries until a real one appears on their doorstep. Their small clues and local knowledge start to outpace the official investigation.
""",
      ),
      Book(
        id: 'cr5',
        title: 'Broken Alibis',
        author: 'Samir Khan',
        category: 'Crime',
        price: '20.00',
        imagePath: 'assets/images/book5.png',
        rating: 4.0,
        description: """
A defense lawyer discovers that a client’s solid alibi rests on a lie. Digging deeper forces him to revisit an old case he would rather forget.
""",
      ),
    ],

    'Horror': [
      Book(
        id: 'ho1',
        title: 'Dark Corners',
        author: 'E. L. Marrow',
        category: 'Horror',
        price: '18.00',
        imagePath: 'assets/images/book3.png',
        rating: 4.1,
        description: """
An old boarding house promises cheap rent and a fresh start, but the rooms do not stay quiet at night. Strange symbols, whispered conversations behind thin walls, and gaps in the building’s history hint at something watching the tenants.
""",
      ),
      Book(
        id: 'ho2',
        title: 'The Haunting of Ashwood House',
        author: 'Cara Bell',
        category: 'Horror',
        price: '19.00',
        imagePath: 'assets/images/book1.jpg',
        rating: 4.0,
        description: """
A family moves into a countryside estate and discovers locked rooms, cold spots, and local stories that never quite line up.

Perfect for readers who like classic haunted house scares.
""",
      ),
      Book(
        id: 'ho3',
        title: 'Whispers in the Walls',
        author: 'Jonas Pike',
        category: 'Horror',
        price: '17.00',
        imagePath: 'assets/images/book2.png',
        rating: 3.9,
        description: """
Residents of an apartment block share stories about strange sounds, missing time, and shapes seen in the stairwell. Each chapter adds another piece to the building’s strange history.
""",
      ),
      Book(
        id: 'ho4',
        title: 'Night Shift Stories',
        author: 'Mira Gould',
        category: 'Horror',
        price: '16.00',
        imagePath: 'assets/images/book4.png',
        rating: 4.1,
        description: """
A set of connected short stories about workers who keep odd hours: security guards, cleaners, and late-night drivers. Some shifts end quietly, others do not.

Good for readers who like bite-sized scares.
""",
      ),
      Book(
        id: 'ho5',
        title: 'The Orchard at Dusk',
        author: 'Valerie Knox',
        category: 'Horror',
        price: '18.00',
        imagePath: 'assets/images/book5.png',
        rating: 4.0,
        description: """
A small town orchard hides a long history of disappearances. Teen volunteers start seeing figures between the trees and hearing names on the wind that no one has mentioned in years.
""",
      ),
    ],

    'Sci-fi': [
      Book(
        id: 'sf1',
        title: 'Stars Beyond Atlas',
        author: 'J. K. Rowan',
        category: 'Sci-fi',
        price: '24.00',
        imagePath: 'assets/images/book7.png',
        rating: 4.0,
        description: """
A small exploration crew jumps to the edge of mapped space and finds a station that should not exist. The AI running it claims to know each of them already and offers everything humanity has ever wanted.
""",
      ),
      Book(
        id: 'sf2',
        title: 'Signal in the Dark',
        author: 'Reid Morgan',
        category: 'Sci-fi',
        price: '23.00',
        imagePath: 'assets/images/book1.jpg',
        rating: 4.1,
        description: """
A deep-space listening post receives a repeating signal that seems to answer back. As the crew investigates, their own systems start to behave oddly.

Perfect if you like quiet, tense space stories.
""",
      ),
      Book(
        id: 'sf3',
        title: 'Orbit Crashers',
        author: 'L. T. Green',
        category: 'Sci-fi',
        price: '20.00',
        imagePath: 'assets/images/book2.png',
        rating: 3.9,
        description: """
A team of salvage pilots cleans up broken satellites and abandoned stations around Earth. One job uncovers evidence of a cover-up that could change who controls orbit.
""",
      ),
      Book(
        id: 'sf4',
        title: 'The Long Way Home',
        author: 'Nova Ellis',
        category: 'Sci-fi',
        price: '22.00',
        imagePath: 'assets/images/book4.png',
        rating: 4.2,
        description: """
After a failed mission, a scattered crew has to cross hostile territory to reach a jump gate. The journey forces them to confront past decisions and old grudges.
""",
      ),
      Book(
        id: 'sf5',
        title: 'City of Glass Towers',
        author: 'Imani Cole',
        category: 'Sci-fi',
        price: '21.00',
        imagePath: 'assets/images/book5.png',
        rating: 4.0,
        description: """
Set in a vertical megacity, this story follows a courier who smuggles data chips between districts. A routine delivery drags her into a conflict between rebel hackers and a polished corporate council.
""",
      ),
    ],

    'Drama': [
      Book(
        id: 'dr1',
        title: 'Stage Lights',
        author: 'Amelia Cross',
        category: 'Drama',
        price: '21.00',
        imagePath: 'assets/images/book5.png',
        rating: 4.1,
        description: """
A struggling city theatre pins its hopes on one last production. The story follows actors, crew, and the exhausted director as they juggle day jobs, family drama, and the risk of losing their beloved stage.
""",
      ),
      Book(
        id: 'dr2',
        title: 'The Summer We Stayed',
        author: 'Holly Byrne',
        category: 'Drama',
        price: '19.00',
        imagePath: 'assets/images/book2.png',
        rating: 4.0,
        description: """
A group of friends returns to their coastal hometown for one last shared summer. Old arguments, new crushes, and family expectations complicate their plans.
""",
      ),
      Book(
        id: 'dr3',
        title: 'A Quiet Storm',
        author: 'Dev Patel',
        category: 'Drama',
        price: '20.00',
        imagePath: 'assets/images/book3.png',
        rating: 4.1,
        description: """
Told across several family members, this novel explores how one decision ripples through parents, siblings, and children over a single week.
""",
      ),
      Book(
        id: 'dr4',
        title: 'Broken Strings',
        author: 'Lea Chang',
        category: 'Drama',
        price: '18.00',
        imagePath: 'assets/images/book4.png',
        rating: 4.0,
        description: """
A violinist faces a hand injury that threatens her career. While she waits for answers, she reconnects with friends and tries to imagine a life that looks different from her plans.
""",
      ),
      Book(
        id: 'dr5',
        title: 'Midnight at the River',
        author: 'Jon Rivera',
        category: 'Drama',
        price: '19.00',
        imagePath: 'assets/images/book1.jpg',
        rating: 4.1,
        description: """
Set over one long night at a riverside café, several strangers cross paths and slowly reveal why they are all avoiding home.

The story leans on dialogue, quiet moments, and small acts of kindness.
""",
      ),
    ],
  };

  // ------------ ALL BOOKS (FOR SEARCH) ------------

  static List<Book> get allBooks {
    return booksByCategory.values.expand((list) => list).toList();
  }
}
