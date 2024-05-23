gst() (
  git status --ignored "$@"
)

gll() (
  git log --graph --decorate --pretty=oneline --abbrev-commit "$@"
)

gca() (
  git commit -a -v "$@"
)

gcam()  (
  git commit -a -m "$*"
)

vb() {
  vim bashrc
  source bashrc
}
