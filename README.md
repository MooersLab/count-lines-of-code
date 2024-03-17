# count-lines-of-code

## Problem addressed
Counts of lines of code generated are used or abused for many purposes.
There is no standard way of making these counts.

## Solution
Use one-liner Python functions for counting lines of code in an external file of code.
The code has no external dependencies.
The code can be in any programming language.
The examples below uses a file written in Elisp.
The last example is the solution that you want most of the time.
The bash function at the bottom can be available everywhere and all of the time.


## Count number of non-blank lines

Python3 one-liner to count number of non-blank lines follows. 
This code will count the number of non-blank lines:

```python
print(sum(1 for line in open("init.el",'r') if line.strip()))
```
[Source](https://stackoverflow.com/questions/10673560/count-number-of-lines-in-a-txt-file-with-python-excluding-blank-lines)

## Count number of commented lines

Python3 one-liner to count number of lines that are commented out follows.
The semicolon is used to comment out lines in Emacs Lisp.
This function will mess those commented lines where the comment has been indented, so this function could be improved.

```python
print(sum(1 for line in open('init.el','r') if (line[0] ==  ';') ) )
```


## Count number of lines with uncommented code

Python3 one-liner to count number of non-blank lines that are not commented out.
This code overlooks block comments and indented  comment lines.
There is room for improvement.

This is the code that you want to use most of the time:

```python
print(sum(1 for line in open('init.el','r') if ((line.strip()) and (line[0] != ';') ) ) )
```


##  More convenient bash function for last example

You could make this into bash function that is callable from anywhere on any kind of code.
Beware that you may have to escape the comment character if it is part of the Bash syntax.
Examples of usage include:

```bash
cntloc test.py \#
cntloc init.el \;
cntloc .bashFunctions \#
cntloc rhoxyz.f \*
cntloc rhoxyz.f95 \!
cntloc ancientCode.f C
cntloc learnjuia.jl \#
cntloc my_model.stan  \/
cntloc testme.c \/
cntloc test.cjl \;
cntloc test.R \#
```

This function can be stored in a `.bashFunctions` file that is sourced when you open a new bash or zsh shell.

```bash
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
```

##  Limitations

- Skips comments in blocks (e.g., triple quote blocks in  Python).
- Skips comments on indented lines.

## Limitations

- Skips blocked comments in special comment environments (e.g., Python triple quoted blocks, html comment blocks, LaTeX comment blocks, comment blocks in C++).
- Skip comments on indented lines
