function codestral --wraps podman
	podman start ollama &> /dev/null
	podman exec -it ollama ollama run mistral-large $argv
end
