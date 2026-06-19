# Godot 4.3 WebXR VR Teleportation Demo 🚀🌐

[![Godot Version](https://img.shields.io/badge/Godot-4.3-%23478cbf?logo=godot-engine&logoColor=white)](https://godotengine.org)
[![Platform](https://img.shields.io/badge/Platform-WebXR%20%7C%20HTML5-orange)](https://aleksanderopas.github.io/vr/)
[![Specialization](https://img.shields.io/badge/Specjalność-MiEPU%20%7C%20Politechnika%20Poznańska-red)]()

Projekt demonstracyjny realizowany w ramach laboratorium na kierunku Elektronika i Telekomunikacja (specjalność: **Multimedia i Elektronika Powszechnego Użytku**). Aplikacja implementuje i testuje podstawowe mechaniki poruszania się (lokomocji) w rzeczywistości wirtualnej (VR) uruchamianej bezpośrednio w przeglądarce internetowej za pomocą standardu **WebXR**.

## 🔗 Live Demo
Aplikacja jest w pełni skompilowana do HTML5 i hostowana za pomocą GitHub Pages. Można ją przetestować bezpośrednio na goglach VR (np. Meta Quest) lub w trybie mobilnym pod adresem:
👉 **[https://aleksanderopas.github.io/vr/](https://aleksanderopas.github.io/vr/)**

---

## 👁️ Przegląd Projektu
Głównym celem projektu było stworzenie wydajnego środowiska 3D odpornego na chorobę lokomocyjną (motion sickness) poprzez zastosowanie mechaniki **teleportacji**. Ze względu na specyfikę platformy webowej, cała scena oraz obiekty (w tym bryły geometryczne oraz modele budynków) zostały zoptymalizowane pod kątem niskiej liczby wielokątów (low-poly), zapewniając renderowanie na poziomie 72/90 FPS na autonomicznych goglach VR.

Projekt wspiera natywne renderowanie stereoskopowe (Side-by-Side dla WebXR API) oraz śledzenie kontrolerów ruchowych/dłoni użytkownika.

| Środowisko testowe z obiektami prymitywnymi | Środowisko testowe z modelem budynku |
|---|---|
| ![Widok 1](https://raw.githubusercontent.com/aleksanderopas/vr/teleport/Zrzut%20ekranu%202026-06-19%20192301.png) | ![Widok 2](https://raw.githubusercontent.com/aleksanderopas/vr/teleport/Zrzut%20ekranu%202026-06-19%20192230.png) |

---

## 🛠️ Implementacja Techniczna

Projekt został stworzony w silniku **Godot 4.3** przy użyciu języka **GDScript** oraz oficjalnego pluginu narzędziowego dla OpenXR/WebXR.

### Kluczowe komponenty sceny:
*   **`XROrigin3D` & `XRCamera3D`**: Główny węzeł kotwiczący przestrzeń VR oraz kamera obsługująca renderowanie stereoskopowe dla każdego oka.
*   **`XRController3D`**: Węzły odpowiedzialne za mapowanie pozycji, rotacji dłoni (kontrolerów) oraz przechwytywanie sygnałów z przycisków (Input Events).
*   **`RayCast3D`**: Narzędzie rzucania promieni wektorowych z kontrolera, służące do detekcji kolizji z podłożem i wskazywania punktu docelowego teleportacji.
*   **`CharacterBody3D`**: Kontener fizyczny gracza, odpowiadający za płynną zmianę globalnego wektora pozycji (`global_position`) w momencie zatwierdzenia teleportu.

### Logika działania algorytmu lokomocji:
1. Użytkownik aktywuje celownik poprzez wychylenie analogu lub naciśnięcie triggera na kontrolerze.
2. Węzeł `RayCast3D` dynamicznie sprawdza kolizję z warstwą fizyczną podłoża (`StaticBody3D`).
3. Skrypt oblicza docelowy wektor pozycji (`Vector3`), filtrując niedozwolone strefy (np. wnętrza obiektów geometrycznych, ściany budynków), transformując współrzędne do bezpiecznej pozycji docelowej (`safe_target`).
4. Po zwolnieniu przycisku następuje natychmiastowa aktualizacja pozycji `XROrigin3D` z krótkim efektem wygaszenia ekranu (fade-out/fade-in), co minimalizuje dyskomfort użytkownika.

---

## 🚀 Jak uruchomić projekt lokalnie

1. Sklonuj to repozytorium:
```bash
   git clone [https://github.com/aleksanderopas/Godot4-WebXR-VR-Teleportation.git](https://github.com/aleksanderopas/Godot4-WebXR-VR-Teleportation.git)
