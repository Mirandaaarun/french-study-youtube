# French Study — YouTube

Interactive French study sites built from YouTube videos. Each video gets a
self-contained page with synced bilingual subtitles, vocabulary tooltips with
audio, a multi-choice practice quiz, vocabulary browser by category, and a
grammar reference.

Built locally via the [`french-youtube-site`](https://github.com/Mirandaaarun/french-study-youtube)
skill. Deployed as a static site to GitHub Pages.

## Live site

https://mirandaaarun.github.io/french-study-youtube/

## Structure

```
/
├── index.html        — library page (lists every video)
├── manifest.json     — PWA manifest
├── sw.js             — service worker (offline support)
├── videos.json       — registry of built videos
├── icons/            — app icons
└── <video-id>/
    ├── index.html    — per-video study page
    └── data.json     — transcript + vocab + grammar
```
