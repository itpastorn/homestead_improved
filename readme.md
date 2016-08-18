# Itpastorn's Homestead Improved

A fork of [the fork](https://github.com/Swader/homestead_improved) of the [original Laravel Homestead](https://laravel.com/docs/5.2/homestead), for my students.

## Hur du använder detta projekt

 1. Hämta hem och installera Git, [VirtualBox](https://www.virtualbox.org/) och [Vagrant](https://www.vagrantup.com/) enligt instruktioner i arbetsboken.
 2. Du förutsätts ha en mappstruktur enligt arbetsbokens rekommendation. Den summeras i kommande punkter (3-5).
 3. Sökvägen till din hemkatalog är vanligtvis C:\Users\*username*\ på Windows och /home/*username*/ på Linux och Mac OS X.
 4. I din hemmamapp bör du ha en säkerhetskopiering med en molntjänst (Dropbox, OneDrive, Google Drive eller liknande). iCloud är svår att använda i det här sammanhanget pga. Apples krångliga sökvägar. Har du ingen molntjänst, ersätt *cloud* nedan med den katalog du använder lokalt, exempelvis *Documents*. Tips: Utforska dina kataloger på din dator med *kommandotolken* för att se vad de heter.
 5. Detta är din mappstruktur:
TODO: Kläm in en mapp ("webdev") mellan moln och webprojects och ips-hs
```javascript
    ~
    + (molntjänstmapp)
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
De enda mapparna som redan **måste** vara skapade ännu är alltså *webprojects* och *webbutveckling-1* med undermappen *html*.

 6. Starta kommandotolken och använd kommandot cd för att ställa dig i *molntjänstmappen*.
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
  11. Avsluta surfningen på servern:
```bash
vagrant halt
```

## Förklaring TODO

När du laddat ner det här projektets filer och kört installationsskriptet kommer du ha fått följande server på din dator:

En virtuell

## Extra

https://scotch.io/tutorials/how-to-setup-ssh-public-key-authentication


## Varför kalla katalogen "ips-hs"

Det är en förkortning av itpastorns Homestead Improved.

## Original comments - things do not work exactly the same any more, but the tutorial is still useful
Homestead Improvedaims to make things even simpler. See full explanation with quickstart tutorial [here](http://www.sitepoint.com/quick-tip-get-homestead-vagrant-vm-running/).
