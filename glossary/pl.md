# Polski słownik terminologiczny

Zasady terminologiczne dla polskich tłumaczeń książek Phippy & Friends. Ustalone przez
sprawdzenie, jak te pojęcia są *faktycznie* używane w polskiej lokalizacji dokumentacji
Kubernetesa (`kubernetes.io/pl/`, źródło: repo `kubernetes/website`, katalog `content/pl/`) oraz
w CNCF Cloud Native Glossary. Zasada nadrzędna: **znany angielski termin bije wymyślony polski
odpowiednik** — nie zgadujemy, sprawdzamy, co już się przyjęło.

**CNCF Cloud Native Glossary (`glossary.cncf.io`) nie ma polskiej lokalizacji** — sprawdzone na
stronie głównej: dostępne języki to m.in. bengalski, francuski, niemiecki, hindi, włoski,
japoński, koreański, portugalski, rosyjski, chiński (uproszczony i tradycyjny), hiszpański,
turecki, urdu i wietnamski. Polski nie jest wśród nich, więc dla polskiego jedynym realnym
źródłem precedensu jest `kubernetes.io/pl/docs/`.

Ważna uwaga o samej dokumentacji `kubernetes.io/pl/`: pokrycie jest nierówne. Strony przeglądowe
(`_index.md`), Pody, Etykiety i Przestrzenie nazw są przetłumaczone i posłużyły za główne źródło
niżej. Strony `Service` (`services-networking/service/`) i `Volumes` (`storage/volumes/`) **nie
mają jeszcze polskiego tłumaczenia** (404 na `/pl/`, tylko `_index.md` sekcji istnieje po
polsku) — dla tych dwóch terminów wnioskuję konwencję z tego, jak są używane *w innych*
przetłumaczonych stronach (np. strona Namespaces cytuje `Service` i `usługi` wielokrotnie).
Podobnie nie istnieje dedykowana strona `ReplicaSet` po polsku — wzorzec odmiany wyprowadzony
przez analogię do `Deployment`, który w tłumaczonych stronach się odmienia.

## Tabela terminów

| Angielski | Polski | Uzasadnienie / źródło |
|---|---|---|
| container | kontener | Ustalony termin w `kubernetes.io/pl` — "jeden lub więcej kontenerów", "środowisko uruchomieniowe kontenerów". [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| cluster | klaster | Standardowy, w pełni spolszczony termin w dokumentacji PL — "Pody w klastrze Kubernetesa". [Przestrzenie nazw (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/namespaces/) |
| node | węzeł (w tekście), `Node` z wielkiej litery przy odwołaniu do rodzaju zasobu | Dokumentacja PL używa "węzeł" w zdaniach opisowych, a "Node" (z linkiem) gdy mowa o samym rodzaju obiektu API. [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| app / application | aplikacja | Ustalony, w pełni spolszczony termin — "instancji danej aplikacji". [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| hosting provider | dostawca hostingu | Standardowe polskie określenie branżowe; nie jest terminem Kubernetesa, więc bez precedensu w dokumentacji K8s — decyzja własna. |
| filesystem | system plików | Ustalony termin — "systemu plików", "system plików". [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| Pod | **Pod** — zachowane po angielsku, z wielkiej litery, odmieniane jak polski rzeczownik rodzaju męskiego bez apostrofu (Poda, Podzie, Pody, Podów, Podami) | Rodzaj obiektu API zawsze zachowany w oryginale i konsekwentnie odmieniany w całej dokumentacji PL — "W obrębie kontekstu Poda", "Kubernetes zarządza Podami". [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| ReplicaSet | **ReplicaSet** — zachowane po angielsku, odmieniane bez apostrofu (ReplicaSetu, ReplicaSetem, ReplicaSety), analogicznie do `Deployment` → `Deploymentów` | Brak dedykowanej strony `ReplicaSet` po polsku; wzorzec odmiany "na sucho" (bez apostrofu, bo słowo kończy się spółgłoską wymawianą) wyprowadzony z `Deploymentów` w [Przestrzeniach nazw (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/namespaces/) |
| Service | usługa | Strona `Service` nie jest przetłumaczona, ale inne strony PL używają "usługa"/"usługi" jako głównego słowa w zdaniach, a "Service'ów" (z apostrofem) tylko przy wyliczaniu rodzajów zasobów. Tekst książki i tak pisze "a service" z małej litery, więc "usługa" pasuje bezpośrednio. [Przestrzenie nazw (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/namespaces/) |
| Namespace | przestrzeń nazw | Tytuł strony PL brzmi wprost "Przestrzenie nazw (ang. Namespaces)" i to jest forma dominująca w treści (choć dokumentacja miejscami miesza to z odmienianym "namespace'em" — dla książki dla dzieci konsekwentnie wybieram spolszczoną formę). [Przestrzenie nazw (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/namespaces/) |
| Volume | wolumin | Strona `Volumes` nie jest przetłumaczona, ale strona Podów używa spolszczonego "wolumin" konsekwentnie — "woluminów", "Woluminy pozwalają". [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| label / nametag | etykieta (termin techniczny) / identyfikator (metafora w warstwie fabularnej) | "Etykieta" to ustalony termin PL — tytuł strony "Etykiety i selektory". Dla fabularnej metafory "name tag" (fizyczna plakietka/identyfikator wręczana przez kapitana) użyto "identyfikator", żeby zachować obrazowość dla dziecka; notatka techniczna (p11) jawnie łączy oba słowa. [Etykiety (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/labels/) |
| service discovery | wykrywanie usług | Ustalone ogólnopolskie tłumaczenie w branży IT (nie tylko K8s). [tr-ex.me](https://tr-ex.me/t%C5%82umaczenie/angielski-polski/service+discovery), [howtointerview.pl](https://howtointerview.pl/definicje/co-to-jest-service-discovery/10893/) |
| replica | replika | Ustalony termin — "Replikowane Pody". [Pody (PL)](https://kubernetes.io/pl/docs/concepts/workloads/pods/) |
| deployment (słowo ogólne, "rolling deployments") | wdrożenie / wdrożenia kroczące | Standardowe polskie tłumaczenie "rolling deployment/update" w branży IT; brak polskiej strony `Deployment` do zacytowania wprost — decyzja własna oparta na powszechnym uzusie. |
| load balancing | równoważenie obciążenia | Ustalony, powszechny polski termin informatyczny spoza samej dokumentacji K8s (strona `Service` nie jest przetłumaczona) — używany np. w polskiej literaturze sieciowej i na Wikipedii PL. |
| scheduling | planowanie (główne, w zdaniach opisowych) / harmonogramowanie (w tytułach sekcji) | Tytuł strony PL: "Harmonogramowanie, pierwszeństwo i eksmisja", ale sama treść definiuje: "planowanie odnosi się do zapewnienia, że Pody są dopasowane do Węzłów". Dla listy pojęć w książce (p7) wybrano "planowanie" jako bardziej czytelne dla ogólnego kontekstu. [Harmonogramowanie (PL)](https://kubernetes.io/pl/docs/concepts/scheduling-eviction/) |
| storage backend | backend pamięci masowej | "Backend" to ugruntowana, nieodmienialna/odmienialna bez adaptacji pożyczka w polskim żargonie IT (np. "backend aplikacji"); "pamięć masowa" to standardowe polskie określenie "storage". Strona `Volumes` nie jest przetłumaczona — decyzja własna oparta na uzusie branżowym. |
| replication controller (fabularne określenie na p16, nie kapitalizowany rodzaj zasobu) | kontroler replikacji | Dosłownie ten sam zwrot pojawia się w dokumentacji PL: "Usługa i Kontroler Replikacji", "kontroler replikacji (`replicationcontroller`)". [Etykiety (PL)](https://kubernetes.io/pl/docs/concepts/overview/working-with-objects/labels/) |

## Imiona postaci i odmiana

- **Phippy** i **Goldie** — pozostawione w oryginalnej łacińskiej pisowni, bez odmiany
  (nieodmienne w każdym przypadku, tak jak np. "Mary" czy "Kathy" w polskim tekście). Rodzaj
  żeński jest przenoszony wyłącznie przez odmianę czasowników i przymiotników ("była",
  "powiedziała", "zrobiła", "przyjaciółkami") — konsekwentnie w całej książce, zgodnie z
  wymaganiem, że Phippy i Goldie są rodzaju żeńskiego przez cały tekst.
- **Kapitan Kube** — polskie słowo pospolite "kapitan" odmienia się normalnie (Kapitana,
  Kapitanowi, Kapitanem...), a "Kube" pozostaje nieodmienne, tak jak polski wzorzec
  "tytuł/rzeczownik pospolity + obce nazwisko" (por. "Pan Smith", "Pana Smith"). Rodzaj męski
  konsekwentnie ("powiedział", "zasugerował").
- **Wieloryb** (bez własnego imienia w oryginale) — "wieloryb" jest w polskim rodzaju męskiego z
  natury, więc odpowiada zaimkowi "he" z oryginału bez dodatkowej decyzji.
- Nie znaleziono żadnego istniejącego polskojęzycznego materiału CNCF ani społecznościowego
  dotyczącego Phippy (sprawdzone wyszukiwaniem) — więc nie było ustalonych wcześniej form imion
  do naśladowania; powyższe decyzje są autorskie dla tego tłumaczenia.

## Dobór rejestru i adaptacje żartów/gry słów

- **Kubernetes = greckie słowo na kapitana statku; „Cybernetic”/„Gubernatorial” się z niego
  wywodzą (p9).** Przetłumaczone wprost — polskie "cybernetyka" i "gubernator" mają dokładnie
  ten sam grecki rdzeń, więc etymologiczne powiązanie przenosi się bez żadnej adaptacji.
- **„genetics and sheep” → żart o klonowaniu (p14).** Przetłumaczone dosłownie ("genetyka i
  owce") — odniesienie do owcy Dolly jest w Polsce równie rozpoznawalne jak w krajach
  anglojęzycznych, więc żart nie wymagał adaptacji.
- **Powtórzenie słowa „service” (p17): „A service tells... what services your application
  provides”.** W polskim tekście oba znaczenia i tak wychodzą jako "usługa"/"usługi", więc gra
  słów oryginału zachowuje się przy okazji, bez dodatkowego zabiegu.
- **„name tag” / „labels” (p10–p11).** Angielski oryginał tłumaczy etykiety Kubernetesa metaforą
  fizycznej plakietki z imieniem. Rozdzielono to świadomie: na stronie fabularnej (p10) — 
  "identyfikator" (przedmiot, który dziecko rozpozna — plakietka konferencyjna), na stronie
  technicznej (p11) — formalne "etykieta", z jawnym zdaniem łączącym oba słowa ("Kubernetes
  wykorzystuje etykiety jako swego rodzaju „identyfikatory”..."), żeby metafora nie zgubiła się
  między stronami.
- **Phippy / PHP.** Gra słów w imieniu (Phippy ⟷ PHP) nie została "przetłumaczona" — oba
  pozostają w oryginalnej łacińskiej pisowni, więc polski czytelnik ma dokładnie taki sam dostęp
  do tego skojarzenia, jak czytelnik angielski.
- **Rejestr.** Strony fabularne pisane klasyczną polską dykcją baśniową ("Dawno, dawno temu żyła
  sobie...", zakończenie "I tak Phippy żyła długo i szczęśliwie") — mają dobrze brzmieć czytane
  dziecku na głos. Strony z notatką techniczną unikają narracyjnych ozdobników i trzymają się
  rejestru zbliżonego do dokumentacji.

## Do sprawdzenia przez native speakera

- Odmiana **ReplicaSet** (ReplicaSetu / ReplicaSetem / ReplicaSety) jest wyprowadzona przez
  analogię (brak polskiej strony źródłowej) — warto potwierdzić, że brzmi naturalnie, a nie
  sztucznie.
- Wybór **„identyfikator”** dla fabularnego „name tag” to autorska decyzja pomostowa do
  „etykiety” — warto sprawdzić, czy metafora działa dobrze czytana dziecku na głos.
- Konsekwentne użycie **„przestrzeń nazw”** zamiast odmienianego „Namespace'a” — dokumentacja PL
  sama miesza obie formy; dla książki dla dzieci uproszczono do jednej, spolszczonej formy.
  Warto potwierdzić, że to uproszczenie jest pożądane także z punktu widzenia późniejszej
  spójności z ewentualnymi kolejnymi książkami z serii.
- **„wdrożenia kroczące”** dla „rolling deployments” (p15) nie ma bezpośredniego oparcia w
  przetłumaczonej stronie K8s (bo takiej nie ma) — sprawdzić, czy to najlepsze sformułowanie.
- Ogólne brzmienie stron fabularnych czytane na głos dziecku — zgodnie z `CONTRIBUTING.md`, to
  najważniejsze kryterium recenzji i wymaga żywego native speakera, nie tylko sprawdzenia
  terminologii.
