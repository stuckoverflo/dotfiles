while read p; do
    app=$(echo $p | cut -d" " -f1)
    mas install $app
done <"apps.txt"
