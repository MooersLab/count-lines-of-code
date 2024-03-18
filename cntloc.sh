cntloc()
{
echo "Count lines of code in almost any plain text file. Will not handle block comments correctly."
echo "You may have to escape the comment character if it is part of the bash syntax."
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments"
  s='Supply the filename and the first comment character (e.g.,  #  / % ; C * !)'
  echo "${s//;\; //#\# ///\/ //%\%  //!\!}"
  t='Usage: cntloc init.el \;'
  echo "${t//;\; //#\# ///\/ //%\%  //!\!}"
  return 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments"
  s='Supply the filename and the first comment character (e.g.,  #  / % ; C  * !)'
  echo "${s//;\; //#\# ///\/ //%\%}"
  t='Usage: cntloc init.el \;'
  echo "${t//;\; //#\# ///\/ //%\%}"
fi
/opt/local/bin/python3.11  -c "print(sum(1 for line in open('$1','r') if ( (line.strip()) and (line[0] != '$2') ) ))"
}
