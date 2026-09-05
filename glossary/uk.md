# Ukrainian glossary — term decisions

This glossary records how technical terms were rendered in the Ukrainian translation of
*The Illustrated Children's Guide to Kubernetes*
(`books/childrens-guide-to-kubernetes/uk.md`).

Ukrainian equivalents were taken primarily from the material written by the Ukrainian
Kubernetes documentation team: their own translation style guide and the Ukrainian glossary
under `kubernetes/website`. Names and terms that the Ukrainian technical community commonly
uses in English were not force-translated. Where doubt remained, the wording already present
in the Ukrainian documentation was used to settle it.

## Research basis

- **No Ukrainian localization exists at `kubernetes.io/uk/docs/`** for the specific concept
  pages this book needed (Pods, Services, Namespaces, Volumes, Labels, ReplicaSets all
  404 at time of writing — only landing/index pages and the glossary are translated). The
  `kubernetes-i18n-ukrainian/website` fork some sources reference is a tracking fork with no
  `content/uk` of its own.
- **What does exist and is authoritative:** the Ukrainian glossary under
  `kubernetes/website` (`content/uk/docs/reference/glossary/*.md`, live at
  `kubernetes.io/uk/docs/reference/glossary/`) and the Ukrainian contributors' own style
  guide: **`kubernetes.io/uk/docs/contribute/localization_uk/`** ("Рекомендації з перекладу
  українською мовою"), which includes an explicit rule for how Kubernetes object names are
  handled and a term dictionary. This is the single strongest source used below — cited as
  *loc_uk* — because it is written by the Ukrainian K8s docs team specifically to fix this
  question.
- **CNCF Cloud Native Glossary (`glossary.cncf.io` / `github.com/cncf/glossary`) has no
  Ukrainian localization.** `content/` in that repo lists `bn de en es fr hi it ja ko pt-br
  ru tr ur vi zh-cn zh-tw` — no `uk`. Not used as a source for that reason (and Russian was
  deliberately not used as a substitute).

## Core rule (from loc_uk)

> Назви об'єктів Kubernetes залишаємо без перекладу і пишемо з великої літери: Service, Pod,
> Deployment, Volume, Namespace, за винятком терміна node (вузол). Назви об'єктів Kubernetes
> вважаємо за іменники ч.р. і відмінюємо за допомогою апострофа: Pod'ів, Deployment'ами.

Kubernetes object/kind names stay in English, capitalized, treated as masculine loanwords:
consonant-ending singular gets genitive `-а` via apostrophe (`Pod'а`, `ReplicaSet'а`);
vowel-ending singular is not declined (`Service`, `Volume`, `Namespace`); plural uses the
bare English form (`Pods`, `Services`, `Volumes` — not a Ukrainianized `-и`/`-ів` ending).

The plural rule is stated explicitly in loc_uk ("У множині використовуємо англійську форму:
користуватися Services, спільні Volumes"), even though some older glossary pages (`pod.md`,
`label.md`, `service.md`) instead use `Podʼи`/`Serviceʼи`/`Podʼів`. The written rule was
followed over the inconsistent legacy pages, as the explicit and current guidance for
translators. This choice still needs a native reviewer's confirmation: the older
apostrophe-plural style reads more smoothly aloud and may be more familiar.

## Term table

| English | Ukrainian | Rationale / source |
|---|---|---|
| Kubernetes | Kubernetes (unchanged, never declined) | Consistent across every fetched `kubernetes.io/uk` page (e.g. "документація Kubernetes", "у Kubernetes") — treated as an invariant brand name. |
| Pod (API kind) | Pod (declined: Pod'а gen.sg, Pod'ом instr.sg; plural Pods) | loc_uk core rule; matches `glossary/pod.md`. |
| Service (API kind) | Service (undeclined, vowel-ending; plural Services) | loc_uk dictionary: two separate entries — "Service \| Service (як об'єкт Kubernetes)" vs "service \| сервіс (як службова програма)". **Service** is used when naming the object itself (p17: "Service повідомляє…", "порти Service"). |
| service (generic/common noun) | сервіс | loc_uk dictionary, same entry as above; also matches "виявлення сервісу" in the same dictionary. Used for "what services your application provides" (p17). |
| service discovery | виявлення сервісу | loc_uk dictionary, exact entry (singular "сервісу", not plural — differs from the older `what-is-kubernetes.md` page which uses plural "Виявлення сервісів"; the dictionary was followed as the more deliberately curated term list). |
| ReplicaSet | ReplicaSet (undeclined save via apostrophe pattern; plural ReplicaSets) | Not in loc_uk's dictionary table by name, but covered by the general object-name rule and listed alongside Deployment/DaemonSet/StatefulSet as untranslated in `content/uk/docs/concepts/_index.md`. The English source book already capitalizes "ReplicaSets" as a proper term (p14–15), so no change of register was needed. |
| replica | репліка | loc_uk dictionary, exact entry; declines as a normal feminine noun (репліка, репліки, реплік). |
| Namespace (API kind) | простір імен (translated, lowercase) | **Deviates from loc_uk's literal object-name rule**, which lists Namespace among the untranslated kinds. The actual live page `kubernetes.io/uk/docs/reference/glossary/namespace.md` was followed instead: its title is "Namespace" but `aka: Простір імен`, and the entire body prose uses "Простори імен" throughout, never bare "Namespace". This reads as the Ukrainian docs team applying their *other* stated rule — "Частовживані і усталені за межами Kubernetes слова перекладаємо" (terms already established outside Kubernetes get translated) — since "namespace" predates Kubernetes as a general CS term and already had a settled Ukrainian translation. It also reads far better aloud in a children's book than leaving "Namespace" bare mid-sentence. **Flagged for reviewer**: this is a judgment call between two K8s-team sources that disagree with each other. |
| Volume (API kind) | Volume (undeclined, vowel-ending) | loc_uk core rule; no established pre-Kubernetes Ukrainian translation the way Namespace has, so kept as the object name per rule (unlike Namespace). |
| label | мітка | loc_uk dictionary, exact entry; matches `glossary/label.md`. |
| name tag (Story-page metaphor for label) | бейджик | Deliberate departure from "мітка" on Story pages only — see Adaptations below. |
| node | вузол | loc_uk dictionary, exact entry (the one explicit exception to "don't translate object names"). Not actually used in the book's running text (the word "node" never appears in `en.md`), but documented per task requirement. |
| cluster | кластер | Transliterated, fully naturalized, regular masculine declension (кластер, кластера…) — not treated as an "object name" requiring apostrophe declension. Used at p21 ("частин кластера") for "the cluster". Confirmed usage throughout `kubernetes.io/uk` (e.g. `glossary/cluster.md` title "Кластер"). |
| container | контейнер | Transliterated, fully naturalized, regular declension — confirmed via `glossary/container.md` ("Контейнери відокремлюють застосунки…"), used throughout `what-is-kubernetes.md`. |
| app / application (generic, technical register) | застосунок | loc_uk dictionary, exact entry; the established Ukrainian K8s-docs term (not "додаток", which reads as "mobile app" in general Ukrainian usage). Used on Note pages. |
| app / application (Phippy herself, Story register) | програма | **Deliberate deviation from "застосунок" on Story pages.** "Застосунок" is grammatically masculine; Phippy is female throughout per the brief. Rather than fight Ukrainian gender agreement sentence by sentence, Story pages use "програма" (grammatically feminine), which lets "вона" (she) agree naturally everywhere Phippy is described. Note pages, which never personify the app, use "застосунок" as normal. See Adaptations below. |
| hosting provider | хостинг-провайдер | Not a Kubernetes term — general Ukrainian tech vocabulary. Standard, widely used compound loanword, regular masculine declension. |
| filesystem | файлова система | Confirmed via `content/uk/docs/concepts/overview/what-is-kubernetes.md` ("власну файлову систему"). |
| web server | веб-сервер | Standard hyphenated Ukrainian tech term; not a Kubernetes-specific term so no docs precedent needed. |
| environment | середовище | Standard, unambiguous; matches `glossary` usage of "середовище" for "environment"/"control plane" contexts throughout `kubernetes.io/uk`. |
| load balancing | балансування навантаження | Confirmed via `what-is-kubernetes.md`: "Балансування навантаження". |
| scheduling (general concept, p7 note) | планування | Not in loc_uk's dictionary as a noun (only the verb "schedule → розподіляти (Pod'и по вузлах)", specific to what kube-scheduler does). "Планування" was used for the general noun in a list of infrastructure challenges, to avoid collision with the separately-listed "distribution" in the same sentence. **Flagged for reviewer** as a judgment call, not a directly sourced term. |
| distribution (p7 note, distinct from scheduling) | розповсюдження | General Ukrainian vocabulary; chosen to avoid overlapping with "планування" (scheduling) in the same list. |
| storage backend | сховище для зберігання даних | No K8s-uk precedent found for this exact compound. "backend" alone is attested as "бекенд" (loc_uk dictionary), but stacking it as "бекенд сховища" reads as an awkward doubled loanword; a plain descriptive phrase was used instead, consistent with "сховища інформації" used as the Storage section title in `content/uk/docs/concepts/storage/_index.md`. |
| production (p9 note) | продакшн-середовище | loc_uk dictionary has "production \| прод" (community slang), but that reads too casual for what should be a neutral documentation register even in a children's book; the fuller, still-common "продакшн-середовище" was used instead. **Deliberate deviation, flagged for reviewer.** |
| control plane / replication controller / controller | контролер реплікації (p16, for the book's own "replication controller") | The English source text itself uses the legacy pre-ReplicaSet term "replication controller" at p16 (an artifact of the original book, not something this translation invented — `en.md` is not edited). Translated descriptively rather than as a proper noun, since "ReplicationController" is not in the untranslated-kinds list and the book already introduced "ReplicaSet" as the named concept one page earlier. "контролер" itself confirmed via loc_uk dictionary ("controller \| контролер"). |
| project (Kubernetes project) | проєкт | Modern Ukrainian orthography (2019 reform) spelling, used consistently instead of the older "проект". |

## Character names

| Character | Ukrainian | Rationale |
|---|---|---|
| Phippy | Фіппі | Standard practical transliteration (Ph→Ф, y→і). Treated as an indeclinable feminine name ending in -і (same pattern as other foreign feminine names ending in -і, e.g. Барбі) — sidesteps needing to invent case endings for a name with no natural Ukrainian declension class. No existing Ukrainian CNCF/community material was found using any form (searched; nothing turned up), so this is a fresh decision. |
| Goldie | Ґолді | Same transliteration logic (hard G → Ґ, per standard Ukrainian practice of using Ґ for a hard foreign /g/ rather than Г). Indeclinable feminine, same class as Фіппі. No existing precedent found. |
| Captain Kube | капітан Кюб | "Captain" → "капітан" (standard, matches the ship/captain metaphor exactly). "Kube" is pronounced /kjuːb/ in English (echoing "cube"); transliterated as "Кюб" rather than "Куб" to preserve that pronunciation — "кю" needs no apostrophe in Ukrainian orthography (unlike after б/п/в/м/ф/р), so this is written plain, like "кювет". Declines as a regular masculine noun (Кюба, Кюбу, Кюбом). Lowercase "капітан" mid-sentence per Ukrainian convention for a rank/title before a name (unlike English, which capitalizes "Captain" as part of the honorific). |
| The whale | кит | Untranslated common noun — "кит" is grammatically masculine in Ukrainian, which conveniently matches the character being male ("he") with no extra work needed. |

## Deliberate adaptations (not literal translation)

- **"Genetics and sheep" (p14) setting up cloning.** Kept as a direct translation
  ("генетикою та вівцями") rather than adapted. The joke depends on the reader recognizing
  Dolly the sheep as the famous first cloned mammal — this is an internationally known
  reference, equally recognized in Ukraine (covered in Ukrainian school biology and popular
  science), so no localization was needed.
- **"Kubernetes is Greek for helmsman/ship's captain," and *Cybernetic*/*Gubernatorial*
  deriving from it (p9).** This etymological joke survives translation intact, because
  Ukrainian borrowed the same Greek root (κυβερνάω) into "кібернетика" and "губернатор" just
  as English did into "cybernetic" and "gubernatorial" — no adaptation required, just an
  accurate translation. Phrasing of the Greek-origin sentence itself echoes the wording
  already used on `kubernetes.io/uk/docs/concepts/overview/what-is-kubernetes.md`
  ("Назва Kubernetes походить з грецької та означає керманич...") for consistency with
  existing Ukrainian K8s writing, adapted to this book's "ship's captain" framing.
  English is kept in parentheses after both derived words — "«кібернетика» (Cybernetic)" —
  because the pun is about the *English* words sharing a root with "Kubernetes"; the
  parenthetical keeps that visible for a reader who wouldn't otherwise see the connection.
- **"Name tag" → "бейджик" on Story pages, but "мітка" on the Note page (p10/p11).**
  The technical term for a Kubernetes label is settled as "мітка" (see table above), but that
  word reads as "sticker/tag" in a cold, technical sense — wrong warmth for a captain
  literally handing a child a badge. Story page uses "бейджик" (name badge, warm, concrete,
  the object a child would recognize); the Note page translates "labels" as "мітки" per the
  glossary term but explicitly calls back to the story's word — "Kubernetes використовує
  мітки як «бейджики»" — so the two pages still visibly connect for the reader, matching how
  the English original puns "labels" against "nametags".
  The same problem exists for "Volume" (p18/p19) but was left unsolved — see Open questions.
- **"App" grammatical gender (Phippy).** See the "app / application" row above — Story pages
  use "програма" (feminine) specifically so "she" agrees naturally; Note pages use the
  standard "застосунок" (masculine) since they never personify the app. This is the single
  biggest structural translation decision in the book and should be the first thing a
  reviewer checks for consistency.
- **Apostrophe glyph.** The plain ASCII apostrophe `'` is used throughout (for both native
  Ukrainian orthographic apostrophes like "об'єктів" and for the Kubernetes
  loanword-declension apostrophes like "Pod'а"), matching `loc_uk` and `pod.md`. Some other
  glossary pages (`label.md`, `service.md`, `namespace.md`) instead use the Unicode modifier
  letter apostrophe `ʼ` (U+02BC). A single glyph was picked for the whole file rather than
  mixing the two.
- **"Boat" vs "ship" (p8, p22).** The English text uses "ship" and "boat" somewhat
  interchangeably for the same vessel (e.g. p8: "a gigantic ship... it looked like one huge
  boat"). A literal "човен" for "boat" reads as a small rowboat in Ukrainian, undercutting
  "gigantic" — "корабель"/"судно" were used as the Ukrainian stylistic pair instead, keeping
  the vessel's scale consistent throughout rather than the English's word choice.

## Open questions for a native-speaker reviewer

1. **Namespace: translated ("простір імен") vs. the literal object-name rule.** The live
   glossary page was followed over the written style-guide rule (see table above) because it
   reads better and matches what a Ukrainian reader would actually find on kubernetes.io/uk
   — but this is a real disagreement between two parts of the K8s-uk team's own material, not
   a clean-cut choice. Worth a second opinion.
2. **Plural declension of Pod/Service/Volume/ReplicaSet** — bare English plural (`Pods`) per
   the written rule, vs. the apostrophe-Cyrillic plural (`Podʼи`) actually used in some live
   glossary pages. The written rule was applied; a native speaker reading the book aloud may
   find the bare-English-plural mid-sentence (e.g. "іншим Pods") more awkward than expected —
   worth reading the whole book aloud before settling this.
3. **"Volume" has no name-tag-style Story/Note bridge** the way Pod/label/ReplicaSet do — p18
   just says "put it in a Volume" with no softer Story-register word first. Given how well the
   бейджик/мітка pairing worked for labels, a reviewer might want a similar warm Story-page
   word for Volume (something like "скринька"/"комора" as a container-for-your-things
   metaphor) with "Volume" reserved for the Note. It was left as plain "Volume" on both pages,
   to avoid inventing an unsourced metaphor without a second opinion.
4. **"планування" for the generic "scheduling"** in the p7 Note (list of infrastructure
   challenges) is an editorial choice, not directly sourced from any Ukrainian K8s doc — the
   only scheduling-related entry in loc_uk is a verb specific to kube-scheduler's job
   ("розподіляти Pod'и по вузлах"). Worth checking against how the (not-yet-translated)
   `kube-scheduler` concept page eventually renders it, if it ever gets translated.
5. **"продакшн-середовище" instead of the community-slang "прод"** (loc_uk dictionary's
   actual entry) for p9 — chosen for register reasons (documentation-neutral rather than
   insider-casual), but this is a deviation from the sourced term, not a direct application
   of it.
