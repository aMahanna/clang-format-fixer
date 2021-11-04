# clang-format-fixer

Create a `clang-format-fix.yml` file in `.github/workflows/`.
Paste this code into the file:

```yml
on: push
name: Clang Format Fixer
jobs:
  lint:
    name: Clang Format Fixer
    runs-on: ubuntu-latest
    steps:
    - name: Clang Format Fixer
      uses: amhanna/clang-format-fixer@v0.0.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
