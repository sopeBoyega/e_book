import '../models/book.dart';

class HomeData {
  // ---------------- BEST DEALS ----------------
  static final List<Book> bestDeals = [
    Book(
      id: 'deal1',
      title: 'Sunsets with Annie',
      author: 'Mindset',
      category: 'Novel',
      price: '33.00',
      imagePath: 'assets/images/book5.png',
      rating: 4.2,
      description: """
Annie has always measured her life in small routines and quiet habits. When a chance encounter pulls her into a sunset photography project, she meets strangers who slowly become the community she did not know she needed.

The story follows her as she learns to step outside her comfort zone, confront old fears, and choose joy instead of just getting through the day. With gentle humor and soft romance, this novel leans into second chances, cozy evenings, and the kind of friendships that feel like home.""",
    ),
    Book(
      id: 'deal2',
      title: 'Zodiac Academy',
      author: 'Caroline Peckham',
      category: 'Fantasy',
      price: '29.00',
      imagePath: 'assets/images/book4.png',
      rating: 4.4,
      description: """
At Zodiac Academy, the sky does not just hold stars, it decides your fate. Rival heirs, dangerous magic classes, and cutthroat competitions push every student to prove they deserve the power written in their birth chart.

Two siblings arrive and discover that the throne they never knew about is now theirs to fight for. Alliances shift, enemies flirt, and every test seems designed to break them or make them ruthless. Readers who enjoy intense academy drama, elemental magic, and slow-burn tension will feel right at home here.""",
    ),
    Book(
      id: 'deal3',
      title: 'The Picture of Dorian Gray',
      author: 'Oscar Wilde',
      category: 'Fiction',
      price: '23.00',
      imagePath: 'assets/images/book1.jpg',
      rating: 4.11,
      description: """
Dorian Gray begins as a charming young man who is almost painfully beautiful. After a fateful conversation about youth and pleasure, he wishes his portrait would age in his place so he can stay flawless forever. The wish comes true, and the painting quietly records every cruel decision and selfish act he makes.

Wilde weaves a gothic tale about vanity, influence, and the cost of chasing every desire. The more Dorian hides his portrait, the more he must lie to protect the life he built on appearances. It is a classic that still feels sharp and unsettling, especially for readers curious about how far someone will go to keep a perfect surface.""",
    ),
    Book(
      id: 'deal4',
      title: 'Nine Liars',
      author: 'Maureen Johnson',
      category: 'Mystery',
      price: '20.00',
      imagePath: 'assets/images/book3.png',
      rating: 4.0,
      description: """
Years ago, a group of friends spent a wild night at a country house party that ended with two of them dead in the woods. The survivors called it a tragic accident, but small details never fully lined up.

When teen detective Stevie Bell visits England, she is drawn into the old case and starts poking at the stories each friend has repeated for years. Secret relationships, jealousies, and carefully edited memories begin to surface. Fans of puzzly mysteries, boarding school vibes, and clever dialogue will enjoy watching Stevie untangle which of the nine liars is hiding the truth.""",
    ),
    Book(
      id: 'deal5',
      title: 'The Ultimate Anxiety Free Collection',
      author: '',
      category: 'Non-fiction',
      price: '15.00',
      imagePath: 'assets/images/book6.png',
      rating: 4.3,
      description: """
This collection brings together simple practices, mindset shifts, and short reflections aimed at easing day-to-day anxiety. Each section focuses on a different part of life, such as work stress, social worries, and nighttime overthinking.

You will find breathing exercises, grounding techniques, and journal prompts that can be done in a few minutes. The tone stays calm and reassuring rather than clinical, which makes it kind to pick up when your thoughts already feel loud. It is a practical companion for readers who want small, realistic tools instead of long lectures.""",
    ),
  ];

  // ---------------- TOP BOOKS: THIS WEEK ----------------
  static final List<Book> topBooksThisWeek = [
    Book(
      id: 'top1',
      title: 'The Picture of Dorian Gray',
      author: 'Oscar Wilde',
      category: 'Gothic fiction',
      price: '25.00',
      imagePath: 'assets/images/book1.jpg',
      rating: 4.11,
      description: """
In this classic, Dorian Gray’s portrait grows older and more twisted as he stays outwardly young. The novel moves between elegant drawing rooms, bohemian studios, and late-night streets where Dorian tests how far he can go without consequences.

Wilde mixes dark humor with social criticism, questioning what society praises and what it quietly ignores. It is a great pick if you like gothic atmosphere, morally gray characters, and stories that linger long after you close the book.""",
    ),
    Book(
      id: 'top2',
      title: 'The Catcher in the Rye',
      author: 'J.D. Salinger',
      category: 'Classics',
      price: '30.00',
      imagePath: 'assets/images/book2.png',
      rating: 3.9,
      description: """
Holden Caulfield wanders New York City over a few days, skipping school, avoiding home, and looking for someone who actually feels honest. His voice is sharp, sarcastic, and often softer than he wants you to notice.

The book looks at grief, loneliness, and the strange moment between being a teenager and becoming an adult. Readers who enjoy character-driven stories and stream-of-consciousness narration usually find a lot to unpack in Holden’s complaints and quiet hopes.""",
    ),
    Book(
      id: 'top3',
      title: 'Zodiac Academy',
      author: 'Caroline Peckham',
      category: 'Fantasy',
      price: '29.00',
      imagePath: 'assets/images/book4.png',
      rating: 4.4,
      description: """
Set in a brutal magical school ruled by star signs, Zodiac Academy throws its characters into dangerous classes, deadly trials, and tangled romances.

It is ideal for readers who enjoy academy fantasy, elemental powers, and rivalries that come with just as much attraction as danger.""",
    ),
    Book(
      id: 'top4',
      title: 'Sunsets with Annie',
      author: 'Mindset',
      category: 'Novel',
      price: '33.00',
      imagePath: 'assets/images/book5.png',
      rating: 4.2,
      description: """
A quiet photography project turns into a season of small, brave choices for Annie. Along the way she builds new friendships and rethinks what a happy life could look like.

This one suits readers who enjoy soft, reflective contemporary stories with cozy vibes and gentle romance.""",
    ),
  ];

  // ---------------- TOP BOOKS: THIS MONTH ----------------
  static final List<Book> topBooksThisMonth = [
    Book(
      id: 'tm1',
      title: 'Sorrow and Starlight',
      author: 'Caroline Peckham, Susanne Valenti',
      category: 'Fantasy',
      price: '30.00',
      imagePath: 'assets/images/book10.png',
      rating: 4.5,
      description: """
This installment brings together years of slow-building tension, tangled prophecies, and shifting loyalties. War finally crashes into the characters’ lives, forcing them to choose what and who they are willing to fight for.

Expect sweeping battles, emotional confrontations, and quieter moments where found family bonds are tested and strengthened.""",
    ),
    Book(
      id: 'tm2',
      title: 'Queen of Myth and Monsters',
      author: 'Scarlett St. Clair',
      category: 'Fantasy',
      price: '28.00',
      imagePath: 'assets/images/book11.jpg',
      rating: 4.2,
      description: """
A queen bound to an ancient prophecy must keep her kingdom safe while navigating gods, monsters, and a complicated royal marriage. Court intrigue mixes with myth-inspired magic and intense romance.

Readers who enjoy lush fantasy settings and morally complex leads will find plenty to sink into here.""",
    ),
    Book(
      id: 'tm3',
      title: 'The Ultimate Anxiety Free Collection',
      author: '',
      category: 'Non-fiction',
      price: '15.00',
      imagePath: 'assets/images/book6.png',
      rating: 4.3,
      description: """
Short, approachable chapters walk through everyday tools for calming anxious thoughts. Each section focuses on realistic habits instead of dramatic overnight changes.

It works well as a bedside or bag companion for readers who want small reminders they can actually use on busy days.""",
    ),
  ];

  // ---------------- TOP BOOKS: THIS YEAR ----------------
  static final List<Book> topBooksThisYear = [
    Book(
      id: 'ty1',
      title: 'Nine Liars',
      author: 'Maureen Johnson',
      category: 'Mystery',
      price: '20.00',
      imagePath: 'assets/images/book3.png',
      rating: 4.0,
      description: """
An old party, two deaths in the woods, and a group of friends who have been repeating the same story for years. Stevie Bell’s arrival forces them to retell the night, and small cracks start to appear.

It is witty, twisty, and perfect if you like amateur sleuths digging into decades-old secrets.""",
    ),
    Book(
      id: 'ty2',
      title: 'Harry Potter and the Philosopher\'s Stone',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '24.00',
      imagePath: 'assets/images/book12.jpg',
      rating: 4.0,
      description: """
Harry discovers he is a wizard and leaves his ordinary life for Hogwarts School of Witchcraft and Wizardry. As he learns magic with new friends, he uncovers secrets about his past and faces a dark presence that threatens the wizarding world.
""",
    ),
    Book(
      id: 'ty3',
      title: 'Harry Potter and the Deathly Hallows',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '21.00',
      imagePath: 'assets/images/book13.jpg',
      rating: 4.1,
      description: """
Harry, Ron, and Hermione hunt down Voldemort’s Horcruxes while the wizarding world crumbles around them. Old mysteries resolve, loyalties are tested, and a final battle decides the future of Hogwarts and everyone Harry cares about.
""",
    ),

  ];

  // ---------------- LATEST BOOKS ----------------
  static final List<Book> latestBooks = [
    Book(
      id: 'latest1',
      title: 'Nine Liars',
      author: 'Maureen Johnson',
      category: 'Young adult',
      price: '16.00',
      imagePath: 'assets/images/book3.png',
      rating: 4.0,
      description: """
Stevie Bell’s latest case takes her to London, where a decades-old game of hide-and-seek ended in real tragedy. A college friend group once called themselves the Nine, and they have been telling the same version of that night ever since.

As Stevie interviews them one by one, she spots gaps, nervous jokes, and details that do not quite match. Between sightseeing, school stress, and relationship drama, she keeps circling back to one question: if it was an accident, why is everyone still so afraid of what comes out?""",
    ),
    Book(
      id: 'latest2',
      title: 'Sorrow and Starlight',
      author: 'Caroline Peckham, Susanne Valenti',
      category: 'Fantasy',
      price: '30.00',
      imagePath: 'assets/images/book10.png',
      rating: 4.5,
      description: """
This installment brings together years of slow-building tension, tangled prophecies, and shifting loyalties. The main characters stand on the edge of a war that has been hinted at for several books, with kingdoms, families, and soul-deep bonds all at risk.

Expect emotional confrontations, big magical set pieces, and quiet scenes where characters finally say what has been left unspoken.""",
    ),
    Book(
      id: 'latest3',
      title: 'Sunsets with Annie',
      author: 'Mindset',
      category: 'Young adult',
      price: '33.00',
      imagePath: 'assets/images/book5.png',
      rating: 4.2,
      description: """
A sunset photography challenge nudges Annie into new friendships and small, steady acts of courage. Each photo session chips away at the idea that her life has to stay small to feel safe.

It is a comforting, reflective read if you enjoy stories about finding community and gently rewriting your routine.""",
    ),
    Book(
      id: 'latest4',
      title: 'The Ultimate Anxiety Free Collection',
      author: '',
      category: 'Non-fiction',
      price: '15.00',
      imagePath: 'assets/images/book6.png',
      rating: 4.3,
      description: """
Designed for quick dips rather than long study sessions, this collection offers prompts, breathing exercises, and reframes you can try in under ten minutes.

It works nicely for readers who keep a book close for reassurance on busy, stressful days.""",
    ),
  ];

  // ---------------- UPCOMING BOOKS ----------------
  static final List<Book> upcomingBooks = [
    Book(
      id: 'upcoming1',
      title: 'Queen of Myth and Monsters',
      author: 'Scarlett St. Clair',
      category: 'Fantasy',
      price: '28.00',
      imagePath: 'assets/images/book11.jpg',
      rating: 4.2,
      description: """
A queen bound to an ancient prophecy must navigate gods, monsters, and a love story that mixes duty with real feeling. As political tensions rise, every choice she makes echoes through the kingdom.

It balances intense romance, divine magic, and court intrigue for readers who like their fantasy bold and emotional.""",
    ),
    Book(
      id: 'upcoming2',
      title: 'Sorrow and Starlight',
      author: 'Caroline Peckham, Susanne Valenti',
      category: 'Fantasy',
      price: '30.00',
      imagePath: 'assets/images/book10.png',
      rating: 4.5,
      description: """
Listed here as an upcoming highlight, this book continues a fan-favorite series full of celestial magic and sharp banter. Long-running tensions and promises come due as war draws closer.

It is a good fit if you want a fantasy that balances drama, humor, and big feelings across a wide cast.""",
    ),
    Book(
      id: 'upcoming3',
      title: 'Harry Potter and the Goblet of Fire',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '24.00',
      imagePath: 'assets/images/book14.jpg',
      rating: 4.0,
      description: """
Harry returns to Hogwarts and is unexpectedly chosen to compete in the dangerous Triwizard Tournament. As he faces dragons, underwater trials, and a deadly maze, strange clues point to a larger plot.

Perfect for readers who like high-stakes magic, darker twists, and Harry’s world expanding beyond the walls of Hogwarts.""",
    ),
    Book(
      id: 'ty3',
      title: 'Harry Potter and the Deathly Hallows',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '21.00',
      imagePath: 'assets/images/book13.jpg',
      rating: 4.1,
      description: """
Harry, Ron, and Hermione hunt down Voldemort’s Horcruxes while the wizarding world crumbles around them. Old mysteries resolve, loyalties are tested, and a final battle decides the future of Hogwarts and everyone Harry cares about.
""",
    ),
  ];
}
