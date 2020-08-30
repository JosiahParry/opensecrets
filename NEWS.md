

<!--
set cul   "cursorline
cc=+1			"colorcolumn is 1 more than tw

!pandoc % -t latex -V linkcolor:blue -V fontsize=12pt -V geometry:margin=0.5in -o ~/Downloads/print_and_delete/out.pdf

-H header
-V or --variable
--pdf-engine=xelatex

PANDOC EXAMPLES:
https://learnbyexample.github.io/tutorial/ebook-generation/customizing-pandoc/

MARKDOWN GUIDE:
https://www.markdownguide.org/basic-syntax/

-->
#	NEWS.md

***

### 0.0.9001  Misc Fixes

*	add imports to DESCRIPTION (#3).
*	add httr::stop_for_status() to GET() (#4).
* begin NEWS.md (#7, @jimrothstein).

<!--
vim:linebreak:spell:nowrap:cul tw=78 fo=tqlnr foldcolumn=3 cc=+1
-->
