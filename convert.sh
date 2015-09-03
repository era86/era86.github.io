for f in *.html; do
  sed '$ d' $f > $f.markdown
  tail -n 1 $f | pandoc -f html -t markdown >> $f.markdown
done

rm *.html
rename s/.html.markdown/.markdown/g *.markdown
