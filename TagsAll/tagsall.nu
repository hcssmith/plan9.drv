# Run Tags+ for all winids
def main [] {
	GetAllWinIDs
  | from json
  | each {|it| Tags+ --id $it.id}
  | ignore
}