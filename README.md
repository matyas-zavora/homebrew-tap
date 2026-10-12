# matyas-zavora/tap

Homebrew formulae for macOS.

## AI Radio Host

[AI Radio Host](https://github.com/matyas-zavora/ai-radio-host): you pick the music in
Spotify, and every few songs an AI host introduces the next one, like a radio DJ.

```bash
brew install matyas-zavora/tap/ai-radio-host
cp -R "$(brew --prefix)/opt/ai-radio-host/AI Radio Host.app" /Applications/
```

The second line puts the app in Applications, Launchpad and Spotlight; it keeps working
after `brew upgrade`. Linux users: use the project's `install.sh` instead.

The formula is updated automatically when a new release is published.
