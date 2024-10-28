function ollama --wraps podman
	podman start ollama &> /dev/null
	podman exec -it ollama ollama $argv
end
