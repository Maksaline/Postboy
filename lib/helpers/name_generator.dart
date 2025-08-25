import 'dart:math';

class NameGenerator {
  static String generateRandomName(int length) {
    if (length < 1 || length > 20) {
      throw ArgumentError('Length must be between 1 and 20');
    }

    // Define names by length - at least 3 options for each length
    final Map<int, List<String>> namesByLength = {
      1: ['A', 'B', 'C', 'I', 'O'],
      2: ['Al', 'Bo', 'Ed', 'Jo', 'Li', 'Mo'],
      3: ['Amy', 'Ben', 'Cal', 'Dan', 'Eva', 'Fox', 'Guy', 'Ian', 'Joy', 'Ken'],
      4: ['Alex', 'Beth', 'Carl', 'Dana', 'Emma', 'Fred', 'Gina', 'Hugo', 'Iris', 'Jake'],
      5: ['Alice', 'Brian', 'Clara', 'David', 'Emily', 'Frank', 'Grace', 'Henry', 'Irene', 'James'],
      6: ['Andrew', 'Brenda', 'Carlos', 'Debora', 'Edward', 'Felice', 'George', 'Hannah', 'Isabel', 'Joshua'],
      7: ['Anthony', 'Barbara', 'Charles', 'Dorothy', 'Eleanor', 'Francis', 'Gabriel', 'Heather', 'Isadora', 'Jeffrey'],
      8: ['Alexander', 'Beatrice', 'Catherine', 'Dominique', 'Elizabeth', 'Florence', 'Giovanni', 'Hyacinth', 'Ignatius', 'Jennifer'],
      9: ['Anastasia', 'Bartholomew', 'Charlotte', 'Desdemona', 'Evangeline', 'Frederick', 'Gabrielle', 'Henrietta', 'Josephine', 'Katharine'],
      10: ['Alexandria', 'Bartholomé', 'Christiana', 'Maximilian', 'Evangelina', 'Francisque', 'Guillermina', 'Jacqueline', 'Marguerite', 'Nathaniele'],
      11: ['Christopher', 'Alexandrina', 'Constantine', 'Bartholomew', 'Evangelist', 'Franciszeka', 'Guadalupe', 'Jacqueline', 'Maximilian', 'Sebastiana'],
      12: ['Bartholomeus', 'Christophine', 'Evangelist', 'Maximillian', 'Bartholomé', 'Christophel', 'Evangeliste', 'Francisquita', 'Guillermino', 'Jacquelined'],
      13: ['Bartholomaeus', 'Christophorus', 'Evangelistine', 'Maximilliana', 'Bartholomeus', 'Christopherus', 'Evangelistica', 'Franciscus', 'Guillermina', 'Jacquelineth'],
      14: ['Bartholomewton', 'Christopherina', 'Evangelisticus', 'Maximilianine', 'Bartholomewina', 'Christopherena', 'Evangelistina', 'Francisca', 'Guillermino', 'Jacquelinetta'],
      15: ['Bartholomewnius', 'Christopherians', 'Evangelisticus', 'Maximillianina', 'Bartholomewgton', 'Christopherinus', 'Evangelisticus', 'Franciscusina', 'Guillermintona', 'Jacquelinettina'],
      16: ['Bartholomewtonus', 'Christopherianos', 'Evangelisticuson', 'Maximilliangtona', 'Bartholomewgtone', 'Christopherinuse', 'Evangelisticusae', 'Franciscusinaton', 'Guillermintonian', 'Jacquelinettinus'],
      17: ['Bartholomewtonino', 'Christopherianaos', 'Evangelisticusone', 'Maximilliangtonia', 'Bartholomewgtonus', 'Christopherinusia', 'Evangelisticusine', 'Franciscusinatoni', 'Guillermintonianu', 'Jacquelinettinius'],
      18: ['Bartholomewtoninos', 'Christopheriananos', 'Evangelisticusonic', 'Maximilliangtonian', 'Bartholomewgtonuse', 'Christopherinusian', 'Evangelisticusinae', 'Franciscusinatoniu', 'Guillermintoniarus', 'Jacquelinettiniuse'],
      19: ['Bartholomewtoninson', 'Christopheriananose', 'Evangelisticusonica', 'Maximilliangtonianu', 'Bartholomewgtonuser', 'Christopherinusianu', 'Evangelisticusinary', 'Franciscusinatorium', 'Guillermintoniarius', 'Jacquelinettiniuser'],
      20: ['Bartholomewtoninsone', 'Christopheriananoses', 'Evangelisticusonical', 'Maximilliangtonianos', 'Bartholomewgtonusers', 'Christopherinusianum', 'Evangelisticusionary', 'Franciscusinatorius', 'Guillermintoniariuse', 'Jacquelinettiniusers'],
    };

    final names = namesByLength[length]!;
    final random = Random();
    return names[random.nextInt(names.length)];
  }
}