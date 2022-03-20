## README do zadania dla LiveBank

Zakładam:
+ (zgodnie z instrukcją) uzycie najnowszej wersji terraform i providera (czyli brak wymagania konkretnej wersji)
+ wcześniejsze stworzenie Azure Storage-a i Container-a na potrzeby przetrzymywania State file (razem z regułami dostępu, np. bucket policies) - zakładam, że będzie przechowywany niezależnie od tworzonej przez terraform infrastruktury opisanej w zadaniu -> odpowiednie nazwy powinne zostać wpisane w backend.tf
+ wydzielenie niektórych plików dla wiekszej czytelności:
    ++ variables.tf -> zawierający zmienne stosowane a kodzie main.tf, które mogą się w przyszłości zmienić - np. inny region, rodzaj środowiska
    ++ outputs.tf -> typowo wyłącza się je dla czytelności tego co po dokonaniu deploymentu zostanie przekazane przez terraform na wyjściu
    ++ backend.tf -> do zdefiniowania miejsca przechowywania pliku Terraform State

Inne dobre praktyki:
+ użycie gotowych sprawdzonych i popularnych modułów społeczności -> nie korzystam, żeby zademonstrować umiejętność używania bazowych reasource-ów
+ użycie własnych modułów (w przypadku zastosowania kodu do tworzenia np. licznych zasobów) -> nie używam tu, bo nie wiem jak rozwijałoby się dalej to rozwiązanie - czy powiększałaby się liczba klastrów, czy subnetów - wtedy pojawiłyby się moduły je opakowujące
+ użycie konkretnej wersji terraform oraz providera od momentu pierwszego deploymentu (apply) -> zalecane, żeby zapewnić kompatybilność kodu z przyszłymi zmianami - ale w definicji zadania mam powiedziane, żeby nie zakładać

- FSzych