thisDir=${0%/*}
while read p; do
    app=$(echo $p | cut -d" " -f1)
    mas install $app
done <"$thisDir/apps.txt"
