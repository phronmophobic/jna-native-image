export JAVA_HOME=/graalvm
export PATH=$JAVA_HOME/bin:$PATH

source /etc/bash_completion

ll() ( ls -l --color "$@" )
la() ( ll -a "$@" )

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
