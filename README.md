# clang-format-fixer

Formats your files using the `.clang-format` of your repo.

Create a `clang-format-fixer.yml` file in `.github/workflows/`.
Paste this code into the file:

```yml
name: clang-format-fixer
on: push
jobs:
  lint:
    name: clang-format-fixer
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: aMahanna/clang-format-fixer@v1.1.2
        with:
          sources: "src/Card.h src/Card.cpp lib/**/*.h"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Common use case:

See https://github.com/Ana06/get-changed-files

```yml
name: clang-format-fixer
on: push
jobs:
  lint:
    name: clang-format-fixer
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: Ana06/get-changed-files@v2.0.0
        id: gcf
        with:
          filter: |
            **/*.cpp
            **/*.hpp
            **/*.c
            **/*.h
      - uses: aMahanna/clang-format-fixer@v1.1.2
        with:
          sources: "${{ steps.gcf.outputs.added_modified }}"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```