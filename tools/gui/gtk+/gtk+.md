# GTK+

[https://www.gtk.org/](https://www.gtk.org/)

## Work with the language of your choice

Develop your GTK app with your language of choice by using Language Bindings or wrappers and take full advantage of the official GNOME bindings which guarantee API stability and time-based releases.

[C](https://www.gtk.org/#list-c)[JavaScript](https://www.gtk.org/#list-javascript)[Perl](https://www.gtk.org/#list-pl)[Python](https://www.gtk.org/#list-py)[Rust](https://www.gtk.org/#list-rs)[Vala](https://www.gtk.org/#list-vala)

```
// Include gtk
#include <gtk/gtk.h>

static void on_activate (GtkApplication *app) {
  // Create a new window
  GtkWidget *window = gtk_application_window_new (app);
  // Create a new button
  GtkWidget *button = gtk_button_new_with_label ("Hello, World!");
  // When the button is clicked, close the window passed as an argument
  g_signal_connect_swapped (button, "clicked", G_CALLBACK (gtk_window_close), window);
  gtk_window_set_child (GTK_WINDOW (window), button);
  gtk_window_present (GTK_WINDOW (window));
}

int main (int argc, char *argv[]) {
  // Create a new application
  GtkApplication *app = gtk_application_new ("com.example.GtkApplication",
                                             G_APPLICATION_FLAGS_NONE);
  g_signal_connect (app, "activate", G_CALLBACK (on_activate), NULL);
  return g_application_run (G_APPLICATION (app), argc, argv);
}
```

## Apps built with GTK

Developers around the world have used GTK as a platform to create apps that solve problems faced by end-users.

[![Image Viewer](https://www.gtk.org/assets/img/apps/app-image-viewer.png)](https://wiki.gnome.org/Apps/EyeOfGnome)Image Viewer

[![Polari](https://www.gtk.org/assets/img/apps/app-polari.png)](https://wiki.gnome.org/Apps/Polari)Polari

[![Key Sign](https://www.gtk.org/assets/img/apps/app-key-sign.png)](https://wiki.gnome.org/Apps/Keysign)Key Sign

[![Maps](https://www.gtk.org/assets/img/apps/app-maps.png)](https://wiki.gnome.org/Apps/Maps)Maps

[![Transmission](https://www.gtk.org/assets/img/apps/app-transmission.png)](https://transmissionbt.com/)Transmission

[![Password Safe](https://www.gtk.org/assets/img/apps/app-password-safe.png)](https://gitlab.gnome.org/World/PasswordSafe)Password Safe

[![GIMP](https://www.gtk.org/assets/img/apps/app-gimp.png)](https://gimp.org/)GIMP

[![Fonts](https://www.gtk.org/assets/img/apps/app-fonts.png)](https://flathub.org/apps/details/org.gnome.font-viewer)Fonts

[![Calculator](https://www.gtk.org/assets/img/apps/app-calculator.png)](https://wiki.gnome.org/Apps/Calculator)Calculator

[![Dictionary](https://www.gtk.org/assets/img/apps/app-dictionary.png)](https://wiki.gnome.org/Apps/Dictionary)Dictionary

[![Games](https://www.gtk.org/assets/img/apps/app-games.png)](https://wiki.gnome.org/Apps/Games)Games

[![Evolution](https://www.gtk.org/assets/img/apps/app-evolution.png)](https://wiki.gnome.org/Apps/Evolution)Evolution

[![Image Viewer](https://www.gtk.org/assets/img/apps/app-image-viewer.png)](https://wiki.gnome.org/Apps/EyeOfGnome)Image Viewer

[![Polari](https://www.gtk.org/assets/img/apps/app-polari.png)](https://wiki.gnome.org/Apps/Polari)Polari

[![Key Sign](https://www.gtk.org/assets/img/apps/app-key-sign.png)](https://wiki.gnome.org/Apps/Keysign)Key Sign

[![Maps](https://www.gtk.org/assets/img/apps/app-maps.png)](https://wiki.gnome.org/Apps/Maps)Maps

[![Transmission](https://www.gtk.org/assets/img/apps/app-transmission.png)](https://transmissionbt.com/)Transmission

[![Password Safe](https://www.gtk.org/assets/img/apps/app-password-safe.png)](https://gitlab.gnome.org/World/PasswordSafe)Password Safe

[![GIMP](https://www.gtk.org/assets/img/apps/app-gimp.png)](https://gimp.org/)GIMP

[![Fonts](https://www.gtk.org/assets/img/apps/app-fonts.png)](https://flathub.org/apps/details/org.gnome.font-viewer)Fonts

[![Calculator](https://www.gtk.org/assets/img/apps/app-calculator.png)](https://wiki.gnome.org/Apps/Calculator)Calculator

[![Dictionary](https://www.gtk.org/assets/img/apps/app-dictionary.png)](https://wiki.gnome.org/Apps/Dictionary)Dictionary

[![Games](https://www.gtk.org/assets/img/apps/app-games.png)](https://wiki.gnome.org/Apps/Games)Games

[![Evolution](https://www.gtk.org/assets/img/apps/app-evolution.png)](https://wiki.gnome.org/Apps/Evolution)Evolution

[![Image Viewer](https://www.gtk.org/assets/img/apps/app-image-viewer.png)](https://wiki.gnome.org/Apps/EyeOfGnome)Image Viewer

[![Polari](https://www.gtk.org/assets/img/apps/app-polari.png)](https://wiki.gnome.org/Apps/Polari)Polari

[![Key Sign](https://www.gtk.org/assets/img/apps/app-key-sign.png)](https://wiki.gnome.org/Apps/Keysign)Key Sign

[![Maps](https://www.gtk.org/assets/img/apps/app-maps.png)](https://wiki.gnome.org/Apps/Maps)Maps

[![Transmission](https://www.gtk.org/assets/img/apps/app-transmission.png)](https://transmissionbt.com/)Transmission

[![Password Safe](https://www.gtk.org/assets/img/apps/app-password-safe.png)](https://gitlab.gnome.org/World/PasswordSafe)Password Safe

## Integrations for Rapid Application Development

Glade is a RAD tool that enables quick and easy development of user interfaces for the GTK toolkit and the GNOME desktop environment.

Check out this easy tutorial on [how to create a toolbar](https://developer.gnome.org/gnome-devel-demos/stable/toolbar_builder.py.html.en) using Glade.

![Integration of Glade and GTK](https://www.gtk.org/assets/img/wall-glade.png)

------

## A feature-rich development tool

GTK has all the features that a widget toolkit needs to have. These features make it the most trusted toolkit for developing Linux applications.



###### Portability

Projects built using GTK and its dependencies run on well known operating systems.



###### Stability

GTK delivers the enticing features and superb performance which adds to your applications.



###### Language Bindings

GTK is written in C but has been designed to support a wide range of languages such as Python, JavaScript, C++, Rust and [many more](https://www.gtk.org/docs/language-bindings/).



###### Interfaces

GTK has a comprehensive collection of core widgets like Buttons, Windows, Toolbars for use in your application.



###### Open Source

GTK is a free and open-source project maintained by GNOME and an active community of contributors. GTK is released under the terms of the [GNU Lesser General Public License](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html).



###### API

GTK boasts of an easy to use [API](https://www.gtk.org/docs/apis/) which helps in decreasing your development time and help you achieve better results.



###### Accommodation

GTK caters to many features like Native look and feel, theme support, Object-oriented approach that today’s developers look for in a toolkit.



###### Foundations

GTK is built on top of GLib. GLib provides the fundamental data types and system integration points to avoid duplicated code in applications.

##### Develop with GTK



By taking advantage of GTK being a cross-platform development tool and its easy to use API, you can develop amazing apps using the GTK. If you are interested in developing an app, get started now by developing this [example application](https://developer.gnome.org/gtk3/stable/ch01s04.html#id-1.2.3.12.5).

##### Develop GTK



GTK is a large project and relies on volunteers from around the world. To help us with the project development, hack away on the existing [bugs and feature requests](https://gitlab.gnome.org/GNOME/gtk/issues/).

##### Looking for Help?



If you want to ask questions about GTK, whether it’s for developing applications with GTK or contributing to GTK itself, you can use the GNOME [Discourse](https://discourse.gnome.org/) instance, under the [Platform/Core](https://discourse.gnome.org/c/platform/core) category. You can use tags like *gtk* or *glib* to narrow down the topic of discussion to specific libraries. You can also ask questions on our [IRC](irc://irc.gnome.org/%23gtk) channel.

## News and Events

##### Catch up with GTK development

Get in touch with GTK developers through [IRC](irc://irc.gnome.org/%23gtk). Get daily updates about GTK and its community from [GTK blog](https://blog.gtk.org/) or through its [Twitter](https://twitter.com/GTKtoolkit/) account.

##### Meet the community

As regularly as possible, GTK team meetings take place at [conferences](https://guadec.org/) and [hackfests](https://wiki.gnome.org/Hackfests) to discuss the future of GTK and define a [roadmap](https://wiki.gnome.org/Projects/GTK/Roadmap).

##### Contribute to GTK

If you are a developer and want to contribute to GTK, you are more than [welcome to do so](https://www.gtk.org/docs/getting-started/).