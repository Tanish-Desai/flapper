# Flapper

**Version:** v1.0 — First release

Flapper is a compact Flappy-Bird style game built with Godot (GDScript). This repository contains the full project source so you can run and edit the game in Godot, plus a ready-to-play Windows executable (`Flapper.exe`) included in the release binaries.

---

## Table of contents

* [Features](#features)
* [Run (Windows)](#run-windows)
* [Run / Edit in Godot (Development)](#run--edit-in-godot-development)
* [Build & Export](#build--export)
* [Project structure](#project-structure)
* [Troubleshooting & Antivirus notes](#troubleshooting--antivirus-notes)
* [Known issues & TODO](#known-issues--todo)

---

## Features

* Classic Flappy-Bird gameplay: Click to flap and avoid pipes.
* Procedural pipe generation with smooth horizontal scrolling.
* Score counter and persistent high score (saved locally).
* Start/tip screen, Game Over flow, and a restart button.
* Basic sound effects for flap, collision and UI feedback.
* Lightweight, easy-to-read GDScript code with modular scenes.

---

## Run (Windows)

**Included:** `Flapper.exe` in the release assets.

Download and Run `Flapper.exe` from the Releases page of this repo.

---

## Run / Edit in Godot (Development)

**Recommended Godot version:** 4.4

1. Clone the repository: `git clone https://github.com/Tanish-Desai/flapper.git`
2. Open Godot, choose **Import** (or *Open existing project*), and select the folder containing `project.godot`.
3. Press **Play** (F5) in the editor to run the game.

Explore scenes under `scenes/` and logic under `scripts/` to learn how gameplay, UI and scoring are implemented.

---

## Build & Export

**Quick notes:** `export_presets.cfg` is included to make re-exporting easier.

### Exporting a Windows build

1. Open the project in Godot and confirm the project runs in the editor.
2. Go to **Project → Export**. If Windows export templates are missing, install them via the Godot installer or download export templates for your Godot version.
3. Choose **Windows Desktop** as the target. In the export options you can choose to export a single executable (embedded project) or an exe + `.pck` pair.

   * **Single exe:** embeds the `.pck` into the `.exe`. The user needs only `Flapper.exe` to run.
   * **Exe + pck:** generates `Flapper.exe` and `Flapper.pck`. Both files must be distributed together in the same folder.
4. Export and verify the generated executable on a clean Windows machine.

---

## Project structure (high level)

```
/ (repo root)
├─ project.godot
├─ export_presets.cfg
├─ assets/            # art, audio and fonts
├─ scenes/            # Godot scenes (.tscn)
├─ scripts/           # GDScript source files
└─ README.md

```

---

## Troubleshooting & Antivirus notes

**Windows SmartScreen / Antivirus warnings:**

* The executable may show up as an "unrecognized app" in Windows SmartScreen or trigger warnings in some antivirus engines. This happens because the binary is not code-signed.

**Recommended steps (in case blocked):**

1. Download only from the official GitHub Releases page for this repository.
2. Optionally scan the downloaded exe on VirusTotal or with your antivirus before running.
3. If Windows SmartScreen blocks the app, click **More info → Run anyway** only if you trust the source.

---

## Known issues & TODO

* Current release targets Windows only.
* Polish items: audio balancing, mobile touch responsiveness, and minor UI layout tweaks.

Authored by **Tanish-Desai**. See commit history for authorship and development details.
