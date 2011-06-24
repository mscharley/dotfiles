# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

for f in ~/.bash/*; do
	source $f
done

