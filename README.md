# Quote App

This is a Flutter based app which shows random quotes, searches quotes and also saves your favourites.

**API used for the quotes :** https://github.com/lukePeavey/quotable
**Favourites :**  [Sqflite](https://pub.dev/packages/sqflite) Package is used for storing the data in local device. 

# Home Page

Home Page shows a variety of quotes ranging from most notable scientists to artists. It also has a like button to save into favourites

<p align="center">
  <img src="screenshots\home.jpeg" width="200" height="400" title="Home Page">
</p>

>The Home pages can refresh and show new quotes every time users pull down to refresh the page.
><p align="center">
  <img src="screenshots\refresh_home.jpeg" title="Refresh Home Page">
</p>



# Favourites

Favourites Page shows all the favourites quotes that you have liked in the past. All the quotes are stored under a database in the local device folder of your phone. Using the SQLflite package, you can delete any favourites or delete all of them at once using the button at the bottom right.
>This page also has a custom widget when there are no favourites indicating to add more favourites.


# Search Page

The Search Page intially shows the quotes of famous writers you might recognize and has a search bar to search all the favourites authors you want to find out. It also has a limit no of quotes feature that can limit the number of quotes as per the demand (default:10)
