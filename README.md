# dafny-training
Some examples of Dafny code to support training sessions

# Install Dafny/VSCode

The easiest way to get Dafny is to install the [Dafny VsCode plugin](https://marketplace.visualstudio.com/items?itemName=dafny-lang.ide-vscode).

You will also have to install `dotnet-sdk` 5.0 or 6.0 (`brew install dotnet@6` on a Mac).

In the VsCode Dsfny settings:

-  set the absolute path to `dotnet`.
- add the item `--relax-definite-assignment` to language server _launch args_.
# Dafny CLI

You can install the [Dafny 4.x latest release](https://github.com/dafny-lang/dafny/releases/) for your system which provides a `dafny` executable (the plugin installs an executuble in the `.vscode/extensions` folder).


Make sure you add the path to the Dafny executable to your paths.
# Checking your installation
## Checking Plugin

1. Fork this repository.
2. Open the file `training1.dfy` in session1
3. The `Problems` tab should display a couple of information (`decreases` and another related to `triggers`). If this is the case you should be all set.

## Checking CLI

In a terminal, the command `dafny /help` should output something like:
```zsh
% dafny -version
Dafny 4.xxx
```

You can `cd` to the `sessions` directory and try the following commands:

```zsh
% dafny /dafnyVerify:1 /compile:0 /trace training1.dfy
```

On my computer this results in (path names may differ on your system):

```zsh
Parsing training1.dfy
Coalescing blocks...
Inlining...

Running abstract interpretation...
  [0.060479 s]
[TRACE] Using prover: /Users/franck/local/dafny3.0.0/z3/bin/z3

Verifying Impl$$_module.__default.abs ...
  [0.465 s, 1 proof obligation]  verified

Verifying Impl$$_module.__default.max ...
  [0.068 s, 1 proof obligation]  verified

Verifying Impl$$_module.__default.ex1 ...
  [0.070 s, 3 proof obligations]  verified

Verifying Impl$$_module.__default.find ...
  [0.070 s, 6 proof obligations]  verified

Verifying CheckWellformed$$_module.__default.sorted ...
  [0.067 s, 2 proof obligations]  verified

Verifying Impl$$_module.__default.unique ...
  [0.064 s, 1 proof obligation]  verified

Verifying Impl$$_module.__default._default_Main ...
  [0.076 s, 6 proof obligations]  verified

Dafny program verifier finished with 7 verified, 0 errors
```
## Note

On MacOSX, if you have manually installed the Dafny 4.x  release you may encounter some permission issues.
Run the script provided with Dafny `allow_on_mac.sh` to fix this issue.

# Dafny Reference Manual

The current versions of the Dafny Reference Manual should be available from the Dafny repo in [docs](https://github.com/dafny-lang/dafny/tree/master/docs).


