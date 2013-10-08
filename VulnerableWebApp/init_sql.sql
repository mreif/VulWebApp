# 
# 1. create mysql server
# 2. import that script
# 3. be happy

#drop schema `hack`;


CREATE DATABASE  IF NOT EXISTS `hack` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `hack`;

###
##  create user table
### 

CREATE  TABLE IF NOT EXISTS `hack`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = MyISAM DEFAULT CHARSET=latin1;

###
##  insert some datasets to user table
###

INSERT INTO `user` (`username`, `password`) VALUES
('leo', '098f6bcd4621d373cade4e832627b4f6'),
('thisuserisverysecret', '5ebe2294ecd0e0f08eab7690d2a6ee69'),
('admin', '482c811da5d5b4bc6d497ffa98491e38'),
('bigbob', 'bdc65274e31c69574d9fb761f15534f3'),
('micha', 'b6dc2f75da9ff3de76ad30b1f3bf3ea5');

###
##  create guestbookentry table
### 

CREATE  TABLE IF NOT EXISTS `hack`.`guestbookentry` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `entry` TEXT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM DEFAULT CHARSET=latin1;

###
##  insert some guestbookentry
###

INSERT INTO `guestbookentry` (`name`, `entry`) VALUES
('gast', 'Hallo! Schoene Ideen habt ihr hier. Ich hab schon zwei davon ausprobiert und es war ein voller Erfolg!'),
('catwoman', 'Ich bin begeistert! Bitte weiter so!!!!! :)');

###
## create gift table
###

CREATE  TABLE IF NOT EXISTS `hack`.`gift` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NOT NULL ,
  `needed_time` VARCHAR(150) NOT NULL ,
  `material` TEXT NOT NULL ,
  `instructions` TEXT NOT NULL ,
  `picture_path` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = MyISAM DEFAULT CHARSET=latin1;

###
##  create some gifts
###

INSERT INTO `gift` (`name`,`description`, `needed_time`, `material`, `instructions`, `picture_path`) VALUES
('Selbstgemachte Gutscheine', 'Selbst druckbare Coupons sind ein Geschenk für jedermann. Man kann sie in Grußkarten hineinstecken oder als kleines eigenes Geschenk verschenken. In letzterem Fall kann man auch mehrere ausdrucken und diese in ein kleines Heft oder Buch machen. Alles was sie dafür brauchen ist ein bisschen Kreativität, einen Computer mit Drucker und ein Grafikprogramm, wie z.B. Paint.',
'unbekannt','Drucker,Computer,Grafikprogramm (z.B. Paint)', '', 'img/giftpics/1_coupon.jpg'),
('Mousepad', 'Endecken Sie wie Sie ein direkt auf ihre Bedürfnisse zugeschnittenes Mousepad erstellen können. Dieses Mousepad kann an verschiedene Persönlichkeiten oder Dekorationen angepasst werden. Probieren Sie es aus und kreieren Sie eins für ein ganz spezielles Geschenk.',
'ca. 30 Minuten (ohne Trockungszeit)',
'Schaumstoff zum basteln,rutschfeste Unterlage,wasserfeste Eddings (verschiedene Farben),einfaches weißes Papier, beliebige Dekorationsobjekte, Kleber,Schere',
'Nehmen Sie die rutschfeste Unterlage und scheiden Sie sie auf die gleiche Größe wie den Schaumstoff. Tragen Sie nun eine dünne Schicht Kleber auf den Schaumstoff auf und legen Sie die Unterlage darüber. Achten Sie darauf, dass eine glatte Oberfläche bestehen bleibt. Nun warten Sie bis der Kleber getrocknet ist. Tun Sie am besten ein schweres Buch darauf.

Nach dem alles getrocknet ist müssen Sie sich die Form entscheiden, die Ihr Mousepad haben soll. Ob rund, eckig oder völlig beliebig ist egal. Sie sollten jediglich darauf achten, dass es groß genug ist um die Mouse ohne Einschränkungen zu manövrieren. Am besten erstellen Sie sich eine Vorlage, vielleicht mit am Computer, drucken sie aus und scheiden sie zurecht. Anhand dieser Vorlage können Sie nun ihr Mousepad zurechtschneiden.

Nun kann das Mousepad dekoriert werden. Verwenden Sie dafür die Eddings um beliebige Motive zu Malen oder das Mousepad zu dekorieren. Außerdem können Sie alles was Sie wollen an das äußere Ende des Mousepad kleben um es so noch weiter zu verschönern!

Sobald alles getrocknet ist können Sie das Mousepad benutzen oder verschenken! Viel Spaß!',
'img/giftpics/2_craftMousepad.jpg'),
('Aufbewahrungsbox',
'Finde herraus wie du dieses großartige Aufbewahrungsbox aus einer Kaffeedose oder ähnlichen machen kannst. Das gibt ein perfektes Geschenk für jeden ab!',
'ca. 30 Minuten (ohne Trockungszeit)',
'Kaffeedose oder ähnliches,Magazine/Zeitschriften und/oder Kataloge,Stifte,Kleber,Leim oder Lack,Schere',
'Erstmal solltest du sicher stellen, dass die Dose sauber und trocken ist. Dann musst du zunächst über ein Konzept nachdenken. Suche in den Zeitschriften und Katalogen nach tollen Motiven die der Person gefallen könnten und schneide diese aus. Natürlich sind auch Fotos oder ähnliches möglich. Suche dir nun die besten Bilder aus und beklebe die Dose bis alles bedeckt ist. Verwende nun Buchstaben oder Stifte, um eine Nachricht oder den Namen auf die Dose zu schreiben.

Ist die Dose soweit fertiggestellt muss das Design für längeren Halt versiegelt werden. Besteichen Sie die Dose mit verdünntem Leim oder einem Klarlack um das Motiv zu schützen und länger ansehnlich zu machen. Ist alles trocken hast du ein super Geschenk!',
'img/giftpics/3_daddycaddy.jpg'),
('Verzierter Bleistift',
'Folge diesen einfach Instruktionen and verschönere einen Bleistift mit einem Band und Perlen. Du wirst nicht glauben wie einfach es ist, deinen Bleistift zu verschönern.',
'ca. 15 Minuten (ohne Trockungszeit)',
'Bleistift,ein Stueck Band,Perlen,Basterkleber,Schere',
'Entferne vosichtig den Radiergummi am Ende des Bleistifts und lege ihn beiseite.

Nun kannst du ein Stückchen Band zurecht schneiden. Mache nun einen kleinen Knoten in das Band. Fädele weitere Perlen auf bis nur noch gut 2cm Platz sind. Nun kann das Band kurz hinter dem Knoten abgeschnitten werden.

Zur Befestigung musst du nun ein bisschen Kleber in das Radiergummiloch geben. Jetzt kann das Band vorsichtig reindrückt werden. Nun den Radiergummi wieder vorsichtig in das Loch schieben und alles trocknen lassen. Fertig ist der Bleistift!',
'img/giftpics/4_dangpenbdth.jpg'),
('Ein ganz besonderes Geschenk',
'Benutzen Sie diese Anleitung um ein spezielles Geschenk fuer ganz besondere Menschen zu machen. Sie können es nutzen wie es ist oder es modifizeren, was Sie daraus machen liegt ganz bei Ihnen!',
'ca. 30 Minuten (ohne Trockungszeit)',
'Schuhkarton oder ähnliche Box mit Deckel,Spiegel,Buntpapier,Malzeug,Stifte,Pinsel,Bastelkleber,Schere',
'Beginnen Sie damit, die Box von aussen zu bemalen. Warten Sie bis die Farbe getrocknet ist, dann können Sie die Box mit weiteren Gegenständen wie Bändern, Bilder oder ähnlichen verzieren wie Sie es wollen.

Erstellen Sie nun eine Nachricht mit dem Buntpapier und den Stiften. Da sollte soetwas stehen wie: "Die Person die hier abgebilded ist, ist eins der größten Geschenke in meinem Leben!" Ändern Sie diese Nachricht für eine genaue Personifizierung oder nach Ihrem Geschmack. Achtung es sollte alles in allem auf den Boden der Box passen.

Kleben sie nun einen Spiegel auf den Boden der Box. Sie sollten dazu in der Lage sein, den Spiegel zu sehen, wenn sie die Box öffnen. Zusätzlich sollten sie auch die Nachricht auf den Boden der Box kleben! Nun warten sie bis alles getrocknet ist und packen Sie das Geschenk dann ein. Fertig ist das spezielle Geschenk? Wissen Sie schon wem Sie eins anfertigen?',
'img/giftpics/5_FavoriteThingsCraft.jpg'),
('Krawattenshirt',
'Auch wenn dein Vater nicht der Typ für Krawatten ist, wird er diese Spaß Krawatte lieben! Du kannst jedem eine machen den du kennst, vielleicht sogar welche für Frauen.',
'ca. 30 Minuten (ohne Trockungszeit)',
'Buegelvlies,Stift,Stoff,T-Shirt,Buegeleisen,Schere',
'Zeichen Sie eine Krawatte auf das Papierseite des Bügelvlieses. Scheiden sie die Form aus und lassen Sie ca. 1'' außerhalb der Linie Platz.

Finden sie nun ein Stückchen Stoff, dass groß genug für ihre Krawatte ist. Am besten nehmen Sie einen Stoff mit einem Motiv das zu dem künftigen Träger passt. Sollte er Sport wie Fußball mögen, könnten z.B. Fußbaelle auf dem Stoff auftauchen.

Bügeln Sie das Bügelvlies, anhand der mitgelieferten Anleitung, auf die falsche Seite des Stück Stoffs. Lassen Sie alles abkühlen. Nun können Sie die Krawatte an der vorher gezeichneten Linie ausschneiden. Entfernen Sie nun das Papier von der Krawatte. Bügeln Sie nun das Bügelvlies auf das T-Shirt und lassen Sie wieder alles abkühlen.

Fertig ist ihr Krawatten-T-Shirt!',
'img/giftpics/6_NecktieTShirt.jpg');

###
##
###

CREATE  TABLE IF NOT EXISTS `hack`.`giftentry` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `rating` INT(10) UNSIGNED NOT NULL ,
  `commentary` TEXT NOT NULL ,
  `gift_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `fk_gift_entry` (`gift_id` ASC)
) ENGINE = MyISAM DEFAULT CHARSET=latin1;