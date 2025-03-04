# Veigo 1

![image](https://github.com/user-attachments/assets/b6f08201-9fa3-462b-9186-9467cd2b9689)

SDDM Qt6 theme based on [Suave Dark](https://store.kde.org/p/2185222) by
[phob1an](https://store.kde.org/u/phob1an), featuring code by Abdurrahman
AVCI (see `ComboBox.qml`).

Changed most of the input elements to have hard rectangular edges,
fixed the combo box, which behaved weirdly, and changed the font family
to be [Croissant One](https://fonts.google.com/specimen/Croissant+One)
everywhere.

## Important

This theme does not provide a default background image. Instead, the
default configuration looks for one in `/usr/share/backgrounds/login.png`.

The preview uses the background image from the original Suave Dark.

## Usage

Assuming you are using SDDM,

1. Put the contents of this repository in a directory, which will be
   called `veigo1` for the sake of this example;
2. Put that directory, `veigo1`, inside `/usr/share/sddm/themes/`, such
   that now there is `/usr/share/sddm/themes/veigo1/`;
3. Add or edit a configuration file in `/etc/sddm.conf.d/`, say, for
   example, `/etc/sddm.conf.d/20-theme.conf`, to add the following field:

   ```desktop
   [Theme]
   Current=veigo1
   ```
4. Either put a PNG image on `/usr/share/backgrounds/login.png` or change
   `theme.conf` and `theme.conf.user` (located on
   `/usr/share/sddm/themes/veigo1/`) so that `General.background` points
   to some other image to use that image as the background.
