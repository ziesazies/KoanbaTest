
# Movie TMDB

Applikasi Movie TMDB mempunyai fitur Searchable, Paginated List, Pull To Refresh.
aplikasi ini juga menggunakan database untuk menghandle offline case.


## Documentation

1. Applikasi ini tidak menggunakan third-party libraries

   untuk memanggil data dari api dan fetch gambar dari url menggunakan URLSession.

2. UI 

   ui di buat dengan cara programatically dengan uikit

3. architeture

   applikasi Movie TMDB mengunakan mvvm clean architeture dimana business logic ada di domain layer. domain layer berisi entities,  use case dan repository.

4. modular

    aplikasi ini menggunakan modular, dimana terdapat beberapa module yang di split. diantaranya ada module Domain, Network dan movie. untuk menjalankan applikasi ini bisa double click file ModularMovie.xcworkspace.

5. Coredata

   menggunakan coredata sebagai database offline datasource 

6. Combine

   menggunakan combine untuk komunikasi antara controller dan viewmodel

