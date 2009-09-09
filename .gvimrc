"colorscheme murphy

if has('gui_macvim')
  cd ~/Documents/MacVim/
  set showtabline=2
  " no scroll/tool bar
  set go=egmtc
  set transparency=20

  " No Full Screen size
  set lines=54
  set columns=180
  " Full Screen mode: MAX window size
  set fuoptions=maxvert,maxhorz
  ":macaction zoomAll:
  map <silent> gw :macaction selectNextWindow:
  map <silent> gW :macaction selectPreviousWindow:
endif

