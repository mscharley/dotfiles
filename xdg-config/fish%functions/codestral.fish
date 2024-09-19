function codestral --wraps podman
	podman start ollama &> /dev/null
	podman exec -it ollama ollama run codestral $argv
end
