---
lang: pl
language: Polski
title: Ilustrowany przewodnik dla dzieci po Kubernetesie
status: draft
translators:
  - Yuriy Novostavskiy
reviewers:
---

Tłumaczenie polskie. Przetłumaczone z pliku `en.md` w tym samym katalogu — angielskiego
tekstu z opublikowanego PDF-a CNCF, a nie z innego tłumaczenia.

Numeracja stron i naprzemienny układ „opowieść / notatka techniczna" wynikają z ilustracji
i muszą odpowiadać `en.md` strona w stronę. Decyzje terminologiczne wraz z uzasadnieniem
znajdują się w [`glossary/pl.md`](../../glossary/pl.md).

## p1 — okładka

- Przewodnik {ilustrowany} dla dzieci po
- Kubernetesie

## p2 — strona redakcyjna

Oto ludzie, którym to zawdzięczamy...

- Tekst: Matt Butcher
- Ilustracje: Bailey Beougher
- Projekt graficzny: Karen Chu
- Ilustracja Goldie została oparta na postaci Go Gophera zaprojektowanej przez Renee French

Tłumaczenie polskie

- Tłumaczenie: Yuriy Novostavskiy

> Phippy, Kapitan Kube oraz The Children's Illustrated Guide to Kubernetes są objęte prawami autorskimi The Linux Foundation, działającej w imieniu Cloud Native Computing Foundation. Są udostępnione na licencji Creative Commons Uznanie autorstwa 4.0 Międzynarodowe (CC-BY-4.0). Zobacz phippy.io.
>
> To jest nieoficjalne tłumaczenie społecznościowe. Nie jest publikowane ani zatwierdzone przez CNCF. Tłumaczenie udostępniane jest na tych samych warunkach — CC-BY-4.0.

## p3 — dedykacja

Dla wszystkich rodziców, którzy próbują wytłumaczyć swoim dzieciom, czym jest inżynieria oprogramowania.

## p4 — opowieść: Phippy

Dawno, dawno temu żyła sobie aplikacja o imieniu Phippy. Była prostą aplikacją napisaną w PHP i miała tylko jedną stronę. Mieszkała u dostawcy hostingu, gdzie dzieliła swoje środowisko ze strasznymi, obcymi aplikacjami, których nie znała i z którymi wcale nie chciała się zadawać. Marzyła, żeby mieć własne środowisko — tylko ona i serwer WWW, które mogłaby nazwać domem.

## p5 — notatka: środowisko

### Środowisko

- Sama aplikacja
- Struktura pomocnicza
  - Serwer WWW
  - Różne elementy systemu operacyjnego

Aplikacja posiada środowisko, od którego zależy jej działanie. W przypadku aplikacji PHP środowisko to może obejmować serwer WWW, dostępny do odczytu system plików oraz sam silnik PHP.

## p6 — opowieść: wieloryb

Pewnego dnia przypłynął dobrotliwy wieloryb. Zasugerował, że mała Phippy mogłaby być szczęśliwsza, gdyby zamieszkała w kontenerze, więc się przeprowadziła. W kontenerze było miło, ale trochę jak w eleganckim salonie unoszącym się na środku oceanu.

## p7 — notatka: kontenery

### Kontenery

- Trzeba nimi zarządzać
- Sieć to trudna sprawa
- Kontenery trzeba planować, dystrybuować i równoważyć ich obciążenie
- A dane muszą się *gdzieś* zachować

Kontener zapewnia odizolowany kontekst, w którym aplikacja może działać razem ze swoim środowiskiem. Odizolowanymi kontenerami trzeba jednak zwykle zarządzać i łączyć je ze światem zewnętrznym. Wyzwaniem są tu między innymi współdzielone systemy plików, sieć, planowanie, równoważenie obciążenia oraz dystrybucja.

## p8 — opowieść: Kapitan Kube

Wieloryb wzruszył ramionami. „Przykro mi, mała" — powiedział i zniknął pod powierzchnią oceanu. Ale zanim Phippy zdążyła się choćby zasmucić, na horyzoncie pojawił się kapitan, sterujący ogromnym statkiem. Statek zbudowany był z dziesiątek tratw powiązanych ze sobą, ale z zewnątrz wyglądał jak jeden wielki okręt.

„Witaj, mała aplikacjo! Nazywam się Kapitan Kube" — powiedział mądry, stary kapitan.

## p9 — notatka: Kubernetes

### Kubernetes

- Phi-Beta-Kappa: Philosophia Biou Kubernetes („umiłowanie mądrości sterem życia")

„Kubernetes" to greckie słowo oznaczające kapitana statku. Od słowa „kubernetes" pochodzą między innymi wyrazy *cybernetyka* i *gubernator*. Projekt Kubernetes skupia się na budowie solidnej platformy do uruchamiania tysięcy kontenerów w środowisku produkcyjnym.

## p10 — opowieść: identyfikator

„Jestem Phippy" — powiedziała mała aplikacja.

„Miło mi cię poznać" — powiedział kapitan, wręczając jej identyfikator.

## p11 — notatka: etykiety

### Kubernetes używa etykiet

- Po tych etykietach można wyszukiwać

Kubernetes wykorzystuje etykiety jako swego rodzaju „identyfikatory", dzięki którym można rozpoznawać poszczególne obiekty. Etykiety są otwarte — możesz ich używać do oznaczania roli, stabilności czy innych ważnych cech.

## p12 — opowieść: Pod

Kapitan Kube zasugerował, że aplikacja mogłaby przenieść swój kontener do Poda na pokładzie statku. Phippy z radością przeniosła swój kontener na pokład. Poczuła się jak w domu.

## p13 — notatka: Pody

### Pody

- Pod może zawierać dowolną liczbę kontenerów, ale zwykle mieści tylko dwa
- Udajemy, że jeden z tych kontenerów nie istnieje
- Pod jest połączony z resztą środowiska przez sieć nakładkową

Pod reprezentuje uruchamialną jednostkę pracy. Zazwyczaj wewnątrz Poda działa pojedynczy kontener, ale gdy kilka kontenerów jest ze sobą ściśle powiązanych, można zdecydować się na uruchomienie więcej niż jednego kontenera w obrębie tego samego Poda. Kubernetes bierze na siebie zadanie podłączenia Poda do sieci i do reszty środowiska Kubernetes.

## p14 — opowieść: klonowanie

Phippy miała nietypowe zainteresowania — bardzo lubiła genetykę i owce. Zapytała więc kapitana: „A co, jeśli zechcę sklonować samą siebie… na żądanie… dowolną liczbę razy?"

„To żaden problem" — powiedział kapitan i przedstawił jej ReplicaSety.

## p15 — notatka: ReplicaSety

### ReplicaSety

- Mają *szablon Poda* do tworzenia dowolnej liczby kopii Poda
- Zapewniają logikę skalowania Poda w górę i w dół
- Można ich używać do wdrożeń kroczących

ReplicaSety zapewniają sposób zarządzania dowolną liczbą Podów. ReplicaSet zawiera szablon Poda, który można replikować dowolną liczbę razy. Za pośrednictwem ReplicaSetu Kubernetes zarządza cyklem życia Twoich Podów, w tym skalowaniem w górę i w dół, wdrożeniami kroczącymi oraz monitorowaniem.

## p16 — opowieść: tunel

Przez wiele dni i nocy mała aplikacja cieszyła się swoim Podem i swoimi replikami. Ale mieć za całe towarzystwo tylko samą siebie — nawet jeśli jest się w N kopiach — to jednak nie to samo, co prawdziwe towarzystwo.

Kapitan Kube uśmiechnął się łagodnie. „Mam właśnie coś takiego."

Nie zdążył nawet skończyć zdania, gdy między kontrolerem replikacji Phippy a resztą statku otworzył się tunel. Kapitan Kube roześmiał się serdecznie: „Nawet gdy twoje klony będą przychodzić i odchodzić, ten tunel tu zostanie, żebyś mogła odkrywać inne Pody, a one mogły odkrywać ciebie!"

## p17 — notatka: usługi

### Usługi

- Trwałe
- Zapewniają wykrywanie usług
- Zapewniają równoważenie obciążenia
- Zapewniają stały adres usługi
- Znajdują Pody po selektorze etykiet

Usługa informuje resztę środowiska Kubernetes (w tym inne Pody i ReplicaSety) o tym, jakie usługi udostępnia Twoja aplikacja. Podczas gdy Pody powstają i znikają, adres IP oraz port usługi pozostają niezmienne. Inne aplikacje mogą odnaleźć Twoją usługę dzięki mechanizmowi wykrywania usług Kubernetes.

## p18 — opowieść: prezent od Goldie

Phippy zaczęła zwiedzać resztę statku. Nie minęło wiele czasu, a poznała Goldie i szybko zostały najlepszymi przyjaciółkami. Pewnego dnia Goldie zrobiła coś niezwykłego — dała Phippy prezent. Phippy spojrzała na niego tylko raz, a z jej oka popłynęła najsmutniejsza z łez.

„Dlaczego jesteś taka smutna?" — zapytała Goldie.

„Uwielbiam ten prezent, ale nie mam gdzie go schować" — pociągnęła nosem Phippy.

Ale Goldie wiedziała, co robić: „A może schowasz go w woluminie?"

## p19 — notatka: woluminy

### Woluminy

- Dostawcy udostępniają zarówno trwałą, jak i ulotną pamięć masową
  - Blokowa pamięć masowa w chmurze
  - Ceph
  - Gluster…
- Pody mogą montować woluminy jak systemy plików

Wolumin reprezentuje miejsce, do którego kontenery mogą uzyskiwać dostęp i w którym mogą przechowywać dane. Wolumin pojawia się jako część lokalnego systemu plików. Za woluminami mogą stać różne mechanizmy przechowywania danych: lokalna pamięć masowa, Ceph, Gluster, blokowa pamięć masowa w chmurze i wiele innych backendów pamięci masowej.

## p20 — opowieść: prywatność

Phippy uwielbiała życie na pokładzie statku Kapitana Kube i cieszyła się towarzystwem swoich nowych przyjaciół (każdy replikowany Pod Goldie był tak samo uroczy). Ale gdy wspominała swoje dni u strasznego dostawcy hostingu, zaczęła się zastanawiać, czy może przydałoby jej się też trochę prywatności.

„Brzmi na to, że potrzebujesz" — powiedział Kapitan Kube — „przestrzeni nazw."

## p21 — notatka: przestrzenie nazw

### Przestrzenie nazw

- Grupują i oddzielają od siebie Pody, ReplicaSety, woluminy i sekrety

Przestrzeń nazw działa w Kubernetesie jako mechanizm grupowania. Usługi, Pody, ReplicaSety i woluminy mogą swobodnie współdziałać w ramach jednej przestrzeni nazw, która zapewnia też pewien stopień izolacji od innych części klastra.

## p22 — opowieść: i żyli długo i szczęśliwie

Życie na pokładzie statku Kapitana Kube było piękne. Razem ze swoimi nowymi przyjaciółmi Phippy żeglowała po morzach. Przeżyła wiele wspaniałych przygód, ale najważniejsze było to, że Phippy odnalazła swój dom.

I tak Phippy żyła długo i szczęśliwie.

## p23 — tylna okładka

Ilustrowany przewodnik dla dzieci po Kubernetesie

Oryginał © The Linux Foundation, w imieniu Cloud Native Computing Foundation, na licencji CC-BY-4.0. Nieoficjalne tłumaczenie społecznościowe, udostępniane na tych samych warunkach.

phippy.io
