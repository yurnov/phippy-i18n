# Polski słownik terminologiczny

Ten słownik określa, jak zostały przetłumaczone terminy techniczne w polskiej wersji książek
Phippy & Friends.

Polskie odpowiedniki zostały dobrane przede wszystkim na podstawie terminologii używanej w
oficjalnej polskiej dokumentacji Kubernetesa (`kubernetes.io/pl/`, źródło: repo
`kubernetes/website`, katalog `content/pl/`). W miarę możliwości sprawdzono również CNCF Cloud
Native Glossary, aby upewnić się, że znaczenie poszczególnych terminów zostało właściwie
zachowane.

Nazwy i terminy powszechnie używane po angielsku w polskim środowisku technicznym nie zostały
przetłumaczone na siłę. Nadrzędną zasadą było stosowanie terminologii już przyjętej w polskim
środowisku technicznym. Jeśli powszechnie używany jest termin angielski, pozostawiono go w
oryginale zamiast tworzyć jego sztuczny polski odpowiednik. W przypadku wątpliwości sprawdzano,
jakie określenie jest już stosowane w polskiej dokumentacji.

**CNCF Cloud Native Glossary (`glossary.cncf.io`) nie jest dostępny w języku polskim.** Wśród
dostępnych tłumaczeń znajdują się m.in. wersje bengalska, francuska, niemiecka, hindi, włoska,
japońska, koreańska, portugalska, rosyjska, chińska (uproszczona i tradycyjna), hiszpańska,
turecka, urdu oraz wietnamska. Język polski nie jest obecnie dostępny, dlatego słownik CNCF nie
może posłużyć do sprawdzenia, jakie polskie odpowiedniki tych terminów są już stosowane. W tym
celu wykorzystana została polska dokumentacja Kubernetesa (`kubernetes.io/pl/docs/`).

Ważna uwaga dotycząca polskiej dokumentacji Kubernetesa (`kubernetes.io/pl/`): nie wszystkie jej
części zostały przetłumaczone w takim samym zakresie. W języku polskim dostępne są strony główne
poszczególnych sekcji (`_index.md`) oraz strony dotyczące Podów, Etykiet i Przestrzeni nazw. To
właśnie te materiały posłużyły jako główne źródło terminologii przedstawionej poniżej. Strony
poświęcone `Service` (`services-networking/service/`) i `Volumes` (`storage/volumes/`) nie mają
jeszcze polskiego tłumaczenia. Ich odpowiedniki w polskiej wersji serwisu `/pl/` zwracają błąd
404. Po polsku dostępne są jedynie strony główne sekcji, do których te materiały należą
(`_index.md`). Dlatego w przypadku terminów `Service` i `Volume` sposób ich użycia został
ustalony na podstawie innych stron, które mają polskie tłumaczenie. Na przykład na stronie
dotyczącej Przestrzeni nazw wielokrotnie pojawia się zarówno nazwa `Service`, jak i polskie
określenia „usługa” oraz „usługi”. Podobnie nie istnieje osobna polska strona dla `ReplicaSet`.
Sposób odmiany tej nazwy został przyjęty przez analogię do `Deployment`, którego nazwa jest
odmieniana na przetłumaczonych stronach dokumentacji.

## Tabela terminów

| Angielski | Polski | Uzasadnienie / źródło |
|---|---|---|
| container | kontener | Ustalony termin w `kubernetes.io/pl` — „jeden lub więcej kontenerów”, „środowisko uruchomieniowe kontenerów”. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| cluster | klaster | Standardowy, w pełni spolszczony termin w dokumentacji PL — „Pody w klastrze Kubernetesa”. [Przestrzenie nazw (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/namespaces/) |
| node | węzeł (w tekście), `Node` z wielkiej litery przy odwołaniu do rodzaju zasobu | Dokumentacja PL używa „węzeł” w zdaniach opisowych, a „Node” (z linkiem) gdy mowa o samym rodzaju obiektu API. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| app / application | aplikacja | Ustalony, w pełni spolszczony termin — „instancja danej aplikacji”. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| hosting provider | dostawca hostingu | Standardowe polskie określenie branżowe; nie jest terminem specyficznym dla Kubernetesa i nie występuje w jego dokumentacji, dlatego użycie jest kwestią przyjętej konwencji. |
| filesystem | system plików | Ustalony termin — „system plików”, „systemu plików”. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| Pod | **Pod** — termin zachowany w oryginalnej, angielskiej formie, zapisywany wielką literą i odmieniany w polskim tekście bez apostrofu (Poda, Podzie, Pody, Podów, Podami) | Nazwa rodzaju obiektu API pozostaje w oryginale; w polskiej dokumentacji jej formy fleksyjne są stosowane konsekwentnie — „W obrębie kontekstu Poda”, „Kubernetes zarządza Podami”. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| ReplicaSet | **ReplicaSet** — termin zachowany w oryginalnej, angielskiej formie, zapisywany wielką literą i odmieniany w polskim tekście bez apostrofu (ReplicaSetu, ReplicaSetem, ReplicaSety), analogicznie do `Deployment` → `Deploymentów` | Brak dedykowanej polskiej strony dotyczącej obiektu `ReplicaSet`; sposób odmiany przyjęto analogicznie do innych angielskich nazw zakończonych w wymowie spółgłoską `Deployment` → `Deploymentów` zgodnie z użyciem w [Przestrzeniach nazw (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/namespaces/) |
| Service | usługa | Dedykowana strona dotycząca `Service` nie została przetłumaczona na język polski, jednak na innych polskojęzycznych stronach dokumentacji jako podstawowego odpowiednika tego terminu używa się form „usługa”/„usługi”. Forma „Service'ów” (z apostrofem) pojawia się jedynie przy wyliczaniu rodzajów zasobów. W tekście książki termin „service” jest zapisywany małą literą, dlatego „usługa” jest bezpośrednim i najbardziej naturalnym odpowiednikiem. [Usługi i sieci (PL)](https://kubernetes.io/pl/docs/concepts/services-networking/) |
| Namespace | przestrzeń nazw | Tytuł polskiej wersji strony brzmi wprost „Przestrzenie nazw (ang. Namespaces)” i to jest forma dominująca w treści dokumentacji. Miejscami pojawia się również odmieniana forma „namespace'em”, jednak ze względu na charakter książki dla dzieci konsekwentnie stosuje się spolszczony i bardziej przystępny termin „przestrzeń nazw”. [Przestrzenie nazw (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/namespaces/) |
| Volume | wolumin | Strona `Volumes` nie została przetłumaczona na język polski, jednak na polskojęzycznej stronie dotyczącej Podów konsekwentnie używana jest spolszczona forma „wolumin”, m.in. w wyrażeniach „woluminów”, czy „woluminy pozwalają na”. Dlatego również w książce stosuje się termin „wolumin”. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| label / nametag | etykieta (termin techniczny) / identyfikator (metafora w warstwie fabularnej) | „Etykieta” jest ustalonym polskim terminem technicznym — występuje m.in. w tytule strony „Etykiety i selektory”. W opowieści „nametag” oznacza fizyczną plakietkę z nazwą wręczaną przez kapitana, dlatego termin ten jest tłumaczony jako bardziej obrazowy i zrozumiały dla dziecka „identyfikator”. Notatka techniczna na str. 11 bezpośrednio łączy określenie „identyfikator” z technicznym terminem „etykieta”. [Etykiety (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/labels/) |
| service discovery | wykrywanie usług | Jest to powszechnie przyjęty polski odpowiednik tego terminu w branży IT, stosowany nie tylko w kontekście Kubernetesa. [tr-ex.me](https://tr-ex.me/t%C5%82umaczenie/angielski-polski/service+discovery), [howtointerview.pl](https://howtointerview.pl/definicje/co-to-jest-service-discovery/10893/) |
| replica | replika | Ustalony termin — „Replika” jest przyjętym polskim odpowiednikiem terminu „replica” w terminologii informatycznej i odnosi się do jednej z wielu równoważnych kopii tego samego zasobu. Takie nazewnictwo jest również zgodne z polską dokumentacją Kubernetes, w której występują powiązane określenia, takie jak „Replikowane Pody” i „replikacja”. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| deployment (słowo ogólne, „rolling deployments”) | wdrożenie / wdrożenia kroczące | „Wdrożenie” jest powszechnie stosowanym polskim odpowiednikiem terminu „deployment” w branży IT. Analogicznie „rolling deployment” tłumaczone jest jako „wdrożenie kroczące”. Ze względu na brak polskiej wersji strony dotyczącej zasobu `Deployment` wybór terminologii opiera się na powszechnym użyciu tych określeń w polskiej terminologii informatycznej. |
| load balancing | równoważenie obciążenia | Termin występuje bezpośrednio w polskiej dokumentacji Kubernetesa — tytuł sekcji brzmi „Usługi, równoważenie obciążenia i sieci w Kubernetesie”. Jest to również ustalony i powszechnie stosowany polski termin informatyczny, szczególnie w kontekście sieci komputerowych i systemów rozproszonych. [Usługi i sieci (PL)](https://kubernetes.io/pl/docs/concepts/services-networking/) |
| scheduling | planowanie (główne, w zdaniach opisowych) / harmonogramowanie (w tytułach sekcji) | W polskiej dokumentacji Kubernetes tytuł odpowiedniej strony brzmi „Harmonogramowanie, pierwszeństwo i eksmisja”, natomiast w jej treści termin ten objaśniany jest jako „planowanie”, odnoszące się do dopasowywania Podów do Węzłów. W liście pojęć na str. 7 książki zastosowano formę „planowanie”, ponieważ jest bardziej przystępna i naturalna w ogólnym, nietechnicznym kontekście. [Harmonogramowanie (PL)](https://kubernetes.io/pl/docs/concepts/scheduling-eviction/) |
| storage backend | backend pamięci masowej | „Backend” jest ugruntowanym zapożyczeniem powszechnie stosowanym w polskiej terminologii informatycznej, np. w określeniu „backend aplikacji”, dlatego pozostawiono go bez tłumaczenia. „Pamięć masowa” jest natomiast standardowym polskim odpowiednikiem terminu „storage”. Ponieważ strona Kubernetes dotycząca `Volumes` nie została przetłumaczona na język polski, zastosowana terminologia opiera się na powszechnym użyciu tych określeń w polskiej branży IT. |
| replication controller | kontroler replikacji | Na str. 16 książki określenie „replication controller” występuje jako nazwa opisowa, a nie jako zapisana wielką literą nazwa rodzaju zasobu, dlatego zastosowano polską formę „kontroler replikacji”. Jest to termin stosowany bezpośrednio w polskiej dokumentacji Kubernetes, m.in. w sformułowaniach „Usługa i Kontroler Replikacji” oraz „kontroler replikacji” (`replicationcontroller`). [Etykiety (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/labels/) |

## Imiona postaci i odmiana

- **Phippy** i **Goldie** — imiona pozostawiono w oryginalnej pisowni i bez odmiany przez
  przypadki, podobnie jak angielskie imiona „Mary” czy „Kathy” w polskim tekście. Rodzaj żeński
  postaci jest zaznaczany za pomocą odpowiednich form czasowników, przymiotników i innych
  odmiennych części mowy, np. „była”, „powiedziała”, „zrobiła” czy „przyjaciółkami”. Zasada ta
  jest stosowana konsekwentnie w całej książce, dzięki czemu Phippy i Goldie są przedstawiane
  jako postacie rodzaju żeńskiego bez ingerowania w oryginalną formę ich imion.
- **Kapitan Kube** — polski rzeczownik pospolity „kapitan” odmienia się zgodnie z zasadami
  języka polskiego („Kapitana”, „Kapitanowi”, „Kapitanem”), natomiast „Kube” pozostaje
  nieodmienne. Konstrukcja ta odpowiada wzorcowi „tytuł lub rzeczownik pospolity + obca nazwa
  własna”, np. „Pan Smith” — „Pana Smith”. Rodzaj męski postaci jest konsekwentnie zaznaczany
  za pomocą odpowiednich form czasowników, np. „powiedział” czy „zasugerował”.
- **Wieloryb** — postać nie ma własnego imienia w oryginale. Określenie „wieloryb” ma w języku
  polskim rodzaj męski, dlatego naturalnie odpowiada używanemu w oryginale zaimkowi „he” i nie
  wymaga dodatkowej decyzji dotyczącej rodzaju postaci.
- Nie znaleziono istniejących polskojęzycznych materiałów CNCF ani materiałów społecznościowych
  dotyczących Phippy (na podstawie przeprowadzonego wyszukiwania). Nie ma zatem ustalonych
  wcześniej polskich form imion, do których można byłoby się odwołać. Powyższe rozwiązania
  zostały przyjęte na potrzeby tego tłumaczenia.

## Dobór rejestru i adaptacje żartów/gry słów

- **Kubernetes = greckie słowo oznaczające kapitana statku; „Cybernetic”/„Gubernatorial” się
  z niego wywodzą (str. 9).** Przetłumaczone bezpośrednio — polskie słowa „cybernetyka” i
  „gubernator” wywodzą się z tego samego greckiego rdzenia, dlatego etymologiczne powiązanie
  zostaje zachowane bez potrzeby dodatkowej adaptacji.
- **„genetics and sheep” → żart o klonowaniu (str. 14).** Przetłumaczone dosłownie („genetyka i
  owce”) — odniesienie do owcy Dolly jest w Polsce równie rozpoznawalne jak w krajach
  anglojęzycznych, dlatego żart nie wymaga dodatkowej adaptacji.
- **Powtórzenie słowa „service” (str. 17): „A service tells... what services your application
  provides”.** W polskim tłumaczeniu oba użycia tego słowa odpowiadają formom
  „usługa”/„usługi”, dzięki czemu gra słów z oryginału zostaje zachowana bez potrzeby
  dodatkowej adaptacji.
- **„name tag” / „labels” (str. 10–11).** Angielski oryginał objaśnia etykiety Kubernetesa za
  pomocą metafory fizycznej plakietki z imieniem. Terminy zostały świadomie rozdzielone:
  w części fabularnej (str. 10) zastosowano „identyfikator” — określenie konkretnego i łatwo
  rozpoznawalnego przedmiotu, takiego jak plakietka konferencyjna — natomiast w części
  technicznej (str. 11) użyto formalnego terminu „etykieta”. Oba pojęcia łączy bezpośrednio
  zdanie „Kubernetes wykorzystuje etykiety jako swego rodzaju »identyfikatory«...”, dzięki
  czemu związek między metaforą a terminem technicznym zostaje zachowany.
- **Phippy / PHP.** Gra słów zawarta w imieniu Phippy (Phippy ⟷ PHP) nie wymaga adaptacji —
  zarówno „Phippy”, jak i „PHP” pozostają w oryginalnej pisowni, dzięki czemu skojarzenie
  między nimi zostaje zachowane również w polskim tłumaczeniu.
- **Rejestr.** W części fabularnej zastosowano klasyczną polską stylistykę baśniową („Dawno,
  dawno temu żyła sobie...”, zakończenie „I tak Phippy żyła długo i szczęśliwie”), tak aby
  tekst brzmiał naturalnie podczas czytania dziecku na głos. Notatki techniczne pozbawiono
  narracyjnych ozdobników i utrzymano w rejestrze zbliżonym do polskiej dokumentacji
  technicznej.

## Stan recenzji i kwestie otwarte

Terminologia oraz treść tego słownika zostały zrecenzowane przez osobę, dla której język polski
jest językiem ojczystym (październik 2026). Recenzja doprecyzowała uzasadnienia i źródła
poszczególnych decyzji, nie zmieniła natomiast żadnej z nich.

Otwarta pozostaje ocena samego tekstu książki
([`books/childrens-guide-to-kubernetes/pl.md`](../books/childrens-guide-to-kubernetes/pl.md)).
Zgodnie z `CONTRIBUTING.md` najważniejszym kryterium recenzji jest ogólne brzmienie części
fabularnej podczas czytania jej dziecku na głos i wymaga ono oceny osoby, dla której język
polski jest językiem ojczystym lub która posługuje się nim z naturalną płynnością. Sama
weryfikacja poprawności terminologii technicznej nie jest wystarczająca.

Przy takiej lekturze warto zweryfikować w szczególności:

- Formy **ReplicaSet** (ReplicaSetu / ReplicaSetem / ReplicaSety) utworzono zgodnie z zasadami
  polskiej odmiany podobnych terminów, ponieważ nie ma polskiej wersji dokumentacji, na której
  można byłoby się oprzeć. Warto sprawdzić, czy brzmią naturalnie w zdaniach książki, a nie
  tylko w tabeli powyżej.
- **Identyfikator** jako odpowiednik „name tag” w części fabularnej został wybrany tak, aby
  umożliwić późniejsze naturalne przejście do technicznego pojęcia „etykiety”. Warto sprawdzić,
  czy takie użycie słowa jest zrozumiałe i naturalne, zwłaszcza podczas czytania tekstu dziecku
  na głos.
- Określenie **„wdrożenia kroczące”** jako odpowiednik „rolling deployments” (str. 15) nie ma
  bezpośredniego oparcia w polskiej wersji dokumentacji Kubernetesa, ponieważ odpowiednia strona
  nie została przetłumaczona. Warto zatem zweryfikować, czy zaproponowany termin jest trafny
  i naturalny w tym kontekście.

Osobną kwestią — nie językową, lecz projektową — jest konsekwentne stosowanie terminu
**„przestrzeń nazw”** zamiast odmienianej formy „Namespace'a”. Polska dokumentacja używa obu
wariantów, natomiast w książce dla dzieci przyjęto jedną, spolszczoną formę. Wymaga to
potwierdzenia pod kątem spójności z ewentualnymi kolejnymi książkami z serii.
