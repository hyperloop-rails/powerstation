# PowerStation

[Powerstation](https://hyperloop-rails.github.io/powerstation/) is a tool to help you find performance bugs in your Rails applications, for example, API misuse, repeated query, etc. 

### What is included:

1. Source code for [powerstation RubyMine plugin](https://plugins.jetbrains.com/plugin/10604-powerstation), in `powerstation/IDE_plugin`;

2. a command line version of powerstation, where you may extend powerstation to find more anti-patterns, in `powerstation/command_line_tool`;

3. a simple checker that finds API misuses, which simply finds misuses by pattern matching on source code and does not require installing any dependent packages, in `static-checker`.

Correspondingly, we have three branches where you can checkout each part individually, for example, 
```$ git clone -b static-checker --single-branch https://github.com/hyperloop-rails/static-checker.git```.

This branch includes only the source code for IDE plugin.

### Anti-patterns that current version of powerstation detects:

1. Loop invariant queries

2. Dead store queries

3. Unused data-retrieval queries

4. Common sub-expression queries

5. API misuses

6. Inefficient data rendering

These anti-patterns are explained in [powerstation features](https://hyperloop-rails.github.io/powerstation/docs/features/).

