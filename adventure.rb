# This is a small, very simple text-based adventure script, created with knowledge from Learn Ruby the Hard Way.

$has_weapon = false
$money = 15
$bomb = ["This is your last chance", "You have two attempts remaining"]

def dead(why)
  puts why, "Game over!"
  exit(0)
end

def stranger_room
  puts "You are in a small room."
  puts "In front of you is a shadowy man in a long trenchcoat."
  puts "He holds his hand out and asks you for five gold coins.  What do you do?"

  while true
    print "> "
    choice = ($stdin.gets.chomp).downcase

    if (choice.include? "give") && (!((choice.include? "don't") || (choice.include? "do not")) && !(choice.include? "no"))
      puts "The man takes only 5 coins and scrambles away to a door across the room."
      puts "He whispers 'The Mongoose breeds in the swamp' in your direction before disappearing through the door."
      $money -= 5
      puts "The path to the next room is now open and you follow the man through."

      print "Press ENTER to continue > "
      $stdin.gets.chomp

      bomb_room
    elsif (((choice.include? "stab") || (choice.include? "fight")) || ((choice.include? "punch") || (choice.include? "hit"))) || ((choice.include? "attack") || (choice.include? "kill"))
      puts dead("You try to attack, but the shadowy man grabs you by the shoulder and stabs you. You bleed out.")
    else
      puts "The stranger stares at you."
    end
  end
end

def bomb_room
  puts "You enter into a very large, brightly lit room, filled with people."
  puts "Everyone is screaming and panicking. You soon spot the source of the panic."
  puts "A very large beeping bomb is ticking down in the center of the room."
  puts "It will kill everybody. The disarm code is three digits long."
  puts "You have no choice but to guess. You have three attempts."
  x = 2

  while true
  print "> "
  choice = $stdin.gets.chomp
    if x == 0
      if choice == "893"
        puts "You got it right!  The bomb is defused and everyone cheers loudly."
        heaven_room
      else
        puts dead("The bomb beeps loudly and the timer flashes zero. It explodes, killing everyone.")
      end
    else
        if choice == "893"
          puts "You got it right!  The bomb is defused and everyone cheers loudly."
          heaven_room
        else
          x -= 1
          puts "The bomb beeps loudly. Incorrect. #{$bomb[x]}"
        end
    end
  end
end

def guard_room
  if $has_weapon == false
    puts "You enter the room to see a guard standing in front of the next door."
    puts "He stares at you, unblinkingly."
    puts "You consider trying to get past or returning to the other room."

    while true
      print "> "
      choice = ($stdin.gets.chomp).downcase

      if (choice.include? "talk")
        puts "The guard responds only with 'Octo, Novem, Tribus'."
      elsif ((choice.include? "leave") || (choice.include? "go back")) || ((choice.include? "return") || (choice.include? "exit"))
        puts "You return to the other room."

        print "Press ENTER to continue > "
        $stdin.gets.chomp

        start
      elsif (((choice.include? "stab") || (choice.include? "fight")) || ((choice.include? "punch") || (choice.include? "hit"))) || ((choice.include? "attack") || (choice.include? "kill"))
        puts dead("You attempt to attack the guard, but he draws a gun and ends your life.")

      elsif ((choice.include? "gold") || (choice.include? "coins")) || ((choice.include? "bribe") || (choice.include? "money"))
        puts "The guard is unamused and pushes you out of the room."

        print "Press ENTER to continue > "
        $stdin.gets.chomp

        start
      else
        puts "The guard continues to stare at you."

      end
    end
    else
      puts "You enter the room to see a guard standing in front of the next door."
      puts "He notices your sword, and steps aside."
      puts "'Good luck,' he says with a nod, and the door opens. You step through."

      print "Press ENTER to continue > "
      $stdin.gets.chomp

      boss_room
  end
end

def boss_room
  puts "As you step through, the door seals tightly behind you."
  puts "You are hit by an immense stench and a blanketing heat."
  puts "In front of you is the most indescribable horror of tentacles and eyeballs."
  puts "The creature screams at you aggressively."
  puts "It looks like it just wants a friend."

  print "> "
  choice = ($stdin.gets.chomp).downcase

  if (((choice.include? "stab") || (choice.include? "fight")) || ((choice.include? "sword") || (choice.include? "hit"))) || ((choice.include? "attack") || (choice.include? "kill"))
    puts "You attempt to fight the beast with the Arklight Sword."
    puts "You fight valiantly, but the abomination is too strong."
    puts "The Arklight Sword was not enough."
    puts dead("The beast grips you with its tentacle, and crushes you.")
  elsif (((choice.include? "hug") || (choice.include? "cuddle")) || ((choice.include? "love") || (choice.include? "put down"))) || ((choice.include? "sword down") || (choice.include? "friend"))
    puts "You show to the beast that you come in peace."
    puts "Confused, it recoils slightly."
    puts "The creature begins shaking violently.  It cannot process the emotion 'love'."
    puts "In an instant, the beast vaporises."
    puts "A voice comes from the Arklight Sword:"
    puts "'The power of friendship was in you the whole time!'"
    puts "The sword transforms in your hand into an enormous block of gold."
    puts dead("Congratulations, you win!")
  else
    puts dead("Unsure as to what you're trying to do, the beast annihilates you.")
  end
end

def heaven_room

  print "Press ENTER to continue > "
  $stdin.gets.chomp

  puts "A kind-looking man in a bright white robe approaches you from the cheering crowds."
  puts "He urges you to follow him and you feel compelled to do so."
  puts "You follow him into an entirely white room. A choir can be heard singing softly in the ether."
  puts "Turning to face you, he asks you a question."
  puts "'Where does the mongoose breed?'"

  print "> "
  choice = ($stdin.gets.chomp).downcase

  if (choice.include? "swamp")
    puts "'Correct. Listen quickly, you must take this.'"
    puts "You received the Arklight Sword!"
    puts "'Take the sword, and slay the beast. It is the only way to end this nightmare.'"
    puts "'I will teleport you back to the start. Get ready.'"
    $has_weapon = true

    print "Press ENTER to continue > "
    $stdin.gets.chomp

    puts "*WHOOSH*"
    start
  else
    puts "'You are not the one. You must die.'"
    puts dead("Before you can react, the man sinks a blade into your chest.")
  end
end

def start
  puts "You are in a dark room."
  puts "There is a door to your right and left."
  puts "You have #{$money} gold coins."
  if $has_weapon == false
    puts "You also have no weapons."
  else
    puts "You also have the Arklight Sword."
  end
  puts "Which door do you take?"

  while true
    print "> "
    choice = ($stdin.gets.chomp).downcase

      if choice == "left"
        guard_room
      elsif choice == "right"
        if $has_weapon == false
          stranger_room
        else
          puts "The door seems to be completely sealed."
        end
      else
        puts "You stumble around the room aimlessly."
      end
  end
end

start
