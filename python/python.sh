thisDir=${0%/*}
python=python3
pip install pip-tools
pip-compile $thisDir/requirements.in > $thisDir/requirements.txt
