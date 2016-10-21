## Homebrew for Ethereum Classic (ETC)

Homebrew is the missing package manager for OSX. You can find installation instructions at www.brew.sh. Alternatively open your terminal and type in:

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Adding ETC Homebrew tap

ETC is not part of standard Homebrew, so you need to add a tap to install its packages. Open your terminal and enter:

```
brew tap ethereumclassic/etc
```

## Installing ETC client software

### Geth (Go client)
```
brew install geth
```

### Eth (C++ client)
```
brew install eth
brew linkapps eth
```

### Parity

```
brew install parity
```

If you want to run Parity in a geth-compatible mode (as a backend for Mist/RPC):

```
brew install parity --geth-compatible
```

## Installing other utilities:

```
brew install solidity
brew install ethabi
brew install ethkey
brew install ethstore
```

## Updates and minor upgrades
In order to update software to the latest version use:

```
brew update && brew upgrade <package_name>
```

```
brew update && brew reinstall <package_name>
```
