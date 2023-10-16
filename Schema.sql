--  DUNGEONS AND DRAGONS TABLES SQL IMPLEMENTATION  
--	JORDAN DUBE AND JUSTIN JONES 
--	CMSC508 WITH PROFESSOR CANO 
--	04/03/2023	


-- DROP PROCEDURE --

-- REMEMBER TO UNTICK "ENABLE FOREIGN KEY CHECKS"

DROP TABLE IF EXISTS Action;
DROP TABLE IF EXISTS Attributes;
DROP TABLE IF EXISTS Background;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS Creature;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Feat;
DROP TABLE IF EXISTS Feature;
DROP TABLE IF EXISTS Magic_Item;
DROP TABLE IF EXISTS Player_Character;
DROP TABLE IF EXISTS Race;
DROP TABLE IF EXISTS Spell;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Background_Language;
DROP TABLE IF EXISTS Background_Proficiency;
DROP TABLE IF EXISTS Class_Proficiency;
DROP TABLE IF EXISTS Creature_Language;
DROP TABLE IF EXISTS Creature_Resistance_Weakness;
DROP TABLE IF EXISTS Creature_Sense;
DROP TABLE IF EXISTS Creature_Skill_Bonus;
DROP TABLE IF EXISTS Player_Character_Equipment_Proficiency;
DROP TABLE IF EXISTS Player_Character_Language;
DROP TABLE IF EXISTS Player_Character_Proficiency;
DROP TABLE IF EXISTS Player_Character_Skill_Bonus;
DROP TABLE IF EXISTS Spell_Component;
DROP TABLE IF EXISTS Background_Equipment;
DROP TABLE IF EXISTS Creature_Action;
DROP TABLE IF EXISTS Creature_Spell;
DROP TABLE IF EXISTS Feature_Background;
DROP TABLE IF EXISTS Feature_Class;
DROP TABLE IF EXISTS Feature_Creature;
DROP TABLE IF EXISTS Feature_Race;
DROP TABLE IF EXISTS Player_Character_Action;
DROP TABLE IF EXISTS Player_Character_Equipment;
DROP TABLE IF EXISTS Player_Character_Feat;
DROP TABLE IF EXISTS Player_Character_Feature;
DROP TABLE IF EXISTS Player_Character_Magic_Item;
DROP TABLE IF EXISTS Player_Character_Spell;


-- CREATION PROCEDURE --
-- REMEMBER TO UNTICK "ENABLE FOREIGN KEY CHECKS"

-- ENTITIES (13) --

-- ACTION
CREATE TABLE IF NOT EXISTS Action(
	ActionID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Level INT,
	Description TEXT,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- ATTRIBUTES
CREATE TABLE IF NOT EXISTS Attributes(
	Player_CharacterID INT AUTO_INCREMENT PRIMARY KEY,
	Strength TINYINT,
	Dexterity TINYINT,
	Constitution TINYINT,
	Intelligence TINYINT,
	Wisdom TINYINT,
	Charisma TINYINT,
	FOREIGN KEY (Player_CharacterID) REFERENCES Player_Character(ID)
);

-- BACKGROUND
CREATE TABLE IF NOT EXISTS Background(
	BackgroundID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Description TEXT,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- CLASS
CREATE TABLE IF NOT EXISTS Class(
	ClassID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Description TEXT NOT NULL,
	Hit_Dice VARCHAR(50),
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- CREATURE
CREATE TABLE IF NOT EXISTS Creature(
	CreatureID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(50),
	Armor_Class SMALLINT,
	Hit_Points INT DEFAULT 0 CHECK (Hit_Points >= 0),
	Speed TINYINT DEFAULT 0 CHECK (Speed >= 0),
	Challenge_Rating NUMERIC(6,3) DEFAULT 0 CHECK (Challenge_Rating >= 0),
	Description TEXT,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- EQUIPMENT
CREATE TABLE IF NOT EXISTS Equipment(
	EquipmentID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(75) NOT NULL,
	Type VARCHAR(20),
	Value INT,
	Weight NUMERIC(6,2),
	Description TEXT NOT NULL,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- FEAT
CREATE TABLE IF NOT EXISTS Feat(
	FeatID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Description TEXT NOT NULL,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- FEATURE
CREATE TABLE IF NOT EXISTS Feature(
	FeatureID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Level INT,
	Description TEXT,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- MAGIC ITEM
CREATE TABLE IF NOT EXISTS Magic_Item(
	Magic_ItemID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(75) NOT NULL,
	Type VARCHAR(20),
	Rarity VARCHAR(20),
	Attunement VARCHAR(30),
	Weight NUMERIC(6,2),
	Description TEXT,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- PLAYER CHARACTER
CREATE TABLE IF NOT EXISTS Player_Character(
	ID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(100) NOT NULL,
	Description TEXT,
	Level SMALLINT NOT NULL CHECK (Level >= 0),
	HP INT NOT NULL CHECK (HP >= 0),
	Max_HP INT NOT NULL CHECK (Max_HP>0),
	Armor_Class VARCHAR(50) NOT NULL,
	Proficiency_Bonus INT GENERATED ALWAYS AS ((floor(((`Level` - 1) / 4)) + 2)) VIRTUAL NOT NULL,
	Background INT NOT NULL,
	Race INT NOT NULL,
	Class INT NOT NULL, 
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Background) REFERENCES Background(BackgroundID),
	FOREIGN KEY (Race) REFERENCES Race(RaceID),
	FOREIGN KEY (Creator) REFERENCES Users(Username),
	FOREIGN KEY (Class) REFERENCES Class(ClassID)
);

-- RACE
CREATE TABLE IF NOT EXISTS Race(
	RaceID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Description TEXT NOT NULL,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- SPELL
CREATE TABLE IF NOT EXISTS Spell(
	SpellID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Level SMALLINT,
	Duration TIME CHECK (Duration >= '00:00:00'),
	Cast_Time TIME CHECK (Cast_Time >= '00:00:00'),
	School VARCHAR(30),
	_Range VARCHAR(20),
	Attack_Save ENUM('Attack', 'Save', 'None'),
	Damage_Effect VARCHAR(255),
	Description TEXT NOT NULL,
	Creator VARCHAR(50) NOT NULL,
	FOREIGN KEY (Creator) REFERENCES Users(Username)
);

-- USERS
CREATE TABLE IF NOT EXISTS Users(
	Username VARCHAR(50) PRIMARY KEY,
	Password VARCHAR(100),
	Last_Login TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- SINGLE ENTITY TABLES (12) --

-- BACKGROUND ->-> LANGAUGE
CREATE TABLE IF NOT EXISTS Background_Language(
	Background INT,
	Language VARCHAR(25),
	PRIMARY KEY (Background, Language),
	FOREIGN KEY (Background) REFERENCES Background(BackgroundID)
);

-- BACKGROUND ->-> PROFICIENCY
CREATE TABLE IF NOT EXISTS Background_Proficiency(
	Background INT,
	Proficiency VARCHAR(30),
	PRIMARY KEY (Background, Proficiency),
	FOREIGN KEY (Background) REFERENCES Background(BackgroundID)
);

-- CLASS ->-> Proficiency
CREATE TABLE IF NOT EXISTS Class_Proficiency(
	Class INT,
	Proficiency VARCHAR(30),
	PRIMARY KEY (Class, Proficiency),
	FOREIGN KEY (Class) REFERENCES Class(ClassID)
);

-- CREATURE ->-> LANGUAGE
CREATE TABLE IF NOT EXISTS Creature_Language(
	Creature INT,
	Language VARCHAR(25),
	PRIMARY KEY (Creature, Language),
	FOREIGN KEY (Creature) REFERENCES Creature(CreatureID)
);

-- CREATURE ->-> RESISTANCE/WEAKNESS
CREATE TABLE IF NOT EXISTS Creature_Resistance_Weakness(
	Creature INT,
	Resistance_Weakness VARCHAR(50),
	PRIMARY KEY (Creature, Resistance_Weakness),
	FOREIGN KEY (Creature) REFERENCES Creature(CreatureID)
);

-- CREATURE ->-> ATTRIBUTE
CREATE TABLE IF NOT EXISTS Creature_Attributes(
    CreatureID INT AUTO_INCREMENT PRIMARY KEY,
    Strength TINYINT,
    Dexterity TINYINT,
    Constitution TINYINT,
    Intelligence TINYINT,
    Wisdom TINYINT,
    Charisma TINYINT,
    FOREIGN KEY (CreatureID) REFERENCES Creature(CreatureID)
);

-- CREATURE ->-> SENSE
CREATE TABLE IF NOT EXISTS Creature_Sense(
	Creature INT,
	Sense VARCHAR(25),
	PRIMARY KEY (Creature, Sense),
	FOREIGN KEY (Creature) REFERENCES Creature(CreatureID)
);

-- CREATURE ->-> SKILL BONUS
CREATE TABLE IF NOT EXISTS Creature_Skill_Bonus(
	Creature INT,
    Acrobatics      SMALLINT NOT NULL DEFAULT '0',
    Animal_Handling SMALLINT NOT NULL DEFAULT '0',
	Arcana          SMALLINT NOT NULL DEFAULT '0',
    Athletics       SMALLINT NOT NULL DEFAULT '0',
    Deception       SMALLINT NOT NULL DEFAULT '0',
    History         SMALLINT NOT NULL DEFAULT '0',
    Insight         SMALLINT NOT NULL DEFAULT '0',
    Intimidation    SMALLINT NOT NULL DEFAULT '0',
    Investigation   SMALLINT NOT NULL DEFAULT '0',
    Medicine        SMALLINT NOT NULL DEFAULT '0',
    Nature          SMALLINT NOT NULL DEFAULT '0',
    Perception      SMALLINT NOT NULL DEFAULT '0',
    Performance     SMALLINT NOT NULL DEFAULT '0',
    Persuasion      SMALLINT NOT NULL DEFAULT '0',
    Religion        SMALLINT NOT NULL DEFAULT '0',
    Sleight_of_Hand SMALLINT NOT NULL DEFAULT '0',
    Stealth         SMALLINT NOT NULL DEFAULT '0',
    Survival        SMALLINT NOT NULL DEFAULT '0',
	PRIMARY KEY (Creature),
	FOREIGN KEY (Creature) REFERENCES Creature(CreatureID)
);

-- PLAYER CHARACTER ->-> EQUIPMENT PROFICIENCY
CREATE TABLE IF NOT EXISTS Player_Character_Equipment_Proficiency(
	Player_CharacterID INT,
	Equipment_Proficiency VARCHAR(30),
	PRIMARY KEY (Player_CharacterID, Equipment_Proficiency),
	FOREIGN KEY (Player_CharacterID) REFERENCES Player_Character(ID)
);

-- PLAYER CHARACTER ->-> LANGUAGE
CREATE TABLE IF NOT EXISTS Player_Character_Language(
	Player_CharacterID INT,
	Language VARCHAR(25),
	PRIMARY KEY (Player_CharacterID, Language),
	FOREIGN KEY (Player_CharacterID) REFERENCES Player_Character(ID)
);

-- PLAYER CHARACTER ->-> PROFICIENCY
CREATE TABLE IF NOT EXISTS Player_Character_Proficiency(
	Player_CharacterID INT,
	Proficiency VARCHAR(30),
	PRIMARY KEY (Player_CharacterID, Proficiency),
	FOREIGN KEY (Player_CharacterID) REFERENCES Player_Character(ID)
);

-- PLAYER CHARACTER ->-> SKILL BONUS
CREATE TABLE IF NOT EXISTS Player_Character_Skill_Bonus(
	Player_CharacterID INT,
    Acrobatics      SMALLINT NOT NULL DEFAULT '0',
    Animal_Handling SMALLINT NOT NULL DEFAULT '0',
	Arcana          SMALLINT NOT NULL DEFAULT '0',
    Athletics       SMALLINT NOT NULL DEFAULT '0',
    Deception       SMALLINT NOT NULL DEFAULT '0',
    History         SMALLINT NOT NULL DEFAULT '0',
    Insight         SMALLINT NOT NULL DEFAULT '0',
    Intimidation    SMALLINT NOT NULL DEFAULT '0',
    Investigation   SMALLINT NOT NULL DEFAULT '0',
    Medicine        SMALLINT NOT NULL DEFAULT '0',
    Nature          SMALLINT NOT NULL DEFAULT '0',
    Perception      SMALLINT NOT NULL DEFAULT '0',
    Performance     SMALLINT NOT NULL DEFAULT '0',
    Persuasion      SMALLINT NOT NULL DEFAULT '0',
    Religion        SMALLINT NOT NULL DEFAULT '0',
    Sleight_of_Hand SMALLINT NOT NULL DEFAULT '0',
    Stealth         SMALLINT NOT NULL DEFAULT '0',
    Survival        SMALLINT NOT NULL DEFAULT '0',
	PRIMARY KEY (Player_CharacterID),
	FOREIGN KEY (Player_CharacterID) REFERENCES Player_Character(ID)
);

-- SPELL ->-> COMPONENT
CREATE TABLE IF NOT EXISTS Spell_Component(
	Spell INT,
	Component VARCHAR(25),
	PRIMARY KEY (Spell, Component),
	FOREIGN KEY (Spell) REFERENCES Spell(SpellID)
);



-- MULTI-ENTITY TABLES (13) --

-- BACKGROUND-EQUIPMENT
CREATE TABLE IF NOT EXISTS Background_Equipment(
	Background INT,
	Equipment INT,
	PRIMARY KEY (Background, Equipment),
	FOREIGN KEY (Background) REFERENCES Background(BackgroundID),
	FOREIGN KEY (Equipment) REFERENCES Equipment(EquipmentID)
);

-- CREATURE-ACTION
CREATE TABLE IF NOT EXISTS Creature_Action(
	Creature INT,
	Action INT,
	PRIMARY KEY (Creature, Action),
	FOREIGN KEY (Creature) REFERENCES Creature(CreatureID),
	FOREIGN KEY (Action) REFERENCES Action(ActionID)
);

-- CREATURE-SPELL
CREATE TABLE IF NOT EXISTS Creature_Spell(
	Creature INT,
	Spell INT,
	PRIMARY KEY (Creature, Spell),
	FOREIGN KEY (Creature) REFERENCES Creature(CreatureID),
	FOREIGN KEY (Spell) REFERENCES Spell(SpellID)
);

-- FEATURE-BACKGROUND
CREATE TABLE IF NOT EXISTS Feature_Background(
	Feature INT,
	Background INT,
	PRIMARY KEY (Feature, Background),
	FOREIGN KEY (Feature) REFERENCES Feature(FeatureID),
	FOREIGN KEY (Background) REFERENCES Background(BackgroundID)
);

-- FEATURE-CLASS
CREATE TABLE IF NOT EXISTS Feature_Class(
	Feature INT,
	Class INT,
	PRIMARY KEY (Feature, Class),
	FOREIGN KEY (Feature) REFERENCES Feature(FeatureID),
	FOREIGN KEY (Class) REFERENCES Class(ClassID)
);

-- FEATURE-CREATURE
CREATE TABLE IF NOT EXISTS Feature_Creature(
	Feature INT,
	Creature INT,
	PRIMARY KEY (Feature, Creature),
	FOREIGN KEY (Feature) REFERENCES Feature(FeatureID),
	FOREIGN KEY (Creature) REFERENCES Creature(CreatureID)
);

-- FEATURE-RACE
CREATE TABLE IF NOT EXISTS Feature_Race(
	Feature INT,
	Race INT,
	PRIMARY KEY (Feature, Race),
	FOREIGN KEY (Feature) REFERENCES Feature(FeatureID),
	FOREIGN KEY (Race) REFERENCES Race(RaceID)
);

-- PLAYER CHARACTER-ACTION
CREATE TABLE IF NOT EXISTS Player_Character_Action(
	Player_Character INT,
	Action INT,
	PRIMARY KEY (Player_Character, Action),
	FOREIGN KEY (Player_Character) REFERENCES Player_Character(ID),
	FOREIGN KEY (Action) REFERENCES Action(ActionID)
);

-- PLAYER CHARACTER-EQUIPMENT
CREATE TABLE IF NOT EXISTS Player_Character_Equipment(
	Player_Character INT,
	Equipment INT,
	PRIMARY KEY (Player_Character, Equipment),
	FOREIGN KEY (Player_Character) REFERENCES Player_Character(ID),
	FOREIGN KEY (Equipment) REFERENCES Equipment(EquipmentID)
);

-- PLAYER CHARACTER-FEAT
CREATE TABLE IF NOT EXISTS Player_Character_Feat(
	Player_Character INT,
	Feat INT,
	PRIMARY KEY (Player_Character, Feat),
	FOREIGN KEY (Player_Character) REFERENCES Player_Character(ID),
	FOREIGN KEY (Feat) REFERENCES Feat(FeatID)
);

-- PLAYER CHARACTER-FEATURE
CREATE TABLE IF NOT EXISTS Player_Character_Feature(
	Player_Character INT,
	Feature INT,
	PRIMARY KEY (Player_Character, Feature),
	FOREIGN KEY (Player_Character) REFERENCES Player_Character(ID),
	FOREIGN KEY (Feature) REFERENCES Feature(FeatureID)
);

-- PLAYER CHARACTER-MAGIC ITEM
CREATE TABLE IF NOT EXISTS Player_Character_Magic_Item(
	Player_Character INT,
	Magic_Item INT,
	PRIMARY KEY (Player_Character, Magic_Item),
	FOREIGN KEY (Player_Character) REFERENCES Player_Character(ID),
	FOREIGN KEY (Magic_Item) REFERENCES Magic_Item(Magic_ItemID)
);

-- PLAYER CHARACTER-SPELL
CREATE TABLE IF NOT EXISTS Player_Character_Spell(	Player_Character INT,
	Spell INT,
	PRIMARY KEY (Player_Character, Spell),
	FOREIGN KEY (Player_Character) REFERENCES Player_Character(ID),
	FOREIGN KEY (Spell) REFERENCES Spell(SpellID)
);

-- PROCEDURES:

-- Updates proficiencies that a character has
drop procedure if exists proficiency_table_update;

delimiter //
create procedure proficiency_table_update(in player_id int)
begin

    -- Temporary table to store all proficiencies 
    -- character should have
    create temporary table prof(
        proficiency varchar(255)
    );

    -- Reset current proficiencies
    delete from Player_Character_Proficiency p
    where p.Player_CharacterID = player_id;

    -- Get class 
    select Class into @class_id
    from Player_Character
    where ID = player_id;

    -- Get background 
    select Background into @background_id
    from Player_Character 
    where ID = player_id;

    -- Insert class proficiencies
    insert into prof 
    select Proficiency 
    from Class_Proficiency
    where Class = @class_id;

    -- Insert background proficiencies
    insert into prof
    select Proficiency
    from Background_Proficiency
    where Background = @background_id;

    -- Insert values into proficiency table
    insert into Player_Character_Proficiency
    select distinct player_id, proficiency
    from prof;

    drop table prof;

end//
delimiter ;


-- Procedure to update Skill Bonus values based on 
-- proficiency & attributes
drop procedure if exists skill_bonus_update;

delimiter //
create procedure skill_bonus_update(in player_id int)
begin

    -- Table to store proficiencies
    create temporary table prof (
        proficiency varchar(255)
    );
    

    -- Get proficiency bonus
    select p.Proficiency_Bonus into @prof_bonus
        from Player_Character p where ID = player_id;


    -- Calculate skill bonuses
    select floor((Strength - 10) / 2) into @str_bonus
        from Attributes where Player_CharacterID = player_id;

    select floor((Dexterity - 10) / 2) into @dex_bonus
        from Attributes where Player_CharacterID = player_id;
    
    select floor((Constitution - 10) / 2) into @con_bonus
        from Attributes where Player_CharacterID = player_id;

    select floor((Intelligence - 10) / 2) into @int_bonus
        from Attributes where Player_CharacterID = player_id;

    select floor((Wisdom - 10) / 2) into @wis_bonus
        from Attributes where Player_CharacterID = player_id;

    select floor((Charisma - 10) / 2) into @cha_bonus
        from Attributes where Player_CharacterID = player_id;

    -- Fetch proficiencies
    insert into prof
    select Proficiency
    from Player_Character_Proficiency
    where Player_CharacterID = player_id;
   
    -- Str bonus skills
    if exists(
        select proficiency 
        from prof
        where proficiency = 'Athletics' 
    ) then
        update Player_Character_Skill_Bonus
        set Athletics = 0 + @str_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Athletics = 0 + @str_bonus
        where Player_CharacterID = player_id;
    end if;

    -- Dex bonus skills
    if exists(
        select proficiency 
        from prof
        where proficiency = 'Acrobatics' 
    ) then
        update Player_Character_Skill_Bonus
        set Acrobatics = 0 + @dex_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Acrobatics = 0 + @dex_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Sleight_of_Hand' 
    ) then
        update Player_Character_Skill_Bonus
        set Sleight_of_Hand = 0 + @dex_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Sleight_of_Hand = 0 + @dex_bonus
        where Player_CharacterID = player_id;
    end if;


    if exists(
        select proficiency 
        from prof
        where proficiency = 'Stealth' 
    ) then
        update Player_Character_Skill_Bonus
        set Stealth = 0 + @dex_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Stealth = 0 + @dex_bonus
        where Player_CharacterID = player_id;
    end if;

    -- Intelligence Skills
    if exists(
        select proficiency 
        from prof
        where proficiency = 'Arcana' 
    ) then
        update Player_Character_Skill_Bonus
        set Arcana = 0 + @int_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Arcana = 0 + @int_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'History' 
    ) then
        update Player_Character_Skill_Bonus
        set History = 0 + @int_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set History = 0 + @int_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Investigation' 
    ) then
        update Player_Character_Skill_Bonus
        set Investigation = 0 + @int_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Investigation = 0 + @int_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Nature' 
    ) then
        update Player_Character_Skill_Bonus
        set Nature = 0 + @int_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Nature = 0 + @int_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Religion' 
    ) then
        update Player_Character_Skill_Bonus
        set Religion = 0 + @int_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Religion = 0 + @int_bonus
        where Player_CharacterID = player_id;
    end if;

    -- Wisdom Skill Bonus
    if exists(
        select proficiency 
        from prof
        where proficiency = 'Animal_Handling' 
    ) then
        update Player_Character_Skill_Bonus
        set Animal_Handling = 0 + @wis_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Animal_Handling = 0 + @wis_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Insight' 
    ) then
        update Player_Character_Skill_Bonus
        set Insight = 0 + @wis_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Insight = 0 + @wis_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Medicine' 
    ) then
        update Player_Character_Skill_Bonus
        set Medicine = 0 + @wis_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Medicine = 0 + @wis_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Perception' 
    ) then
        update Player_Character_Skill_Bonus
        set Perception = 0 + @wis_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Perception = 0 + @wis_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Survival' 
    ) then
        update Player_Character_Skill_Bonus
        set Survival = 0 + @wis_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Survival = 0 + @wis_bonus
        where Player_CharacterID = player_id;
    end if;

    -- Charisma Skill Bonuses
    if exists(
        select proficiency 
        from prof
        where proficiency = 'Deception' 
    ) then
        update Player_Character_Skill_Bonus
        set Deception = 0 + @cha_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Deception = 0 + @cha_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Intimidation' 
    ) then
        update Player_Character_Skill_Bonus
        set Intimidation = 0 + @cha_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Intimidation = 0 + @cha_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Performance' 
    ) then
        update Player_Character_Skill_Bonus
        set Performance = 0 + @cha_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Performance = 0 + @cha_bonus
        where Player_CharacterID = player_id;
    end if;

    if exists(
        select proficiency 
        from prof
        where proficiency = 'Persuasion' 
    ) then
        update Player_Character_Skill_Bonus
        set Persuasion = 0 + @cha_bonus + @prof_bonus
        where Player_CharacterID = player_id;
    else 
        update Player_Character_Skill_Bonus
        set Persuasion = 0 + @cha_bonus
        where Player_CharacterID = player_id;
    end if;

    drop table prof;

end//
delimiter ;

drop procedure if exists update_class_proficiencies;

delimiter //
create procedure update_class_proficiencies(in class_id int)
begin

    declare pcid int;
    declare done int default false;
    declare cur cursor for 
        select ID
        from Player_Character p
        where p.Class = class_id;
    declare continue handler for not found set done = true;


    open cur;
    myloop: loop
        fetch next from cur into pcid;
        if done then
            leave myloop;
        end if;
        call proficiency_table_update(pcid);
        call skill_bonus_update(pcid);
    end loop myloop;
    close cur;

end//
delimiter ;

drop procedure if exists update_background_proficiencies;

delimiter //
create procedure update_background_proficiencies(in background_id int)
begin

    declare pcid int;
    declare done int default false;
    declare cur cursor for 
        select ID
        from Player_Character p
        where p.Background = background_id;
    declare continue handler for not found set done = true;

    open cur;
    myloop: loop
        fetch next from cur into pcid;
        if done then
            leave myloop;
        end if;
        call proficiency_table_update(pcid);
        call skill_bonus_update(pcid);
    end loop myloop;
    close cur;

end//
delimiter ;


-- TRIGGERS

-- Class_Proficiency update
drop trigger if exists class_prof_update;
delimiter //
create trigger class_prof_update
after update on Class_Proficiency
for each row
begin
    
    delete from Player_Character_Proficiency
    where Player_CharacterID in (
        select p1.ID
        from Player_Character p1
        where p1.Class = old.Class
    )
    and Proficiency = old.Proficiency;

    insert into Player_Character_Proficiency
    select p2.ID, new.Proficiency
    from Player_Character p2
    where p2.Class = new.Class;


end//
delimiter ;

drop trigger if exists class_prof_insert;
delimiter //
create trigger class_prof_insert
after update on Class_Proficiency
for each row
begin

    insert into Player_Character_Proficiency
    select p.ID, new.Proficiency
    from Player_Character p
    where p.Class = new.Class;

end//
delimiter ;

drop trigger if exists class_prof_delete;
delimiter //
create trigger class_prof_delete
after update on Class_Proficiency
for each row
begin

    delete from Player_Character_Proficiency
    where Player_CharacterID in (
        select p1.ID
        from Player_Character p1
        where p1.Class = old.Class
    )
    and Proficiency = old.Proficiency;
    
end//
delimiter ;

drop trigger if exists background_prof_update;
delimiter //
create trigger background_prof_update
after update on Background_Proficiency
for each row
begin
    
    delete from Player_Character_Proficiency
    where Player_CharacterID in (
        select p1.ID
        from Player_Character p1
        where p1.Background = old.Background
    )
    and Proficiency = old.Proficiency;

    insert into Player_Character_Proficiency
    select p2.ID, new.Proficiency
    from Player_Character p2
    where p2.Background = new.Background;


end//
delimiter ;

drop trigger if exists background_prof_insert;
delimiter //
create trigger background_prof_insert
after update on Background_Proficiency
for each row
begin

    insert into Player_Character_Proficiency
    select p2.ID, new.Proficiency
    from Player_Character p2
    where p2.Background = new.Background;


end//
delimiter ;

drop trigger if exists background_prof_delete;
delimiter //
create trigger background_prof_delete
after update on Background_Proficiency
for each row
begin
    
    delete from Player_Character_Proficiency
    where Player_CharacterID in (
        select p1.ID
        from Player_Character p1
        where p1.Background = old.Background
    )
    and Proficiency = old.Proficiency;


end//
delimiter ;

drop trigger if exists player_update;
delimiter //
create trigger player_update
after update on Player_Character
for each row
begin

    if(new.Class <> old.Class) then
        delete from Player_Character_Proficiency p
        where p.Player_CharacterID = new.ID
        and p.Proficiency in (
            select c.Proficiency
            from Class_Proficiency c
            where c.Class = old.Class
        ) and p.Proficiency not in (
            select b1.Proficiency
            from Background_Proficiency b1
            where b1.Background = new.Background
        );

        insert into Player_Character_Proficiency
        select new.ID, c2.Proficiency
        from Class_Proficiency c2
        where c2.Class = new.Class;

    end if; 

    if (new.Background <> old.Background) then
        delete from Player_Character_Proficiency p1
        where p1.Player_CharacterID = new.ID
        and p1.Proficiency in (
            select b.Proficiency
            from Background_Proficiency b
            where b.Background = old.Background
        ) and p1.Proficiency not in (
            select c1.Class
            from Class_Proficiency c1
            where c1.Class = new.Class
        );

        insert into Player_Character_Proficiency
        select new.ID, b2.Proficiency
        from Background_Proficiency b2
        where b2.Background = new.Background;

    end if;

end//
delimiter ;

drop trigger if exists player_insert;
delimiter //
create trigger player_insert
after insert on Player_Character
for each row
begin

    insert into Player_Character_Proficiency
    select new.ID, c2.Proficiency
    from Class_Proficiency c2
    where c2.Class = new.Class;

    insert into Player_Character_Proficiency
    select new.ID, b2.Proficiency
    from Background_Proficiency b2
    where b2.Background = new.Background
	and b2.Proficiency not in (
		select c3. Proficiency
		from Class_Proficiency c3
		where c3.Class = new.Class
	);


end//
delimiter ;

drop trigger if exists player_delete;
delimiter //
create trigger player_delete
after delete on Player_Character
for each row
begin

    delete from Player_Character_Proficiency p
    where p.Player_CharacterID = old.ID;

	delete from Player_Character_Action a
    where a.Player_Character = old.ID;

	delete from Player_Character_Equipment e
    where e.Player_Character = old.ID;
	
	delete from Player_Character_Equipment_Proficiency ep
    where ep.Player_CharacterID = old.ID;
	
	delete from Player_Character_Feat f
    where f.Player_Character = old.ID;
	
	delete from Player_Character_Feature fe
    where fe.Player_Character = old.ID;
	
	delete from Player_Character_Language l
    where l.Player_CharacterID = old.ID;
	
	delete from Player_Character_Magic_Item m
    where m.Player_Character = old.ID;
	
	delete from Player_Character_Skill_Bonus s
    where s.Player_CharacterID = old.ID;
	
	delete from Player_Character_Spell sp
    where sp.Player_Character = old.ID;

end//
delimiter ;

drop trigger if exists equipment_delete;
delimiter //
create trigger equipment_delete
after delete on Equipment
for each row
begin

    delete from Player_Character_Equipment p
    where p.Equipment = old.EquipmentID;

end//
delimiter;

drop trigger if exists magic_item_delete;
delimiter //
create trigger magic_item_delete
after delete on Magic_Item
for each row
begin

    delete from Player_Character_Magic_Item p
    where p.Magic_Item = old.Magic_ItemID;

end//
delimiter;

drop trigger if exists feat_delete;
delimiter //
create trigger feat_delete
after delete on Feat
for each row
begin

    delete from Player_Character_Feat p
    where p.Feat = old.FeatID;

end//
delimiter;

drop trigger if exists feature_delete;
delimiter //
create trigger feature_delete
after delete on Feature
for each row
begin

    delete from Player_Character_Feature p
    where p.Feature = old.FeatureID;

    delete from Feature_Creature f
    where f.Feature = old.FeatureID;

end//
delimiter;

drop trigger if exists spell_delete;
delimiter //
create trigger spell_delete
after delete on Spell
for each row
begin

    delete from Player_Character_Spell p
    where p.Spell = old.SpellID;

    delete from Creature_Spell c
    where c.Spell = old.SpellID;

end//
delimiter;

drop trigger if exists action_delete;
delimiter //
create trigger action_delete
after delete on Action
for each row
begin

    delete from Player_Character_Action p
    where p.Action = old.ActionID;

    delete from Creature_Action c
    where c.Action = old.ActionID;

end//
delimiter;



-- VIEW
-- Gives all information for a single character
drop view if exists full_view;
create view full_view as
select Name, Description, Level, HP, Max_HP, Armor_Class, Proficiency_Bonus, 
(
    select Strength
    from Attributes 
    where Player_CharacterID = p.ID
) as "Strength",
(
    select Dexterity
    from Attributes 
    where Player_CharacterID = p.ID
) as "Dexterity",
(
    select Constitution
    from Attributes 
    where Player_CharacterID = p.ID
) as "Constitution",
(
    select Intelligence
    from Attributes 
    where Player_CharacterID = p.ID
) as "Intelligence",
(
    select Wisdom
    from Attributes 
    where Player_CharacterID = p.ID
) as "Wisdom",
(
    select Charisma
    from Attributes 
    where Player_CharacterID = p.ID
) as "Charisma",
(
    select Name
    from Background 
    where BackgroundID = p.Background
) as "Background",
(
    select Name
    from Race 
    where RaceID = p.Race
) as "Race",
(
    select Name
    from Class 
    where ClassID = p.Class
) as "Class",
Creator
from Player_Character p;