def main [
	file: string,
	--id (-i): int
] {
	let text = 9 9p read $'acme/($id)/($file)'
	return $text
}