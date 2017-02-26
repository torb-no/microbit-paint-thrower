# Malekaster med microbits og Processing
Av: Torbjørn Vik Lunde

I denne oppgaven skal vi lage et opplegg hvor du kan peke med en microbit og kaste virtuell maling på skjermen med den andre.

![](/img/Bilde.jpeg)

Til denne oppgaven trenger du 2 microbit med lange USB-kabler og en PC.

## Sette opp maleveggen
Denne oppgaven bruker Processing til å vise maleveggen. Om du ikke har det allerede [last ned Processing](https://processing.org/download/?processing). [Last ned den ferdige koden for maleveggen](/Malevegg/Malevegg.pde) og dobbeltklikk på den.

Processing vil da spørre deg om du vil flytte den inn i sin egen mappe. Svar jå på dette. Deretter trykk på Play-knappen i Processing. Da skal du få opp noe som ser slik ut.

![](/img/Processing-1.png)

## Programmere malekasteren
Koble til en av microbit-ene. Gå inn på [PXT Editoren til microbit](https://pxt.microbit.org) og lag et prosjekt med kode som ser slik ut. Denne vil sende en melding til maleveggen hvar gang en kaste-bevegelse blir gjort med denne microbit-en.

![](/img/PXT-1.png)

Laste den koden med den lilla Download-knappen i PXT. Deretter finner du den nedlastede filen ved å kopiere den til Micro bit. Etterpå start maleveggen (om den ikke kjører allerede) og gjør en kastebevegelse med micro biten. Da skal du kunne kaste maling i midten av maleveggen.

![](/img/Processing-2.png)

## Programmere pekeren
Nå kan du kaste maling på maleveggen, men du kan ikke bestemme hvor på veggen du vil kaste malingen. Nå skal vi lage et program for den andre micro bit-en som gjør at vi skal kunne peke med den.

Lag et nytt prosjekt i PXT. Dette gjør du ved å trykke på Projects og deretter New Project. Lag et prosjekt so har denne koden i seg:

![](/img/PXT-2.png)

Deretter kobler du til den andre Micro bit-en og kopierer koden til den andre Micro bit-en. Pass på at du legger koden over til den andre Micro bit-en og ikke den første!

Gå deretter tilbake til Maleveggen i prosessing. Nå kan du flytte pekeren oppover og nedeover og male både oppe og nede.

![](/img/Processing-3.png)

Du kan derimot ikke flytte til siden. Det skal vi fikse nå. Vi henter retningen fra kompasset i microbit-en. Vi må da også legge til at den sender med knapper slik vi kan  fortelle maleveggen hvilken vei som er fremover.

![](/img/PXT-3.png)

Deretter overfører du programmet til den andre microbit-en som med de forrige. Når den har blitt ferdigoverført så kan det være at den viser litt tekst og så viser en prikk i midten. Dette gjør den når den vil at du skal kallibrere kompasset. Dette gjør du ved holde den slik at den prikken som beveger seg ruller rundt på alle sidene i en ferdig sirkel.

![](/img/micro-bit-circle.png)

Når kalibreringen er ferdig vil du få opp et smiley-face. Start Maleveggen igjen. Nå kan du styre både oppover/nedover og til sidene. For å nullstille sidene trykker du på en av knappene på den andre microbit-en.

![](/img/Processing-4.png)

## Styre hvor mye maling
Akkurat nå kaster malekasteren vår like mye maling hver gang. Men vi kan lage ett bedre program for malekaster-programmet vårt som gjør at vi kaster mindre maling om vi kaster forsiktig, og mer maling dersom vi kaster hardere.

For å gjøre det må vi lage kode som sender forskjellige tallkoder på g, alt etter hvor hardt vi kaster. Koden må være litt anerledes. I stedet for å sende beskjed hver gang vi kaster, så sjekker vi heller om hvor hardt vi har kastet hele tiden og sender videre beskjeden om det. Koden ser slik ut:

![](/img/PXT-4.png)

Overfør koden til den første microbit-en. Nå skal du ved å justere hvor hardt du gjøre kastebevegelsen styre hvor mye maling du kaster.

![](/img/Processing-5.png)


## Utfordringer
- Kan du gjøre pekeren og malekasteren trådløs? (Hint: du trenger en tredje Micro Bit)
- Kan du gjøre pekeren mer stabil?
- Kan du se på Processing-skissen og se om du kan få den til å bli fullskjerm?
- Kan du skjule pekeren som svirrer rundt?


## Kommentarer
- Bare testet på OS X. Jeg antar det kommer til å fungere greit på Linux, men har lest på nettet at seriell-kommunikasjon på Windows kan være litt tricky.
- Har forsøkt å skrive Processing-koden slik at den greier å automatisk kjenne igjen hvilke seriell-porter som er microbits og koble til dem uten å foresake feil. Men har ikke sjekket dette på andre plattformer
- Processing-koden kan sikkert bli mer ryddig slik at den er enklere for andre å sette seg inn i.
- Instruksjonene for koden er veldig gjør-dette, gjør-dette og kanskje ikke så mye å oppdage selv når det kommer til kode. Jeg tror dette ikke trenger å være så dumt, for det er stor sjangs for at de kommer til å ha problemer med å finne ut av hva som er rett microbit og sett opp Processing. På mange måter er det en oppgave som vil lære dem mer om å få miljøet rundt koden sin til å fungere, men det er jo nyttig læring det også.
- Tror det ferdige produktet viser dem hvordan man kan leke med kode.