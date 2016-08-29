# Om PHP:s inställningar

## php.ini

Php styrs av en settingsfil som heter *php.ini* inuti den virtuella maskinen.
Sökvägen till filen är när detta skrivs

    /etc/php/7.0/fpm/

Kanske har du en annan version av PHP aktiverad.

För att kontrollera detta, se till att din virtuella maskin är startad:

```bash
    cd path/to/ips-hs
    vagrant status
    vagrant up   # Om det behövs
```

Gå sedan till http://servertest.app i en webbläsare och följ länken "Information 
om PHP-installationen". Fjärde raden du ser är "Configuration File
(php.ini) Path". Lägg den på minnet.

## Om felrapporteringen inte stämmer

Gå till http://serverstest.app och följ länken "Klarar installationen
bokens krav?"

Om du inte får godkänt på *display_errors* eller *error_reporting*
behöver du ändra i din php.ini-fil. Gå till terminalen och skriv detta:

```bash
    cd path/to/ips-hs
    vagrant ssh
    cd /etc/php/7.0/fpm/ # Eller vad du såg i förra avsnittet
    sudo nano php.ini
```

Du kommer då in i editorn nano. Alla rader som börjar med semikolon är
kommentarer. Hitta dessa båda raderna, som inte är kommentarer och se
till att de har följande värden. Du kan söka med CTRL + W.

    error_reporting = E_ALL
    display_errors = On

Avsluta med CTRL + X och svara Y(es) om att spara ändringarna.

Lämna sedan SSH och starta om vagrant-maskinen

```bash
    CTRL + D # exit
    vagrant reload --provision
```
Nu bör det fungera!