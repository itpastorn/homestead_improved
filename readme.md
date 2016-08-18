# Itpastorn's Homestead Improved

A fork of [the fork](https://github.com/Swader/homestead_improved) of the [original Laravel Homestead](https://laravel.com/docs/5.2/homestead), for my students.

## Hur du använder detta projekt

 1. Hämta hem och installera Git, [VirtualBox](https://www.virtualbox.org/) och [Vagrant](https://www.vagrantup.com/) enligt instruktioner i arbetsboken.
 2. Du förutsätts ha en mappstruktur enligt arbetsbokens rekommendation. Den summeras i kommande punkter (3-5).
 3. Sökvägen till din hemkatalog är vanligtvis C:\Users\\*username*\ på Windows och /home/*username*/ på Linux och Mac OS X.
 4. I din hemmamapp bör du ha en mapp som säkerhetskopieras med en molntjänst, som Dropbox, OneDrive eller Google Drive. (iCloud är svår att använda i det här sammanhanget pga. Apples krångliga sökvägar.) Har du ingen molntjänst, ersätt mappen *cloud* nedan med den katalog du använder lokalt, exempelvis *Documents*. Tips: Utforska dina kataloger på din dator med *kommandotolken* för att se vad de heter. Utforskaren i Windows och Finder på Mac har "användarvänliga" namn på mapparna, som inte stämmer överens med vad de egentligen heter i filsystemet.
 5. Detta är din mappstruktur:
```javascript
    ~
    + (molntjänstmapp)
      + webdev   // Allt du gör
       + ips-hs  // Denna mapp kommer du snart att skapa med Git
       + webprojects
         + webbutveckling-1 // Denna katalog måste finnas enligt bokens instruktioner
           + html
         + webbserverprogrammering-1       // Denna katalog kan skapas senare
           + html
         + webbutveckling-1-slutuppgift    // Ditto 
           + html
         + webbserverprogrammering-1-slutuppgift // Ditto
           + html
```
De enda mapparna som redan **måste** vara skapade ännu är alltså *webdev* som innehåller mappen *webprojects* och den innehåller i sin tur mappen *webbutveckling-1* med undermappen *html*. (Dessa skapas i "Uppgift noll" i arbetsboken.)

 6. Starta kommandotolken och använd kommandot cd för att ställa dig i mappen *webdev*.
 7. Skriv dessa kommandon, exklusive kommentarerna som börjar med #
```bash
git clone --depth=1 https://github.com/itpastorn/itps-homestead-improved.git ips-hs # Hämtar detta projekt
cd ips-hs
bash folderfix.sh  # Skapar inställningar i filen Homestead.yaml - titta gärna i den
vagrant up
```
  8. Redigera filen som heter *hosts*
     a. I Windows ligger den i mappen *C:\Windows\system32\drivers\etc*
     b. På Mac OS X och Linux ligger den i mappen /etc
     c. Du kan behöva administratörsprivilegier för att kunna ändra i hosts-filen
     d. Du ska lägga till följande rader:

```
192.168.10.10	wu1-ovningar.app
192.168.10.10	wu1-slutuppgift.app
192.168.10.10	ws1-ovningar.app
192.168.10.10	ws1-slutuppgift.app
```
  9. Öppna en webbläsare och skriv följande adress: http://wu1-ovningar.app/tests/
  10. Kontrollera att installationen fungerat genom att klicka på länkarna. Använd bakåtpilen för att se alla de tre testsidorna.
  11. 
  12. Stäng av servern:
```bash
vagrant halt
```

## Förklaring TODO

När du laddat ner det här projektets filer och kört installationsskriptet kommer du ha fått följande server på din dator:

 1. En virtuell *virtuell maskin*, med operativsystemet Ubuntu, som är en en linuxdistribution.
 2. På den maskinen körs *webbservern* Nginx, med stöd för PHP och MariaDB (som liknar MySQL).
 3. Webbservern har fyra färdigkonfigurerade virtuella *värdar*. Det är dessa du når tack vare att du redigerat hosts-filen.
 4. Webbroten för var och en av dessa är den mapp som heter *html*.
 5. Alla filer som ligger i *projektroten* kommer att vara åtkomliga såväl som vanligt på den dator du jobbar, och inuti den virtuella maskinen. De utgör en delad arbetsyta. Ändringar i en fil utanför den virtuella maskinen kommer därför att vara synlig inuti den virtuella maskinen, utan att du behöver skicka upp den med FTP eller någon annan teknik för filöverföring. (För servrar som är publika vill man inte ha med allt på servern, utan bara vissa delar, men för utveckling är detta inget problem.)
 6. Inställningarna för den virtuella maskinen och servrarna finns i en fil som heter *Homestead.yaml*. Titta gärna på den. Härma det som redan står i filen om du vill lägga till fler virtuella värdar.

Lär dig följande kommandon, som måste skrivas när du står i katalogen *ips-hs*:
```bash
  vagrant up         # Bootar up den virtuella maskinen
  vagrant halt       # Stänger av den
  vagrant destroy    # Stänger av och tar bort den. Används om du behöver börja om.
  vagrant provision  # Används för att på nytt läsa in Homestead.yaml om den ändrats
  vagrant            # Visar hjälp
  vagrant -h foo     # Visar hjälp om kommandot foo
```
[Manual för Vagrantkommandon](https://www.vagrantup.com/docs/cli/)

## Extra

https://scotch.io/tutorials/how-to-setup-ssh-public-key-authentication


## Varför kalla katalogen "ips-hs"

Det är en förkortning av itpastorns Homestead Improved.

## Original comments - things do not work exactly the same any more, but the tutorial is still useful
Homestead Improvedaims to make things even simpler. See full explanation with quickstart tutorial [here](http://www.sitepoint.com/quick-tip-get-homestead-vagrant-vm-running/).
