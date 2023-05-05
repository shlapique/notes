# Prerequisites

## openSUSE Tumbleweed

```bash
sudo zypper in pandoc texlive-xelatex-dev-bin R tcl libpng libpng-devel texlive-babel-russian texlive-cm-unicode
```

## Ubuntu LTS 20.04 (or WSL2 on Windows)

```bash
sudo apt install pandoc texlive-xetex r-base tcl libpng-dev texlive-lang-cyrillic fonts-cmu
```

### install Rmarkdown
```bash
sudo R
```

```bash
install.packages(c("rmarkdown","reticulate"));
```

### install renv and packages
```bash
R
```

```bash
install.packages("renv")
```

```bash
renv::restore()
```

## todo

- [X] fix header
- [X] fix 'hats' on wide letters
- [X] fix spell mistakes
- [X] add plots and pictures
- [X] fix semantic mistakes 
- [X] fixes in highlighting of *important* details
