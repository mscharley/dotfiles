function ollama --wraps podman
	podman start ollama-rocm &> /dev/null
	podman exec -it ollama-rocm ollama $argv
end
