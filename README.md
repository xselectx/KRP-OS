# Kotnik Role Play - Open Source

## Jak uruchomić serwer

Aby ułatwić wam obczajanie co i jak, umieszczam tutorial krok po kroku, jak uruchomić serwer.
```
# Instalujemy git'a
# https://git-scm.com/downloads

# Klonujemy projekt razem z submodułami
git clone --recurse-submodules https://github.com/xselectx/KRP-OS
cd KRP-OS

# Potrzebne będzie jeszcze sampctl
https://github.com/Southclaws/sampctl/wiki

# OK, repozytorium pobrane, teraz możemy odpalić serwer
sampctl ensure
sampctl build
sampctl run

# Jeżeli chciałbyś edytować kod, polecam zapoznać się z plikiem IDE.md, 
# który opisuje w jaki sposób skofigurować IDE takie jak Visual Studio Code, by pisać kod w Pawn.
```
## Twórcy

- [Fear]? - Twórcy podstawy gamemodu - skryptu The Godfather
- [Mrucznik] Twórca modyfikacji mapy (mapa została napisana na podstawie skryptu The Godfather) i założyciel serwera Mrucznik Role Play,
- [Simeone] Developer w latach 2018 - 2019
- [Pecet] Developer w latach 2017-2019
- [Akil] Developer (brak szczegółowych danych)
- [Kubi] Developer od 2013 (?) do 2015 roku
- [Veroon] Developer (brak szczegółowych danych)
- [niceCzlowiek] Developer w latach 2017-2018
- [lukeSql] Developer w 2018 + KRP - 2019/2020
- [Creative] Developer od 6 listopada 2019
- [Sandał] Developer od 9 grudnia 2019
- [skTom] autor modułu discordowego
- [xSeLeCTx] Developer i założyciel serwera Kotnik Role Play 2019-2023
- [AnakinEU] Zarządca Kotnik Role Play 2020-2023
- [Dawidoskyy] Developer KRP
- [skMetinek] Developer KRP
- [Renosk] Developer KRP

## [Edytory do PAWN](IDE.md)

## Kompilacja

Gamemod Mrucznika jest przystosowany do [sampctl](https://github.com/Southclaws/sampctl).
Aby skompilować gamemode z użyciem sampctl, należy [zainstalować sampctl](https://github.com/Southclaws/sampctl/wiki/Windows) a następnie wpisać następujące polecenia:

- `sampctl ensure`
- `sampctl build`

## Subrepozytoria
- https://github.com/xselectx/KRP-Obiekty-OS - obiekty serwera
- https://github.com/xselectx/KRP-Includes-OS - includy serwera
