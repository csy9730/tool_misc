# GitHub CLI

[https://github.com/cli/cli](https://github.com/cli/cli)


`gh` is GitHub on the command line. It brings pull requests, issues, and other GitHub concepts to the terminal next to where you are already working with `git` and your code.

[![screenshot of gh pr status](https://user-images.githubusercontent.com/98482/84171218-327e7a80-aa40-11ea-8cd1-5177fc2d0e72.png)](https://user-images.githubusercontent.com/98482/84171218-327e7a80-aa40-11ea-8cd1-5177fc2d0e72.png)

GitHub CLI is available for repositories hosted on GitHub.com and GitHub Enterprise Server 2.20+, and to install on macOS, Windows, and Linux.

## Documentation

[See the manual](https://cli.github.com/manual/) for setup and usage instructions.

## Contributing

If anything feels off, or if you feel that some functionality is missing, please check out the [contributing page](https://github.com/cli/cli/blob/trunk/.github/CONTRIBUTING.md). There you will find instructions for sharing your feedback, building the tool locally, and submitting pull requests to the project.

## Installation

### macOS

`gh` is available via [Homebrew](https://brew.sh/), [MacPorts](https://www.macports.org/), [Conda](https://docs.conda.io/en/latest/), [Spack](https://spack.io/), and as a downloadable binary from the [releases page](https://github.com/cli/cli/releases/latest).

#### Homebrew

| Install:          | Upgrade:          |
| ----------------- | ----------------- |
| `brew install gh` | `brew upgrade gh` |

#### MacPorts

| Install:               | Upgrade:                                       |
| ---------------------- | ---------------------------------------------- |
| `sudo port install gh` | `sudo port selfupdate && sudo port upgrade gh` |

#### Conda

| Install:                                 | Upgrade:                                |
| ---------------------------------------- | --------------------------------------- |
| `conda install gh --channel conda-forge` | `conda update gh --channel conda-forge` |

Additional Conda installation options available on the [gh-feedstock page](https://github.com/conda-forge/gh-feedstock#installing-gh).

#### Spack

| Install:           | Upgrade:                                 |
| ------------------ | ---------------------------------------- |
| `spack install gh` | `spack uninstall gh && spack install gh` |

### Linux & BSD

`gh` is available via [Homebrew](https://github.com/cli/cli#homebrew), [Conda](https://github.com/cli/cli#conda), [Spack](https://github.com/cli/cli#spack), and as downloadable binaries from the [releases page](https://github.com/cli/cli/releases/latest).

For instructions on specific distributions and package managers, see [Linux & BSD installation](https://github.com/cli/cli/blob/trunk/docs/install_linux.md).

### Windows

`gh` is available via [WinGet](https://github.com/microsoft/winget-cli), [scoop](https://scoop.sh/), [Chocolatey](https://chocolatey.org/), [Conda](https://github.com/cli/cli#conda), and as downloadable MSI.

#### WinGet

| Install:                         | Upgrade:                         |
| -------------------------------- | -------------------------------- |
| `winget install --id GitHub.cli` | `winget upgrade --id GitHub.cli` |

#### scoop

| Install:           | Upgrade:          |
| ------------------ | ----------------- |
| `scoop install gh` | `scoop update gh` |

#### Chocolatey

| Install:           | Upgrade:           |
| ------------------ | ------------------ |
| `choco install gh` | `choco upgrade gh` |

#### Signed MSI

MSI installers are available for download on the [releases page](https://github.com/cli/cli/releases/latest).

### GitHub Actions

GitHub CLI comes pre-installed in all [GitHub-Hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners).

### Other platforms

Download packaged binaries from the [releases page](https://github.com/cli/cli/releases/latest).

### Build from source

See here on how to [build GitHub CLI from source](https://github.com/cli/cli/blob/trunk/docs/source.md).

## Comparison with hub

For many years, [hub](https://github.com/github/hub) was the unofficial GitHub CLI tool. `gh` is a new project that helps us explore what an official GitHub CLI tool can look like with a fundamentally different design. While both tools bring GitHub to the terminal, `hub` behaves as a proxy to `git`, and `gh` is a standalone tool. Check out our [more detailed explanation](https://github.com/cli/cli/blob/trunk/docs/gh-vs-hub.md) to learn more.