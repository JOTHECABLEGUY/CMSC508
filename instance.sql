INSERT INTO Action(Name, Level, Description, Creator) VALUES('climb', 0, 'CLIMB THE OBSTACLE IN FRONT OF THE ENTITY', 'admin');
INSERT INTO Action(Name, Level, Description, Creator) VALUES('attack', 0, 'ATTACK A TARGET', 'admin');
INSERT INTO Action(Name, Level, Description, Creator) VALUES('eat', 0, 'CONSUME AN OBJECT', 'admin');
INSERT INTO Attributes(Player_CharacterID, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma) VALUES(1, 12, 13, 14, 15, 16, 1);
INSERT INTO Attributes(Player_CharacterID, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma) VALUES(2, 11, 11, 11, 11, 11, 11);
INSERT INTO Attributes(Player_CharacterID, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma) VALUES(3, 1, 1, 1, 1, 1, 1);
INSERT INTO Background(Name, Description, Creator) VALUES('THIEF', 'GREW UP ON THE STREETS, STEALING TO SURVIVE', 'admin');
INSERT INTO Background(Name, Description, Creator) VALUES('WARRIOR', 'TRAINED WITH THE BEST SWORDSMEN IN A MERCENARY TROUPE', 'admin');
INSERT INTO Background(Name, Description, Creator) VALUES('WIZARD', 'STUDIED THE ARCANE ARTS FOR MANY YEARS', 'admin');
INSERT INTO Class(Name, Description, Hit_Dice, Creator) VALUES('BARD', 'USES SONGS AND RHYMES TO CHANGE THE SURROUNDINGS', '1d4', 'admin');
INSERT INTO Class(Name, Description, Hit_Dice, Creator) VALUES('ACOLYTE', 'STUDENT OF MAGIC CAN USE SPELLS', '1d8', 'admin');
INSERT INTO Class(Name, Description, Hit_Dice, Creator) VALUES('RANGER', 'HAS KNOWLEDGE OF THE LAND', '1d4', 'admin');
INSERT INTO Creature(Name, Armor_Class, Hit_Points, Speed, Challenge_Rating, Description, Creator) VALUES('WORM', 13, 50, 15, 17, 'a literal worm', 'admin');
INSERT INTO Creature(Name, Armor_Class, Hit_Points, Speed, Challenge_Rating, Description, Creator) VALUES('SAND SQUID', 20, 500, 20, 20, 'a massive sand dwelling creature said to devour planets', 'admin');
INSERT INTO Creature(Name, Armor_Class, Hit_Points, Speed, Challenge_Rating, Description, Creator) VALUES('GOBLIN', 3, 10, 2, 3, 'a small weak creature that travels in packs', 'admin');
INSERT INTO Equipment(Name, Type, Value, Weight, Description, Creator) VALUES('straw hat', 'light armor', 10, 0.5, 'Simple hat for a simple farmer', 'admin');
INSERT INTO Equipment(Name, Type, Value, Weight, Description, Creator) VALUES('halberd', 'medium weapon', 100, 5, 'strong weapon with a medium reach', 'admin');
INSERT INTO Equipment(Name, Type, Value, Weight, Description, Creator) VALUES('steel boots', 'heavy armor', 50, 15, 'Strong boots usually worn by guards', 'admin');
INSERT INTO Feat(Name, Description, Creator) VALUES('heavy armor trained', 'can wear heavy armor pieces', 'admin');
INSERT INTO Feat(Name, Description, Creator) VALUES('metamagic adept', 'can use intermediate level spells', 'admin');
INSERT INTO Feat(Name, Description, Creator) VALUES('goblin speaker', 'can speak the language of goblins and communicate with them', 'admin');
INSERT INTO Feature(Name, Level, Description, Creator) VALUES('rage', 1, 'In battle, you fight with primal ferocity. On your turn, you can enter a rage as a bonus action. While raging, you gain the following benefits if you aren’t wearing heavy armor: You have advantage on Strength checks and Strength saving throws. When you make a melee weapon attack using Strength, you gain a bonus to the damage roll that increases as you gain levels as a barbarian, as shown in the Rage Damage column of the Barbarian table. You have resistance to bludgeoning, piercing, and slashing damage. If you are able to cast spells, you can’t cast them or concentrate on them while raging. Your rage lasts for 1 minute. It ends early if you are knocked unconscious or if your turn ends and you haven’t attacked a hostile creature since your last turn or taken damage since then. You can also end your rage on your turn as a bonus action. Once you have raged the number of times shown for your barbarian level in the Rages column of the Barbarian table, you must finish a long rest before you can rage again.', 'admin');
INSERT INTO Feature(Name, Level, Description, Creator) VALUES('arcane recovery', 1, 'You have learned to regain some of your magical energy by studying your spellbook. Once per day when you finish a short rest, you can choose expended spell slots to recover. The spell slots can have a combined level that is equal to or less than half your wizard level (rounded up), and none of the slots can be 6th level or higher. For example, if you’re a 4th-level wizard, you can recover up to two levels worth of spell slots. You can recover either a 2nd-level spell slot or two 1st-level spell slots.', 'admin');
INSERT INTO Feature(Name, Level, Description, Creator) VALUES('Sneak Attack', 1, 'Beginning at 1st level, you know how to strike subtly and exploit a foe’s distraction. Once per turn, you can deal an extra 1d6 damage to one creature you hit with an attack if you have advantage on the attack roll. The attack must use a finesse or a ranged weapon. You don’t need advantage on the attack roll if another enemy of the target is within 5 feet of it, that enemy isn’t incapacitated, and you don’t have disadvantage on the attack roll. The amount of the extra damage increases as you gain levels in this class, as shown in the Sneak Attack column of the Rogue table.', 'admin');
INSERT INTO Magic_Item (Name, Type, Rarity, Attunement, Description, Creator) 
    VALUES('Bag of Holding', 'Wondrous Item', 'Uncommon', 'None', 'This bag has an interior space considerably larger than its outside dimensions, roughly 2 feet in diameter at the mouth and 4 feet deep. The bag can hold up to 500 pounds, not exceeding a volume of 64 cubic feet. The bag weighs 15 pounds, regardless of its contents. Retrieving an item from the bag requires an action.

If the bag is overloaded, pierced, or torn, it ruptures and is destroyed, and its contents are scattered in the Astral Plane. If the bag is turned inside out, its contents spill forth, unharmed, but the bag must be put right before it can be used again. Breathing creatures inside the bag can survive up to a number of minutes equal to 10 divided by the number of creatures (minimum 1 minute), after which time they begin to suffocate.

Placing a bag of holding inside an extradimensional space created by a handy haversack, portable hole, or similar item instantly destroys both items and opens a gate to the Astral Plane. The gate originates where the one item was placed inside the other. Any creature within 10 feet of the gate is sucked through it to a random location on the Astral Plane. The gate then closes. The gate is one-way only and can’t be reopened.', 'admin');

INSERT INTO Magic_Item (Name, Type, Rarity, Attunement, Description, Creator) 
    VALUES('Bracers of Archery', 'Wondrous Item', 'Uncommon', 'Required', 'While wearing these bracers, you have proficiency with the longbow and shortbow, and you gain a +2 bonus to damage rolls on ranged attacks made with such weapons.', 'admin');

INSERT INTO Magic_Item (Name, Type, Rarity, Attunement, Description, Creator) 
    VALUES('Cloak of Elvenkind', 'Wondrous Item', 'Uncommon', 'Required', 'While you wear this cloak with its hood up, Wisdom (Perception) checks made to see you have disadvantage, and you have advantage on Dexterity (Stealth) checks made to hide, as the cloaks color shifts to camouflage you. Pulling the hood up or down requires an action.', 'admin');
INSERT INTO Player_Character (Name, Level, HP, Max_HP, Armor_Class, Background, Race, Creator)
    VALUES('Tazl', 7, 58, 58, 17, 1, 1, 'admin' );

INSERT INTO Player_Character (Name, Level, HP, Max_HP, Armor_Class, Background, Race, Creator)
    VALUES('Innara', 7, 58, 58, 17, 2, 2, 'admin' );
    
INSERT INTO Player_Character (Name, Level, HP, Max_HP, Armor_Class, Background, Race, Creator)
    VALUES('Taron', 7, 58, 58, 17, 3, 3, 'admin' );
INSERT INTO Race (Name, Description, Creator)
    VALUES('Tiefling', '', 'admin');

INSERT INTO Race (Name, Description, Creator)
    VALUES('Human', '', 'admin');

INSERT INTO Race (Name, Description, Creator)
    VALUES('Dragonborn', '', 'admin');
    INSERT INTO Spell (Name, Level, Duration, Cast_Time, School, _Range, Attack_Save, Damage_Effect, Description, Creator)
        VALUES('Mage Hand', 0, '00:01:00', '00:00:06' , 'Conjuration','30 ft', 'None', 'Utility', 'A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again.

    You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.

    The hand cant attack, activate magic items, or carry more than 10 pounds.', 'admin');

    INSERT INTO Spell (Name, Level, Duration, Cast_Time, School, _Range, Attack_Save, Damage_Effect, Description, Creator)
        VALUES('Message', 0, '00:00:06', '00:00:06' ,'Transmutation', '120 ft', 'None', 'Communication', 'You point your finger toward a creature within range and whisper a message. The target (and only the target) hears the message and can reply in a whisper that only you can hear.

    You can cast this spell through solid objects if you are familiar with the target and know it is beyond the barrier. Magical silence, 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood blocks the spell. The spell doesnt have to follow a straight line and can travel freely around corners or through openings.', 'admin');  

    INSERT INTO Spell (Name, Level, Duration, Cast_Time, School, _Range, Attack_Save, Damage_Effect, Description, Creator)
        VALUES('Mold Earth', 0, '00:00:00', '00:00:06','Transmutation', '30 ft, 5ft cube', 'None', 'Control', 'You choose a portion of dirt or stone that you can see within range and that fits within a 5-foot cube. You manipulate it in one of the following ways:

    If you target an area of loose earth, you can instantaneously excavate it, move it along the ground, and deposit it up to 5 feet away. This movement doesnt have enough force to cause damage.

    You cause shapes, colors, or both to appear on the dirt or stone, spelling out words, creating images, or shaping patterns. The changes last for 1 hour.

    If the dirt or stone you target is on the ground, you cause it to become difficult terrain. Alternatively, you can cause the ground to become normal terrain if it is already difficult terrain. This change lasts for 1 hour.

    If you cast this spell multiple times, you can have no more than two of its non-instantaneous effects active at a time, and you can dismiss such an effect as an action.', 'admin'); 
INSERT INTO Users(Username, Password) VALUES('admin', 'adminspassword');
INSERT INTO Users(Username, Password) VALUES('admin1', 'adminspassword1');
INSERT INTO Users(Username, Password) VALUES('admin2', 'adminspassword2');
INSERT INTO Background_Language(Background, Language) VALUES(1, 'Abyssal');
INSERT INTO Background_Language(Background, Language) VALUES(1, 'Celestial');
INSERT INTO Background_Language(Background, Language) VALUES(2, 'Abyssal');
INSERT INTO Background_Proficiency(Background, Proficiency) VALUES(1, 'Athletics');
INSERT INTO Background_Proficiency(Background, Proficiency) VALUES(2, 'Sleight Of Hand');
INSERT INTO Background_Proficiency(Background, Proficiency) VALUES(3, 'Acrobatics');
INSERT INTO Class_Proficiency (Class, Proficiency) VALUES(1, 'Athletics');
INSERT INTO Class_Proficiency (Class, Proficiency) VALUES(2, 'Sleight Of Hand');
INSERT INTO Class_Proficiency (Class, Proficiency) VALUES(3, 'Acrobatics');
INSERT INTO Creature_Language(Creature, Language) VALUES(2, 'Abyssal');
INSERT INTO Creature_Language(Creature, Language) VALUES(2, 'Celestial');
INSERT INTO Creature_Language(Creature, Language) VALUES(3, 'Abyssal');
INSERT INTO Creature_Resistance_Weakness(Creature, Resistance_Weakness) VALUES(1, 'immune to fire');
INSERT INTO Creature_Resistance_Weakness(Creature, Resistance_Weakness) VALUES(2, 'resistant to cold');
INSERT INTO Creature_Resistance_Weakness(Creature, Resistance_Weakness) VALUES(3, 'weak to lightning');
INSERT INTO Creature_Sense(Creature, Sense) VALUES(1, 'darkvision');
INSERT INTO Creature_Sense(Creature, Sense) VALUES(3, 'sent');
INSERT INTO Creature_Sense(Creature, Sense) VALUES(3, 'low-light');
INSERT INTO Creature_Skill_Bonus VALUES(1, "Stealth +3");
INSERT INTO Creature_Skill_Bonus VALUES(2, "Sleight of Hand +3");
INSERT INTO Creature_Skill_Bonus VALUES(1, "Acrobatics +3");
INSERT INTO Player_Character_Equipment_Proficiency VALUES(1, "Simple Weapons");
INSERT INTO Player_Character_Equipment_Proficiency VALUES(2, "Simple Weapons");
INSERT INTO Player_Character_Equipment_Proficiency VALUES(3, "Simple Weapons");
INSERT INTO Player_Character_Language(Player_CharacterID, Language) VALUES(1, 'Abyssal');
INSERT INTO Player_Character_Language(Player_CharacterID, Language) VALUES(2, 'Celestial');
INSERT INTO Player_Character_Language(Player_CharacterID, Language) VALUES(3, 'Celestial');
INSERT INTO Player_Character_Proficiency VALUES(1, "Stealth");
INSERT INTO Player_Character_Proficiency VALUES(2, "Acrobatics");
INSERT INTO Player_Character_Proficiency VALUES(3, "Arcana");
INSERT INTO Player_Character_Skill_Bonus VALUES(1, "Stealth +1");
INSERT INTO Player_Character_Skill_Bonus VALUES(2, "Acrobatics +1");
INSERT INTO Player_Character_Skill_Bonus VALUES(3, "Arcana +1");
INSERT INTO Spell_Component(Spell, Component) VALUES(1, 'Diamond Dust');
INSERT INTO Spell_Component(Spell, Component) VALUES(2, 'Hallow');
INSERT INTO Spell_Component(Spell, Component) VALUES(3, 'Agate');
INSERT INTO Background_Equipment(Background, Equipment) VALUES(1, 1);
INSERT INTO Background_Equipment(Background, Equipment) VALUES(2, 1);
INSERT INTO Background_Equipment(Background, Equipment) VALUES(2, 3);
INSERT INTO Creature_Action(Creature, Action) VALUES(1, 1);
INSERT INTO Creature_Action(Creature, Action) VALUES(1, 2);
INSERT INTO Creature_Action(Creature, Action) VALUES(1, 3);
INSERT INTO Creature_Spell(Creature, Spell) VALUES(2, 1);
INSERT INTO Creature_Spell(Creature, Spell) VALUES(2, 2);
INSERT INTO Creature_Spell(Creature, Spell) VALUES(2, 3);
INSERT INTO Feature_Background(Feature, Background) VALUES(3, 1);
INSERT INTO Feature_Background(Feature, Background) VALUES(3, 2);
INSERT INTO Feature_Background(Feature, Background) VALUES(3, 3);
INSERT INTO Feature_Class(Feature, Class) VALUES(1, 1);
INSERT INTO Feature_Class(Feature, Class) VALUES(2, 1);
INSERT INTO Feature_Class(Feature, Class) VALUES(3, 1);
INSERT INTO Feature_Creature(Feature, Creature) VALUES(1, 2);
INSERT INTO Feature_Creature(Feature, Creature) VALUES(2, 2);
INSERT INTO Feature_Creature(Feature, Creature) VALUES(3, 2);
INSERT INTO Feature_Race(Feature, Race) VALUES(1, 3);
INSERT INTO Feature_Race(Feature, Race) VALUES(2, 3);
INSERT INTO Feature_Race(Feature, Race) VALUES(3, 3);
INSERT INTO Player_Character_Action(Player_Character, Action) VALUES(1, 1);
INSERT INTO Player_Character_Action(Player_Character, Action) VALUES(2, 2);
INSERT INTO Player_Character_Action(Player_Character, Action) VALUES(3, 3);
INSERT INTO Player_Character_Equipment(Player_Character, Equipment) VALUES(1, 1);
INSERT INTO Player_Character_Equipment(Player_Character, Equipment) VALUES(2, 3);
INSERT INTO Player_Character_Equipment(Player_Character, Equipment) VALUES(3, 2);
INSERT INTO Player_Character_Feat(Player_Character, Feat) VALUES(1, 3);
INSERT INTO Player_Character_Feat(Player_Character, Feat) VALUES(2, 2);
INSERT INTO Player_Character_Feat(Player_Character, Feat) VALUES(3, 1);
INSERT INTO Player_Character_Feature(Player_Character, Feature) VALUES(1, 1);
INSERT INTO Player_Character_Feature(Player_Character, Feature) VALUES(1, 2);
INSERT INTO Player_Character_Feature(Player_Character, Feature) VALUES(1, 3);
INSERT INTO Player_Character_Magic_Item(Player_Character, Magic_Item) VALUES(3, 1);
INSERT INTO Player_Character_Magic_Item(Player_Character, Magic_Item) VALUES(3, 2);
INSERT INTO Player_Character_Magic_Item(Player_Character, Magic_Item) VALUES(3, 3);
INSERT INTO Player_Character_Spell(Player_Character, Spell) VALUES(1, 3);
INSERT INTO Player_Character_Spell(Player_Character, Spell) VALUES(2, 3);
INSERT INTO Player_Character_Spell(Player_Character, Spell) VALUES(3, 2);