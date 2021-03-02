# Command Line Tools

- `jq`
  - Parse JSON from the command line
- `mdless`
  - Pretty-format markdown from the command line
- `qrencode`
  - Generate QR codes as images or ASCII/Unicode art
  - `echo 'http://someurl.com' | qrencode -t utf8` to print a QR code
  to the terminal
- `tabulate` (`python3-tabulate`)
  - Pretty-print tabular date (e.g. tsv, csv) as a table
- `xclip`
  - Interact with the clipboard from the command line.
  - `cat somefile | xclip -i -sel CLIPBOARD` will load the contents of
  `file` to the X11 clipboard
  - `xclip -o | sort | xclip -i` will sort the clipboard.

