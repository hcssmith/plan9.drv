# Eecute command from Tag gets current tag
def main --wrapped [
	command: string
	...args:string
	--id (-i): int # Id of window to runn command in
] {


	let command_str = ($command | append ($args | str join ' ') | str join ' ')

	Write --id $id ctl nomenu
	Write --id $id ctl cleartag
	Write --id $id tag $'($command_str)'
	let wdata = (GetWinData --id $id | from json)
	let start = ($wdata.name | str length) + ($wdata.stdtag | str length) + 3
	let offset = $start + ($command_str | str length)
	let ev_cmd = $'Mx($start) ($wdata.tagc)'
	^echo $ev_cmd | 9 9p write $'acme/($id)/event'

	Write --id $id ctl cleartag
	Write --id $id tag ($wdata.tag | str join ' ')

	Write --id $id ctl menu
}