# PowerStation

[Powerstation](https://hyperloop-rails.github.io/powerstation/) is a tool that finds performance bugs in Rails applications, for example, API misuse, repeated query, etc. 

## Using the tool

There are two ways to use Powerstation:

- As a RubyMine plugin that you can [download from the jetbrains website](https://plugins.jetbrains.com/plugin/10604-powerstation). The source code is included in this repo under `powerstation/IDE_plugin`.

- As command line tool. The instructions and source code are included in this repo under `powerstation/command_line_tool`.

Both of these uses a static code checker that we have built to detect performance issues. The source code of the checker is in `static-checker`.

These are packaged in two separate branches (`IDE_plugin`, `static-checker`) in case you prefer checkout each part individually, for example:
```
$ git clone -b static-checker --single-branch https://github.com/hyperloop-rails/static-checker.git
```

## Bugs that we currently detect:

1. Loop invariant queries

2. Dead store queries

3. Unused data-retrieval queries

4. Common sub-expression queries

5. API misuses

6. Inefficient data rendering

Details of these are explained in [our documentation](https://hyperloop-rails.github.io/powerstation/docs/features/).

See our [main website](https://hyperloop-rails.github.io) for more details. Feel free to submit issues and pull requests!
