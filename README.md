# clang-format-fixer

Create a `clang-format-fix.yml` file in `.github/workflows/`.
Paste this code into the file:

```yml
name: clang-format-fixer
on: push
jobs:
  lint:
    name: clang-format-fixer
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/clang-format-fixer'
    steps:
      - uses: actions/checkout@v2
      - uses: amahanna/clang-format-fixer@v0.1.0
        with:
          sources: "src/*.cpp,src/*.h"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
